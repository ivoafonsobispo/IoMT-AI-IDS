import os
import time
import pandas as pd

from scripts.utils import print_with_timestamp


def combine_csvs(folder_path):
    """
    Combines multiple _combined.csv files into a single CSV file.
    """
    print_with_timestamp("Script started")
    print_with_timestamp(f"Cleaning logs in folder: {folder_path}")

    start_time = time.time()
    total_folders = len(os.listdir(folder_path))
    processed_folders = 0
    data_frames = []

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

        # Read CSV file and append the data frame to the list
        if combined_file_path:
            df = pd.read_csv(combined_file_path)
            data_frames.append(df)

            processed_folders += 1
            print_with_timestamp(f"Progress: {processed_folders}/{total_folders} folders processed")

    # Concatenate all the data frames into a single data frame
    combined_data = pd.concat(data_frames, ignore_index=True)

    # Save the combined data to a new CSV file
    combined_file_path = folder_path + '/iomt_flows.csv'
    combined_data.to_csv(combined_file_path, index=False)

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")
