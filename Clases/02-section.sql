/* 

    AGREGAR = COUNT, SUM, MAX, AVG, MIN, GROUP BY, HAVING, ORDER BY    
    FILTRADO - LIKE, IN, IS NULL, IS NOT NULL, WHERE, AND, OR, BETWEEN

    SELECT *, CAMPOS, ALIAS, FUNCIONES
    WHERE = CONDITION, CONDITIONS, AND, OR , IN, LIKE

    JOINS

    GROUP BY = CAMPO AGRUPADO, ALL
    HAVING = CONDITION
    ORDER BY = EXPRESSION, ASC, DESC
    LIMIT = VALOR, ALL
    OFFSET = PUNTO INICIAL


*/

select * from users;

-- Nombre, apellido e IP, donde la última conexión se dió de 221.XXX.XXX.XXX
SELECT
	first_name,
	last_name,
	last_connection
FROM
	users
WHERE
	last_connection LIKE '221.%';

	-- Nombre, apellido y seguidores(followers) de todos a los que lo siguen más de 4600 personas|
SELECT
	COUNT(*) AS total_users,
	MIN(followers) AS min_followers,
	MAX(followers) AS max_followers,
	ROUND( AVG(followers) ) AS promedio_redondeo_followers,
	AVG(followers)  AS promedio_followers,
	SUM(followers) / COUNT(*) AS promedio_manual
FROM
	users;

SELECT first_name, last_name, followers
FROM users
WHERE followers = 4 or followers = 4999;

/* GROUP BY */
SELECT
	COUNT(*),
	followers
FROM
	users
WHERE
	followers = 4
	OR followers = 4999
GROUP BY
	followers
ORDER BY
	followers ASC;

/* HAVING = CONDICIONA */
SELECT
	COUNT(*),
	country
FROM
	users
GROUP BY
	country
HAVING
	COUNT(*) > 5 -- PODEMOS APLICAR OTRAS INSTRUCCIONES COMO BETWEEN
ORDER BY
	COUNT(*) DESC

-- /* DISTINCT = AL MENOS 1, PERO SI TENEMOS UN ESPACIO EN CADA UNO DEL NOMBRE PUEDE TOMARLO COMO OTRO PAÍS */
SELECT DISTINCT
	country
FROM
	users;

/* POSICIONA EL ARROBA Y MAS 1 EMPIEZA A CONTAR HACIA LA DERECHA*/
SELECT
	COUNT(*),
	SUBSTRING(email, POSITION('@' IN email) + 1) AS domain
FROM
	users
GROUP BY SUBSTRING(email, POSITION('@' IN email) + 1)
HAVING COUNT(*) > 1;
ORDER BY
	SUBSTRING(email, POSITION('@' IN email) + 1) ASC