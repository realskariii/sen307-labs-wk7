-- ============================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: JOSEPH IJANU SKARI Matric: VUG/SEN/24/11477
-- ============================================
USE sen307_11477;

-- Task 1: Retrieve all students in one department (for example Software Engineering), sorted alphabetically by full name.
-- Explanation:
SELECT s.full_name 
FROM student s
JOIN department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;
-- Joins Student to Department on dept_id, keeps only Software Engineering
-- students, and sorts them alphabetically by full name.

-- Task 2: List all courses with the name of each lecturer teaching them, using INNER JOIN.
-- Explanation:
SELECT c.course_id, c.course_title, l.full_name AS lecturer
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_id, l.full_name;
-- Links Course to Lecturer through CourseAllocation. Only courses that have an
-- allocation appear. Course 1 shows twice because it has two lecturers.

-- Task 3:
-- Explanation: List every student and the courses they are enrolled in, including students with no enrolments.
SELECT s.student_id, s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name, c.course_title;
-- LEFT JOIN keeps all students. Those with no enrolment get NULL in course_title.


SELECT s.student_id, s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;
-- Same join, filtered to the NULL rows, so it lists only students with no courses.


-- Task 4: Write one query that combines at least three of AND, OR, IN and BETWEEN. For example: female students in Software Engineering or Artificial Intelligence, born between 2004-01-01 and 2005-12-31
-- Explanation:
SELECT s.student_id, s.matric_no, s.full_name, s.gender, s.date_of_birth, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
WHERE s.gender = 'M'
  AND s.dept_id IN (6, 7)
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.full_name;
-- Male students in department 6 or 7 born from 2004-01-01 to 2005-12-31
-- (BETWEEN includes both end dates).

-- Task 5: Show the enrolments 10 at a time: page 1 (rows 1–10), then page 2 (rows 11–20).
-- Explanation:
SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 0;
-- Page 1: rows 1 to 10. ORDER BY gives a fixed order, so pages never overlap.

SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 10;
-- Page 2: skips the first 10 rows and returns rows 11 to 20.
