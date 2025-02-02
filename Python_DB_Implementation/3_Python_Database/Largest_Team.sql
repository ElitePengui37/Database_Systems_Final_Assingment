
SELECT Athlete.Name, Athlete.Gender, Athlete.Country FROM Athlete
JOIN Team ON Athlete.Athlete_Code=Team.Athlete_Code
WHERE Team.Team_Code = (
	SELECT Team.Team_Code FROM Team
	GROUP BY Team.Team_Code
	ORDER BY COUNT(Team.Team_Code) DESC LIMIT 1);
