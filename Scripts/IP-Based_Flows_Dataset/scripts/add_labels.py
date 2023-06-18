import os
import time
import pandas as pd

from scripts.utils import print_with_timestamp

def add_labels(folder_path):
    """
    Adds labels to the _combined.csv files in the specified folder path.
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

        # Find the _combined.csv file
        combined_file_path = None
        for file in os.listdir(folder):
            if file.endswith("_combined.csv"):
                combined_file_path = os.path.join(folder, file)
                break

        # Clean and filter the contents of the CSV file
        if combined_file_path:
            # Extract folder name
            folder_name = os.path.basename(folder)

            # Read CSV file
            df = pd.read_csv(combined_file_path)

            # Add label column
            df['traffic'] = folder_name

            # Write the cleaned contents back to the CSV file
            df.to_csv(combined_file_path, index=False)

            processed_folders += 1
            print_with_timestamp(f"Progress: {processed_folders}/{total_folders} folders processed")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")
