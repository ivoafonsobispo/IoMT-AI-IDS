import sys
import os
import csv
import datetime
import time

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


def log_to_csv(folder_path):
    """
    Convert the _combined.log file to a CSV file in each folder.
    """
    print_with_timestamp("Script started")
    print_with_timestamp(f"Converting logs to CSV in folder: {folder_path}")

    start_time = time.time()

    # Get the total number of folders
    total_folders = len(os.listdir(folder_path))
    current_folder = 0

    # Iterate over folders in the specified folder path
    for folder in os.listdir(folder_path):
        folder = os.path.join(folder_path, folder)

        combined_file_path = None

        # Find the _combined.log file
        for file in os.listdir(folder):
            if file.endswith("_combined.log"):
                combined_file_path = os.path.join(folder, file)

        # Convert the _combined.log file to CSV
        if combined_file_path:
            # Extract folder name
            folder_name = os.path.basename(folder)

            # Create the CSV file name
            csv_file_name = f"{folder_name}_combined.csv"
            csv_file_path = os.path.join(folder, csv_file_name)

            with open(combined_file_path, 'r') as combined_file, open(csv_file_path, 'w', newline='') as csv_file:
                reader = csv.reader(combined_file, delimiter='\t')
                writer = csv.writer(csv_file)

                # Write the contents to CSV
                writer.writerows(reader)

            # Delete the _combined.log file
            os.remove(combined_file_path)

        # Update progress
        current_folder += 1
        print_with_timestamp(f"Progress: {current_folder}/{total_folders} folders processed")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")


log_to_csv(folder_path)
