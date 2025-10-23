
	SELECT greet_employee('Fernando');
	SELECT first_name, greet_employee(first_name) FROM employees;


	CREATE OR REPLACE FUNCTION greet_employee ( employee_name VARCHAR) RETURNS VARCHAR AS
	$$
	-- DECLARE
	BEGIN
		RETURN 'hola ' || employee_name;
	END;
	$$
	LANGUAGE plpgsql;

	-- SELECT
	SELECT 
		employee_id,
		first_name,
		salary,
		max_salary,
		max_salary -  salary AS possible_raise,
		max_raise( employee_id ),
		max_raise2( employee_id )
	FROM employees
	INNER JOIN jobs 
	ON jobs.job_id = employees.job_id;
	
	SELECT * FROM employees WHERE employee_id = 206;

	SELECT max_raise(206);
	SELECT employee_id, first_name, max_raise(employee_id) FROM employees;
	
	
	-- FUNCTION #1
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

	
	-- FUNCTION #2
	CREATE OR REPLACE FUNCTION max_raise2( empl_id int ) RETURNS NUMERIC(8,2) AS
	$$
	DECLARE
		employee_job_id INT;
		current_salary NUMERIC(8,2);
		
		job_max_salary NUMERIC(8,2);
		possible_raise NUMERIC(8,2);
	
		BEGIN
		
			-- Tomar el puesto de trabjo y el salario
			SELECT 
				job_id,	salary
				INTO
				employee_job_id, current_salary				
			FROM employees
			WHERE employee_id = empl_id;
			
			-- Tomar el max salary acorde a su job
			SELECT 
				max_salary INTO job_max_salary
			FROM jobs 
			WHERE job_id = employee_job_id;
			
			-- Cáculos
			possible_raise = job_max_salary - current_salary;

			IF ( possible_raise < 0 ) THEN
				RAISE EXCEPTION 'Persona con salario mayor max_salary: %', empl_id;
-- 				possible_raise = 0;
			END IF;
			
			RETURN possible_raise;
			
		END;

	$$ LANGUAGE plpgsql;

	SELECT 
		employee_id, first_name, max_raise2( employee_id ) 
	FROM employees 
	WHERE employee_id = 206;

-- FUNCTION #3 Modificada usando rowtype
	CREATE OR REPLACE FUNCTION max_raise3( empl_id int ) RETURNS NUMERIC(8,2) AS
	$$
	DECLARE
		selected_employee employees%rowtype; -- se tiene toda la información de la línea
		selected_job jobs%rowtype;
				
		possible_raise NUMERIC(8,2);
	
		BEGIN
		
			-- Tomar el puesto de trabjo y el salario
			SELECT * FROM employees INTO selected_employee
			WHERE employee_id = empl_id;
			
			-- Tomar el max salary acorde a su job
			SELECT * FROM jobs INTO selected_job
			WHERE job_id = selected_employee.job_id;
			
			-- Cáculos
			possible_raise = selected_job.max_salary - selected_employee.salary;

			IF ( possible_raise < 0 ) THEN
				RAISE EXCEPTION 
					'Persona con salario mayor max_salary: id:%, %', 
							selected_employee.employee_id, selected_employee.first_name;
-- 				possible_raise = 0;
			END IF;
			
			RETURN possible_raise;
			
		END;

	$$ LANGUAGE plpgsql;

	SELECT 
		employee_id, first_name, max_raise3( employee_id ) 
	FROM employees 
	WHERE employee_id = 206;

	
	 
	

	