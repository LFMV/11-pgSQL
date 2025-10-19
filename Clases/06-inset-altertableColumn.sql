SELECT * FROM country;

-- Inserta el nombre de los continentes de tabla a tabla
INSERT INTO
	continent (name)
SELECT DISTINCT
	continent
FROM
	country
ORDER BY
	continent ASC;

-- Borrar los datos fila
DELETE FROM continent WHERE code IN (9, 10, 11, 12, 13, 14, 15, 16);
SELECT * FROM continent;

-- Realizar un backup de una tabla a otra tabla
INSERT INTO
	country_bk
SELECT
	*
FROM
	country;

SELECT * FROM country_bk;
SELECT * FROM country;

-- Eliminar un check
ALTER TABLE country DROP CONSTRAINT country_continent_check;

-- Query de que compara las 2 tablas que conincidan y cambiamos el nombre a code 
SELECT
	a.name,
	a.continent,
	( SELECT "code" FROM continent b WHERE b.name = a.continent )
FROM
	country a;

-- Actualiza la tabla continentes ya con número
UPDATE country a
SET continent = ( SELECT "code" FROM continent b WHERE b.name = a.continent );

-- Cambia el tipo dato a la columna
ALTER TABLE country 
ALTER COLUMN continent TYPE int4
USING continent::integer; --casteo

-- Borrar una tabla
DROP TABLE country_bk;



-- Tarea con countryLanguage

-- Crear la tabla de language

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;


-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);

-- inserta los lenguajes que hay
INSERT INTO "language" ( name )
SELECT DISTINCT "language" FROM countrylanguage ORDER BY "language" ASC;

SELECT * FROM "language"; -- tabla 
SELECT * FROM countrylanguage; -- tabla 

-- Empezar con el select para confirmar lo que vamos a actualizar
SELECT "language", 
-- 	   ( SELECT "name" FROM "language" b WHERE a."language" = b."name")
	   ( SELECT code FROM "language" b WHERE a."language" = b."name")
FROM countrylanguage a;


-- Actualizar todos los registros

UPDATE countrylanguage a SET
	languagecode = (
		SELECT
			code
		FROM
			"language" b
		WHERE
			a."language" = b."name"
	);

-- Cambiar tipo de dato en countrylanguage - languagecode por int4
ALTER TABLE countrylanguage
ALTER COLUMN languagecode TYPE int4
USING languagecode::INTEGER;

-- Crear el forening key y constraints de no nulo el language_code

-- Revisar lo creado
SELECT * FROM countrylanguage;