SELECT g.title, COUNT(performer_id) FROM genres_performer gp
LEFT JOIN genres g ON g.id = gp.genres_id  
GROUP BY g.title;

SELECT COUNT(*) FROM track t 
LEFT JOIN album a ON t.album_id  = a.id 
WHERE a."year"  BETWEEN 2019 AND 2020;

SELECT a.title  , AVG(t.duration) FROM track t
LEFT JOIN album a ON t.album_id  = a.id
GROUP BY a.title; 

SELECT p.nickname FROM album a 
LEFT JOIN album_performer ap ON ap.album_id  = a.id
LEFT JOIN performer p ON p.id = ap.performer_id  
WHERE not a."year" = 2020
GROUP BY p.nickname;

SELECT distinct c.title FROM compilation c
LEFT JOIN compilation_track ct ON ct.compilation_id = c.id  
LEFT JOIN track t ON ct.track_id = t.id  
LEFT JOIN album a ON t.album_id = a.id 
LEFT JOIN album_performer ap ON a.id = ap.album_id  
LEFT JOIN performer p ON p.id  = ap.performer_id 
WHERE p.nickname  LIKE 'AC/DC';

SELECT a.title from album a 
LEFT JOIN album_performer ap ON a.id = ap.album_id  
LEFT JOIN performer p ON p.id = ap.performer_id 
LEFT JOIN genres_performer gp ON gp.performer_id  = p.id
GROUP BY a.title 
HAVING COUNT(gp.genres_id) > 1;

SELECT t."name" from track t 
LEFT JOIN compilation_track ct ON ct.track_id = t.id  
WHERE ct.compilation_id IS NULL;

SELECT p.nickname FROM track t
LEFT JOIN album a ON t.album_id  = a.id 
LEFT JOIN album_performer ap ON a.id = ap.album_id 
LEFT JOIN performer p ON p.id  = ap.performer_id 
WHERE t.duration = (SELECT MIN(duration) FROM track t);

SELECT a.title , COUNT(*) FROM album a
LEFT JOIN track t ON t.album_id = a.id 
GROUP BY a.title 
HAVING COUNT(*) = 
				(SELECT COUNT(*) FROM album a
				LEFT JOIN track t ON t.album_id  = a.id 
				GROUP BY a.title 
				ORDER BY COUNT(*) 
				LIMIT 1)
;