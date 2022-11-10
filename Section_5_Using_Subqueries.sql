-- Aliasing...
SELECT first_name, last_name, *
FROM employees;

SELECT d.department
FROM employees e, departments d;

-- Introducing subqueries...
SELECT *
FROM employees
WHERE department NOT IN (SELECT department FROM departments);

SELECT *
FROM (SELECT * FROM employees WHERE salary > 150000) AS a;

SELECT a.first_name, a.salary
FROM (SELECT * FROM employees WHERE salary > 150000) AS a;

SELECT a.employee_name, a.yearly_salary
FROM (SELECT first_name employee_name, salary yearly_salary
	  FROM employees WHERE salary > 150000) AS a;

SELECT employee_name, yearly_salary
FROM (SELECT first_name employee_name, salary yearly_salary
	  FROM employees WHERE salary > 150000) AS a;
	  
SELECT a.employee_name, a.yearly_salary
FROM (SELECT first_name employee_name, salary yearly_salary
	  FROM employees WHERE salary > 150000) AS a,
	  (SELECT department employee_name FROM departments) b;
	  
-- Exercises...
SELECT *
FROM employees
WHERE department IN (SELECT department FROM departments);

SELECT *
FROM (SELECT department FROM departments) AS a;

SELECT first_name, last_name, salary, (SELECT first_name FROM employees LIMIT 1)
FROM employees;

-- A query that returns all of those employees who work in electronics division...
SELECT *
FROM departments;

SELECT *
FROM employees
WHERE department IN (SELECT department FROM departments WHERE division = 'Electronics');
	  
-- Get all employees that work in Asia or Canada and that make > 130000 dollars
SELECT * 
FROM employees;

SELECT *
FROM regions;

SELECT *
FROM employees
WHERE region_id IN (SELECT region_id FROM regions 
					WHERE (country = 'Asia' OR country = 'Canada')) 
AND salary > 130000;

SELECT *
FROM employees
WHERE region_id IN (SELECT region_id FROM regions 
					WHERE country IN('Asia','Canada')) 
AND salary > 130000;

-- Show the first_name and the department that employee works for along with 
-- how much less they make than the highest paid employee in the company. Show
-- this only for the employees that work in Asia or Canada...
SELECT first_name, department, salary, (SELECT MAX(salary) FROM employees) max_salary,
((SELECT MAX(salary) FROM employees) - salary) salary_diff
FROM employees
WHERE region_id IN (SELECT region_id FROM regions 
					WHERE country IN('Asia','Canada'));
					
-- Subqueries with ANY and ALL operators
SELECT *
FROM regions;

SELECT *
FROM employees
WHERE region_id IN (SELECT region_id FROM regions WHERE country = 'United States');

SELECT *
FROM employees
WHERE region_id > ANY (SELECT region_id FROM regions WHERE country = 'United States');

SELECT *
FROM employees
WHERE region_id > ALL (SELECT region_id FROM regions WHERE country = 'United States');

-- Write a query that returns all of those employees that work in the kids division AND
-- the dates at which those employees were hired is greater than all of the hire_dates
-- of employees who work in the maintenance department.
SELECT *
FROM employees
WHERE department IN (SELECT department 
					 FROM departments 
					 WHERE division = 'Kids')
AND hire_date > ALL (SELECT hire_date 
					 FROM employees 
					 WHERE department = 'Maintenance');

SELECT *
FROM employees
WHERE department = ANY (SELECT department 
					 FROM departments 
					 WHERE division = 'Kids')
AND hire_date > ALL (SELECT hire_date 
					 FROM employees 
					 WHERE department = 'Maintenance');

-- Get the salary that appears most frequently
SELECT salary
FROM (
		SELECT salary, COUNT(*)
		FROM employees
		GROUP BY salary
		ORDER BY COUNT(*) DESC, salary DESC
		LIMIT 1
	) AS a;

SELECT salary
FROM employees
GROUP BY salary
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM employees
					  GROUP BY salary)
ORDER BY salary DESC
LIMIT 1;

-- More practice with subqueries
CREATE TABLE dupes (id integer, name varchar(10));

INSERT INTO dupes VALUES (1,'FRANK');
INSERT INTO dupes VALUES (2,'FRANK');
INSERT INTO dupes VALUES (3,'ROBERT');
INSERT INTO dupes VALUES (4,'ROBERT');
INSERT INTO dupes VALUES (5,'SAM');
INSERT INTO dupes VALUES (6,'FRANK');
INSERT INTO dupes VALUES (7,'PETER');

SELECT *
FROM dupes;

SELECT DISTINCT name
FROM dupes;

-- Write a query that shows distinct names with one of id values that correspond to it
SELECT MIN(id), name 
FROM dupes
GROUP BY name

SELECT *
FROM dupes
WHERE id IN (
	SELECT min(id) 
	FROM dupes 
	GROUP BY name
)

-- How to delete duplicate queries?
DELETE
FROM dupes
WHERE id NOT IN (
	SELECT min(id) 
	FROM dupes 
	GROUP BY name
)

-- Drop table
DROP TABLE dupes;

-- Compute the average salary for all the employees but exclude the minimum
-- and the maximum salaries (the highes paid and the lowest paid employees)...
SELECT ROUND(AVG(salary))
FROM employees
WHERE salary < ALL (SELECT MAX(salary) 
					FROM employees) AND 
	  salary > ALL (SELECT MIN(salary) 
					FROM employees);

SELECT ROUND(AVG(salary))
FROM employees
WHERE salary NOT IN (
	(SELECT MIN(salary) FROM employees),
	(SELECT MAX(salary) FROM employees)
);