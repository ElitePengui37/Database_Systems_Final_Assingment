import csv

def generate_sql_from_csv(input_csv, output_sql):
    with open(input_csv, mode='r', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        
        with open(output_sql, mode='w', encoding='utf-8') as sqlfile:
            # Write the use statement for the database
            sqlfile.write("USE Olympics_21936856;\n\n")
            
            for row in reader:
                Increment_ID = row['Increment_ID']
                Team_Code = row['Team_Code']
                Team_Name = row['Team_Name']
                Discipline = row['Discipline']
                Event = row['Event']
                Athlete_Code = row['Athlete_Code'] if row['Athlete_Code'] else 'NULL'  # Handle NULL for Athlete_Code
                Coach_Code = row['Coach_Code'] if row['Coach_Code'] else 'NULL'  # Handle NULL for Coach_Code

                # Construct the INSERT statement
                insert_statement = f"""
INSERT INTO Team (Increment_ID, Team_Code, Team_Name, Discipline, Event, Athlete_Code, Coach_Code) VALUES ({Increment_ID}, '{Team_Code}', '{Team_Name}', '{Discipline}', '{Event}', {Athlete_Code}, {Coach_Code});"""
                # Write the statement to the SQL file
                sqlfile.write(insert_statement)

# Example usage
input_csv_file = 'teams.csv'
output_sql_file = 'Insert_Teams.sql'
generate_sql_from_csv(input_csv_file, output_sql_file)

