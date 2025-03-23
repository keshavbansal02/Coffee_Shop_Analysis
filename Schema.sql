Create database Monday_Coffee;

use Monday_Coffee;

drop table  if exists city;

Create table city(
city_id INT Primary key,
city_name Varchar(20),
population	BIGINT,
estimated_rent	INT,
city_rank INT
);

drop table  if exists customers;

Create table Customers(
customer_id	INT Primary Key,
customer_name Varchar(20),
city_id INT,
FOREIGN KEY (city_id) REFERENCES city(city_id)
);

drop table  if exists products;

Create table Products(
product_id	INT primary key,
product_name Varchar(40),
price Float
);

drop table  if exists sales;

Create table Sales(
sale_id	INT Primary key,
sale_date	date,
product_id int,
customer_id int,
foreign key(product_id) references products(product_id),
foreign key(customer_id) references customers(customer_id),
total	float,
rating float
);