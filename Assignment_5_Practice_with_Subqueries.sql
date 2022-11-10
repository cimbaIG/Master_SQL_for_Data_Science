SELECT *
FROM students;

SELECT *
FROM courses;

SELECT *
FROM student_enrollment;

--1.) Is the students table directly related to the courses table? Why or why not?
-- The students table is not directly related to the courses table. 
-- The students table just contains student details. The courses table just contains 
-- courses information. The table that relates both the students table and courses table 
-- is the student_enrollment table. What student is enrolled in what course is captured 
-- in the student_enrollment table.

--2.) Using subqueries only, write a SQL statement that returns the names of those students 
-- that are taking the courses Physics and US History.
-- NOTE: Do not jump ahead and use joins. I want you to solve this problem using only what 
-- you've learned in this section.
SELECT *
FROM students
WHERE student_no IN (SELECT student_no 
					 FROM student_enrollment 
					 WHERE course_no IN (SELECT course_no 
										 FROM courses 
										 WHERE course_title IN ('Physics','US History')));

SELECT student_name
FROM students 
WHERE student_no IN (SELECT student_no
					 FROM student_enrollment
					 WHERE course_no IN (SELECT course_no
										 FROM courses 
										 WHERE course_title IN ('Physics', 'US History')));
										 
--3.) Using subqueries only, write a query that returns the name of the student that is taking 
-- the highest number of courses.
-- NOTE: Do not jump ahead and use joins. I want you to solve this problem using only what you've 
-- learned in this section. 
SELECT student_name
FROM students
WHERE student_no IN (SELECT student_no
					 FROM student_enrollment
					 GROUP BY student_no
					 ORDER BY COUNT(*) DESC
					 LIMIT 1
					);

SELECT student_name 
FROM students 
WHERE student_no IN (SELECT student_no 
					 FROM (SELECT student_no, COUNT(course_no) course_cnt
						   FROM STUDENT_ENROLLMENT         
						   GROUP BY student_no         
						   ORDER BY course_cnt desc         
						   LIMIT 1) a 
					);
										 
--4.) Answer TRUE or FALSE for the following statement:
-- Subqueries can be used in the FROM clause and the WHERE clause but cannot be used in the 
-- SELECT Clause.
-- This is FALSE! Subqueries may be used in the SELECT, FROM and WHERE clauses. They may even
-- be used inside the HAVING clause!

--5.) Write a query to find the student that is the oldest.
-- NOTE: You are not allowed to use LIMIT or the ORDER BY clause to solve this problem.
SELECT student_name, age
FROM students
WHERE age = (SELECT MAX(age) 
			 FROM students);
			 
SELECT *
FROM students
WHERE age = (SELECT MAX(age) 
			 FROM students);