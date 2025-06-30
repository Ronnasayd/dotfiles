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
DCOLOR="\e[37m" # White
COUNTER=0

# Reset color
reset="\e[0m"

# Function to colorize words in a line based on a given delimiter
colorize-line() {
  local line="$1"
  local delimiter="$2"

  # Set IFS to the specified delimiter for splitting
  IFS="$delimiter"
  read -ra words <<<"$line" # Read words into an array

  local color_count=${#colors[@]}

  for i in "${!words[@]}"; do
    if ((i % 2 == 0)); then
      # Print the word in white for even indices
      echo -ne "${DCOLOR}${words[i]}${reset} " # White color
    else
      # Get the corresponding color for odd indices
      color=${colors[$((COUNTER % color_count))]}
      echo -ne "${color}${words[i]}${reset} " # Sequential color
      ((COUNTER++))
    fi
  done
  echo # New line after printing all words
  COUNTER=0
}

# # Check if a delimiter is provided as an argument
if [ $# -ne 1 ]; then
  delimiter=" "
else
  delimiter="$1"
fi

while IFS= read -r line; do
  # Call colorize-line with the specified delimiter
  colorize-line "$line" "$delimiter"
done

# # Call colorize_all with the provided delimiter argument
# colorize_all "$1"
