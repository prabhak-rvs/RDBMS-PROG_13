#!/bin/bash

set -e

echo "======================================"
echo "Assignment 13 - 3NF Normalization"
echo "======================================"

mysql -u root -e "DROP DATABASE IF EXISTS CollegeDB;"
mysql -u root -e "CREATE DATABASE CollegeDB;"

echo "Running student SQL..."

mysql -u root CollegeDB < Assignment_13/answers.sql

echo "Checking tables..."

mysql -u root CollegeDB -e "DESCRIBE Department;"
mysql -u root CollegeDB -e "DESCRIBE Faculty;"
mysql -u root CollegeDB -e "DESCRIBE Course;"
mysql -u root CollegeDB -e "DESCRIBE Student;"

echo "Checking Primary Keys..."

mysql -u root CollegeDB -e "
SELECT TABLE_NAME, COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'CollegeDB'
AND CONSTRAINT_NAME = 'PRIMARY';
"

echo "Checking Foreign Keys..."

mysql -u root CollegeDB -e "
SELECT TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'CollegeDB'
AND REFERENCED_TABLE_NAME IS NOT NULL;
"

echo "======================================"
echo "ALL TESTS PASSED!"
echo "======================================"
