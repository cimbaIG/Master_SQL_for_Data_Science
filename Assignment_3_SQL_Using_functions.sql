--1.)
SELECT last_name ||' works in the '|| department ||' department.'
FROM professors;

--2.) 
SELECT last_name, (salary > 95000) AS highly_paid
FROM professors;

SELECT 'It is ' ||(salary > 95000)|| ' that professor ' || last_name || ' is highly paid'
FROM professors;

--3.)
SELECT last_name, UPPER(SUBSTRING(department FROM 1 FOR 3)) AS shortened, salary, hire_date
FROM professors;

SELECT last_name,
UPPER(SUBSTRING(department, 1, 3)) as department, salary, hire_date
FROM professors;

--4.)
SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary
FROM professors
WHERE last_name != 'Wilson';

--5.)
SELECT MIN(hire_date) AS hire_date
FROM professors;