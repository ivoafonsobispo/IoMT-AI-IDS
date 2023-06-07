#!/bin/bash

# Read the contents of the second file into an array
mapfile -t lines < Fields_To_Remove.txt

# Iterate over each line in the first file
while IFS= read -r line; do
  # Check if the line exists in the second file
  if [[ ! " ${lines[@]} " =~ " $line " ]]; then
    # Line doesn't exist in the second file, so print it
    echo "$line"
  fi
done < Fields.txt > Fields_Filtered.txt