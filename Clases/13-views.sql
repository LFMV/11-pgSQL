
-- CREATE OR REPLACE VIEW comments_per_week AS
CREATE VIEW comments_per_week AS
SELECT 
	date_trunc('week', posts.created_at ) AS weeks, 
	COUNT( DISTINCT posts.post_id ) AS number_of_posts,
	SUM( claps.counter ) AS total_claps
FROM posts
INNER JOIN claps 
ON claps.post_id = posts.post_id
GROUP BY weeks
ORDER BY weeks DESC;


-- SELECT * FROM posts WHERE post_id = 1; 
SELECT * FROM comments_per_week;

CREATE MATERIALIZED VIEW comments_per_week_mat AS
SELECT 
	date_trunc('week', posts.created_at ) AS weeks, 
	COUNT( DISTINCT posts.post_id ) AS number_of_posts,
	SUM( claps.counter ) AS total_claps
FROM posts
INNER JOIN claps 
ON claps.post_id = posts.post_id
GROUP BY weeks
ORDER BY weeks DESC;

SELECT * FROM comments_per_week_mat;
SELECT * FROM comments_per_week;

REFRESH MATERIALIZED VIEW comments_per_week_mat;

ALTER VIEW comments_per_week RENAME TO posts_per_weeks2;
ALTER MATERIALIZED VIEW comments_per_week_mat RENAME TO comments_per_week_mat2;


--tabla virtual es una tabla en memoria

-- SELECT * FROM posts_per_weeks2;

WITH post_week_2025 AS (
	SELECT date_trunc('week'::text, posts.created_at) AS weeks,
    count(DISTINCT posts.post_id) AS number_of_posts,
    sum(claps.counter) AS total_claps
   	FROM posts
    JOIN claps ON claps.post_id = posts.post_id
  	GROUP BY (date_trunc('week'::text, posts.created_at))
  	ORDER BY (date_trunc('week'::text, posts.created_at)) DESC
)
SELECT * FROM post_week_2025;

-- campo que vamos a tener
WITH RECURSIVE countdown( val ) AS (

	-- inicializacion
	SELECT 5 AS val
	UNION
	-- query recurdivo
	SELECT val - 1 FROM countdown WHERE val > 1
	
)
SELECT * FROM countdown ORDER BY val ASC;

-- campo que vamos a tener
WITH RECURSIVE counter( val ) AS (

	-- inicializacion
	SELECT 1 AS val
	UNION
	-- query recurdivo
	SELECT val + 1 FROM counter WHERE val < 10
	
)
SELECT * FROM counter;


WITH RECURSIVE multiplication_table( base, val, result ) AS (

	-- init
	SELECT 5 AS base, 1 AS val, 5 AS result
-- 	VALUES(5,1,5)
	UNION
	--Recursive
	SELECT 5 AS base, val + 1, (val + 1) * base FROM multiplication_table
	WHERE val < 10 
	

)
SELECT * FROM multiplication_table;




SELECT * FROM employees;

WITH RECURSIVE bosses AS (

	-- init
	SELECT 
		id, 
		name,
	    reports,
	    1 AS depth
	FROM employees
	WHERE reports IS NULL
	
	UNION
	
	-- Recursive
	SELECT 
		employees.id,
	    employees.name, 
	    employees.reports,
	    depth + 1
	FROM employees
	INNER JOIN bosses 
	ON bosses.id = employees.reports
	WHERE depth < 4
	
)
SELECT * 
FROM bosses
LEFT JOIN employees 
ON employees.id = bosses.reports
ORDER BY depth
;






