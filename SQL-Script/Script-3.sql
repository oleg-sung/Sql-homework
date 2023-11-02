SELECT title, year FROM album
WHERE year = 2019;

SELECT name, duration FROM track
ORDER BY duration DESC
LIMIT 1;

SELECT name FROM track
WHERE duration >= 210;

SELECT title FROM compilation
WHERE year BETWEEN 2018 AND 2020;

SELECT nickname FROM performer
WHERE nickname NOT LIKE '% %';

SELECT name FROM track
WHERE name LIKE '%my%'; 

 