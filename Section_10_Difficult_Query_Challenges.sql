-- Just checking out the table data...
SELECT *
FROM professors;

SELECT *
FROM students;

SELECT *
FROM teach;

SELECT *
FROM student_enrollment;

SELECT *
FROM courses;

-- 1.) Write a query that finds students who do not take CS180.
-- My solution
SELECT student_name
FROM students
WHERE student_no IN (SELECT student_no
					 FROM student_enrollment
					 WHERE course_no != 'CS180');
-- Udemy solution
-- You may have thought about the following query at first, but this is not correct:
SELECT * 
FROM students
WHERE student_no IN (SELECT student_no
					 FROM student_enrollment
					 WHERE course_no != 'CS180')
ORDER BY student_name;
-- The above query is incorrect because it does not answer the question "Who does not take CS180?". 
-- Instead, it answers the question "Who takes a course that is not CS180?" The correct result should include students who take 
-- no courses as well as students who take courses but none of them CS180.
-- There are two possible solutions:
-- a) 
SELECT * 
FROM students
WHERE student_no NOT IN (SELECT student_no
						 FROM student_enrollment
						 WHERE course_no = 'CS180');
-- b)
SELECT s.student_no, s.student_name, s.age
FROM students s 
LEFT JOIN student_enrollment se ON s.student_no = se.student_no
GROUP BY s.student_no, s.student_name, s.age
HAVING MAX(CASE 
		   		WHEN se.course_no = 'CS180' THEN 1 
		   		ELSE 0 
		   END) = 0;