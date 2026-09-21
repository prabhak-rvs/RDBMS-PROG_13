```bash
#!/bin/bash
set -e

mysql -h 127.0.0.1 -P 3306 -u root -proot -e "DROP DATABASE IF EXISTS CollegeDB"
mysql -h 127.0.0.1 -P 3306 -u root -proot -e "CREATE DATABASE CollegeDB"

mysql -h 127.0.0.1 -P 3306 -u root -proot CollegeDB < answers.sql

mysql -h 127.0.0.1 -P 3306 -u root -proot CollegeDB -e "SHOW TABLES"

mysql -h 127.0.0.1 -P 3306 -u root -proot CollegeDB -e "DESCRIBE Department"
mysql -h 127.0.0.1 -P 3306 -u root -proot CollegeDB -e "DESCRIBE Faculty"
mysql -h 127.0.0.1 -P 3306 -u root -proot CollegeDB -e "DESCRIBE Course"
mysql -h 127.0.0.1 -P 3306 -u root -proot CollegeDB -e "DESCRIBE Student"
```
