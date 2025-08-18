create schema July_intake;

set search_path to July_intake;


-- Numeric 
-- INTEGER(INT)- whole numbers
-- SERIAL- auto increasing ID
-- NUMERIC(8,2)- precision numbers 678959.56
-- 	DECIMAL (8,2)

-- CHARACTER/ STRING 
-- CHAR(10)- fixed length string
-- VARCHAR(50) - Variable length string 
-- TEXT- unlimited string length

-- Date& Time 
-- DATE - stores dates
-- Time- stores time
-- TIMESTAMP- Date & time

-- BOOLEAN- TRUE/FALSE

create table Students (
student_ID serial,
first_name varchar(50),
last_name varchar (50),
phone_number char (10),
email text,
age int,
fee_amount numeric
);
alter table students
add column course text;

--Inserting values into Students
insert into Students (first_name, last_name, phone_number, email, age, fee_amount, course)
values
('chanai', 'agwata', '2547423001', 'nyaosia@gmail.com', 42, 230000, 'engineering'),
('John', 'Doe', '071234450', 'john@gmail.com', 22, 35000, 'data science'),
('Joy', 'Koufman', '07335628', 'kpufman@gmail.com', 22, 42992, 'analytics');

delete from students where student_ID in (2,3,4);
Select * from Students;

