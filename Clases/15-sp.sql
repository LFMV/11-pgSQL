
-- F
CREATE OR REPLACE FUNCTION country_region()
	RETURNS TABLE ( id CHARACTER(2), name VARCHAR(40), region VARCHAR(25) ) AS
$$

	BEGIN
		
		RETURN query
		
		SELECT 
		country_id,
		country_name,
		region_name
		FROM countries
		INNER JOIN regions
		ON countries.region_id = regions.region_id;
		
	END;

$$ LANGUAGE plpgsql;


SELECT * FROM country_region();

-- PROCEDURE #1
CREATE OR REPLACE PROCEDURE insert_region_proc ( INT, VARCHAR ) AS
$$
BEGIN
	INSERT INTO regions( region_id, region_name)
	VALUES ( $1, $2); -- 

	RAISE NOTICE 'VARIABLE 1: %, %', $1, $2;
-- 	ROLLBACK; --reviete NO DEJA INSERTAR
	COMMIT;	
END;
$$ LANGUAGE plpgsql;

CALL insert_region_proc( 5, 'Central America');
SELECT * from regions;

-- FUNCTION #
	CREATE OR REPLACE FUNCTION max_raise( empl_id int ) RETURNS NUMERIC(8,2) AS
	$$
	DECLARE
		possible_raise NUMERIC(8,2);
	
		BEGIN
		
			SELECT 
				max_salary -  salary INTO possible_raise
			FROM employees
			INNER JOIN jobs 
			ON jobs.job_id = employees.job_id
			WHERE employee_id = empl_id;		
			
			RETURN possible_raise;
			
		END;

	$$ LANGUAGE plpgsql;
 
 

-- PROCEDURE #2
-- percentage: 5/100
CREATE OR REPLACE PROCEDURE controlled_raise ( percentage NUMERIC ) AS
$$

DECLARE
	real_percentage NUMERIC(8,2);
	total_employee INT;

BEGIN
 	
 	real_percentage =  percentage / 100;
 	
	-- Insertar en el historico
	INSERT INTO raise_history( date, employee_id, base_salary, amount, percentage )	
	SELECT
		CURRENT_DATE as "date",
	 	employee_id,
	 	salary,
	 	max_raise( employee_id ) * real_percentage as amount,
 		percentage	
    FROM employees;

	-- Impactar la tabla de empleados
	UPDATE employees
		SET salary = ( max_raise( employee_id ) * real_percentage ) + salary;

	COMMIT;

	SELECT COUNT(*) INTO total_employee FROM employees;
	
	-- MENSAJE 
	RAISE NOTICE 'AFECTADOS % EMPLEADOS', total_employee;

END;
$$ LANGUAGE plpgsql;

CALL controlled_raise(1);

SELECT * FROM employees;
SELECT * FROM raise_history;