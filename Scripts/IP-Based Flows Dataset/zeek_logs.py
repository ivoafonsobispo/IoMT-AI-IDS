def clean_zeek_log_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Remove the first 6 rows
    cleaned_lines = lines[6:]

    # Remove the 2th line after cleaning the first 6 rows
    if len(cleaned_lines) >= 8:
        cleaned_lines.pop(1)

    # Delete the first value of the first column in the first row and shift left
    cleaned_lines[0] = '\t'.join(cleaned_lines[0].split('\t')[1:])

    # Remove the last line
    cleaned_lines.pop()

    # Write the cleaned lines to a new file
    cleaned_file_path = file_path + '.cleaned'
    with open(cleaned_file_path, 'w') as file:
        file.writelines(cleaned_lines)

    #print(f"[INFO] Saved In/As - {cleaned_file_path}")


def combine_cleaned_logs(flowmeter_file, conn_file, combined_file):
    with open(flowmeter_file, 'r') as flowmeter, open(conn_file, 'r') as conn, open(combined_file, 'w') as combined:
        for conn_line, flow_line in zip(conn, flowmeter):
            combined.write(conn_line.rstrip() + '\t' + flow_line)
        #print(f"[INFO] Combined - {combined_file}")


def log_to_csv(log_file, csv_file):
    # Open the log file for reading and the CSV file for writing
    with open(log_file, 'r') as log_file, open(csv_file, 'w', newline='') as csv_file:
        log_lines = log_file.readlines()

        # Write the lines to the CSV file
        csv_file.writelines(log_lines)

        #print(f'[INFO] Transformation complete. Converted {log_file} to CSV.')
