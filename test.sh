```bash
#!/bin/bash

set -e

HOST="127.0.0.1"
USER="root"
PASSWORD="root"
DB="CollegeDB"

MYSQL="mysql -h $HOST -P 3306 -u $USER -p$PASSWORD"

echo "Assignment 13 - 3NF Normalization"
echo "--------------------------------"

echo "Creating database..."
$MYSQL -e "DROP DATABASE IF EXISTS $DB;"
$MYSQL -e "CREATE DATABASE $DB;"

echo "Running student solution..."
$MYSQL $DB < answers.sql

echo "Checking required tables..."

TABLE_COUNT=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DB'
AND table_name IN ('Department','Faculty','Course','Student');
")

if [ "$TABLE_COUNT" -ne 4 ]; then
    echo "FAIL: Department, Faculty, Course and Student tables are required."
    exit 1
fi

echo "PASS: Four required tables exist."

echo "Checking Department table..."

$MYSQL $DB -e "DESCRIBE Department;"

DEPT_ID=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Department'
AND column_name='DepartmentID';
")

DEPT_NAME=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Department'
AND column_name='DepartmentName';
")

if [ "$DEPT_ID" -ne 1 ] || [ "$DEPT_NAME" -ne 1 ]; then
    echo "FAIL: Department must contain DepartmentID and DepartmentName."
    exit 1
fi

echo "PASS: Department structure is correct."

echo "Checking Faculty table..."

$MYSQL $DB -e "DESCRIBE Faculty;"

FAC_ID=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Faculty'
AND column_name='FacultyID';
")

FAC_NAME=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Faculty'
AND column_name='FacultyName';
")

FAC_DEPT=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Faculty'
AND column_name='DepartmentID';
")

if [ "$FAC_ID" -ne 1 ] || [ "$FAC_NAME" -ne 1 ] || [ "$FAC_DEPT" -ne 1 ]; then
    echo "FAIL: Faculty must contain FacultyID, FacultyName and DepartmentID."
    exit 1
fi

echo "PASS: Faculty structure is correct."

echo "Checking Course table..."

$MYSQL $DB -e "DESCRIBE Course;"

COURSE_ID=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Course'
AND column_name='CourseID';
")

COURSE_NAME=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Course'
AND column_name='CourseName';
")

COURSE_FAC=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Course'
AND column_name='FacultyID';
")

if [ "$COURSE_ID" -ne 1 ] || [ "$COURSE_NAME" -ne 1 ] || [ "$COURSE_FAC" -ne 1 ]; then
    echo "FAIL: Course must contain CourseID, CourseName and FacultyID."
    exit 1
fi

echo "PASS: Course structure is correct."

echo "Checking Student table..."

$MYSQL $DB -e "DESCRIBE Student;"

STUDENT_ID=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Student'
AND column_name='StudentID';
")

STUDENT_NAME=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Student'
AND column_name='StudentName';
")

STUDENT_COURSE=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema='$DB'
AND table_name='Student'
AND column_name='CourseID';
")

if [ "$STUDENT_ID" -ne 1 ] || [ "$STUDENT_NAME" -ne 1 ] || [ "$STUDENT_COURSE" -ne 1 ]; then
    echo "FAIL: Student must contain StudentID, StudentName and CourseID."
    exit 1
fi

echo "PASS: Student structure is correct."

echo "Checking primary keys..."

PK_DEPT=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='$DB'
AND table_name='Department'
AND column_name='DepartmentID'
AND constraint_name='PRIMARY';
")

PK_FAC=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='$DB'
AND table_name='Faculty'
AND column_name='FacultyID'
AND constraint_name='PRIMARY';
")

PK_COURSE=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='$DB'
AND table_name='Course'
AND column_name='CourseID'
AND constraint_name='PRIMARY';
")

PK_STUDENT=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='$DB'
AND table_name='Student'
AND column_name='StudentID'
AND constraint_name='PRIMARY';
")

if [ "$PK_DEPT" -ne 1 ] || [ "$PK_FAC" -ne 1 ] || [ "$PK_COURSE" -ne 1 ] || [ "$PK_STUDENT" -ne 1 ]; then
    echo "FAIL: Correct primary keys are required."
    exit 1
fi

echo "PASS: Primary keys are correct."

echo "Checking foreign keys..."

FK_FAC=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='$DB'
AND table_name='Faculty'
AND column_name='DepartmentID'
AND referenced_table_name='Department'
AND referenced_column_name='DepartmentID';
")

FK_COURSE=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='$DB'
AND table_name='Course'
AND column_name='FacultyID'
AND referenced_table_name='Faculty'
AND referenced_column_name='FacultyID';
")

FK_STUDENT=$($MYSQL -N -e "
SELECT COUNT(*)
FROM information_schema.key_column_usage
WHERE table_schema='$DB'
AND table_name='Student'
AND column_name='CourseID'
AND referenced_table_name='Course'
AND referenced_column_name='CourseID';
")

if [ "$FK_FAC" -ne 1 ] || [ "$FK_COURSE" -ne 1 ] || [ "$FK_STUDENT" -ne 1 ]; then
    echo "FAIL: Required foreign keys are missing."
    exit 1
fi

echo "PASS: Foreign keys are correct."

echo "--------------------------------"
echo "ALL TESTS PASSED"
echo "Assignment 13 completed successfully"
```
