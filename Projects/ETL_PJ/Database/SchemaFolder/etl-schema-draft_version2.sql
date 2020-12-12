--drop table if it already exist in the database-
DROP TABLE IF EXISTS MoviesOnStreamingPlatform;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS ratings_small;
DROP TABLE IF EXISTS movies_metadatav2;

--select all statements to check the table is okay
SELECT * FROM MoviesOnStreamingPlatform;
SELECT * FROM ratings_small;
SELECT * FROM ratings
LIMIT 5;
SELECT * FROM movies_metadatav2

--currently none of these tables have primary or foreign keys

CREATE TABLE MoviesOnStreamingPlatform (
	ID SERIAL NOT NULL,
	Title VARCHAR NOT NULL,
	Year INT,
	Age VARCHAR(5),
	IMDb REAL,
	Rotten_Tomatoes VARCHAR(5),
	Netflix INT NOT NULL,
	Hulu INT NOT NULL,
	Prime_Video INT NOT NULL,
	Disney INT NOT NULL,
	Type INT NOT NULL,
	Directors VARCHAR(800),
	Genres VARCHAR(800),
	Country VARCHAR(800),
	Language VARCHAR(800),
	Runtime INT);


CREATE TABLE ratings (
	userId INT NOT NULL,
	movieId INT NOT NULL,
	rating REAL NOT NULL,
	timestamp interval NOT NULL);


CREATE TABLE ratings_small (
	userId INT NOT NULL,
	movieId INT NOT NULL,
	rating REAL NOT NULL,
	timestamp interval NOT NULL);

CREATE TABLE movies_metadatav2 (
	adult BOOLEAN NOT NULL,
	budget INT NOT NULL,	
	id INT NOT NULL,
	imdb_id VARCHAR(500),
	original_language CHAR(2),
	original_stitle VARCHAR(500) NOT NULL,
	popularity REAL,
	release_date DATE,
	revenue BIGINT,
	runtime REAL,
	status CHAR(50),
	title VARCHAR(500),
	video BOOLEAN,
	vote_average REAL,
	vote_count INT);