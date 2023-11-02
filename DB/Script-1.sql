CREATE TABLE IF NOT EXISTS album (
	id serial PRIMARY KEY,
	title varchar(60) NOT NULL,
	year int
);

CREATE TABLE IF NOT EXISTS genres (
	id serial PRIMARY KEY,
	title varchar(60) NOT null
);

CREATE TABLE IF NOT EXISTS performer (
	id serial PRIMARY KEY,
	nickname varchar(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS compilation (
	id serial PRIMARY KEY,
	title varchar(60) NOT NULL,
	year int
);

CREATE TABLE IF NOT EXISTS track (
	id serial PRIMARY KEY,
	name varchar(60) NOT NULL,
	duration integer NOT NULL,
	album_id int REFERENCES album(id)
);


CREATE TABLE IF NOT EXISTS compilation_track (
	track_id int NOT NULL REFERENCES track(id),
	compilation_id int NOT NULL REFERENCES compilation(id),
	CONSTRAINT pk_compilation_track PRIMARY KEY (compilation_id, track_id)
);

CREATE TABLE IF NOT EXISTS album_performer (
	album_id int NOT NULL REFERENCES album(id),
	performer_id int NOT NULL REFERENCES performer(id),
	CONSTRAINT pk_album_performer PRIMARY KEY (album_id, performer_id)
);

CREATE TABLE IF NOT EXISTS genres_performer (
	genres_id int NOT NULL REFERENCES genres(id),
	performer_id int NOT NULL REFERENCES performer(id),
	CONSTRAINT pk_genres_performer PRIMARY KEY (performer_id, genres_id)
);