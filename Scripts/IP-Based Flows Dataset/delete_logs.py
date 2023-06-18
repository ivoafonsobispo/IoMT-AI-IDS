import sys
import os
import datetime
import time

if len(sys.argv) != 2:
    print("Usage: python3 clean_logs.py <folder_path>")
    sys.exit(1)

folder_path = sys.argv[1]


def print_with_timestamp(message):
    """
    Prints a message with a timestamp in the format: [YYYY-MM-DD HH:MM:SS] message
    """
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] {message}")


def clean_logs(folder_path):
    """
    Deletes log files and cleaned log files in the specified folder path.

    :param folder_path: The path to the folder containing the log files.
    """
    print_with_timestamp("Script started")
    print_with_timestamp(f"Cleaning logs in folder: {folder_path}")

    start_time = time.time()
    processed_folders = 0

    # Iterate over folders in the specified folder path
    for folder in os.listdir(folder_path):
        folder = os.path.join(folder_path, folder)

        if not os.path.isdir(folder):
            continue

        # Delete log files and cleaned log files
        for file in os.listdir(folder):
            if file.endswith(".log") or file.endswith(".cleaned"):
                file_path = os.path.join(folder, file)
                os.remove(file_path)

        processed_folders += 1
        print_with_timestamp(f"Progress: {processed_folders}/{len(os.listdir(folder_path))} folders processed")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")


clean_logs(folder_path)
