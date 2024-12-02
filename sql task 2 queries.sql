--JOINS 
QUE. TASK1

create table customers (customer_id serial primary key,customer_name varchar,city varchar,phone_number bigint,email varchar,registration_date date
);

create table orders(order_id serial primary key,customer_id int references customers(customer_id),order_date date,order_amount int,delivery_city varchar,payment_mode varchar
);

create table products (product_id serial primary key,product_name varchar,	category varchar,price int,stock_quantity int,supplier_name varchar,supplier_city varchar,supply_date date
);

create table order_items (order_item_id serial primary key,order_id int references orders(order_id),product_id int references products(product_id),
quantity int,total_price int);

select c.customer_name,c.city,o.order_date from customers c
join orders o on c.customer_id = o.customer_id
where extract (year from order_date) = 2023

TASK2

Select p.product_name,p.category,oi.total_price from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where c.city = 'Mumbai'

TASK3


Select c.customer_name,o.order_date,oi.total_price from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.payment_mode = 'Credit Card'

TASK4 

select p.product_name,p.category,oi.total_price from orders o
join order_items oi on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
where o.order_date between '2023-01-01' and '2023-06-01'

TASK5

select c.customer_name, sum (oi.quantity) from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_name


--DISTINCT 

TASK1

select distinct city from customers

TASK2

select distinct supplier_name from products

TASK3

select distinct payment_mode from orders

TASK4

select distinct category from products

TASK5

select distinct supplier_city from products

--ORDER BY 

TASK1

select * from customers
order by customer_name Asc

TASK2

select * from order_items
order by total_price desc

TASK3

select * from products
order by price asc,category desc

TASK4

select order_id,customer_id,order_date from orders
order by order_date desc

TASK5

select city, count(order_id) from customers c
join orders o on c.customer_id = o.customer_id
group by city order by city asc


--LIMIT & OFFSET

TASK1 

select * from customers order by customer_name limit 10 

TASK2

select * from products order by price desc
limit 5

TASK3

select * from customers
order by customer_id asc
limit 10 offset 10

TASK4

select order_id,order_date,customer_id from orders
where extract (year from order_date)= 2023
order by order_date asc
limit 5

TASK5

select  distinct delivery_city from orders
limit 10 offset 10

--AGGREGATE FUNCTIONS

TASK1

select count(order_id) from orders

TASK2

select sum(order_amount) from orders where payment_mode = 'UPI'

TASK3

select avg(price) from products

TASK4

select min(total_price),max(total_price) from order_items oi
join orders o on oi.order_id =o.order_id
where extract (year from order_date ) = 2023

TASK5

select product_id, sum(quantity) from order_items
group by product_id

--SET OPERATIONS 

TASK1

select customer_name from customers where customer_id in (select customer_id from orders where extract ( year from order_date)=2022
intersect
select customer_id from orders where extract ( year from order_date)=2023)


TASK2

select product_name from products where product_id in ( select product_id from orders o
join order_items oi on oi.order_id = o.order_id
where extract (year from order_date)= 2022)
EXCEPT
select product_name from products where product_id in ( select product_id from orders o
join order_items oi on oi.order_id = o.order_id
where extract (year from order_date)=2023)

TASK3

select supplier_city from products
except
select city from customers

TASK4

select supplier_city from products
union
select city from customers

TASK5

select product_name from products where product_id in (select product_id from products
intersect
select product_id from order_items oi
join orders o on o.order_id = oi.order_id
where extract (year from order_date) = 2023)

--SUBQUERIES

TASK1

select customer_name from customers where customer_id in ( select customer_id from orders o
join order_items oi on oi.order_id = o.order_id
group by customer_id having sum(total_price) > (select avg (total_price) from order_items ))

TASK2

select product_name from products where product_id in 
(select product_id from order_items
group by product_id having count (*)>1)

TASK3

select product_name from products where product_id in 
(select product_id from order_items oi
join orders o on o.order_id = oi.order_id
join customers c on o.customer_id = c.customer_id
where city = 'Pune')

TASK4

select order_id, delivery_city,payment_mode from orders where order_id in 
(select order_id from order_items group by order_id order by sum(total_price) desc limit 3)

TASK5

select customer_name from customers where customer_id in ( select customer_id from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where p.price > 30000)





















