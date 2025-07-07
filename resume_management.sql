-- Create a database for Resume Management System
CREATE DATABASE resume_management;

-- Use the database
USE resume_management;

-- Create a table for personal details
CREATE TABLE personal_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    date_of_birth DATE,
    linkedin_url VARCHAR(255)
);

-- Create a table for skills
CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT,
    skill_name VARCHAR(100),
    proficiency_level ENUM('Beginner', 'Intermediate', 'Advanced'),
    FOREIGN KEY (resume_id) REFERENCES personal_details(id)
);

-- Create a table for education
CREATE TABLE education (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT,
    degree VARCHAR(100),
    institution VARCHAR(255),
    graduation_year INT,
    FOREIGN KEY (resume_id) REFERENCES personal_details(id)
);

-- Create a table for work experience
CREATE TABLE work_experience (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT,
    job_title VARCHAR(100),
    company VARCHAR(255),
    start_date DATE,
    end_date DATE,
    job_description TEXT,
    FOREIGN KEY (resume_id) REFERENCES personal_details(id)
);

-- Create a table for certifications
CREATE TABLE certifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT,
    certification_name VARCHAR(255),
    issuing_organization VARCHAR(255),
    issue_date DATE,
    expiration_date DATE,
    FOREIGN KEY (resume_id) REFERENCES personal_details(id)
);

-- DATA INSERTION 

-- Insert into personal_details
INSERT INTO personal_details (full_name, email, phone, address, date_of_birth, linkedin_url) 
VALUES 
('John Doe', 'johndoe@gmail.com', '123-456-7890', '123 Main St, Cityville', '1990-05-15', 'https://www.linkedin.com/in/johndoe');

-- Insert into skills
INSERT INTO skills (resume_id, skill_name, proficiency_level) 
VALUES 
(1, 'JavaScript', 'Advanced'),
(1, 'MySQL', 'Intermediate'),
(1, 'Python', 'Intermediate'),
(1, 'Project Management', 'Advanced');

-- Insert into education
INSERT INTO education (resume_id, degree, institution, graduation_year) 
VALUES 
(1, 'Bachelor of Science in Computer Science', 'University of Cityville', 2012),
(1, 'Master of Business Administration', 'Business School of Cityville', 2016);

-- Insert into work_experience
INSERT INTO work_experience (resume_id, job_title, company, start_date, end_date, job_description) 
VALUES 
(1, 'Software Engineer', 'Tech Solutions Inc.', '2013-06-01', '2017-08-15', 'Developed web applications using JavaScript and MySQL.'),
(1, 'Project Manager', 'Innovate Corp.', '2017-09-01', '2021-08-15', 'Managing projects, leading teams, and ensuring timely delivery.');

-- Insert into certifications
INSERT INTO certifications (resume_id, certification_name, issuing_organization, issue_date, expiration_date) 
VALUES 
(1, 'Certified ScrumMaster (CSM)', 'Scrum Alliance', '2018-03-10', '2023-03-10'),
(1, 'AWS Certified Solutions Architect', 'Amazon Web Services', '2019-06-05', '2024-06-05');


-- Basic queries
-- Query 1: Fetch a Candidate's Personal Details
SELECT full_name, email, phone, address, date_of_birth, linkedin_url
FROM personal_details
WHERE id = 1;

--  Query 2: Fetch Candidate Skills
SELECT skill_name, proficiency_level
FROM skills
WHERE resume_id = 1;

--  Query 3: Fetch Candidate Education
SELECT degree, institution, graduation_year
FROM education
WHERE resume_id = 1;

--  Query 4: Fetch Candidate Work Experience
SELECT job_title, company, start_date, end_date, job_description
FROM work_experience
WHERE resume_id = 1;

-- Query 5: Fetch Candidate Certifications
SELECT certification_name, issuing_organization, issue_date, expiration_date
FROM certifications
WHERE resume_id = 1;

-- Some Intermediate queries

-- Query 1: Fetch a Full Resume (All Data)
-- Select personal details of the candidate
SELECT full_name, email, phone, address, date_of_birth, linkedin_url
FROM personal_details
WHERE id = 1;

-- Select skills of the candidate
SELECT skill_name, proficiency_level
FROM skills
WHERE resume_id = 1;

-- Select education details of the candidate
SELECT degree, institution, graduation_year
FROM education
WHERE resume_id = 1;

-- Select work experience details of the candidate
SELECT job_title, company, start_date, end_date, job_description
FROM work_experience
WHERE resume_id = 1;

-- Select certifications of the candidate
SELECT certification_name, issuing_organization, issue_date, expiration_date
FROM certifications
WHERE resume_id = 1;


-- Query 2: Find Candidates with Advanced Skills in JavaScript 
SELECT pd.full_name, pd.email, s.skill_name, s.proficiency_level
FROM personal_details pd
JOIN skills s ON pd.id = s.resume_id
WHERE s.skill_name = 'JavaScript' AND s.proficiency_level = 'Advanced';

-- Query 3: Find All Work Experience for a Specific Job Title
SELECT pd.full_name, w.job_title, w.company, w.start_date, w.end_date, w.job_description
FROM work_experience w
JOIN personal_details pd ON w.resume_id = pd.id
WHERE w.job_title = 'Software Engineer';

-- Query 4: List All Certifications Expiring Soon
SELECT pd.full_name, c.certification_name, c.expiration_date
FROM certifications c
JOIN personal_details pd ON c.resume_id = pd.id
WHERE c.expiration_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 YEAR);

-- Query 5: Count the Number of Resumes with a Certain Degree
SELECT e.degree, COUNT(*) AS resume_count
FROM education e
GROUP BY e.degree
HAVING e.degree = 'Bachelor of Science in Computer Science';










