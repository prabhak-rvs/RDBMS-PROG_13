USE CollegeDB;

-- Department table
CREATE TABLE IF NOT EXISTS Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Faculty table
CREATE TABLE IF NOT EXISTS Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Course table
CREATE TABLE IF NOT EXISTS Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL,
    FacultyID INT,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

-- Student table
CREATE TABLE IF NOT EXISTS Student3NF (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Department data
INSERT INTO Department VALUES
(1, 'Computer Science'),
(2, 'Management');

-- Faculty data
INSERT INTO Faculty VALUES
(1, 'Dr. Kumar', 1),
(2, 'Dr. Ravi', 1),
(3, 'Dr. Priya', 2);

-- Course data
INSERT INTO Course VALUES
(1, 'BCA', 1),
(2, 'BSc CS', 2),
(3, 'BBA', 3);

-- Student data
INSERT INTO Student3NF VALUES
(101, 'Arun', 1),
(102, 'Divya', 1),
(103, 'Karthik', 2),
(104, 'Meena', 3);
