#!/bin/bash

set -e

USER="root"
PASSWORD="root"
HOST="127.0.0.1"
DATABASE="CollegeDB"

echo "======================================"
echo "Assignment 13 - 3NF Normalization"
echo "======================================"

mysql -h "$HOST" -u "$USER" -p"$PASSWORD" \
  -e "DROP DATABASE IF EXISTS $DATABASE;"

mysql -h "$HOST" -u "$USER" -p"$PASSWORD" \
  -e "CREATE DATABASE $DATABASE;"

echo "Running student SQL..."

mysql -h "$HOST" -u "$USER" -p"$PASSWORD" "$DATABASE" \
  < Assignment_13/answers.sql

echo "Checking tables..."

TABLE_COUNT=$(mysql -h "$HOST" -u "$USER" -p"$PASSWORD" -N -e "
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema='$DATABASE'
AND table_name IN ('Department','Faculty','Course','Student');
")

if [ "$TABLE_COUNT" -ne 4 ]; then
    echo "FAIL: All four required tables were not created."
    exit 1
fi

echo "PASS: All four tables exist."

echo "Checking Primary Keys..."

mysql -h "$HOST" -u "$USER" -p"$PASSWORD" "$DATABASE" -e "
SELECT TABLE_NAME, COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='$DATABASE'
AND CONSTRAINT_NAME='PRIMARY';
"

echo "Checking Foreign Keys..."

mysql -h "$HOST" -u "$USER" -p"$PASSWORD" "$DATABASE" -e "
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
