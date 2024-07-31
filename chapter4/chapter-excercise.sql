CREATE TABLE movie (
    id serial,
	movie text,
	actor text
);

COPY movie (id, movie, actor)
FROM 'C:\01-my-folder\Work\code-college\my_code\software\sql\chapter4\movie.txt'
WITH (FORMAT CSV, HEADER, DELIMITER ':');

SELECT * FROM movie;

/* next query */

COPY (
 SELECT geo_name, state_us_abbreviation, population_count_100_percent
 FROM us_counties_2010
 ORDER BY population_count_100_percent LIMIT 20
 ) 
TO 'C:\01-my-folder\Work\code-college\my_code\software\sql\chapter4\top-20.txt'
WITH (FORMAT CSV, HEADER);

/* next query */

CREATE TABLE numeric_example (
	numbers numeric(3,8)
);

INSERT INTO numeric_example (numbers)
VALUES 
	(17519.668),
	(20084.461),
	(18976.335);