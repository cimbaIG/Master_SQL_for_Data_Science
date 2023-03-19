-- 1.) Write a query against the professors table that can output
-- the following in the result: "Chong works in the Science department."
SELECT last_name ||' works in the '|| department ||' department.'
FROM professors;

-- 2.) Write a SQL query against the professors table that would return
-- the following result: "It is false that professor Chong is highly paid."
SELECT last_name, (salary > 95000) AS highly_paid
FROM professors;

SELECT 'It is ' ||(salary > 95000)|| ' that professor ' || last_name || ' is highly paid'
FROM professors;

-- 3.) Write a query that returns all of the records and columns from the professors table
-- but shortens the department names to only the first three characters in upper case.
SELECT last_name, UPPER(SUBSTRING(department FROM 1 FOR 3)) AS shortened, salary, hire_date
FROM professors;

SELECT last_name,
UPPER(SUBSTRING(department, 1, 3)) as department, salary, hire_date
FROM professors;

-- 4.) Write a query that will display the hire date of the professor that has been teaching
-- the longest.
SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary
FROM professors
WHERE last_name != 'Wilson';

-- 5.) Write a query that will display the hire date  of the professor that has been 
-- teaching the longest.
SELECT MIN(hire_date) AS hire_date
FROM professors;