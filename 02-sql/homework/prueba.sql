 
CREATE TABLE IF NOT EXISTS "actors" (
  "id" int(11) NOT NULL DEFAULT '0',
  "first_name" varchar(100) DEFAULT NULL,
  "last_name" varchar(100) DEFAULT NULL,
  "gender" char(1) DEFAULT NULL,
  PRIMARY KEY ("id")
);
CREATE TABLE IF NOT EXISTS "directors" (
  "id" int(11) NOT NULL DEFAULT '0',
  "first_name" varchar(100) DEFAULT NULL,
  "last_name" varchar(100) DEFAULT NULL,
  PRIMARY KEY ("id")
);


CREATE TABLE IF NOT EXISTS "movies" (
  "id" int(11) NOT NULL DEFAULT '0',
  "name" varchar(100) DEFAULT NULL,
  "year" int(11) DEFAULT NULL,
  "rank" float DEFAULT NULL,
  PRIMARY KEY ("id")
);


CREATE TABLE IF NOT EXISTS "directors_genres" (
  "director_id" int(11) DEFAULT NULL,
  "genre" varchar(100) DEFAULT NULL,
  "prob" float DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS "movies_directors" (
  "director_id" int(11) DEFAULT NULL,
  "movie_id" int(11) DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "movies_genres" (
  "movie_id" int(11) DEFAULT NULL,
  "genre" varchar(100) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS "roles" (
  "actor_id" int(11) DEFAULT NULL,
  "movie_id" int(11) DEFAULT NULL,
  "role" varchar(100) DEFAULT NULL
);


SELECT directors.first_name ||" "|| directors.last_name AS Full_name , movies.name AS Pelicula , movies.year AS año  
FROM directors 
JOIN movies_directors ON movies_directors.director_id = directors.id
JOIN movies_genres ON movies_directors.movie_id = movies_genres.movie_id
JOIN movies ON movies_genres.movie_id= movies.id
WHERE genre = 'Film-Noir' AND year%4=0 ORDER BY Pelicula ;

° Bacon
Listá todos los actores que hayan trabajado con Kevin Bacon en películas de Drama (incluí el título de la peli). Excluí al señor Bacon de los resultados.

actors, genre, movie , roles

SELECT movies.name AS Titulo, movies.year, movies_genres.genre  FROM movies JOIN roles ON roles.movie_id= movies.id JOIN actors ON roles.actor_id= actors.id JOIN movies_genres ON movies_genres.movie_id= movies.id WHERE first_name= "Kevin" AND last_name= "Bacon" AND genre= "Drama" ;



SELECT actors.first_name, actors.last_name, movies.name FROM actors JOIN roles ON roles.actor_id= actors.id JOIN movies ON roles.movie_id= movies.id
WHERE movies.id
 IN (
    SELECT movies.id 
     FROM movies 
     JOIN roles ON roles.movie_id= movies.id
      JOIN actors ON roles.actor_id= actors.id 
      JOIN movies_genres ON movies_genres.movie_id= movies.id
     WHERE first_name= "Kevin" AND last_name= "Bacon" AND genre= "Drama"
    );


Immortal Actors
Qué actores actuaron en una película antes de 1900 y también en una película después del 2000?

SELECT actors.id AS Id, (actors.first_name||" "||actors.last_name) AS Actor  FROM actors JOIN roles ON roles.actor_id= actors.id JOIN movies ON
roles.movie_id= movies.id
WHERE movies.year>= 2000 AND actors.id
IN(
SELECT actors.id FROM actors JOIN roles ON roles.actor_id= actors.id JOIN movies ON
roles.movie_id= movies.id WHERE movies.year <= 1900 ORDER BY year ) GROUP BY Actor ;

Busy Filming
Buscá actores que actuaron en cinco o más roles en la misma película después del año 1990. Noten que los ROLES pueden tener duplicados ocasionales, sobre los cuales no estamos interesados: queremos actores que hayan tenido cinco o más roles DISTINTOS (DISTINCT cough cough) en la misma película. Escribí un query que retorne los nombres del actor, el título de la película y el número de roles (siempre debería ser > 5).


SELECT a.first_name,
    a.last_name,
    m.name,
    COUNT(DISTINCT r.role) as nveces
FROM actors as a
    JOIN roles as r ON a.id = r.actor_id
    JOIN movies as m ON r.movie_id = m.id
WHERE m.year > 1990
GROUP BY a.id,
    m.id
HAVING nveces > 5;


