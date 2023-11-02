INSERT INTO album (title, "year")
VALUES
	('Stoners Night', 2022),
	('Huncho Jack', 2017),
	('A Night At The Odeon', 2015),
	('Gone Shootin', 2019),
	('Voyage', 2021),
	('Electro Swing Sessions', 2017),
	('Магадан', 2004),
	('Hully Gully Twist', 2016);

INSERT INTO genres (title)
VALUES
	('Реп'),
	('Рок'),
	('Диско'),
	('Шансон'),
	('Блюз');

INSERT INTO performer (nickname)
VALUES
	('Wiz Khalifa'),
	('Travis Scott'),
	('Queen'),
	('AC/DC'),
	('ABBA'),
	('Blue System'),
	('Михаил Круг'),
	('Би Би Кинг');

INSERT INTO track (name, duration, album_id)
VALUES
	('Testin', 295, 1),	
	('Weak', 239, 1),
	('Saint', 209, 2),
	('Go', 349, 2),
	('Ogre Battle', 117, 3),
	('Killer Queen', 222, 3),
	('Live Wire', 415, 4),
	('Sin City', 532, 4),
	('I Still Have Faith In You', 279, 5),
	('Little Things', 237, 5),
	('Greek', 259, 6),
	('Magic', 219, 6),
	('Лебеди', 193, 7),
	('Магадан', 163, 7),
	('Come By Here',214, 8);


INSERT INTO compilation (title, "year")
VALUES 
	('Streets', 2017),
	('Ghetto', 2016),
	('80s rock classic', 2020),	
	('Best Rock', 2021),
	('Disco 60s', 2017),
	('The best disco of our time', 2022),	
	('Русский шансон', 2008),
	('King bluesа', 2015);


INSERT INTO compilation_track (track_id, compilation_id)
VALUES
	(1, 1),
	(3, 1),
	(2, 2),
	(4, 2),
	(5, 3),
	(7, 3),
	(6, 4),
	(8, 4),
	(9, 5),
	(10, 5),
	(11, 6),
	(12, 6),
	(13, 7),
	(14, 7),
	(15, 8);

INSERT INTO genres_performer (performer_id, genres_id)
VALUES 
	(1,1),
	(2,1),
	(3,2),
	(4,2),
	(5,3),
	(6,3),
	(7,4),
	(8,5);

INSERT INTO album_performer (performer_id, album_id)
VALUES 
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,8);
