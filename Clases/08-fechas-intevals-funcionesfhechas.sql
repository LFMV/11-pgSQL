 /*
 	https://www.postgresql.org/docs/8.1/functions-datetime.html
 	https://neon.com/postgresql/postgresql-date-functions/postgresql-date_part 	
 */
 
 SELECT
 	now(),
 	CURRENT_DATE,
 	CURRENT_TIME,
 	date_part('hours', now() ) as hours,
 	date_part('minutes', now() ) as minutes,
 	date_part('seconds', now() ) as seconds,
 	date_part('days', now() ) as days,
 	date_part('months', now() ) as months,
 	date_part('years', now() ) as years;

SELECT * FROM employees
WHERE hire_date > DATE('1998-02-05')
ORDER BY hire_date DESC;

SELECT
	MAX(hire_date) as mas_nuevo,
	MIN(hire_date) as primer_empleado
FROM employees;

SELECT * FROM employees
WHERE hire_date BETWEEN '1999-01-01' AND '2000-01-01'
ORDER BY hire_date DESC;

-- INTERVALO
SELECT
	MAX(hire_date),
-- 	MAX(hire_date) + INTERVAL '1 days' AS IntervalDay,
-- 	MAX(hire_date) + INTERVAL '1 month' AS IntervalMonth,
-- 	MAX(hire_date) + INTERVAL '1 year' AS IntervalYear,
	MAX(hire_date) + INTERVAL '1 year 1 month 1 day ' AS IntervalYearMonth,
	date_part('year', now() ) AS year,
	make_interval( years := date_part('year', now())::INTEGER ),
	MAX(hire_date) + make_interval( years:= 23 )
FROM employees;

-- diferencia entre fechas
SELECT 
	hire_date, 
	MAKE_INTERVAL( YEARS := 2025 - EXTRACT( YEARS FROM hire_date )::INTEGER ) AS manual,
	MAKE_INTERVAL( YEARS := DATE_PART('years', CURRENT_DATE)::INTEGER - EXTRACT( YEAR FROM hire_date )::INTEGER ) AS cumputadora
FROM employees
ORDER BY hire_date DESC;

--Actualizacion masiva
SELECT
	hire_date,
	hire_date + INTERVAL '25 years'	
FROM employees
ORDER BY hire_date DESC;

UPDATE employees
SET hire_date = hire_date + INTERVAL '25 years';

-- clasula case-then rango A,B,C,D
SELECT 
	first_name,
	last_name,
	hire_date,
	CASE
		WHEN hire_date > now() - INTERVAL '1 year' THEN '1 año o menos'
		WHEN hire_date > now() - INTERVAL '3 year' THEN '1 a 3 años'
		WHEN hire_date > now() - INTERVAL '4 year' THEN '3 a 6 años'
		ELSE '+ de 6 años'
	END 
FROM employees
ORDER BY hire_date DESC;

