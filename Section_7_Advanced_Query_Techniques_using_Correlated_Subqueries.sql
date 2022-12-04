-- Example on how to use subquery
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT ROUND(AVG(salary)) FROM employees);

-- How to make correlated subqueries?
-- Correlated subquery is nested inside the outer query and uses values from the outer query.
-- Note that subquery runs for every single query of the outer query and because of that subqueries are not
-- particularly efficient in case of large databases.
SELECT first_name, salary
FROM employees AS e1
WHERE salary > (SELECT ROUND(AVG(salary)) 
				FROM employees AS e2 WHERE e1.department = e2.department);

SELECT first_name, salary
FROM employees AS e1
WHERE salary > (SELECT ROUND(AVG(salary)) 
				FROM employees AS e2 WHERE e1.region_id = e2.region_id);

SELECT first_name, department, salary,
(SELECT ROUND(AVG(salary)) 
				FROM employees AS e2 WHERE e1.department = e2.department) AS avg_department_salary
FROM employees AS e1

-- Write a query to obtain the names of those departments that have more than 38 employees.
SELECT * FROM employees;
SELECT * FROM departments;

-- Solution using departments table
SELECT department
FROM departments AS d
WHERE 38 < (SELECT COUNT(*)
		   	FROM employees e
		    WHERE e.department = d.department);

-- Solution using employees table without groupby
SELECT DISTINCT department
FROM employees e1
WHERE 38 < (SELECT COUNT(*)
		   	FROM employees e2
		    WHERE e1.department = e2.department);

-- Solution using employees table with groupby
SELECT department, COUNT(*) AS number_of_employees
FROM employees e1
WHERE 38 < (SELECT COUNT(*)
		   	FROM employees e2
		    WHERE e1.department = e2.department)
GROUP BY department;

SELECT department
FROM employees e1
WHERE 38 < (SELECT COUNT(*)
		   	FROM employees e2
		    WHERE e1.department = e2.department)
GROUP BY department;

-- Present the column with the highest paid salaries for each department
SELECT department, (SELECT MAX(salary) 
					FROM employees
					WHERE department = d.department)
FROM departments AS d
WHERE 38 < (SELECT COUNT(*)
		   	FROM employees e
		    WHERE e.department = d.department);

SELECT department, (SELECT MAX(salary) 
					FROM employees
					WHERE department = d.department)
FROM departments AS d;

-- Completely the same results may be obtained by grouping by departments over the
-- maximum salary.
SELECT department, MAX(salary)
FROM employees
GROUP BY department

-- Exercises
-- Present the table that shows the first_name of the highest and the lowest paid employee per each department,
-- their salaries and flag table with two values - HIGHEST_SALARY and LOWEST_SALARY.
-- My solution:
SELECT department, first_name, salary, (SELECT 
											CASE 
												WHEN e1.salary = MAX(e3.salary) THEN 'HIGHEST SALARY' 
												WHEN e1.salary = MIN(e3.salary) THEN 'LOWEST SALARY'
											END 
										FROM employees e3 
										WHERE e1.department = e3.department) AS new_column_name
FROM employees AS e1
WHERE e1.salary = (SELECT MAX(salary)
				   FROM employees e2 
				   WHERE e1.department = e2.department)
OR e1.salary = (SELECT MIN(salary) 
				FROM employees e2 
				WHERE e1.department = e2.department)
GROUP BY department, first_name, salary
ORDER BY department, salary DESC;

-- Udemy solution:
SELECT department, first_name, salary, CASE 
											WHEN salary = max_by_department THEN 'HIGHEST SALARY' 
											WHEN salary = min_by_department THEN 'LOWEST SALARY' 
									   	END 
										AS salary_in_department
FROM (
SELECT department, first_name, salary, (SELECT MAX(salary) FROM employees e2 
										WHERE e1.department = e2.department) AS max_by_department, 
									   (SELECT MIN(salary) FROM employees e2 
										WHERE e1.department = e2.department) AS min_by_department
FROM employees e1
ORDER BY department
) a
WHERE salary = max_by_department OR salary = min_by_department;