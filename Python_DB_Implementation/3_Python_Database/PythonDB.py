import mysql.connector

conn = mysql.connector.connect(user='dsuser', password='userCreateSQL', host='localhost', database='Olympics_21936856') # establish connection to DB with dsuser
cursor = conn.cursor() # create cursor

if conn.is_connected(): 
    choice = 0
    
    print("Welcome to the Olympics database MySQL Python interface\n")
    
    while choice != 5: # while exit option is not chosen
        print("What would you like to do:")
        print("1. Create a New Entry in Table")
        print("2. Read (Query from file)")
        print("3. Update an Existing Entry in the Athlete table")
        print("4. Delete an Entry in the Athlete table")
        print("5. Exit")
        
        try:
            choice = int(input(": ")) # prompt user to choose option
        except ValueError:
            print("Invalid input\n")
            continue
        

        if choice == 1:  # choice 1: insert value into a table
            table_name = input("Enter the table name to insert into: ").strip() # user enters table name

            try:
                cursor.execute(f"DESCRIBE {table_name}")  # retrieve table structure (columns and their types)
                table_structure = cursor.fetchall()

                if not table_structure: # run this if entered table doesnt exist
                    print(f"'{table_name}' doesn't exist\n\n")
                    continue

                values = []
                placeholders = []  # placeholder for prepared statement to allow one insert query to work on any table

                # Loop through columns, prompt user for each value
                for column in table_structure:
                    value = input(f"Enter value for {column[0]} (type: {column[1]}): ").strip()

                    if value == "":  # If a string is empty it is NULL
                        values.append(None)  # NULL value
                    else:
                        values.append(value)
                    
                    placeholders.append("%s")  # Add placeholder for every column used in prepared statement

                
                query = f"INSERT INTO {table_name} VALUES({', '.join(placeholders)})"  # prepared INSERT statement with placeholders which allows this insert query to work with any table
                
                try: # execute the query
                    cursor.execute(query, tuple(values))
                    conn.commit()  # Commit the changes to database
                    print("Entry added successfully.")
                except mysql.connector.Error as err:
                    print(f"Error: {err}")

            except mysql.connector.Error as err:  # throw error if can't retrieve table structure most common cause is table not existing
                print(f"Error fetching table structure: {err}\n")
                

        elif choice == 2:  # choice 2: query from file
            # print all file options
            print("\n\nChoose file:")
            print("(Norway_Athletes.sql) -- Displays all athletes from Norway")
            print("(Australian_Officials.sql) -- Displays all technical officials from Australia with a coach code between 1.5 million and 2 million")
            print("(Medal_Count.sql) -- Displays the total of each type of medal")
            print("(Common_Disciplines.sql) -- Displays most common discipline for technical officials in descending order")
            print("(Smallest_Country.sql) -- Displays details of all athletes in country with least athletes")
            print("(Gold_Medalists.sql) -- Displays info on gold medalists")
            print("(Largest_Team.sql) -- Displays info on the largest teams' athletes")
            print("(Smallest_Coach.sql) -- Displays info on coach with smallest team number that coaches a team\n")

            file_name = input("Enter the name of the file: ").strip() # prompt user for file name

            try:
                with open(file_name, 'r') as sql:
                    query = sql.read().strip()  # open file and place query into variable
                
                cursor.execute(query) # execute query
                display = cursor.fetchall()  # fetch results
                
                print("\n\nQuery results:") # display all items from query
                for item in display:
                    print(item)
                print("\n\n")

            except FileNotFoundError: # error checking
                print("Error: Specified file cannot be found.")
            except mysql.connector.Error as e:
                print(f"An error has occurred: {e}")


        elif choice == 3:  # choice 3: update an Athlete entry
            print("Updating value in Athlete Table")
            
            try:
                # user input values
                athlete_code = input("Enter updated Athlete Code: ").strip()
                name = input("Enter updated Name: ").strip()
                gender = input("Enter updated Gender: ").strip()
                country_code = input("Enter updated Country Code: ").strip()
                country = input("Enter updated Country: ").strip()
                discipline = input("Enter updated Discipline: ").strip()
                event = input("Enter updated Event: ").strip()
                
                # mapping inputs to dictionary
                params = {
                    'Athlete_Code': athlete_code,
                    'Name': name,
                    'Gender': gender,
                    'Country_Code': country_code,
                    'Country': country,
                    'Discipline': discipline,
                    'Event': event
                }
                
                # prepared update query
                update = "UPDATE Athlete SET Name = %(Name)s, Gender = %(Gender)s, Country_Code = %(Country_Code)s, Country = %(Country)s, Discipline = %(Discipline)s, Event = %(Event)s WHERE Athlete_Code = %(Athlete_Code)s"
                
                # query run
                cursor.execute(update, params)
                conn.commit()
                
                print("\nValue Updated\n\n")
                
            except mysql.connector.Error as e:
                print(f"An error has occurred: {e}")

        elif choice == 4:  # choice 4: delete an entry from athlete table
            
            try:
                # primary key of deleted value
                athlete_code = input("Enter Athlete code to delete: ").strip()
                
                # prepared query
                delete_query = f"DELETE FROM Athlete WHERE Athlete_Code = %s"

                # execute the DELETE query
                cursor.execute(delete_query, (athlete_code,))
                conn.commit()  # Commit the deletion

                # check if update worked
                if cursor.rowcount > 0:
                    print("Entry deleted successfully.")
                else:
                    print("No matching entry found.")

            except mysql.connector.Error as e:
                print(f"An error has occurred: {e}")




cursor.close()
conn.close()
