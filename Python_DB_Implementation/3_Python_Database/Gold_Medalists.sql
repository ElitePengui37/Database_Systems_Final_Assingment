SELECT Medals.Athlete_Code, Athlete.Name, Medals.Medal_Type FROM Medals
JOIN Athlete ON Athlete.Athlete_Code=Medals.Athlete_Code
WHERE Medals.Medal_Type LIKE 'Gold'
ORDER BY Name ASC;
