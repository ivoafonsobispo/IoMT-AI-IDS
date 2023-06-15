import os
import pandas as pd
import csv

def clean_ips_df(df, path, traffic):

    if traffic == 'normal' or traffic == 'camoverflow':
        # Filter rows based on condition
        df = df[~df['id.orig_h'].isin(['10.10.10.252', '10.10.10.253'])]
    else:
        # Filter rows based on condition
        df = df[df['id.orig_h'].isin(['10.10.10.252', '10.10.10.253'])]

    prev_path = path

    # Save the cleaned CSV file
    path = os.path.join(path, 'combined_cleaned.csv')
    df.to_csv(path, index=False)

    # Delete the old CSV file
    os.remove(os.path.join(prev_path, 'combined.csv'))

    print(f"[INFO] Filtered data - {path}")


def add_attack_column(base_directory):
    # Iterate over the folders
    for folder_name in os.listdir(base_directory):
        folder_path = os.path.join(base_directory, folder_name)
        
        # Check if the item in the directory is a folder
        if os.path.isdir(folder_path):
            # Iterate over the CSV files in the folder
            for file_name in os.listdir(folder_path):
                if file_name.endswith('.csv'):
                    file_path = os.path.join(folder_path, file_name)
                    
                    # Create a temporary file to write the modified CSV data
                    temp_file = file_path + '.temp'
                    
                    with open(file_path, 'r') as csv_file, open(temp_file, 'w', newline='') as temp_csv_file:
                        reader = csv.reader(csv_file)
                        writer = csv.writer(temp_csv_file)
                        
                        # Read the header row
                        header = next(reader)
                        header.append('traffic')
                        
                        # Write the modified header to the temporary file
                        writer.writerow(header)
                        
                        # Read and write the remaining rows
                        for row in reader:
                            row.append(folder_name)
                            writer.writerow(row)
                    
                    # Replace the original file with the modified file
                    os.replace(temp_file, file_path)