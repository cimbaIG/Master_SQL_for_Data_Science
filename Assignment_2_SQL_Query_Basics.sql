-- Write a query to display the names of those students that are between the ages of 18 and 20.
SELECT student_name
FROM students
WHERE age BETWEEN 18 AND 20;

-- Or...
SELECT student_name
FROM students
WHERE age >= 18 AND age <= 20;

-- Write a query to display all of those students that contain the letters "ch" in their name 
-- or their name ends with the letters "nd".
SELECT *
FROM students
WHERE student_name LIKE '%ch%'
OR student_name LIKE '%nd';

-- Write a query to display the name of those students that have the letters "ae" or "ph" 
-- in their name and are NOT 19 years old.
SELECT student_name
FROM students
WHERE (student_name LIKE '%ae%' OR student_name LIKE '%ph%')
AND age != 19;

-- Write a query that lists the names of students sorted by their age from largest to smallest
SELECT student_name
FROM students
ORDER BY age DESC;

-- Write a query that displays the names and ages of the top 4 oldest students.
SELECT student_name, age
FROM students
ORDER BY age DESC
FETCH FIRST 4 ROWS ONLY;

-- Or...
SELECT student_name, age
FROM students
ORDER BY age DESC
LIMIT 4;

-- Write a query that returns students based on the following criteria:
-- The student must not be older than age 20 if their student_no is either between 3 and 5 
-- or their student_no is 7. Your query should also return students older than age 20 but in 
-- that case they must have a student_no that is at least 4.
SELECT *
FROM students
WHERE (age <= 20 AND (student_no BETWEEN 3 AND 5
OR student_no = 7))
OR (age > 20 AND student_no >= 4);

-- Udemy solution
SELECT *
FROM students
WHERE AGE <= 20 
AND ( student_no BETWEEN 3 AND 5 OR student_no = 7 )
OR (AGE > 20 AND student_no >= 4);