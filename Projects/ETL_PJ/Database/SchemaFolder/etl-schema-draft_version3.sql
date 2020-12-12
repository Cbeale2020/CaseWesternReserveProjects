--drop table if it already exist in the database-

DROP TABLE IF EXISTS moviesOnStreamingplatform;
DROP TABLE IF EXISTS rotten_tomatoes;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS movies_metadata;
DROP TABLE IF EXISTS imbd;


--select all statements to check the table is okay--

--SELECT * FROM ratings LIMIT 5;--
--SELECT * FROM rotten_tomatoes;--
--SELECT * FROM imbd;-- 
--SELECT * FROM movies_table;--
--SELECT * FROM moviesOnStreamingplatform;--
--SELECT * FROM genre;--
--SELECT * FROM movies_metadata;--



--Tables based off of the ERD--

CREATE TABLE ratings (
	id SERIAL NOT NULL (primary_key=True),
	movie_id INT NOT NULL,
	rating REAL NOT NULL);

CREATE TABLE rotten_tomatoes (
	id SERIAL NOT NULL (primary_key=True)
	movie_id INT NOT NULL,	
	Rotten_Tomatoes VARCHAR(5));

CREATE TABLE imbd (
	id INT SERIAL NOT NULL (primary_key=True),
	movie_id INT NOT NULL,
	imdb_id VARCHAR(500));	

CREATE TABLE movies_table (
	id SERIAL NOT NULL (primary_key=True)
	original_stitle VARCHAR(500) NOT NULL,
	Year INT);

CREATE TABLE moviesOnStreamingplatform (
	id SERIAL NOT NULL (primary_key=True)
	Netflix INT NOT NULL,
	Hulu INT NOT NULL,
	Prime_Video INT NOT NULL,
	movie_id INT NOT NULL);

CREATE TABLE genre (
	id SERIAL NOT NULL (primary_key=True),
	movie_id INT NOT NULL,
	genres_id INT NOT NULL,
	genres VARCHAR() NOT NULL);

CREATE TABLE movies_metadata (
	id INT SERIAL NOT NULL (primary_key=True),
	movie_id INT NOT NULL,
	genres VARCHAR() NOT NULL,
	original_stitle VARCHAR(500) NOT NULL,
	release_date DATE);

