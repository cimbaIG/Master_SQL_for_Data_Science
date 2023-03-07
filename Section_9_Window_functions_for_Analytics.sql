-- 01 -- Window functions using the OVER() clause
-- This is slow approach because subquery related to table e1 has to run for each row in table e2,
-- i.e. it has to run 1000 times (because table has 1000 rows)
SELECT first_name, department, 
(SELECT COUNT(*) FROM employees e1 WHERE e1.department = e2.department)
FROM employees e2
GROUP BY department, first_name
ORDER BY department

-- Alternative is to use window functions (keyword OVER)
-- There is no more need for GROUP BY!
-- The query below gives completely the same result as the query above!
SELECT first_name, department, COUNT(*) OVER(PARTITION BY department)
FROM employees e2

-- Let's prove that both queries are the same!
-- We can do that by using the EXCEPT keyword which subtracts the result
-- of first query and the second query!
-- The query will return nothing, which means both queries give the same result!
(SELECT first_name, department, 
(SELECT COUNT(*) FROM employees e1 WHERE e1.department = e2.department)
FROM employees e2
GROUP BY department, first_name
ORDER BY department)
EXCEPT
SELECT first_name, department, COUNT(*) OVER(PARTITION BY department)
FROM employees e2

-- How to get the total salaries paid for each department? Using the window
-- function and SUM!
SELECT first_name, department,
SUM (salary) OVER(PARTITION BY department)
FROM employees

-- What happens if we get rid of PARTITION BY?
-- The query returns the total salaries paid to all employees in the company!
SELECT first_name, department,
SUM (salary) OVER()
FROM employees

-- We can partition over multiple things. E.g. we can get the number of
-- employees working in the same region as first_name and number of
-- employees working in the same department as first_name
SELECT first_name, department,
COUNT(*) OVER(PARTITION BY department) dept_count,
region_id,
COUNT(*) OVER(PARTITION BY region_id) region_count
FROM employees

-- Alternative to window functions are correlated queries! But they are much
-- more expensive and they are also harder to code for developer. This is the
-- reason why it is better option to use window functions!

-- How are the SQL queries evaluated? First is evaluated the FROM query and 
-- WHERE query is evaluated next! SELECT queries are evaluated at the end!
-- The query below returns all rows with region_id = 3 (145 rows in total)
SELECT first_name, department
FROM employees
WHERE region_id = 3

-- As FROM is evaluated first, WHERE the second and SELECT at the end,
-- COUNT(*) OVER() will only be applied to these 145 rows!
SELECT first_name, department,
COUNT(*) OVER(PARTITION BY department)
FROM employees
WHERE region_id = 3

-- 02 -- Ordering data in windows frames
-- Window is basically a group of data defined by partition (similar to GROUP BY 
-- clause)!
-- How to calculate the total number of salaries paid to all employees by their 
-- hire_date? 
SELECT first_name, hire_date, salary,
SUM(salary) OVER(ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING 
				 AND CURRENT ROW) AS running_total_of_salaries
FROM employees

-- However, we would get the sam result by using only OVER(ORDER BY hire_date),
-- because by default the range is evaluated between the first row and the row
-- that is currently evaluating. I.e. between unbounded preceding and current
-- row.
SELECT first_name, hire_date, salary,
SUM(salary) OVER(ORDER BY hire_date) AS running_total_of_salaries
FROM employees

-- We can also use PARTITION BY in a combination with ORDER BY. For instance,
-- if we want to get the total amount of salaries paid of to all employees
-- working in unique departments from the first fire_date, to the last 
-- hire_date, we can do this as follows:
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(PARTITION BY department ORDER BY hire_date) AS running_total_of_salaries
FROM employees

-- How to compute adjacent salaries?
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 1 PRECEDING 
				 AND CURRENT ROW)
FROM employees

-- How to compute salaries to the 3 salaries preceding?
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 3 PRECEDING 
				 AND CURRENT ROW)
FROM employees

-- Which salary would return 1000 preceding rows in the last row? 
-- The total salary of all employees!
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 1000 PRECEDING 
				 AND CURRENT ROW)
FROM employees

SELECT SUM(salary) 
FROM employees

-- There is also ROWS FOLLOWING command!

-- 03 -- RANK, FIRST_VALUE and NTILE functions
-- RANK function
-- The query returns all employees partitioned (grouped) by
-- their departments and ranked by their salaries (from those)
-- with largest salary in department to that with the lowest
-- salary in particular department.
SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees

-- How to get all of those employees that are ranked as 
-- eight by salary in their departments?
SELECT * FROM (
SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees) AS a
WHERE rank = 8

-- This query will not work because SELECT part of the query
-- is processed after the WHERE part of the query. This is 
-- the reason why rank column does not exist until the end
-- and 'column "rank" does not exist' error would appear:
-- SELECT first_name, email, department, salary,
-- RANK() OVER(PARTITION BY department ORDER BY salary DESC)
-- FROM employees
-- WHERE rank = 8

-- NTILE() function (it takes an argument)
-- How to rank a group of rows? For instance, how to rank
-- the employee salaries by using the five groups?
SELECT first_name, email, department, salary,
NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC) AS salary_bracket
FROM employees

-- FIRST_VALUE() function (it takes the column as argument)
-- The function takes the first salary value of employee in
-- a particular department and assigns this value to all 
-- other employees in the same department.
SELECT first_name, email, department, salary,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees

-- The alternative for above query is to use MAX() function, which
-- would return the completely the same result.
SELECT first_name, email, department, salary,
MAX(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees

-- However, it is not possible to obtain the same result for the
-- following query (here the only way is to use the FIRST_VALUE()
-- function):
SELECT first_name, email, department, salary,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY first_name ASC)
FROM employees

-- There is also NTH_VALUE() function, which takes two arguments. First
-- is a particular column and second is the nth value we want to assign
-- to all other employees
SELECT first_name, email, department, salary,
NTH_VALUE(salary,5) OVER(PARTITION BY department ORDER BY first_name ASC) nth_value
FROM employees

-- 04 -- Working with LEAD and LAG functions
-- This functions enable us to work with rows that are directly above or
-- directly below the currently processed row. I.e., they allow us to
-- work with data relative to the current row.
-- E.g. how to get a salary that immediatelly follows the current row
-- salary?
SELECT first_name, last_name, salary,
LEAD(salary) OVER() next_salary
FROM employees

-- How to get a first salary that is previous to the current salary?
SELECT first_name, last_name, salary,
LAG(salary) OVER() previous_salary
FROM employees

-- Example of use: How to get a closest higher salary for a particular
-- employee?
SELECT department, last_name, salary,
LAG(salary) OVER(ORDER BY salary DESC) closest_higher_salary
FROM employees

-- How to get a closest lower salary for a particular employee?
SELECT department, last_name, salary,
LEAD(salary) OVER(ORDER BY salary DESC) closest_lower_salary
FROM employees

-- We can also partition data by department
SELECT department, last_name, salary,
LEAD(salary) OVER(PARTITION BY department ORDER BY salary DESC) closest_lower_salary
FROM employees

-- 05 -- Working with rollups and cubes
-- Create sales table and populate it with data
CREATE TABLE sales
(
	continent varchar(20),
	country varchar(20),
	city varchar(20),
	units_sold integer
);

INSERT INTO sales VALUES ('North America', 'Canada', 'Toronto', 10000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Montreal', 5000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Vancouver', 15000);
INSERT INTO sales VALUES ('Asia', 'China', 'Hong Kong', 7000);
INSERT INTO sales VALUES ('Asia', 'China', 'Shanghai', 3000);
INSERT INTO sales VALUES ('Asia', 'Japan', 'Tokyo', 5000);
INSERT INTO sales VALUES ('Europe', 'UK', 'London', 6000);
INSERT INTO sales VALUES ('Europe', 'UK', 'Manchester', 12000);
INSERT INTO sales VALUES ('Europe', 'France', 'Paris', 5000);

SELECT *
FROM sales
ORDER BY continent, country, city

SELECT continent, SUM(units_sold)
FROM sales
GROUP BY continent

SELECT country, SUM(units_sold)
FROM sales
GROUP BY country

SELECT city, SUM(units_sold)
FROM sales
GROUP BY city

-- How to get the same data by using one single query instead
-- of three different queries?
-- By using GROUPING SETS!
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city)

-- How to get the total number of units_sold in table?
-- By using closed set of empty parentheses as additional
-- SETS argument!
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city, ())

-- ROLLUP function returns the amount od units_sold in case
-- we grouped by continent, country and city, only continent
-- and country, as well as only continent.
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city)

-- CUBE function allows us to figure out what are units_sold in
-- case of all existing grouping combinations
-- In contrary, ROLLUP does not show the results of all possible
-- combinations.
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY CUBE(continent, country, city)