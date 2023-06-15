import time
import os
import pandas as pd
import glob

from zeek_logs import *
from fix_csv import *

def main():
    # Print time started
    start_time = time.time()
    print("[STARTED] " + time.strftime("%H:%M:%S", time.localtime()))

    for folder in os.listdir():
        if os.path.isdir(folder):
            log_file_path = os.path.join(folder, 'flowmeter.log')
            clean_zeek_log_file(log_file_path)
            log_file_path = os.path.join(folder, 'conn.log')
            clean_zeek_log_file(log_file_path)
    print("[DONE] Cleaning Zeek Log " + time.strftime("%H:%M:%S", time.localtime()))

    for folder in os.listdir():
        if os.path.isdir(folder):
            flowmeter_file = os.path.join(folder, 'flowmeter.log.cleaned')
            conn_file = os.path.join(folder, 'conn.log.cleaned')
            combined_file = os.path.join(folder, 'combined.log')
            combine_cleaned_logs(flowmeter_file, conn_file, combined_file)
    print("[DONE] Combining Logs " + time.strftime("%H:%M:%S", time.localtime()))


    for folder in os.listdir():
        if os.path.isdir(folder):
            log_file = os.path.join(folder, 'combined.log')
            csv_file = os.path.join(folder, 'combined.csv')
            log_to_csv(log_file, csv_file)
    print("[DONE] Log to CSV " + time.strftime("%H:%M:%S", time.localtime()))   

    for folder in os.listdir():
        if os.path.isdir(folder):
            df = pd.read_csv(os.path.join(folder, 'combined.csv'), sep='\t')
            clean_ips_df(df, folder, os.path.basename(folder))
    print("[DONE] Cleaning Unused IP's " + time.strftime("%H:%M:%S", time.localtime()))

    # Set the path to the directory containing the folders
    base_directory = '/home/shanks/projects/iomt-ai-ids/Datasets/IP-Based/'
    add_attack_column(base_directory)
    print("[DONE] Adding Predicting Label " + time.strftime("%H:%M:%S", time.localtime()))

    combine_datasets(base_directory)
    print("[DONE] Combining Dataset " + time.strftime("%H:%M:%S", time.localtime()))

    print("[ENDED] " + time.strftime("%H:%M:%S", time.localtime()))
    print("[ELAPSED] " + time.strftime("%H:%M:%S", time.gmtime(time.time() - start_time)))

def combine_datasets(base_directory):
    # Create an empty list to store the data frames
    data_frames = []

    # Iterate over the folders
    for folder_name in os.listdir(base_directory):
        folder_path = os.path.join(base_directory, folder_name)
        
        # Check if the item in the directory is a folder
        if os.path.isdir(folder_path):
            # Iterate over the CSV files in the folder
            for file_name in os.listdir(folder_path):
                if file_name.endswith('.csv'):
                    file_path = os.path.join(folder_path, file_name)
                    
                    # Read the CSV file and add the attack_name column
                    data = pd.read_csv(file_path)
                    data['traffic'] = folder_name
                    data_frames.append(data)

    # Concatenate all the data frames into a single data frame
    combined_data = pd.concat(data_frames, ignore_index=True)

    # Save the combined data to a new CSV file
    combined_file_path = base_directory + 'untilted193.csv'

    combined_data.to_csv(combined_file_path, index=False)

main()
