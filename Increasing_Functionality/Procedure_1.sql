-- copy the part within the delimiter into sql to create the procedure

DELIMITER // -- delimiter prevents ; from ending the procedure

CREATE PROCEDURE InsertIntoAthlete ( -- in paramaters
	IN athlete_Code INTEGER(7),
	IN name VARCHAR(255),
	IN gender CHAR(1),
	IN country_Code CHAR(3),
	IN country VARCHAR(64),
	IN discipline VARCHAR(128),
	IN event VARCHAR(255)
)

BEGIN
	INSERT INTO Athlete (Athlete_Code, Name, Gender, Country_Code, Country, Discipline, Event) -- insert query
	VALUES(athlete_Code, name, gender, country_Code, country, discipline, event);
END //

DELIMITER ; -- delimiter changed back to normal





-- How to Run Procedure

CALL InsertIntoAthlete('1111111', 'Test Name', 'M', 'AUS', 'Australia', 'Boxing', 'Mens 51kg'); -- procedure called




-- How to tes Procedure to see if it works

SELECT * FROM Athlete WHERE Athlete_Code = '1111111'; -- value is checked
