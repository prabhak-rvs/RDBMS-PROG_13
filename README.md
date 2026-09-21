Problem Statement

Consider the following unnormalized Student table:

Student(StudentID, StudentName, CourseName, FacultyName, DepartmentName)

Normalize the table up to Third Normal Form (3NF).

You must identify the appropriate entities and create separate tables with suitable Primary Keys and Foreign Keys.
Expected 3NF Structure

Your solution should contain the following tables:

1. Department
Department(DepartmentID, DepartmentName)
DepartmentID – Primary Key
DepartmentName – Name of the department

2. Faculty
Faculty(FacultyID, FacultyName, DepartmentID)
FacultyID – Primary Key
FacultyName – Name of the faculty
DepartmentID – Foreign Key referencing Department
3. Course
Course(CourseID, CourseName, FacultyID)
CourseID – Primary Key
CourseName – Name of the course
FacultyID – Foreign Key referencing Faculty
4. Student
Student(StudentID, StudentName, CourseID)
StudentID – Primary Key
StudentName – Name of the student
CourseID – Foreign Key referencing Course
