CREATE TABLE IF NOT EXISTS album (
	id serial PRIMARY KEY,
	title VARCHAR(60) NOT NULL,
	year INT
);

CREATE TABLE IF NOT EXISTS genres (
	id serial PRIMARY KEY,
	title VARCHAR(60) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS performer (
	id serial PRIMARY KEY,
	nickname VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS compilation (
	id serial PRIMARY KEY,
	title VARCHAR(60) NOT NULL,
	year INT
);

CREATE TABLE IF NOT EXISTS track (
	id serial PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	duration INTEGER NOT NULL,
	album_id INT REFERENCES album(id)
);


CREATE TABLE IF NOT EXISTS compilation_track (
	track_id INT NOT NULL REFERENCES track(id),
	compilation_id INT NOT NULL REFERENCES compilation(id),
	CONSTRAINT pk_compilation_track PRIMARY KEY (compilation_id, track_id)
);

CREATE TABLE IF NOT EXISTS album_performer (
	album_id INT NOT NULL REFERENCES album(id),
	performer_id INT NOT NULL REFERENCES performer(id),
	CONSTRAINT pk_album_performer PRIMARY KEY (album_id, performer_id)
);

CREATE TABLE IF NOT EXISTS genres_performer (
	genres_id INT NOT NULL REFERENCES genres(id),
	performer_id INT NOT NULL REFERENCES performer(id),
	CONSTRAINT pk_genres_performer PRIMARY KEY (performer_id, genres_id)
);