import os
import time

from scripts.utils import print_with_timestamp


def delete_logs(folder_path):
    """
    Deletes log files and cleaned log files in the specified folder path.
    """
    print_with_timestamp("Script started")
    print_with_timestamp(f"Cleaning logs in folder: {folder_path}")

    start_time = time.time()
    total_folders = len(os.listdir(folder_path))
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
        print_with_timestamp(f"Progress: {processed_folders}/{total_folders} folders processed")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")
