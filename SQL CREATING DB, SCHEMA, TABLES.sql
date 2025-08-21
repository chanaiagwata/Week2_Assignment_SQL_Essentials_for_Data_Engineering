
SET search_path TO lemonjuicedb;
create schema lemon_shop_affair;
SET search_path TO lemon_shop_affair;
--table 1
create table Customers_Info (
customerID int primary key,
FullName varchar(90),
Location varchar (90)
);
--table2
create table Product(
product_id int primary key,
product_name varChar(45),
price float
);

--table3
create table Orders(
order_id int primary key,
customerID int,
quantity int,
price float
);
insert into customers_info (customerID, FullName, Location)
values
(1, 'John Doe', 'Nairobi'),
(2, 'Mary Jane', 'Machakos');

select * from  customers_info;

insert into Product (product_id,product_name,price)
values
(1, 'Laptop', 34000.50),
(2, 'Mouse', 850.34);
select * from Product;

alter table Orders
add column product_name varChar(45);



insert into Orders(order_id,customerID,product_name, quantity,price)
values
(1,1,'mouse',5,4251.7),
(2,2,'Laptop', 10,340000);
--
--update Orders
--set order_id  = 2
--where order_id =3;
--
--delete from Orders
--where order_id =2;

select * from Orders

