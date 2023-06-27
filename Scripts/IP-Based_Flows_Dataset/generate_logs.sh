#!/bin/bash

# Set the path to Zeek binary
ZEEK_PATH="/usr/local/zeek/bin/zeek"

# Function to display usage instructions
display_usage() {
    echo "Usage: $0 <parent_directory> <log_directory>"
    echo "       <parent_directory>: The parent directory containing the folders with pcap files."
    echo "       <log_directory>: The directory where you want to store the log files."
}

# Check if the number of arguments is less than 2
if [ $# -lt 2 ]; then
    display_usage
    exit 1
fi

# Get the parent directory containing the folders with pcap files
PARENT_DIR="$1"

# Get the directory where you want to store the log files
LOG_DIR="$2"

# Change to Zeek bin directory
cd /usr/local/zeek/bin

# Start the timer
start_time=$(date +%s)

# Function to process a single pcap file
process_pcap_file() {
    local pcap_file=$1
    local folder_name=$2

    # Get the filename without extension
    filename=$(basename "$pcap_file" .pcap)

    echo "Processing file: $filename.pcap"

    # Start the timer for the current file
    file_start_time=$(date +%s)

    # Run Zeek flowmeter for the pcap file
    sudo ./zeek flowmeter -r "$pcap_file"

    # Rename the generated log files
    sudo mv conn.log "$LOG_DIR/$folder_name/$filename"_conn.log
    sudo mv flowmeter.log "$LOG_DIR/$folder_name/$filename"_flowmeter.log

    # Calculate the elapsed time for the current file
    file_end_time=$(date +%s)
    file_elapsed_time=$((file_end_time - file_start_time))
    echo "Completed processing file: $filename.pcap (Time: $file_elapsed_time seconds)"
}

export -f process_pcap_file

# Loop through each folder in the parent directory
for folder in "$PARENT_DIR"/*/; do
  # Get the folder name
  folder_name=$(basename "$folder")

  echo "Processing folder: $folder_name"

  # Get the list of pcap files in the folder
  pcap_files=("$folder"/*.pcap)
  total_files=${#pcap_files[@]}
  processed_files=0

  # Process each pcap file in parallel
  for pcap_file in "${pcap_files[@]}"; do
    ((processed_files++))
    # Get the filename without extension
    filename=$(basename "$pcap_file" .pcap)

    echo "[$processed_files/$total_files] Processing file: $filename.pcap"

    # Start the timer for the current file
    file_start_time=$(date +%s)

    # Run Zeek flowmeter for the pcap file
    sudo ./zeek flowmeter -r "$pcap_file"

    # Rename the generated log files
    sudo mv conn.log "$LOG_DIR/$folder_name/$filename"_conn.log
    sudo mv flowmeter.log "$LOG_DIR/$folder_name/$filename"_flowmeter.log

    # Calculate the elapsed time for the current file
    file_end_time=$(date +%s)
    file_elapsed_time=$((file_end_time - file_start_time))
    echo "[$processed_files/$total_files] Completed processing file: $filename.pcap (Time: $file_elapsed_time seconds)"
  done

  echo "Completed processing folder: $folder_name"
done

# Calculate the total elapsed time
end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Script execution time: $elapsed_time seconds"