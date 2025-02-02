import csv

def csv_to_sql(input_file, output_file):
    # Open the input CSV file
    with open(input_file, mode='r', newline='', encoding='utf-8') as infile:
        reader = csv.reader(infile)
        
        # Ignore first line as its the headings which are only used for readability
        next(reader)

        # Open the output SQL file
        with open(output_file, mode='w', encoding='utf-8') as sqlfile:
            # Make sure the file contains use database to switch to correct database
            sqlfile.write("USE Olympics_21936856;\n\n")
            
            # Loop through each row in the CSV and create an INSERT statement
            for row in reader:
                # Create an INSERT statement for each row
                sql_statement = (
                    "INSERT INTO Athlete (Athlete_Code, Name, Gender, Country_Code, Country, Discipline, Event) "
                    f"VALUES ('{row[0]}', '{row[1]}', '{row[2]}', '{row[3]}', '{row[4]}', '{row[5]}', '{row[6]}');\n"
                )
                
                sqlfile.write(sql_statement)


input_csv = 'athletes.csv'
output_sql = 'Insert_Athletes.sql'
csv_to_sql(input_csv, output_sql)

