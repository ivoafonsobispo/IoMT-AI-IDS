import os
import time
from scripts.utils import print_with_timestamp

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

        conn_files = []
        flowmeter_files = []

        # Find the _conn.log.cleaned and _flowmeter.log.cleaned files
        for file in os.listdir(folder):
            if file.endswith("_conn.log.cleaned"):
                conn_files.append(os.path.join(folder, file))
            elif file.endswith("_flowmeter.log.cleaned"):
                flowmeter_files.append(os.path.join(folder, file))

        # Combine the contents of the _conn.log.cleaned and _flowmeter.log.cleaned files
        if conn_files and flowmeter_files:
            # Extract folder name
            folder_name = os.path.basename(folder)

            # Create the combined file name
            combined_file_name = f"{folder_name}_combined.log"
            combined_file_path = os.path.join(folder, combined_file_name)

            with open(combined_file_path, 'w') as combined_file:
                # Keep track of lines using a set
                unique_lines = set()

                for conn_file, flowmeter_file in zip(conn_files, flowmeter_files):
                    with open(conn_file, 'r') as conn_file_obj, open(flowmeter_file, 'r') as flowmeter_file_obj:
                        conn_lines = conn_file_obj.readlines()
                        flowmeter_lines = flowmeter_file_obj.readlines()

                        # Combine the header line
                        combined_header = conn_lines[0].rstrip() + '\t' + flowmeter_lines[0]

                        # Write the header to the combined file
                        combined_file.write(combined_header)

                        # Iterate over the remaining lines
                        for conn_line, flowmeter_line in zip(conn_lines[1:], flowmeter_lines[1:]):
                            combined_line = conn_line.rstrip() + '\t' + flowmeter_line

                            # Check if the line is unique
                            if combined_line not in unique_lines:
                                # Write the unique line to the combined file
                                combined_file.write(combined_line)

                                # Add the line to the set of unique lines
                                unique_lines.add(combined_line)

        # Update progress
        current_folder += 1
        print_with_timestamp(f"Progress: {current_folder}/{total_folders} folders processed")

    end_time = time.time()
    execution_time = end_time - start_time
    print_with_timestamp(f"Script completed in {execution_time:.2f} seconds")

