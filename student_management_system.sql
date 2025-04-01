CREATE DATABASE student_management;
USE student_management;

-- 1. Create Students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY, 
    full_name VARCHAR(100),                    
    date_of_birth DATE,                         
    phone VARCHAR(20),                          
    address VARCHAR(255)                      
);

-- 2. Create Instructors Table
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),                    
    department VARCHAR(100),                    
    email VARCHAR(100)                          
);

-- 3. Create Courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,  
    course_name VARCHAR(100),                    
    course_code VARCHAR(10)                      
);

-- 4. Create Enrollments Table
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,  
    student_id INT,                                
    course_id INT,                                
    enrollment_date DATE,                         
    grade DECIMAL(4, 2),                           
    FOREIGN KEY (student_id) REFERENCES students(student_id),  
    FOREIGN KEY (course_id) REFERENCES courses(course_id)    
);

-- 5. Create Assignments Table
CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,  
    course_id INT,                                 
    title VARCHAR(255),                           
    due_date DATE,                                
    FOREIGN KEY (course_id) REFERENCES courses(course_id) 
);

-- Insert Instructors Data
INSERT INTO instructors (full_name, department, email)
VALUES 
('Dr. John Smith', 'Computer Science', 'john.smith@university.com'),
('Prof. Jane Doe', 'Mathematics', 'jane.doe@university.com');

-- Insert Courses Data
INSERT INTO courses (course_name, course_code)
VALUES 
('Introduction to Programming', 'CS101'),
('Calculus I', 'MATH101'),
('Data Structures', 'CS102');

-- Insert Students Data
INSERT INTO students (full_name, date_of_birth, phone, address)
VALUES 
('Alice Johnson',  '2000-04-01', '123-555-1234', '123 Main St, Cityville'),
('Bob Smith', '1999-07-15', '321-555-5678', '456 Oak St, Townsville');

-- Insert Enrollments Data
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES 
(1, 1, '2025-01-10', 85.5), 
(1, 2, '2025-01-15', 90.0), 
(2, 1, '2025-01-12', 78.0), 
(2, 3, '2025-01-16', 88.0);  

-- Insert Assignments Data
INSERT INTO assignments (course_id, title, due_date)
VALUES 
(1, 'Programming Assignment 1', '2025-02-10'),  
(2, 'Calculus Assignment 1', '2025-02-12'),      
(3, 'Data Structures Project', '2025-02-15');    

-- some query executions
-- Query 1: Find all students enrolled in the "Introduction to Programming" course

SELECT s.full_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Introduction to Programming';

-- Query 2: Fetch the grades of all students for a particular course
SELECT s.full_name, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Calculus I';

-- Query 3: Get the number of students enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;

-- Query 4: List all students who have not enrolled in any courses
SELECT s.full_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.course_id IS NULL;

-- Query 5: Find the highest grade in each course
SELECT c.course_name, MAX(e.grade) AS highest_grade
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- Query 6: List all students and the courses they are enrolled in, including grades
SELECT s.full_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Query 7: Fetch the average grade of all students in "Data Structures"
SELECT AVG(e.grade) AS average_grade
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Data Structures';

-- Query 8: Get a list of students who have enrolled in more than one course
SELECT s.full_name, COUNT(e.course_id) AS course_count
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 1;



