import sys
import os
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


def combine_logs(folder_path):
    """
    Combine the contents of _conn.log.cleaned and _flowmeter.log.cleaned files in each folder.
    """
    print_with_timestamp("Script started")
    print_with_timestamp(f"Combining logs in folder: {folder_path}")

    start_time = time.time()

    # Get the total number of folders
    total_folders = len(os.listdir(folder_path))
    current_folder = 0

    # Iterate over folders in the specified folder path
    for folder in os.listdir(folder_path):
        folder = os.path.join(folder_path, folder)

        conn_file_path = None
        flowmeter_file_path = None

        # Find the _conn.log.cleaned and _flowmeter.log.cleaned files
        for file in os.listdir(folder):
            if file.endswith("_conn.log.cleaned"):
                conn_file_path = os.path.join(folder, file)
            elif file.endswith("_flowmeter.log.cleaned"):
                flowmeter_file_path = os.path.join(folder, file)

        # Combine the contents of the _conn.log.cleaned and _flowmeter.log.cleaned files
        if conn_file_path and flowmeter_file_path:
            # Extract folder name
            folder_name = os.path.basename(folder)

            # Create the combined file name
            combined_file_name = f"{folder_name}_combined.log"
            combined_file_path = os.path.join(folder, combined_file_name)

            with open(conn_file_path, 'r') as conn_file, open(flowmeter_file_path, 'r') as flowmeter_file, open(
                    combined_file_path, 'w') as combined_file:
                conn_lines = conn_file.readlines()
                flowmeter_lines = flowmeter_file.readlines()

                # Combine lines side by side
                for conn_line, flowmeter_line in zip(conn_lines, flowmeter_lines):
                    combined_line = conn_line.rstrip() + '\t' + flowmeter_line
                    combined_file.write(combined_line)

        # Update progress
        current_folder += 1
        print_with_timestamp(f"Progress: {current_folder}/{total_folders} folders processed")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")


combine_logs(folder_path)
