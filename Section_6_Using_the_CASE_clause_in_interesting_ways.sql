-- How to use CASE to query results?
SELECT first_name, salary, 
CASE
	WHEN salary < 100000 THEN 'UNDER PAID'
	WHEN salary > 100000 THEN 'PAID WELL'
	ELSE 'UNPAID'
END
FROM employees
ORDER BY salary DESC;

SELECT first_name, salary, 
CASE
	WHEN salary < 100000 THEN 'UNDER PAID'
	WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
	WHEN salary > 160000 THEN 'EXECUTIVE'
	ELSE 'UNPAID'
END AS category
FROM employees
ORDER BY salary DESC;

-- Return the total count of under paid, paid well, executive and unpaid employees
SELECT a.category, COUNT(*) 
FROM (
	SELECT first_name, salary, 
	CASE
		WHEN salary < 100000 THEN 'UNDER PAID'
		WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
		WHEN salary > 160000 THEN 'EXECUTIVE'
		ELSE 'UNPAID'
	END AS category
	FROM employees
	ORDER BY salary DESC
) AS a
GROUP BY a.category;

SELECT a.category, COUNT(*) 
FROM (
	SELECT first_name, salary, 
	CASE
		WHEN salary < 100000 THEN 0
		WHEN salary > 100000 AND salary < 160000 THEN 1
		WHEN salary > 160000 THEN 2
		ELSE 3
	END AS category
	FROM employees
	ORDER BY salary DESC
) AS a
GROUP BY a.category;

-- How to transpose the obtained data (how to switch rows for columns)?
SELECT 
	SUM
	( 
		CASE 
			WHEN salary < 100000 THEN 1 
			ELSE 0
		END
	) AS under_paid,
	SUM
	(
		CASE 
			WHEN salary > 100000 and salary < 150000 THEN 1 
			ELSE 0
		END
	) AS paid_well,
	SUM
	(
		CASE 
			WHEN salary > 150000 THEN 1 
			ELSE 0
		END
	) AS executive
FROM employees;

-- Select total number of employees working in departments ('Sports', 'Tools', 'Clothing', 'Computers')
SELECT department, COUNT(*)
FROM employees
WHERE department IN ('Sports', 'Tools', 'Clothing', 'Computers')
GROUP BY department;
	
-- Transpose the obtained table (switch rows for columns)	
SELECT 
	SUM 
	( 
		CASE 
			WHEN department = 'Sports' THEN 1 
			ELSE 0 
		END 
	) AS sports_employees,
	SUM 
	( 
		CASE 
			WHEN department = 'Tools' THEN 1 
			ELSE 0 
		END 
	) AS tools_employees,
	SUM 
	( 
		CASE 
			WHEN department = 'Clothing' THEN 1 
			ELSE 0 
		END 
	) AS clothing_employees,
	SUM 
	( 
		CASE 
			WHEN department = 'Computers' THEN 1 
			ELSE 0 
		END 
	) AS computers_employees
FROM employees;

-- Sort employees first_name by regions they work in and countries related to that region
SELECT * FROM regions;
SELECT * FROM employees;

SELECT first_name,
CASE WHEN region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) END AS region_1,
CASE WHEN region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) END AS region_2,
CASE WHEN region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) END AS region_3,
CASE WHEN region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) END AS region_4,
CASE WHEN region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5) END AS region_5,
CASE WHEN region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) END AS region_6,
CASE WHEN region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) END AS region_7
FROM employees;

-- Generate the total number of employees per each one of three countries with three columns and one row
SELECT COUNT(a.region_1) + COUNT(a.region_2) + COUNT(a.region_3) AS United_states,
COUNT (a.region_4) + COUNT(a.region_5) AS Asia,
COUNT (a.region_6) + COUNT(a.region_7) AS Canada
FROM (
SELECT first_name,
CASE WHEN region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) END AS region_1,
CASE WHEN region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) END AS region_2,
CASE WHEN region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) END AS region_3,
CASE WHEN region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) END AS region_4,
CASE WHEN region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5) END AS region_5,
CASE WHEN region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) END AS region_6,
CASE WHEN region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) END AS region_7
FROM employees) AS a;

-- Get total numbers of employees by summing up employees per each country
SELECT united_states + asia + canada
FROM (
SELECT COUNT(a.region_1) + COUNT(a.region_2) + COUNT(a.region_3) AS United_states,
COUNT (a.region_4) + COUNT(a.region_5) AS Asia,
COUNT (a.region_6) + COUNT(a.region_7) AS Canada
FROM (
SELECT first_name,
CASE WHEN region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) END AS region_1,
CASE WHEN region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) END AS region_2,
CASE WHEN region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) END AS region_3,
CASE WHEN region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) END AS region_4,
CASE WHEN region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5) END AS region_5,
CASE WHEN region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) END AS region_6,
CASE WHEN region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) END AS region_7
FROM employees) AS a
) AS b;