DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
use employee;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS location;
CREATE TABLE location(
    location_id int AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO location VALUES(null,'eluru');
INSERT INTO location VALUES(null,'hyd');
INSERT INTO location VALUES(null,'ctp');
SELECT * FROM location;
DESCRIBE location;
CREATe TABLE departments(
    department_id int PRIMARY KEY,
    department_name VARCHAR(30)
);
INSERT INTO departments VALUES(1001,'IT');
SELECT * FROM departments;
DESCRIBE departments;
CREATE TABLE employees(
    employee_id int PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender ENUM('m','f'),
    age int CHECK(age >= 18),
    hire_date DATE DEFAULT(current_date),
    designation VARCHAR(100),
    department_id int,
    location_id INT,
    salaty DECIMAL(10,2),
    FOREIGN KEY(department_id) REFERENCES departments(department_id),
    FOREIGN KEY(location_id) REFERENCES location(location_id)
);
DESCRIBE employees;








