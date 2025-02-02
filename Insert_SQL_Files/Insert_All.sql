-- this file Calls all the insert files in the correct order to keep referential integrity (takes roughly 10 minutes to run)

-- makes sure the database is correct
use Olympics_21936856;

-- sourcing all insert files
SOURCE Insert_Athletes.sql;

SOURCE Insert_Coaches.sql;

SOURCE Insert_Teams.sql;

SOURCE Insert_Medals.sql;

SOURCE Insert_Schedules.sql;

SOURCE Insert_Events.sql;

SOURCE Insert_Technical_Officials.sql;
