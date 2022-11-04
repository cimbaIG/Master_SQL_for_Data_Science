SELECT * 
FROM employees 
WHERE department IN ('Sports','First Aid','Toys','Garden');

SELECT *
FROM employees
WHERE salary BETWEEN 80000 AND 100000;

SELECT first_name, email
FROM employees
WHERE GENDER = 'F'
AND department = 'Tools'
AND salary > 110000;

SELECT first_name, hire_date
FROM employees
WHERE salary > 165000
OR (department = 'Sports' AND gender = 'M');

SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2002-01-01' AND '2004-01-01';

SELECT *
FROM employees
WHERE (department = 'Automotive' AND gender = 'M' AND salary > 40000 AND salary < 100000)
OR (gender = 'F' AND department = 'Toys');

-- Hey just review this query for me...

SELECT *
FROM employees
ORDER BY employee_id DESC;

SELECT *
FROM employees
ORDER BY department;

SELECT *
FROM employees
ORDER BY department DESC;

SELECT *
FROM employees
ORDER BY salary DESC;

-- Get unique department values
SELECT DISTINCT department
FROM employees;

SELECT DISTINCT department
FROM employees
ORDER BY 1;

SELECT DISTINCT department
FROM employees
ORDER BY 1
LIMIT 10;

SELECT DISTINCT department AS sorted_departments
FROM employees
ORDER BY 1
FETCH FIRST 10 ROWS ONLY;

-- How to use aliases
SELECT first_name, last_name, department, salary AS "Yearly salary"
FROM employees;