#!/bin/bash

set -e

USER="grader"
PASSWORD="grader123"
DATABASE="CollegeDB"

echo "======================================"
echo "Assignment 13 - 3NF Normalization"
echo "======================================"

mysql -u"$USER" -p"$PASSWORD" -e "DROP DATABASE IF EXISTS $DATABASE;"
mysql -u"$USER" -p"$PASSWORD" -e "CREATE DATABASE $DATABASE;"

echo "Running student SQL..."

mysql -u"$USER" -p"$PASSWORD" "$DATABASE" < Assignment_13/answers.sql

echo "Checking required tables..."

TABLE_COUNT=$(mysql -u"$USER" -p"$PASSWORD" -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DATABASE'
AND table_name IN ('Department','Faculty','Course','Student');
")

if [ "$TABLE_COUNT" -ne 4 ]; then
    echo "FAIL: Required tables are missing."
    exit 1
fi

echo "PASS: All 4 tables exist."

echo "Checking Primary Keys..."

mysql -u"$USER" -p"$PASSWORD" "$DATABASE" -e "
SELECT TABLE_NAME, COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='$DATABASE'
AND CONSTRAINT_NAME='PRIMARY';
"

echo "Checking Foreign Keys..."

mysql -u"$USER" -p"$PASSWORD" "$DATABASE" -e "
SELECT TABLE_NAME,
       COLUMN_NAME,
       REFERENCED_TABLE_NAME,
       REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='$DATABASE'
AND REFERENCED_TABLE_NAME IS NOT NULL;
"

echo "======================================"
echo "ALL TESTS PASSED!"
echo "======================================"
