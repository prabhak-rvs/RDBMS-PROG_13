#!/bin/bash

set -e

DB="CollegeDB"

echo "======================================"
echo " Assignment 13 - 3NF Autograding"
echo "======================================"

mysql -uroot -p"$MYSQL_PWD" -e "DROP DATABASE IF EXISTS $DB;"
mysql -uroot -p"$MYSQL_PWD" < starter.sql
mysql -uroot -p"$MYSQL_PWD" < answers.sql

echo ""
echo "Checking Department table..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Department';
" | grep -q "^1$"

echo "PASS: Department table exists."

echo ""
echo "Checking Faculty table..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Faculty';
" | grep -q "^1$"

echo "PASS: Faculty table exists."

echo ""
echo "Checking Course table..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Course';
" | grep -q "^1$"

echo "PASS: Course table exists."

echo ""
echo "Checking Student3NF table..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name='Student3NF';
" | grep -q "^1$"

echo "PASS: Student3NF table exists."

echo ""
echo "Checking Department records..."

COUNT=$(mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Department;
")

if [ "$COUNT" -ge 2 ]; then
    echo "PASS: Department data exists."
else
    echo "FAIL: Department data is missing."
    exit 1
fi

echo ""
echo "Checking Faculty records..."

COUNT=$(mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Faculty;
")

if [ "$COUNT" -ge 3 ]; then
    echo "PASS: Faculty data exists."
else
    echo "FAIL: Faculty data is missing."
    exit 1
fi

echo ""
echo "Checking Course records..."

COUNT=$(mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Course;
")

if [ "$COUNT" -ge 3 ]; then
    echo "PASS: Course data exists."
else
    echo "FAIL: Course data is missing."
    exit 1
fi

echo ""
echo "Checking Student records..."

COUNT=$(mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT COUNT(*) FROM Student3NF;
")

if [ "$COUNT" -ge 4 ]; then
    echo "PASS: Student data exists."
else
    echo "FAIL: Student data is missing."
    exit 1
fi

echo ""
echo "Checking Student3NF columns..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Student3NF'
ORDER BY ordinal_position;
" > student_columns.txt

grep -q "StudentID" student_columns.txt
grep -q "StudentName" student_columns.txt
grep -q "CourseID" student_columns.txt

echo "PASS: Student3NF contains required columns."

echo ""
echo "Checking Course columns..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Course';
" > course_columns.txt

grep -q "CourseID" course_columns.txt
grep -q "CourseName" course_columns.txt
grep -q "FacultyID" course_columns.txt

echo "PASS: Course contains required columns."

echo ""
echo "Checking Faculty columns..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Faculty';
" > faculty_columns.txt

grep -q "FacultyID" faculty_columns.txt
grep -q "FacultyName" faculty_columns.txt
grep -q "DepartmentID" faculty_columns.txt

echo "PASS: Faculty contains required columns."

echo ""
echo "Checking Department columns..."

mysql -uroot -p"$MYSQL_PWD" -N -e "
USE $DB;
SELECT column_name
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Department';
" > department_columns.txt

grep -q "DepartmentID" department_columns.txt
grep -q "DepartmentName" department_columns.txt

echo "PASS: Department contains required columns."

echo ""
echo "======================================"
echo " ALL TESTS PASSED"
echo " Assignment 13 completed successfully"
echo "======================================"
