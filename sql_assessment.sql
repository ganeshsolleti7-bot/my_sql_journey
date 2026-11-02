create database employee;
use employees;
create table deparements_info(
    department_id int primary key,
    department_name varchar(100)
);
DESCRIBE deparements_info;
create table locations(
    location_id int primary key,
    location varchar(30)
);
DESCRIBE locations;
create table employees(
    employee_id int primary key,
    employee_name varchar(50),
    gender enum('m','f'),
    age int,
    hire_date date,
    designattion varchar(100),
    department_id int,
    location_id int,
    salary decimal(10,2),
    FOREIGN KEY(department_id) REFERENCES deparements(department_id),
     FOREIGN KEY(location_id) REFERENCES location(location_id)
);
DESCRIBE employees;
ALTER table employees
ADD email VARCHAR(100);
ALTER TABLE employees
MODIFY COLUMN designattion VARCHAR(255);
ALTER TABLE employees
DROP COLUMN age;
ALTER TABLE employees
RENAME COLUMN hire_date to date_of_joining;
RENAME TABLE deparements to departments_info;
RENAME TABLE location to locations;
TRUNCATE TABLE employees;
DROP TABLE IF EXISTS employees;
DROP DATABASE IF EXISTS employees;


