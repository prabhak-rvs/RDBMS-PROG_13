#!/bin/bash

set -e

echo "======================================"
echo " Assignment 13 - 3NF Autograding"
echo "======================================"

mysql -uroot -proot -e "DROP DATABASE IF EXISTS CollegeDB;"
mysql -uroot -proot -e "CREATE DATABASE CollegeDB;"

mysql -uroot -proot CollegeDB < answers.sql

echo "Checking tables..."

TABLES=$(mysql -uroot -proot -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='CollegeDB'
AND table_name IN ('Department','Faculty','Course','Student');
")

if [ "$TABLES" -ne 4 ]; then
echo "FAIL: All four required tables are not present."
exit 1
fi

echo "PASS: All four tables exist."

echo "Checking columns..."

mysql -uroot -proot CollegeDB -e "
SELECT DepartmentID, DepartmentName
FROM Department;
" > /dev/null

mysql -uroot -proot CollegeDB -e "
SELECT FacultyID, FacultyName, DepartmentID
FROM Faculty;
" > /dev/null

mysql -uroot -proot CollegeDB -e "
SELECT CourseID, CourseName, FacultyID
FROM Course;
" > /dev/null

mysql -uroot -proot CollegeDB -e "
SELECT StudentID, StudentName, CourseID
FROM Student;
" > /dev/null

echo "PASS: Required columns exist."

echo "Checking Primary Keys..."

check_pk() {
TABLE=$1
COLUMN=$2

```
RESULT=$(mysql -uroot -proot -N CollegeDB -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='CollegeDB'
AND table_name='$TABLE'
AND column_name='$COLUMN'
AND constraint_name='PRIMARY';
")

if [ "$RESULT" -ne 1 ]; then
    echo "FAIL: $TABLE.$COLUMN is not a Primary Key."
    exit 1
fi
```

}

check_pk "Department" "DepartmentID"
check_pk "Faculty" "FacultyID"
check_pk "Course" "CourseID"
check_pk "Student" "StudentID"

echo "PASS: Primary Keys are correct."

echo "Checking Foreign Keys..."

check_fk() {
TABLE=$1
COLUMN=$2
REF_TABLE=$3
REF_COLUMN=$4

```
RESULT=$(mysql -uroot -proot -N CollegeDB -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='CollegeDB'
AND table_name='$TABLE'
AND column_name='$COLUMN'
AND referenced_table_name='$REF_TABLE'
AND referenced_column_name='$REF_COLUMN';
")

if [ "$RESULT" -ne 1 ]; then
    echo "FAIL: Foreign Key $TABLE.$COLUMN -> $REF_TABLE.$REF_COLUMN is incorrect."
    exit 1
fi
```

}

check_fk "Faculty" "DepartmentID" "Department" "DepartmentID"
check_fk "Course" "FacultyID" "Faculty" "FacultyID"
check_fk "Student" "CourseID" "Course" "CourseID"

echo "PASS: Foreign Keys are correct."

echo "======================================"
echo " ALL TESTS PASSED!"
echo "======================================"
