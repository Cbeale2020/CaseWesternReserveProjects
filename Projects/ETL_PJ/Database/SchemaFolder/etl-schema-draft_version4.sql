--DROP TABLE IF EXISTS imdb;
--DROP TABLE IF EXISTS movie_meta;
--DROP TABLE IF EXISTS movies;
--DROP TABLE IF EXISTS movies_merged;
--DROP TABLE IF EXISTS movies_streaming;
--DROP TABLE IF EXISTS rotten_tomatoes;
--DROP TABLE IF EXISTS stream_movie;
--DROP TABLE IF EXISTS genres;

SELECT * FROM imdb;
SELECT * FROM movie_meta;
SELECT * FROM movies_merged;
SELECT * FROM movies;
SELECT * FROM movies_streaming;
SELECT * FROM rotten_tomatoes;
SELECT * FROM stream_movie;
SELECT * FROM genres;

--Rotten Tomatoes Top 10 /Also you can see which have with Stream Services--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", sm."Netflix", sm."Hulu", sm."Prime Video"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN stream_movie AS sm ON rt.index = sm.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes Here's with a particular year--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", sm."Netflix", sm."Hulu", sm."Prime Video"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN stream_movie AS sm ON rt.index = sm.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND mm."Year" = 1970
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10; 

--Rotten Tomatoes Here's with a particular AGE--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", sm."Netflix", sm."Hulu", sm."Prime Video", mvm."Age"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN stream_movie AS sm ON rt.index = sm.index
INNER JOIN movies_merged AS mvm ON rt.index = mvm.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND mvm."Age" = '13+'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;
 

--Rotten Tomatoes By Action--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."action"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."action" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes By comedy--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."comedy"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."comedy" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes By documentary--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."documentary"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."documentary" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes By drama--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."drama"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."drama" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes By family--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."family"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."family" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes By horror--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."horror"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."horror" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes By sci-fi--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."sci-fi"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."sci-fi" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;

--Rotten Tomatoes By western--
SELECT rt."Rotten Tomatoes", mm."Year", mm."original_title", gn."western"
FROM movie_meta AS mm
INNER JOIN rotten_tomatoes AS rt ON rt.index = mm.index
INNER JOIN genres AS gn ON rt.index = gn.index
WHERE rt."Rotten Tomatoes" IS NOT NULL AND mm."original_title" IS NOT NULL AND gn."western" = '1'
ORDER BY rt."Rotten Tomatoes" DESC
LIMIT 10;


--IMbd Top 10 /Also you can see which have with Stream Services----
SELECT mmt."IMDb", mmt."Title", mmt."Year", sm."Netflix", sm."Hulu", sm."Prime Video"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN stream_movie AS sm ON mmt.index = sm.index
WHERE mmt."IMDb" IS NOT NULL
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Top 10 /Also you can see which have with Stream Services /See a particular Year----
SELECT mmt."IMDb", mmt."Title", mmt."Year", sm."Netflix", sm."Hulu", sm."Prime Video"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN stream_movie AS sm ON mmt.index = sm.index
WHERE mmt."IMDb" IS NOT NULL AND mmt."Year" = 1970
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Top 10 /Also you can see which have with Stream Services/ See a particular Age----
SELECT mmt."IMDb", mmt."Title", mmt."Year", sm."Netflix", sm."Hulu", sm."Prime Video", mvm."Age"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN stream_movie AS sm ON mmt.index = sm.index
INNER JOIN movies_merged AS mvm ON mmt.index = mvm.index
WHERE mmt."IMDb" IS NOT NULL AND mvm."Age" = '18+'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By action--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."action"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."action" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By comedy--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."comedy"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."comedy" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By documentary--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."documentary"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."documentary" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By drama--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."drama"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."drama" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By family--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."family"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."family" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By horror--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."horror"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."horror" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By sci-fi--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."sci-fi"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."sci-fi" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;

--IMbd Up By western--
SELECT mmt."IMDb", mmt."Title", mmt."Year", gn."western"
FROM movies_merged AS mmt
INNER JOIN imdb AS im ON im.index = mmt.index
INNER JOIN genres AS gn ON mmt.index = gn.index
WHERE mmt."IMDb" IS NOT NULL AND gn."western" = '1'
ORDER BY mmt."IMDb" DESC
LIMIT 10;



--Tables based off of the ERD--READ ONLY DO not use to Import---

CREATE TABLE rotten_tomatoes (
	index BIGINT SERIAL NOT NULL (primary_key=True),
	movie_ID BIGINT,	
	Rotten_Tomatoes TEXT;

CREATE TABLE imbd (
	index BIGINT SERIAL NOT NULL (primary_key=True),
	movie_ID BIGINT,
	imdb_id TEXT);	

CREATE TABLE movie_meta (
	index SERIAL NOT NULL (primary_key=True),
	movie_ID BIGINT,
	Year BIGINT,
	Genres TEXT,
	original_title TEXT);

CREATE TABLE movies (
	index SERIAL NOT NULL (primary_key=True),
	movie_ID BIGINT,
	Year INT,
	original_title TEXT);

CREATE TABLE moviesOnStreamingplatform (
	index SERIAL NOT NULL (primary_key=True),
	movie_ID BIGINT,
	Netflix BIGINT NOT NULL,
	Hulu BIGINT NOT NULL,
	Prime_Video BIGINT NOT NULL);

CREATE TABLE genres (
	index SERIAL NOT NULL (primary_key=True),
	movie_ID BIGINT,
	action',
	adventure TEXT',
	animation TEXT,
	biography TEXT,'
	comedy TEXT,
	crime TEXT,
	documentary TEXT,
	dramaTEXT,
	family TEXT,
	fantasy TEXT,
	film-noir TEXT,'
	game-show TEXT,
	history TEXT,
	horror TEXT,
	music TEXT,
	musical TEXT,
	mystery TEXT,
	news TEXT,
	reality-tv TEXT,
	romance TEXT,
	sci-fi TEXT,
	short TEXT,
	sport TEXT,'
	talk-showTEXT,
	thriller TEXT,
	war TEXT,
	western TEXT);