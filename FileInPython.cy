import csv
total_tests = 0
failed_tests = 0
passed_tests = 0
skipped_tests = 0
failed_tests_names = []
total_duration = 0.0
filename=input("Enter the filename (with .csv extension): ")
try:
    try:
        with open(filename, 'r') as file:
            reader = csv.DictReader(file)
            print(f'{"Test ID":<2}, {"Test Name":<37}, {"Duration (s)":<5}, {"Status":<11}')
            for row in reader:
                try:
                    total_duration += float(row["duration_seconds"])
                except ValueError:
                    pass
                if row["status"].lower() == "failed":
                    failed_tests += 1
                    failed_tests_names.append(row["test_name"])
                elif row["status"].lower() == "passed":
                    passed_tests += 1
                else:
                    skipped_tests += 1
                print(f'{row["test_id"]:<7}, {row["test_name"]:<37}, {row["duration_seconds"]:<12}, {row["status"]:<10}')
                total_tests += 1
                print()
        print(f'Total number of tests: {total_tests}')
        print(f'Number of passed tests: {passed_tests}')
        print(f'Number of failed tests: {failed_tests}')
        print(f'Number of skipped tests: {skipped_tests}')
        print(f'Percentage of passed tests: {passed_tests / total_tests * 100:.1f}%')
        print(f'Total duration of all tests: {total_duration:.2f} seconds')
        print(f'Average duration of tests: {total_duration / total_tests:.2f} seconds')
        print(f"Failed test names:")
        for name in failed_tests_names:
            print(f"  - {name}")
    except FileNotFoundError:
        print("Error: The file 'test_results.csv' was not found.")

    with open('summary.txt', 'a') as file:
        file.write(f'Total number of tests: {total_tests}\n')
        file.write(f'Number of passed tests: {passed_tests}\n')
        file.write(f'Number of failed tests: {failed_tests}\n')
        file.write(f'Number of skipped tests: {skipped_tests}\n')
        file.write(f'Percentage of passed tests: {passed_tests / total_tests * 100:.1f}%\n')
        file.write(f'Total duration of all tests: {total_duration:.2f} seconds\n')
        file.write(f'Average duration of tests: {total_duration / total_tests:.2f} seconds\n')
        file.write(f"Failed test names:\n")
        for name in failed_tests_names:
            file.write(f"  - {name}\n")
except FileNotFoundError:
    print(f"Error: {filename} not found.")
