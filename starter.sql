CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    CourseName VARCHAR(50),
    FacultyName VARCHAR(50),
    DepartmentName VARCHAR(50)
);

INSERT INTO Student VALUES
(101, 'Arun', 'BCA', 'Dr. Kumar', 'Computer Science'),
(102, 'Divya', 'BCA', 'Dr. Kumar', 'Computer Science'),
(103, 'Karthik', 'BSc CS', 'Dr. Ravi', 'Computer Science'),
(104, 'Meena', 'BBA', 'Dr. Priya', 'Management');
