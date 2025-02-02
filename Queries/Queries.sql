-- simple queries


-- 1.
-- display a list of athlete details for athletes that are from Norway

SELECT * FROM Athlete
WHERE Country LIKE 'Norway';


-- 2.
-- display the code, name, gender, discipline and organisation country of all the technical officials whose organisation country is Autralia and who have a code between 1,500,000 and 2,000,000
SELECT Code, Name, Gender, Disciplines, Organisation_Country FROM Technical_Officials
WHERE Organisation_Country LIKE 'Australia' AND Code BETWEEN '1500000' AND '2000000';

-- 3.
-- find the total of each type of medal in the medals table
SELECT Medal_Type, COUNT(*) AS 'Medal Total' FROM Medals
GROUP BY Medal_Type;

-- 4.
-- Find the most common disciplines for technical officials show most common on the top and least common at the bottom also have a count of how many technical officials do that discipline
SELECT Disciplines, COUNT(*) AS 'Number Of Occurences' FROM Technical_Officials
GROUP BY Disciplines
ORDER BY COUNT(*) DESC;





-- complex queries

-- 5.
-- display all of the athletes in the country with the least athletes
SELECT * FROM Athlete
WHERE Country_Code = (
	SELECT Country_Code FROM Athlete
	GROUP BY Country_Code
	ORDER BY COUNT(Athlete_Code) ASC LIMIT 1
);

-- 6.
-- Find the Codes and Names of all gold medalists as well as the date of the medals, order names alphabetically
SELECT Medals.Athlete_Code, Athlete.Name, Medals.Medal_Type FROM Medals
JOIN Athlete ON Athlete.Athlete_Code=Medals.Athlete_Code
WHERE Medals.Medal_Type LIKE 'Gold'
ORDER BY Name ASC;



-- 7.
-- Find the Names, Genders and countries of all the players in the team that has the most number of players
SELECT Athlete.Name, Athlete.Gender, Athlete.Country FROM Athlete
JOIN Team ON Athlete.Athlete_Code=Team.Athlete_Code
WHERE Team.Team_Code = (
	SELECT Team.Team_Code FROM Team
	GROUP BY Team.Team_Code
	ORDER BY COUNT(Team.Team_Code) DESC LIMIT 1);


-- 8.
-- for teams that have coaches find all the details about the coach that has the lowest value in coach code
SELECT Team.Coach_Code, Coach.`Function`, Coach.Name, Coach.Gender FROM Team
JOIN Coach ON Coach.Coach_Code=Team.Coach_Code
WHERE Team.Coach_Code = (
	SELECT MIN(Coach_Code) FROM Team
	WHERE Coach_Code IS NOT NULL);
