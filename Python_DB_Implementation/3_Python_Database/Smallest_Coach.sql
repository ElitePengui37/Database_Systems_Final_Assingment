SELECT Team.Coach_Code, Coach.`Function`, Coach.Name, Coach.Gender FROM Team
JOIN Coach ON Coach.Coach_Code=Team.Coach_Code
WHERE Team.Coach_Code = (
	SELECT MIN(Coach_Code) FROM Team
	WHERE Coach_Code IS NOT NULL);
