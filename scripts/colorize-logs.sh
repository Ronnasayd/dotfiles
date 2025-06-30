#!/bin/bash

# Define color codes
colors=(
  "\e[31m" # Red
  "\e[32m" # Green
  "\e[33m" # Yellow
  "\e[34m" # Blue
  "\e[35m" # Magenta
  "\e[36m" # Cyan
)
DCOLOR="\e[37m"    # White for normal text
JSONCOLOR="\e[36m" # Cyan for JSON regions
reset="\e[0m"
COUNTER=0

# Function to colorize words in a line based on a given delimiter
colorize_line() {
  local line="$1"
  local delimiter="$2"

  IFS="$delimiter"
  read -ra words <<<"$line"

  local color_count=${#colors[@]}
  for i in "${!words[@]}"; do
    if ((i % 2 == 0)); then
      echo -ne "${DCOLOR}${words[i]}${reset}${delimiter}"
    else
      color=${colors[$((COUNTER % color_count))]}
      echo -ne "${color}${words[i]}${reset}${delimiter}"
      ((COUNTER++))
    fi
  done
  echo
  COUNTER=0
}

# Function to colorize JSON substrings inside a line
colorize_json_substrings() {
  local line="$1"
  local delimiter="$2"

  # Regex to match JSON-like substrings: {...} or [...]
  # This simple regex does NOT handle nested braces/brackets or multiline JSON.
  local regex='(\{[^{}]*\}|\[[^\[\]]*\])'

  # Use perl to split and colorize JSON and non-JSON parts
  perl -e '
    use strict;
    use warnings;

    my $line = shift;
    my $delimiter = shift;
    my @colors = ("\e[31m","\e[32m","\e[33m","\e[34m","\e[35m","\e[36m");
    my $dcolor = "\e[37m";
    my $reset = "\e[0m";
    my $counter = 0;
    my $color_count = scalar @colors;
    my $key_color = "\e[32m";    # Yellow
    my $value_color = "\e[34m";  # Magenta
    my $brace_color = "\e[36m";  # Cyan for braces/brackets

    my $regex = qr/(\{[^{}]*\}|\[[^\[\]]*\])/;

    my $pos = 0;
    while ($line =~ /$regex/g) {
      my $start = $-[0];
      my $end = $+[0];

      # Print non-JSON part before match, colorized by delimiter
      my $before = substr($line, $pos, $start - $pos);
      if ($before ne "") {
        my @parts = split(/\Q$delimiter\E/, $before, -1);
        for my $i (0..$#parts) {
          if ($i % 2 == 0) {
            print $dcolor . $parts[$i] . $reset;
          } else {
            print $colors[$counter % $color_count] . $parts[$i] . $reset;
            $counter++;
          }
          print $delimiter if $i != $#parts;
        }
      }

      # Print JSON substring with colorized keys and values
      my $json_substr = substr($line, $start, $end - $start);

      while ($json_substr =~ /(("?([\w\s]+))"?(:)("?([\w\s]+))"?)/g) {
        my $key = $3;
        my $colon = $4;
        my $value = $6;

        my $before_match = substr($json_substr, 0, $-[0]);
        print $brace_color . $before_match . $reset if $before_match ne "";

        print $key_color . $key . $reset;
        print $brace_color . $colon . $reset;
        print $value_color . $value . $reset;

        $json_substr = substr($json_substr, $+[0]);
        pos($json_substr) = 0;
      }

      # Print any remaining part of the JSON substring (like closing braces)
      if ($json_substr ne "") {
        print $brace_color . $json_substr . $reset;
      }

      $pos = $end;
    }

    # Print the rest of the line after last JSON match
    my $rest = substr($line, $pos);
    if ($rest ne "") {
      my @parts = split(/\Q$delimiter\E/, $rest, -1);
      for my $i (0..$#parts) {
        if ($i % 2 == 0) {
          print $dcolor . $parts[$i] . $reset;
        } else {
          print $colors[$counter % $color_count] . $parts[$i] . $reset;
          $counter++;
        }
        print $delimiter if $i != $#parts;
      }
    }
    print "\n";
  ' "$line" "$delimiter"
}

# Main loop
if [ $# -ne 1 ]; then
  delimiter=" "
else
  delimiter="$1"
fi

while IFS= read -r line; do
  # If line contains JSON-like substring, colorize JSON substrings only
  if [[ "$line" =~ \{.*\} ]] || [[ "$line" =~ \[.*\] ]]; then
    colorize_json_substrings "$line" "$delimiter"
  else
    colorize_line "$line" "$delimiter"
  fi
done
