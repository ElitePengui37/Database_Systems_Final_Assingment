SELECT Code, Name, Gender, Disciplines, Organisation_Country FROM Technical_Officials
WHERE Organisation_Country LIKE 'Australia' AND Code BETWEEN '1500000' AND '2000000';
