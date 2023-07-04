import os
import sys
import time

from scripts import (
    add_labels,
    clean_csvs,
    clean_logs,
    combine_csvs,
    combine_logs,
    delete_logs,
    log_to_csv,
)


def main(folder_path):
    """
    Main function to clean and process logs and CSV files.
    """
    start_time = time.time()

    # Clean logs
    print("[STARTED] Cleaning logs...")
    clean_logs.clean_logs(folder_path)
    print("[FINISHED] Logs cleaned.")

    # Combine logs
    print("[STARTED] Combining logs...")
    combine_logs.combine_logs(folder_path)
    print("[FINISHED] Logs combined.")

    # Convert logs to CSV
    print("[STARTED] Converting logs to CSV...")
    log_to_csv.log_to_csv(folder_path)
    print("[FINISHED] Logs converted to CSV.")

    # Clean CSV files
    print("[STARTED] Cleaning CSV files...")
    clean_csvs.clean_csv(folder_path)
    print("[FINISHED] CSV files cleaned.")

    # Add labels to CSV files
    print("[STARTED] Adding labels to CSV files...")
    add_labels.add_labels(folder_path)
    print("[FINISHED] Labels added to CSV files.")

    # Combine CSV files
    print("[STARTED] Combining CSV files...")
    combine_csvs.combine_csvs(folder_path)
    print("[FINISHED] CSV files combined.")

    # Delete remaining logs
    print("[STARTED] Deleting remaining logs...")
    delete_logs.delete_logs(folder_path)
    print("[FINISHED] Remaining logs deleted.")

    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"[DONE] Process completed in {elapsed_time:.2f} seconds.")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 clean_csvs.py <folder_path>")
        sys.exit(1)

    folder_path = sys.argv[1]
    main(folder_path)
