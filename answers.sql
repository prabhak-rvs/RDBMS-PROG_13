

CREATE TABLE Department (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Faculty (
FacultyID INT PRIMARY KEY,
FacultyName VARCHAR(50) NOT NULL,
DepartmentID INT,
FOREIGN KEY (DepartmentID)
REFERENCES Department(DepartmentID)
);

CREATE TABLE Course (
CourseID INT PRIMARY KEY,
CourseName VARCHAR(50) NOT NULL,
FacultyID INT,
FOREIGN KEY (FacultyID)
REFERENCES Faculty(FacultyID)
);

CREATE TABLE Student (
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50) NOT NULL,
CourseID INT,
FOREIGN KEY (CourseID)
REFERENCES Course(CourseID)
);
