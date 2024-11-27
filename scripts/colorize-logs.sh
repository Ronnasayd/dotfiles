#!/bin/bash

# Define color codes
colors=(
    "\e[31m"  # Red
    "\e[32m"  # Green
    "\e[33m"  # Yellow
    "\e[34m"  # Blue
    "\e[35m"  # Magenta
    "\e[36m"  # Cyan
    "\e[37m"  # White
)

# Reset color
reset="\e[0m"

# Function to colorize words in a line based on a given delimiter
colorize-line() {
    local line="$1"
    local delimiter="$2"
    
    # Set IFS to the specified delimiter for splitting
    IFS="$delimiter"
    read -ra words <<< "$line"  # Read words into an array

    local color_count=${#colors[@]}
    
    for i in "${!words[@]}"; do
        # Get the corresponding color for the word
        color=${colors[$((i % color_count))]}
        # Print the word with the selected color
        echo -ne "${color}${words[i]}${reset} "
    done
    echo  # New line after printing all words
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