select * from customers_info ci;

select * from orders;

select * from product;

set search_path to lemon_shop_affair;



create  table produc(
product_id int primary key,
product_name varchar(50),
price float
);
insert into product (
values
(1, 'Laptop', 1050),
(2,'Mouse', 850),
(3,'Keyboard', 1000),
(4,'Powerbank', 1200)
);

create table customers_info (
customer_id int primary key,
customer_name varchar(50),
location varchar(50)
);
insert into customers_info(
values
(1, 'John Doe', 'Nrb'),
(2, 'Mary M', 'Thika'),
(3, 'Ben K', 'NKR'),
(4, 'Betty B', 'KRC'),
(5, 'Kete L', 'BSA'),
(6, 'Nem B', 'KRC'),
(7, 'Jane A', 'SSS'),
(8, 'Jem B', 'MSA')
);

alter table produc
rename to product;

create table orders (
order_id int,
product_id int,
customer_id int,
foreign key (product_id) references product (product_id),
foreign key (customer_id) references customers_info  (customer_id),
sales int,
price float
);
select * from products;
insert into orders(
values
(1, 2,3,10,850),
(2,1,1,50,1050),
(3,2,4,300,850),
(4,2,1,350,297500),
(5,2,8,450,892500),
(6,2,7,250,212500),
(7,2,6,650,552500),
(8,3,6,1050,1050000),
(9,3,5,150,150000),
(10,1,1,500,525000),
(11,4,1,250,300000),
(12,4,1,1150,1380000),
(13,4,1,350,420000)
);
select * from orders;

--Which product generate the highest total sales?

select a.product_id, b.product_name, sum(a.sales*a.price) Total_Sales 
 from orders a
 inner join product b
 on a.product_id = b.product_id
 group by a.product_id,b.product_name 
order by Total_Sales  desc;

--Which customers have made purchases, and what products did they buy?
 select a.product_id, b.customer_name, c.product_name from orders a
 inner join customers_info b on a.customer_id = b.customer_id
 left join product c on a.product_id = c.product_id
 order by product_id
 
--What is the total sales amount per customer?
 select b.customer_name, sum(a.sales*a.price)  from orders a
 inner join customers_info b on a.customer_id = b.customer_id
 Group by b.customer_name

--Are there any customers who haven't bought any products?

 select b.customer_name, sum(a.sales*a.price) total_sales  from orders a
 right join customers_info b on a.customer_id = b.customer_id
 Group by b.customer_name

--Which was the 2nd most bought product?
select product_name, product_id, total_sales,
RANK() over (order by total_sales DESC) as rank
from (select a.product_name, a.product_id,SUM(b.sales*b.price) total_sales from  product a
left join orders b
on a.product_id = b.product_id
group by a.product_id,a.product_name);
 
 
create schema product_Categories;
create table product_cat (
subcategory_ID Serial,
name varchar(50),
subcategory varchar(50),
cateory varchar(50)
);
alter table product_cat
rename column  subcategory_id to employee_id;
insert  into product_cat (employee,manager,manager_id)
values
('chanai', 'wachira',2),
('kiama', 'CK',14),
('Kip', 'Glory',13),
('Ndunge', 'Kip',3),
('Stella', 'Ruth',6),
('Ruth', 'Glory',13),
('Mwas', 'Glory',15),
('Lilian', 'Mwas',8),
('Konye', 'Hellen',10),
('Hellen', 'Edu',15),
('Mary', 'Stella',5),
('Henry', 'Ruth',6),
('Glory', 'Edu',15),
('CK','null',NULL),
('EDU','null',NULL)
;
update product_cat
set manager_id = 13
Where employee_id = 7

select * from product_cat


with recursive heirarchy_cte as (
	select employee_id,employee, manager_id, manager, 1 AS level
	from product_cat
	where manager_id is NULL
	union all
	select p.employee_id, p.employee, p.manager_id, p.manager, level+1 from product_cat p
	inner join heirarchy_cte he ON p.manager_id = he.employee_id
)
select*from heirarchy_cte;







