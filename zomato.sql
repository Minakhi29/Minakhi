create database ZOMATO;
use ZOMATO;

create table LOGIN(
ID int primary key,
CountryCode varchar(10) DEFAULT (+91),
mobile numeric
 );
 
 insert into LOGIN(ID,Countrycode,mobile)
 values
 (1,+91,9348936261),
 (2,+91,6370547509),
 (3,+91,8328837742),
 (4,+91,8763912030);
 
 select*from LOGIN;
 
 create table customers(
 ID int,
 customer_name varchar(20) not null,
 contact_number varchar(11) not null,
 address varchar(30) not null);
 
 insert into customers(ID,customer_name,contact_number,address)
 values
(1,"ROSHAN",9348936261,"DAMANJODI"),
(2,"PRADEEP",6370547509,"BHADRAK"),
(3,"DEEPAK",8328837742,"RAYAGADA"),
(4,"PIKAN",8763912030,"KORAPUT"); 

select*from customers;

create table restaurant(
 restaurant_id int,
 restaurant_name varchar(20) not null,
 rlocation varchar(20) not null,
 rrating decimal(2,1) not null);
 
 insert into restaurant(restaurant_id,restaurant_name,rlocation,rrating)
 values
(101,"odisha hotel","marathali", '4.5'),
(102, "green chilly","btm layout", '4.1'),
(103, "hydrabadi","hsr layout", '3.9'),
(104, "olive","jp nagar", '3.6'),
(105, "laa unico", "mukund nagar", '4.3'),
(106, "blue hill","krishna nagar", '4.2'),
(107, "royal dhaba","sahid nagar", '4.3');

select * from restaurant;

create table foods(
 food_id int,
 food_name varchar(20) not null,
 price_per_unit decimal(5,2) not null
);

insert into foods(food_id,food_name,price_per_unit)
values
(1001, 'allo paratha', '80.00'),
(1002, 'veg meal', '120.00'),
(1003, 'chapati', '20.00'),
(1004, 'veg thali', '220.00'),
(1005, 'chicken thali', '150.00'),
(1006, 'veg biryani', '280.00'),
(1007, 'mix veg', '180.00'),
(1008, 'veg pulav', '190.00'),
(1009, 'mix paratha', '180.00'),
(1010, 'cold drink', '35.00'),
(1011, 'paneer roll', '180.00'),
(1012, 'veg roll', '180.00');

select*from foods;

create table order_details(
 order_id int,
 ID int,
 restaurant_id int,
 order_status varchar(10));
 
 insert into order_details(order_id,ID,restaurant_id,order_status)
 values
 (501,1,101,"confirmed"),
 (502,2,102,"confirmed"),
 (503,3,103,"confirmed"),
 (504,4,104,"confirmed"),
 (505,3,106,"confirmed"),
 (506,1,104,"confirmed"),
 (507,4,107,"confirmed"),
 (508,2,103,"confirmed"),
 (509,2,105,"confirmed"),
 (510,3,101,"confirmed"),
 (511,1,104,"confirmed"),
 (512,2,106,"confirmed");
 
 select*from order_details;
 
 drop table order_food;
 create table order_food(
 order_id int,
 ID int,
 restaurant_id int,
 food_id int,
 quantity int);
 
 insert into order_food(order_id,ID,restaurant_id,food_id,quantity)
 values
 (501,1,101,1003,2),
 (506,2,106,1002,4),
 (506,4,104,1006,2),
 (502,2,107,1009,1),
 (505,3,102,1010,1),
 (503,1,104,1004,1),
 (507,2,105,1004,2),
 (508,3,101,1012,3),
 (509,4,102,1001,1),
 (510,2,103,1005,1),
 (512,3,106,1011,1);
 
 select * from order_food;
 
 -- (1) Write a SQL query to find the number of Zomato users
 select count(*) as total_no_of_users from customers;
 -- ans (4)
 
 -- (2)  Write a SQL query to find details of restaurant
 select * from restaurant;
 -- (3)  Write a SQL query to find  the list of Zomato users who made more than 2 order 
 select ID, count(*) as food_id from order_food group by ID having food_id>2;
 
 -- (4) write a sql query to find how many veg meal was order from krishna nagar resturant
SELECT COUNT(*) AS veg_meal_orders
FROM order_food ofd
JOIN restaurant r ON ofd.restaurant_id = r.restaurant_id
JOIN foods f ON ofd.food_id = f.food_id
WHERE r.restaurant_name = 'krishna nagar'
  AND f.food_name = 'veg meal';
  
  -- (5) write sql query what was the quantity of order id 505 from green chilly restaurant
SELECT quantity
FROM order_food ofd
JOIN restaurant r ON ofd.restaurant_id = r.restaurant_id
WHERE ofd.order_id = 505
AND r.restaurant_name = 'green chilly';

-- (6) Write a query to fetch the restaurant whose rating is  4 or above Fetch customer details who ordered 1 or more items should be printed.
SELECT r.restaurant_id, r.restaurant_name, r.rlocation, r.rrating, c.customer_name, c.contact_number, c.address
FROM restaurant r
JOIN order_details o ON r.restaurant_id = o.restaurant_id
JOIN order_food ofd ON o.order_id = ofd.order_id
JOIN customers c ON o.ID = c.ID
GROUP BY r.restaurant_id, r.restaurant_name, r.rlocation, r.rrating, c.customer_name, c.contact_number, c.address
HAVING r.rrating >= 4 AND COUNT(ofd.food_id) >= 1;

-- (7) fetch customer data who ordered food in location marathali and also fetch the quantity of food items they ordered
SELECT c.customer_name, c.contact_number, c.address, ofd.quantity
FROM customers c
JOIN order_details od ON c.ID = od.ID
JOIN order_food ofd ON od.order_id = ofd.order_id
JOIN restaurant r ON od.restaurant_id = r.restaurant_id
WHERE r.rlocation = 'marathali';


SELECT COUNT(*) AS veg_meal_orders
FROM order_food ofd
JOIN restaurant r ON ofd.restaurant_id = r.restaurant_id
JOIN foods f ON ofd.food_id = f.food_id
WHERE f.food_name = 'veg meal'  AND r.restaurant_name = 'krishna nagar';
