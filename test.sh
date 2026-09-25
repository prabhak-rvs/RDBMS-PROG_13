#!/bin/bash

set -e

DB="CollegeDB"

echo "======================================"
echo " Assignment 13 - 3NF Autograding"
echo "======================================"

echo "Testing MySQL connection..."

mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -e "SELECT VERSION();"

echo "MySQL connection successful."

echo ""
echo "Running starter.sql..."

mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" < starter.sql

echo "starter.sql executed successfully."

echo ""
echo "Running answers.sql..."

mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" < answers.sql

echo "answers.sql executed successfully."

echo ""
echo "Checking Department table..."

RESULT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Department';
")

if [ "$RESULT" != "1" ]; then
    echo "FAIL: Department table not found."
    exit 1
fi

echo "PASS: Department table exists."

echo ""
echo "Checking Faculty table..."

RESULT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Faculty';
")

if [ "$RESULT" != "1" ]; then
    echo "FAIL: Faculty table not found."
    exit 1
fi

echo "PASS: Faculty table exists."

echo ""
echo "Checking Course table..."

RESULT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Course';
")

if [ "$RESULT" != "1" ]; then
    echo "FAIL: Course table not found."
    exit 1
fi

echo "PASS: Course table exists."

echo ""
echo "Checking Student table..."

RESULT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Student';
")

if [ "$RESULT" != "1" ]; then
    echo "FAIL: Student table not found."
    exit 1
fi

echo "PASS: Student table exists."

echo ""
echo "Checking Department columns..."

mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_name='Department'
ORDER BY ordinal_position;
" > department_columns.txt

grep -q "^DepartmentID$" department_columns.txt
grep -q "^DepartmentName$" department_columns.txt

echo "PASS: Department columns are correct."

echo ""
echo "Checking Faculty columns..."

mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_name='Faculty'
ORDER BY ordinal_position;
" > faculty_columns.txt

grep -q "^FacultyID$" faculty_columns.txt
grep -q "^FacultyName$" faculty_columns.txt
grep -q "^DepartmentID$" faculty_columns.txt

echo "PASS: Faculty columns are correct."

echo ""
echo "Checking Course columns..."

mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_name='Course'
ORDER BY ordinal_position;
" > course_columns.txt

grep -q "^CourseID$" course_columns.txt
grep -q "^CourseName$" course_columns.txt
grep -q "^FacultyID$" course_columns.txt

echo "PASS: Course columns are correct."

echo ""
echo "Checking Student columns..."

mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_name='Student'
ORDER BY ordinal_position;
" > student_columns.txt

grep -q "^StudentID$" student_columns.txt
grep -q "^StudentName$" student_columns.txt
grep -q "^CourseID$" student_columns.txt

echo "PASS: Student columns are correct."

echo ""
echo "Checking Department data..."

COUNT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Department;
")

if [ "$COUNT" -ne 2 ]; then
    echo "FAIL: Department data incorrect."
    exit 1
fi

echo "PASS: Department data."

echo ""
echo "Checking Faculty data..."

COUNT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Faculty;
")

if [ "$COUNT" -ne 3 ]; then
    echo "FAIL: Faculty data incorrect."
    exit 1
fi

echo "PASS: Faculty data."

echo ""
echo "Checking Course data..."

COUNT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Course;
")

if [ "$COUNT" -ne 3 ]; then
    echo "FAIL: Course data incorrect."
    exit 1
fi

echo "PASS: Course data."

echo ""
echo "Checking Student data..."

COUNT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Student;
")

if [ "$COUNT" -ne 4 ]; then
    echo "FAIL: Student data incorrect."
    exit 1
fi

echo "PASS: Student data."

echo ""
echo "Checking Faculty -> Department foreign key..."

FK_COUNT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
SELECT COUNT(*)
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='$DB'
AND TABLE_NAME='Faculty'
AND COLUMN_NAME='DepartmentID'
AND REFERENCED_TABLE_NAME='Department';
")

if [ "$FK_COUNT" -lt 1 ]; then
    echo "FAIL: Faculty.DepartmentID foreign key missing."
    exit 1
fi

echo "PASS: Faculty foreign key."

echo ""
echo "Checking Course -> Faculty foreign key..."

FK_COUNT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
SELECT COUNT(*)
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='$DB'
AND TABLE_NAME='Course'
AND COLUMN_NAME='FacultyID'
AND REFERENCED_TABLE_NAME='Faculty';
")

if [ "$FK_COUNT" -lt 1 ]; then
    echo "FAIL: Course.FacultyID foreign key missing."
    exit 1
fi

echo "PASS: Course foreign key."

echo ""
echo "Checking Student -> Course foreign key..."

FK_COUNT=$(mysql -h 127.0.0.1 -uroot -p"$MYSQL_PWD" -N -e "
SELECT COUNT(*)
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='$DB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='CourseID'
AND REFERENCED_TABLE_NAME='Course';
")

if [ "$FK_COUNT" -lt 1 ]; then
    echo "FAIL: Student.CourseID foreign key missing."
    exit 1
fi

echo "PASS: Student foreign key."

echo ""
echo "======================================"
echo " ALL TESTS PASSED"
echo " Assignment 13 - 3NF"
echo "======================================"
