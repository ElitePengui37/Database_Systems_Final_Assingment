-- Clean Database if need to rebuild it
DROP DATABASE IF EXISTS Olympics_21936856;

-- Create fresh database
CREATE DATABASE Olympics_21936856;


-- use the newly created database
use Olympics_21936856;

-- first create the tables that dont depend on other tables

  -- create Coach table
CREATE TABLE Coach (
	Coach_Code INTEGER(7) NOT NULL,
	Name VARCHAR(255),
	Gender CHAR(1) NOT NULL,
	`Function` VARCHAR(64),
	PRIMARY KEY(Coach_Code)
);

  -- create Schedule Table
CREATE TABLE Schedule (
	Day DATE NOT NULL,
	Discipline_Code CHAR(3) NOT NULL,
	Event VARCHAR(255) NOT NULL,
	Phase VARCHAR(64) NOT NULL,
	Venue VARCHAR(64) NOT NULL,
	PRIMARY KEY(Day, Discipline_Code, Event, Phase)
);

  -- create Techniacal Officials table
CREATE TABLE Technical_Officials (
	Code INTEGER(7) NOT NULL,
	Disciplines VARCHAR(255) NOT NULL,
	`Function` VARCHAR(32) NOT NULL,
	Organisation_Country VARCHAR(64) NOT NULL,
	Name VARCHAR(255),
	Gender CHAR(1) NOT NULL,
	PRIMARY KEY(Code)
); 

-- create Athlete table
CREATE TABLE Athlete (
	Athlete_Code INTEGER(7) NOT NULL,
	Name VARCHAR(255),
	Gender CHAR(1) NOT NULL,
	Country_Code CHAR(3) NOT NULL,
	Country VARCHAR(64) NOT NULL,
	Discipline VARCHAR(128) NOT NULL,
	Event VARCHAR(255) NOT NULL,
	PRIMARY KEY(Athlete_Code)
);


-- next create tables with Foreign Key depndencies (Referential dependencies)


-- Create Team table
CREATE TABLE Team (
	Increment_ID INTEGER(7) NOT NULL,
	Team_Code CHAR(17) NOT NULL,
	Team_Name VARCHAR(128) NOT NULL,
	Discipline VARCHAR(64) NOT NULL,
	Event VARCHAR(64),
	Athlete_Code INTEGER(7), -- this field is multivalued so has been normalized to 1nf in .csv file
	Coach_Code INTEGER(7),	-- this field is multivalued so has been normalized to 1nf in .csv file
	PRIMARY KEY(Team_Code, Increment_ID),
	FOREIGN KEY (Athlete_Code) REFERENCES Athlete(Athlete_Code)
);

-- Create Medals Table
CREATE TABLE Medals (
	Athlete_Code INTEGER(7) NOT NULL,
	Medal_Type VARCHAR(6) NOT NULL,
	Medal_Date DATE NOT NULL,
	Event_Type VARCHAR(5) NOT NULL,
	PRIMARY KEY(Athlete_Code),
	FOREIGN KEY (Athlete_Code) REFERENCES Athlete(Athlete_Code)
);


-- create Event Table
CREATE TABLE Event (
	Event_Name VARCHAR(255) NOT NULL,
	Sport_Code CHAR(3) NOT NULL,
	Sport_Type VARCHAR(32) NOT NULL,
	Day DATE NOT NULL,
	Phase VARCHAR(64) NOT NULL,
	PRIMARY KEY(Event_Name, Sport_Code),
	FOREIGN KEY (Day, Sport_Code, Event_Name, Phase)  -- Composite foreign key
		REFERENCES Schedule(Day, Discipline_Code, Event, Phase)
);
