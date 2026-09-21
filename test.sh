```bash
#!/bin/bash

set -e

echo "Assignment 13 - 3NF Normalization"
echo "Starting tests..."

mysql -h 127.0.0.1 -u root -proot -e "DROP DATABASE IF EXISTS CollegeDB"
mysql -h 127.0.0.1 -u root -proot -e "CREATE DATABASE CollegeDB"

echo "Running answers.sql..."

mysql -h 127.0.0.1 -u root -proot CollegeDB < answers.sql

echo "Checking tables..."

TABLE_COUNT=$(mysql -h 127.0.0.1 -u root -proot -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='CollegeDB' AND table_name IN ('Department','Faculty','Course','Student')")

if [ "$TABLE_COUNT" -ne 4 ]; then
    echo "FAIL: All four required tables were not created."
    exit 1
fi

echo "PASS: Department, Faculty, Course and Student tables exist."

echo "Checking Department table..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Department"

echo "Checking Faculty table..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Faculty"

echo "Checking Course table..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Course"

echo "Checking Student table..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Student"

echo "Checking primary keys..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA='CollegeDB' AND CONSTRAINT_NAME='PRIMARY'"

echo "Checking foreign keys..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "SELECT TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA='CollegeDB' AND REFERENCED_TABLE_NAME IS NOT NULL"

echo "Assignment 13 tests completed successfully."
```
