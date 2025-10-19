

SELECT * FROM country;
SELECT DISTINCT continent FROM country;
SELECT * FROM country WHERE code = 'CRI';

/* Agregar una Primary key */
ALTER TABLE country
ADD PRIMARY KEY (code);

/*  Se eliminio debido a que existian 2 code */
SELECT * FROM country WHERE code = 'NLD';
DELETE FROM country WHERE code = 'NLD' AND code2 = 'NA';

/* CHECK es un CONSTRAINT especial para verificar un campo */
ALTER TABLE country
ADD CHECK (surfacearea >= 0);

/* CKECK */
ALTER TABLE country ADD CHECK(
	(continent = 'Asia'::text ) OR
	(continent = 'South America'::text ) OR
	(continent = 'North America'::text ) OR
	(continent = 'Oceania'::text ) OR
	(continent = 'Antarctica'::text ) OR
	(continent = 'Africa'::text ) OR
	(continent = 'Europe'::text ) OR
	(continent = 'Central America'::text ) 	
);

/* Borrar CONTRAINT*/
ALTER TABLE country DROP CONSTRAINT "country_continent_check";

/* INDEX */

SELECT * FROM country WHERE continent = 'Africa';

CREATE INDEX "country_continent" on country (
	continent
);

CREATE UNIQUE INDEX "unique_country_name" on country (
	name
);
