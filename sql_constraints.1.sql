#creating a database
create database ecommerce;
use ecommerce;
#create table category
create table category(
    cat_id int primary key AUTO_INCREMENT,
    cat_name varchar(20)
);
insert into category values(10,'Electronics');
insert into category values(20,'Grocery');
#structure
describe category;
select * from category;
insert into category(cat_name) values('Electronics');
insert into category(cat_name) values('Grocery');
insert into category(cat_name) values('Fashion');
#remove the TABLE
drop table category;

#create table customer
create table customer(
    cust_id int PRIMARY KEY,
    cust_name VARCHAR(20) not null,
    age int CHECK(age >= 18),
    email_id VARCHAR(30) UNIQUE
);
insert into customer values(100,'moon',20,'moon@gmail.com'); 
insert into customer values(101,'sun',19,'sun@gmail.com'); 
SELECT *from customer;

create table student(
    regno int,
    sname VARCHAR(20)
);
insert into student values(1,'sai'),(2,'ganesh'),(3,'lokesh');
DESCRIBE student;
SELECT * FROM student;
#table records are DELETE
TRUNCATE TABLE student;
#delete
DELETE from student;
SELECT * from student;
DELETE from student WHERE regno=2;

#create table product
create table product(
    p_id int PRIMARY KEY,
    p_name VARCHAR(20) not null,
    cat_id int,
    price int,
    FOREIGN KEY(cat_id) REFERENCES category(cat_id)
);
insert into product values(1002,'pixel',20,5200);
insert into product values(1003,'apple',10,52000);
SELECT * from product;





