import sys
import os
import datetime
import time
import pandas as pd

if len(sys.argv) != 2:
    print("Usage: python3 count_lines.py <folder_path>")
    sys.exit(1)

folder_path = sys.argv[1]


def print_with_timestamp(message):
    """
    Prints a message with a timestamp in the format: [YYYY-MM-DD HH:MM:SS] message
    """
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] {message}")


def clean_csv(folder_path):
    """
    Clean and filter the contents of CSV files in each folder.

    Args:
        folder_path (str): Path to the folder containing the CSV files.

    Returns:
        None
    """
    print_with_timestamp("Script started")
    print_with_timestamp(f"Cleaning logs in folder: {folder_path}")

    start_time = time.time()
    # Get the total number of folders
    total_folders = len(os.listdir(folder_path))
    current_folder = 0

    # Iterate over folders in the specified folder path
    for folder in os.listdir(folder_path):
        folder = os.path.join(folder_path, folder)

        combined_file_path = None

        # Find the _combined.csv file
        for file in os.listdir(folder):
            if file.endswith("_combined.csv"):
                combined_file_path = os.path.join(folder, file)

        # Clean and filter the contents of the CSV file
        if combined_file_path:
            # Extract folder name
            traffic = os.path.basename(folder)

            # Read CSV file
            df = pd.read_csv(combined_file_path, delimiter=',')

            if traffic == 'normal' or traffic == 'camoverflow':
                # Filter rows based on condition
                df = df[~df['id.orig_h'].isin(['10.10.10.252', '10.10.10.253'])]
            else:
                # Filter rows based on condition
                df = df[df['id.orig_h'].isin(['10.10.10.252', '10.10.10.253'])]

            # Write the cleaned contents back to the CSV file
            df.to_csv(combined_file_path, index=False)

            # Update progress
            current_folder += 1
            print_with_timestamp(f"Progress: {current_folder}/{total_folders} folders processed")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")


clean_csv(folder_path)
