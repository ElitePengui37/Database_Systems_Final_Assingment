-- a view that shows code name and gender as well as medal details all medalists from sweden

CREATE VIEW Sweden_Medalists AS 
SELECT Athlete.Athlete_Code, Athlete.Name, Athlete.Gender, Athlete.Country, Medals.Medal_Type, Medals.Medal_Date, Medals.Event_Type FROM Athlete
JOIN Medals ON Medals.Athlete_Code=Athlete.Athlete_Code
WHERE Athlete.Country LIKE 'Sweden';





-- example of using view
SELECT * FROM Sweden_Medalists
WHERE Gender LIKE 'M';
