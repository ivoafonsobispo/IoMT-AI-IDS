import sys
import csv

csv_file_path = sys.argv[1]

line_count = 0
with open(csv_file_path, 'r') as file:
    csv_reader = csv.reader(file)
    for line in csv_reader:
        line_count += 1

print(f"The CSV file '{csv_file_path}' has {line_count} lines.")
