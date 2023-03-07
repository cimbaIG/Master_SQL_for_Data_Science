-- Get data from more tables based on the common column regions_id
SELECT first_name, country
FROM employees, regions
WHERE employees.region_id = regions.region_id;

-- Create report that contains first_name, email and division in which employee works in for all
-- employees with existing email entry.
SELECT *
FROM departments;

SELECT first_name, email, division
FROM employees, departments
WHERE employees.department = departments.department
AND employees.email != '';

SELECT first_name, email, division
FROM employees, departments
WHERE employees.department = departments.department
AND employees.email IS NOT NULL;

-- How to join three tables?
SELECT first_name, email, division, country
FROM employees, departments, regions
WHERE employees.department = departments.department
AND employees.region_id = regions.region_id
AND employees.email IS NOT NULL;

SELECT first_name, email, employees.department, division, country
FROM employees, departments, regions
WHERE employees.department = departments.department
AND employees.region_id = regions.region_id
AND employees.email IS NOT NULL;

SELECT first_name, email, e.department, division, country
FROM employees e, departments d, regions r
WHERE e.department = d.department
AND e.region_id = r.region_id
AND e.email IS NOT NULL;

-- Write a query that produces a country and total number of employees per country
-- First column is going to show country and second column is going to show the total
-- number of employees for that country.
SELECT *
FROM regions;

SELECT *
FROM employees;

SELECT country, COUNT(*)
FROM regions r, employees e
WHERE r.region_id = e.region_id
GROUP BY r.country;

SELECT country, COUNT(employee_id)
FROM employees e, regions r
WHERE e.region_id = r.region_id
GROUP BY country;

-- Subquery can also be a source of data
SELECT country, COUNT(employee_id)
FROM employees e, (SELECT * FROM regions) r
WHERE e.region_id = r.region_id
GROUP BY country;

-- Inner and Outer joins
-- Inner join
SELECT first_name, country
FROM employees INNER JOIN regions
ON employees.region_id = regions.region_id;

SELECT first_name, email, division
FROM employees INNER JOIN departments
ON employees.department = departments.department
WHERE email IS NOT NULL;

-- Inner join three tables
SELECT first_name, email, division, country
FROM employees INNER JOIN departments
ON employees.department = departments.department
INNER JOIN regions ON employees.region_id = regions.region_id
WHERE email IS NOT NULL;

-- Outer joins
-- Left outer join or left join - give me all those departments from the employees table 
-- regardless of whether or not they match the values in the departments table.
-- Left join gives the preference to the table on the left (e.g. employees
-- table in the following examples).
-- 27 rows obtained in total
SELECT DISTINCT department FROM employees; -- returns 27 departments
SELECT DISTINCT department FROM departments; -- returns 24 departments

SELECT DISTINCT employees.department, departments.department
FROM employees INNER JOIN departments ON employees.department = departments.department;

SELECT DISTINCT employees.department employees_department, 
				departments.department departments_department
FROM employees LEFT JOIN departments ON employees.department = departments.department;

SELECT DISTINCT employees.department employees_department, 
				departments.department departments_department
FROM employees LEFT OUTER JOIN departments ON employees.department = departments.department;

-- Right outer join or right join - gives preference to the table on the right.
-- Give me all those departments from the departments table 
-- regardless of whether or not they match the values in the employees table.
-- We give preference to the table on the right, i.e. table departments in the
-- following example.
-- 24 rows obtained in total
SELECT DISTINCT employees.department employees_department, 
				departments.department departments_department
FROM employees RIGHT JOIN departments ON employees.department = departments.department;

SELECT DISTINCT employees.department employees_department, 
				departments.department departments_department
FROM employees RIGHT OUTER JOIN departments ON employees.department = departments.department;

-- Exercise: Show only those departments that exist in the employees table but do not exist in the 
-- departments table.
SELECT DISTINCT employees.department employees_department
FROM employees LEFT JOIN departments ON employees.department = departments.department
WHERE departments.department IS NULL;

-- Full outer join (outer join): Shows departments that exist in the employees table, as well as 
-- departments that exist in the departments table but do not exist in the employees table.
SELECT DISTINCT employees.department employees_department, 
				departments.department departments_department
FROM employees FULL OUTER JOIN departments ON employees.department = departments.department;

-- Using UNION, UNION ALL and EXCEPT clauses
-- The columns must match!!!
-- UNION is used to stack one set of data to the top of another set of data.
-- UNION is going to remove any duplicates and stack all employees departments on the top
-- of the departments in departments table. All duplicates are going to be removed!!!
SELECT department 
FROM employees
UNION
SELECT department
FROM departments;

-- UNION ALL is going to take all of the records from the top query and all of the records 
-- from the bottom query and combine them together (including all duplicates).
-- UNION ALL does not eliminate duplicates!!!
-- It returns 1024 records (1000 from employees + 24 from departments).
SELECT department 
FROM employees
UNION ALL
SELECT department
FROM departments;

-- It returns 51 records (27 distinct values from employees + 24 from departments).
SELECT DISTINCT department 
FROM employees
UNION ALL
SELECT department
FROM departments;

-- What if columns do not match?! Query will not work because we are trying to combine
-- two columns with one column!
SELECT DISTINCT department, region_id
FROM employees
UNION ALL
SELECT department
FROM departments;

-- What if we try to combine columns that contain different data type?!
-- The query will not work because region_id column is numeric type and 
-- division column is string data!!!
SELECT DISTINCT department, region_id
FROM employees
UNION ALL
SELECT department, division
FROM departments;

-- We can make it work by changing the region_id column to the string type
-- column first_name (now data types do match)! Though it does not make sense
-- to combine those columns.
SELECT DISTINCT department, first_name
FROM employees
UNION ALL
SELECT department, division
FROM departments;

-- When using UNION clauses, ORDER BY should always come to the end of the query!!!
-- ORDER BY clause applies to the entire query!
SELECT DISTINCT department
FROM employees
UNION ALL
SELECT department
FROM departments
ORDER BY department;

-- EXCEPT clause takes the first result set and removes from it all of the rows found
-- in the second result set (it works as subtraction). In the OracleDB, EXCEPT clause does not
-- exist and MINUS clause has to be used!
-- If there are rows in the employees.department column that exist in the departments.department column,
-- they are going to be removed from the employees.department column. I.e., we are getting only those rows
-- that exist in the employees.department, but do not exist in the departments.department.
SELECT DISTINCT department
FROM employees
EXCEPT 
SELECT department
FROM departments;

-- Now we are getting only those rows that exist in the departments.department, but do not exist in the 
-- employees.department.
SELECT department
FROM departments
EXCEPT 
SELECT department
FROM employees;

-- Generate the report that shows break down by department, i.e. the department and the total number of 
-- employees working for that department. The last row must contain the value TOTAL in department column and
-- the total number of employees (1000) in the count column (TOTAL = 1000).
SELECT department, COUNT(*)
FROM employees
GROUP BY department
UNION ALL
SELECT 'TOTAL', COUNT(*)
FROM employees;

-- Cartesian Product with CROSS JOIN
-- Get number of rows returned by subquery
SELECT COUNT(*)
FROM (SELECT * FROM employees, departments) a;

-- When join type is not specified, every single combination of rows is returned, i.e. for 24 entries from
-- departments table and 1000 entries from employees table, the 1000 * 24 = 24000 combinations are returned.
-- This is called cartesian product or cross join.
SELECT * 
FROM employees, departments;

-- Query returns the total number of 1000 * 1000 = 1 000 000 records.
SELECT COUNT(*)
FROM (SELECT *
FROM employees a, employees b) sub;

-- How to use cross join?
SELECT *
FROM employees a CROSS JOIN departments b;

-- Exercises --
-- Write a query that returns the first_name, department, hire_date and country of the first employees that
-- was hired in the company, as well as the last employee hired in the company.
-- My solution
SELECT first_name, department, hire_date, country
FROM employees INNER JOIN regions
ON employees.region_id = regions.region_id
WHERE hire_date = (SELECT MIN(hire_date) FROM employees) OR
hire_date = (SELECT MAX(hire_date) FROM employees);

-- Udemy solution
(SELECT first_name, department, hire_date, country
FROM employees e INNER JOIN regions r
ON e.region_id = r.region_id
WHERE hire_date = (SELECT MIN(hire_date) FROM employees e2)
LIMIT 1)
UNION ALL
SELECT first_name, department, hire_date, country
FROM employees e INNER JOIN regions r
ON e.region_id = r.region_id
WHERE hire_date = (SELECT MAX(hire_date) FROM employees e2)
ORDER BY hire_date;

-- Write a query that shows how the salary spending budget fluctuates every 90-day period.
-- Concept of the MOVING RANGE --
SELECT hire_date, salary, 
(SELECT SUM(salary) 
 FROM employees e2
WHERE e2.hire_date BETWEEN e.hire_date - 90 AND e.hire_date) AS spending_pattern
FROM employees e
ORDER BY hire_date;

-- Creating Views vs. Inline Views
CREATE VIEW v_employee_information AS
SELECT first_name, email, e.department, salary, division, region, country
FROM employees e, departments d, regions r
WHERE e.department = d.department
AND e.region_id = r.region_id;

-- You cannot insert data to view nor delete data from view!
SELECT * 
FROM v_employee_information;

SELECT first_name, region
FROM v_employee_information;

-- Inline view: When you have a subquery inside the from clause, this is called
-- inline view. For instance:
SELECT *
FROM (SELECT * FROM departments) d;