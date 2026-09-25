USE CollegeDB;

DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL,
    FacultyID INT NOT NULL,
    FOREIGN KEY (FacultyID)
        REFERENCES Faculty(FacultyID)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    CourseID INT NOT NULL,
    FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);

INSERT INTO Department VALUES
(1, 'Computer Science'),
(2, 'Management');

INSERT INTO Faculty VALUES
(1, 'Dr. Kumar', 1),
(2, 'Dr. Ravi', 1),
(3, 'Dr. Priya', 2);

INSERT INTO Course VALUES
(1, 'BCA', 1),
(2, 'BSc CS', 2),
(3, 'BBA', 3);

INSERT INTO Student VALUES
(101, 'Arun', 1),
(102, 'Divya', 1),
(103, 'Karthik', 2),
(104, 'Meena', 3);
