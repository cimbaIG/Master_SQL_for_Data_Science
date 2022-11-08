DROP TABLE cars;
CREATE TABLE cars(make varchar(10));

SELECT * 
FROM cars;

INSERT INTO cars VALUES ('HONDA');
INSERT INTO cars VALUES ('HONDA');
INSERT INTO cars VALUES ('HONDA');
INSERT INTO cars VALUES ('TOYOTA');
INSERT INTO cars VALUES ('TOYOTA');
INSERT INTO cars VALUES ('NISSAN');
INSERT INTO cars VALUES (NULL);
INSERT INTO cars VALUES (NULL);
INSERT INTO cars VALUES (NULL);
INSERT INTO cars VALUES (NULL);

SELECT COUNT(*), make 
FROM cars
GROUP BY make;

SELECT make, COUNT(*)
FROM cars
GROUP BY make;

--------------------------------------
SELECT department, SUM(salary)
FROM employees
WHERE 1=1
GROUP BY department;

SELECT department, SUM(salary)
FROM employees
WHERE region_id IN (4,5,6,7)
GROUP BY department;

SELECT department, COUNT(employee_id) AS "Number of employees"
FROM employees
GROUP BY department;

SELECT department, COUNT(*)
FROM employees
GROUP BY department;

SELECT department, COUNT(*) total_number_employees, ROUND(AVG(salary)) avg_sal, MIN(salary) min_sal, MAX(salary) max_sal
FROM employees
WHERE salary > 70000
GROUP BY department
ORDER BY total_number_employees DESC;

SELECT department, gender, count(*)
FROM employees
GROUP BY department, gender
ORDER BY department;

-- Using HAVING for filtering aggregated data...
SELECT department, count(*)
FROM employees
GROUP BY department
HAVING count(*) > 35
ORDER BY department;

-------------------------------------------------
-- Using GROUP BY and HAVING clauses practice...

SELECT * FROM employees;

-- How many company employees have the same first name?
SELECT first_name, count(*) first_name_duplicates
FROM employees
GROUP BY first_name
ORDER BY first_name_duplicates DESC;

-- Filter only those employees whose names are not unique!
SELECT first_name, count(*) first_name_duplicates
FROM employees
GROUP BY first_name
HAVING COUNT(*) > 1
ORDER BY first_name_duplicates DESC;

-- Filter out unique departments...
SELECT DISTINCT department
FROM employees;

SELECT department, count(*)
FROM employees
GROUP BY department;

SELECT department
FROM employees
GROUP BY department;

-- Filter out the total number of employees for a specific email domain...
SELECT SUBSTRING(email, POSITION('@' IN email) + 1) AS "domain", COUNT(*) AS num_of_employees_with_domain
FROM employees
WHERE email IS NOT NULL
GROUP BY "domain"
ORDER BY num_of_employees_with_domain DESC;

SELECT substring(email, position('@' IN email) + 1) as email_domain, count(*)
FROM employees
WHERE email IS NOT NULL
GROUP BY substring(email, position('@' IN email) + 1)
ORDER BY COUNT(*) DESC

-- SQL query that produces table with min, max and avg salaries broken down by region and gender
SELECT gender, region_id, MIN(salary) min_salary, MAX(salary) max_salary, ROUND(AVG(salary)) avg_salary
FROM employees
GROUP BY gender, region_id
ORDER BY gender, region_id