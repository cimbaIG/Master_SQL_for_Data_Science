SELECT * FROM
employees;

SELECT UPPER(first_name), LOWER(department)
FROM employees;

SELECT LENGTH(first_name)
FROM employees;

SELECT LENGTH(TRIM('   HELLO THERE   '));

SELECT first_name ||' '|| last_name AS full_name
FROM employees;

SELECT first_name ||' '|| last_name full_name
FROM employees;

SELECT first_name ||' '|| last_name AS full_name, (salary > 140000) AS is_highly_paid
FROM employees;

SELECT first_name ||' '|| last_name AS full_name, (salary > 140000) AS is_highly_paid
FROM employees
ORDER BY boolean_column DESC;

SELECT first_name ||' '|| last_name AS full_name, (salary > 140000) AS is_highly_paid
FROM employees
ORDER BY salary DESC;

SELECT department, ('Clothing' IN (department, first_name))
FROM employees;

SELECT department, (department LIKE '%oth%')
FROM employees;

SELECT 'This is test data' test_data;

SELECT SUBSTRING('This is test data' FROM 1 FOR 4) test_data_extracted;

SELECT SUBSTRING('This is test data' FROM 9 FOR 4) test_data_extracted;

SELECT SUBSTRING('This is test data' FROM 9) test_data_extracted;

SELECT SUBSTRING('This is test data' FROM 3) test_data_extracted;

SELECT department, 
REPLACE(department, 'Clothing', 'Attire') AS modified_data
FROM departments;

SELECT department ||' department' AS modified_departments
FROM departments;

SELECT department,
REPLACE(department, 'Clothing', 'Attire') AS modified_data,
department ||' department' AS "Complete Department Name"
FROM departments;

SELECT *
FROM employees;

SELECT SUBSTRING(email, POSITION('@' IN email))
FROM employees;

SELECT SUBSTRING(email, POSITION('@' IN email) + 1)
FROM employees;

SELECT email, SUBSTRING(email, POSITION('@' IN email) + 1) AS email_domains
FROM employees;

SELECT COALESCE(email, 'NONE') AS email
FROM employees;

SELECT UPPER(first_name), LOWER(last_name)
FROM employees;

SELECT MAX(salary)
FROM employees;

SELECT MIN(salary)
FROM employees;

SELECT ROUND(AVG(salary))
FROM employees;

SELECT COUNT(employee_id)
FROM employees;

SELECT COUNT(email)
FROM employees;

SELECT COUNT(*)
FROM employees;

SELECT SUM(salary)
FROM employees;

SELECT SUM(salary)
FROM employees
WHERE department = 'Clothing';