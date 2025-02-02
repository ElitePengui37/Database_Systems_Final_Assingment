SELECT Disciplines, COUNT(*) AS 'Number Of Occurences' FROM Technical_Officials
GROUP BY Disciplines
ORDER BY COUNT(*) DESC;
