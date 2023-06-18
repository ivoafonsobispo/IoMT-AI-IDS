import os
import time

from scripts.utils import print_with_timestamp


def clean_logs(folder_path):
    """
    Cleans log files in the specified folder path. Removes the first 6 lines, removes the 2nd line after cleaning,
    deletes the first value of the first column in the first row, removes the last line, and saves the cleaned lines
    to new files with the .cleaned extension.
    """
    print_with_timestamp("Script started")
    print_with_timestamp(f"Cleaning logs in folder: {folder_path}")

    start_time = time.time()

    # Iterate over folders in the specified folder path
    for folder in os.listdir(folder_path):
        folder = os.path.join(folder_path, folder)

        # Iterate over files in each folder
        for file in os.listdir(folder):
            file_path = os.path.join(folder, file)

            # Read the contents of the file
            with open(file_path, 'r') as f:
                lines = f.readlines()

            # Remove the first 6 lines and the 2nd line
            lines = lines[6:]
            del lines[1]

            # Delete the first value of the first column in the first row and shift left
            lines[0] = '\t'.join(lines[0].split('\t')[1:])

            # Remove the last line
            lines.pop()

            # Create a path for the cleaned file
            cleaned_file_path = file_path + '.cleaned'

            # Write the cleaned lines to a new file
            with open(cleaned_file_path, 'w') as f:
                f.writelines(lines)

            # Delete the old file
            os.remove(file_path)

            print_with_timestamp(f"Processed file: {file}")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")
