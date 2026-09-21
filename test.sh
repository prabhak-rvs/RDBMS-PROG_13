```bash
#!/bin/bash

set -e

echo "Assignment 13 - 3NF Normalization"
echo "Starting..."

mysql -h 127.0.0.1 -u root -proot -e "DROP DATABASE IF EXISTS CollegeDB"
mysql -h 127.0.0.1 -u root -proot -e "CREATE DATABASE CollegeDB"

echo "Executing student answers..."

mysql -h 127.0.0.1 -u root -proot CollegeDB < answers.sql

echo "Checking tables..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "SHOW TABLES"

echo "Checking Department..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Department"

echo "Checking Faculty..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Faculty"

echo "Checking Course..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Course"

echo "Checking Student..."

mysql -h 127.0.0.1 -u root -proot CollegeDB -e "DESCRIBE Student"

echo "TEST COMPLETED SUCCESSFULLY"
```
