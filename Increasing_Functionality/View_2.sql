-- Simple view that displays all teams that have more then 5 players in alphabetical order

CREATE VIEW DisplayLargeTeams AS
	SELECT Team_Code, Team_Name, Discipline, Event, COUNT(Athlete_Code) AS `Player Count` FROM Team
	GROUP BY Team_Code, Team_Name, Discipline, Event
	HAVING COUNT(Athlete_Code) > 5;



-- using the view
SELECT * FROM DisplayLargeTeams;
