SELECT * FROM Athlete
WHERE Country_Code = (
	SELECT Country_Code FROM Athlete
	GROUP BY Country_Code
	ORDER BY COUNT(Athlete_Code) ASC LIMIT 1
);
