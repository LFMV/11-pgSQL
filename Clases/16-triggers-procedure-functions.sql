]CREATE EXTENSION pgcrypto;

INSERT INTO "users" ( username, PASSWORD )
VALUES(
	'Fernando',
	crypt( '12345', gen_salt('bf'))
);

SELECT* FROM users;

SELECT COUNT(*) FROM "users"
WHERE username = 'Fernando' AND
PASSWORD = crypt('12345', password);



CREATE OR REPLACE PROCEDURE user_login( user_name VARCHAR, user_password VARCHAR ) AS $$
DECLARE
	was_found BOOLEAN;

BEGIN
	
	SELECT COUNT(*) INTO was_found
	FROM "users"
	WHERE username = user_name AND
	password = crypt( user_password, password );

	IF ( was_found = FALSE ) THEN
		INSERT INTO session_failed( username, "when" ) VALUES( user_name, now() );
		COMMIT;	
		
		RAISE EXCEPTION 'Usuario y contraseña son incorrectos';
	END IF;

	UPDATE "users" SET last_login = now() WHERE username = user_name;

	COMMIT;
	RAISE NOTICE 'Usuario encontrado %', was_found;
	
END;
$$ LANGUAGE plpgsql;


CALL user_login('Fernando', '12345');

-- TRIGGER
CREATE OR REPLACE TRIGGER create_session_trigger AFTER UPDATE ON users 
FOR EACH ROW 
	WHEN ( OLD.last_login IS DISTINCT FROM NEW.last_login )
EXECUTE FUNCTION created_session_login();	

-- FUNCTION
CREATE OR REPLACE FUNCTION created_session_login() RETURNS TRIGGER AS $$
	BEGIN
		INSERT INTO "session" ( user_id, last_login ) VALUES ( NEW.id, now() );
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;




