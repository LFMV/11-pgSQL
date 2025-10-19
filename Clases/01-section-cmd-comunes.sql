
/* DEFINITIONS

    DDL = DATA DEFINITION LANGUAGE ( Create, Alter, Drop, Truncate ).
    DML = DATA MANIPULATION LANGUAGE ( Insert, Delete, Update ).
    TCL = TRANSITION CONTROL LANGUAGE ( Commit, Rollback ),
    DQL = DATA QUERY LANGUAGE ( Select )

*/ 


/* INSET, UPDATE, DELETE */
INSERT INTO users (name) VALUES 'Luis'

UPDATE users SET name = 'Luis' WHERE name = 'LuisM';

DELETE FROM users WHERE name ='Luis';


/* EJERCICIOS */
-- 1. Ver todos los registros
SELECT * FROM users;

-- 2. Ver el registro cuyo id sea igual a 10
SELECT * FROM users WHERE id = 10;

-- 3. Quiero todos los registros que cuyo primer nombre sea Jim (engañosa)
SELECT * FROM users WHERE  name LIKE 'Jim %';

-- 4. Todos los registros cuyo segundo nombre es Alexander
SELECT * FROM users WHERE  name LIKE '% Alexander';

-- 5. Cambiar el nombre del registro con id = 1, por tu nombre Ej:'Fernando Herrera'
UPDATE users SET name = 'Luis Fernando' WHERE id = 1;
SELECT * from users WHERE id = 1;

-- 6. Borrar el último registro de la FROM

DELETE FROM users WHERE id = ( SELECT MAX(id) FROM users );


/* OPERADORES STRINGS Y FUNCIONES */ 
SELECT
    id,
    UPPER( name ) as upper_name,
    LOWER( name ) as lower_name,
    LENGTH( name ) as LENGTH,
    ( 20 * 2) as constante,
    CONCAT('*' || id || '-' || name '*' ),
    name
from
    users;
,

-- SUBSTRING, TRIM, POSITION 
SELECT name,
--        substring( name, 0, 5 ),  /* corta */
--        position( ' ' in name ) /* indica la posición de la letra*/
       substring( name, 0, position( ' ' in name ) ) as fist_name,
       substring( name, 0, position( ' ' in name ) + 1 ) as last_name,
--        trim( substring(name, 0, position( ' ' in name )) ) as trim_last_name
FROM users;

UPDATE users
SET
	first_name = substring(name, 0, position(' ' IN name)),
	last_name = substring(name, 0, position(' ' IN name) + 1);

select * from users;

