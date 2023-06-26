#!/bin/bash

# Check if a directory path is provided
if [ -z "$1" ]; then
  echo "Please provide a directory path."
  exit 1
fi

# Check if the directory exists
if [ ! -d "$1" ]; then
  echo "Directory does not exist: $1"
  exit 1
fi

# Start time
start_time=$(date +%s)
echo "Script started at $(date)"

# Iterate over each subdirectory in the provided path
for dir in "$1"/*/; do
  # Get the folder name
  folder=$(basename "$dir")

  # Find pcap files starting with "capture" in the subdirectory
  pcap_files=("$dir"capture*.pcap)

  # Check if any pcap files exist
  if [ ${#pcap_files[@]} -eq 0 ]; then
    echo "No pcap files found in $dir"
    continue
  fi

  # Start time for the folder
  folder_start_time=$(date +%s)
  echo "Processing folder: $folder"

  # Run editcap command for each pcap file
  for file in "${pcap_files[@]}"; do
    new_name="$dir$folder.pcap"
    editcap -i 5 "$file" "$new_name"
    echo "Converted $file to $new_name"
  done

  # Delete previous capture*.pcap files
  rm -f "$dir"capture*.pcap
  echo "Deleted previous capture*.pcap files in $dir"

  # Duration for the folder
  folder_end_time=$(date +%s)
  duration=$((folder_end_time - folder_start_time))
  echo "Folder $folder took $duration seconds"
done

# Overall duration
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "Script completed in $duration seconds"

