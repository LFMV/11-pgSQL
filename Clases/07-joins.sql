
-- UNION
SELECT * FROM continent WHERE name like '%America%'
UNION
SELECT * FROM continent WHERE code IN (1, 5)
ORDER BY name ASC;

-- UNION DE TABLAS
SELECT * FROM country;
SELECT * FROM continent;

-- WHERE JOIN
SELECT a."name" AS country, b."name" AS continent 
FROM country a, continent b
WHERE a.continent = b.code
ORDER BY a."name" ASC;

-- INNER JOIN
SELECT a."name" as country, b."name" as continent
FROM country a
INNER JOIN continent b 
ON a.continent = b.code
ORDER BY a."name" ASC;


-- Reinicia la secuencia del Id incremental
ALTER SEQUENCE continent_code_seq RESTART WITH 8;

-- FULL OUTER JOIN = se usa para saber que registros no no se estab usando de la tabla
SELECT a."name" as country, a.continent as continentCode, b."name" AS continentName
FROM country a
FULL OUTER JOIN continent b
ON a.continent = b.code
ORDER BY a."name" DESC;

-- RIGHT OUTER JOIN - revisa que no este asociado a nada
SELECT a."name" as country, a.continent as continentCode, b."name" AS continentName
FROM country a
RIGHT JOIN continent b
ON a.continent = b.code
WHERE a.continent IS NULL
ORDER BY a."name" DESC;

--Sub QUERYS con INNER JOIN
( SELECT COUNT(*) AS count, 
	     b."name" AS continentName
FROM country a
INNER JOIN continent b 
ON a.continent = b.code
GROUP BY b."name" )

UNION

( SELECT 0 as count, 
		 b."name"
FROM country a
RIGHT JOIN continent b 
ON a.continent = b.code
WHERE a.continent IS NULL
GROUP BY b."name" )
ORDER BY count;

-- Ejemplo #1
SELECT COUNT(*) FROM country;
SELECT * FROM continent;

( SELECT COUNT(*) as Total,
	   b."name" as continentName 
FROM country a
INNER JOIN continent b 
ON a.continent = b.code
WHERE b."name" NOT LIKE '%America%'
GROUP BY b."name" )
UNION
-- Agrupa solo america
( SELECT COUNT(*) AS total,
		 'America'
FROM country a
INNER JOIN continent b  
ON a.continent = b.code
WHERE b."name" LIKE '%America%' )
ORDER BY total ASC;

-- Ejemplo #2
SELECT * FROM city;
SELECT * FROM country;

SELECT COUNT(*) AS total, 
	   b."name" AS country 
FROM city a
INNER JOIN country b 
ON a.countrycode = b.code
GROUP BY b."name"
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) FROM city WHERE countrycode = 'NLD';

-- Ejemplo #2 IDIOMAS OFICIALES QUE SE HABLAN POR CONTINENTE
SELECT DISTINCT d."name", c."name" AS continent FROM countrylanguage a
INNER JOIN country b ON a.countrycode = b.code
INNER JOIN continent c ON b.continent = c.code
INNER JOIN "language" d ON d.code = a.languagecode
WHERE a.isofficial = TRUE;

-- Ejemplo #3 Cuantos idiomas oficiales se habla por continente
SELECT COUNT(*), continent FROM (
	SELECT a."language", c."name" AS continent FROM countrylanguage a
	INNER JOIN country b ON a.countrycode = b.code
	INNER JOIN continent c ON b.continent = c.code
	WHERE a.isofficial = TRUE
) AS totales
GROUP BY continent;



