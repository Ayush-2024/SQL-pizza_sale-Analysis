create database pizzahut;

use pizzahut;
select * from pizzas;
select * from pizza_types;
select * from orders;
select * from order_details;
-- BASIC QUESTION
-- Retrieve the total number of orders placed. 
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;
-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- Identify the highest-priced pizza.
select name,price from pizzas
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by price desc
limit 1;
-- Identify the most common pizza size ordered.
select count(size),size from pizzas
group by size limit 1;

-- List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name, sum(order_details.quantity) as quantity from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;

-- Intermediate:

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(time); 

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS names
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) AS order_per_day
FROM
    (SELECT 
        date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category, round(sum(order_details.quantity * pizzas.price) / (select
round(sum(order_details.quantity * pizzas.price),
         2) as total_sales
 from 
 order_details
 join
 pizzas on pizzas.pizza_id = order_details.pizza_id) * 100,2) as revenue
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details  
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc;


-- for practise the nested query

-- find the average price
-- find the size > ang price
select * from pizzas
where price > (select avg(price) from pizzas);

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select * from
(select pt.pizza_type_id,pt.category, round(sum(P.price * od.quantity),2) as revenue,
dense_rank() over(partition by pt.category order by sum(P.price * od.quantity) desc) as top_sale_each_category_pizza
from pizza_types as pt
join pizzas as P
on 
P.pizza_type_id = pt.pizza_type_id
join order_details as od
on
od.pizza_id = P.pizza_id
group by 1,2
) as t1
where top_sale_each_category_pizza <=3
;

-- Analyze the cumulative revenue generated over time.

select date, round(sum(od.quantity * p.price),2) as total_revenue
from orders as o
join order_details as od
on
o.order_id = od.order_id
join pizzas as p
on
p.pizza_id = od.pizza_id
group by 1
;
