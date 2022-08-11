-- Designing the database  and Populating the tables in the database

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  runner_id INTEGER,
  registration_date DATE
);
INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');

DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INT,
  customer_id INT,
  pizza_id INT,
  exclusions VARCHAR(10),
  extras VARCHAR(10),
  order_time TIMESTAMP 
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');

DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INT,
  runner_id INT,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');

DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INT,
  pizza_name TEXT
);
INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INT,
  toppings TEXT
);

INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');
  
DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INT,
  topping_name TEXT
);


INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');  


-- codes to answer the various business Questions for Danny
-- Data clean-up
 -- first customer_orders.
 drop table customer_orders_cleaned;
 CREATE TABLE customer_orders_cleaned SELECT * FROM customer_orders LIMIT 0;  
 
 INSERT INTO customer_orders_cleaned
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');
  
  UPDATE customer_orders_cleaned SET exclusions = '' where exclusions = 'null' or exclusions = '';
  UPDATE customer_orders_cleaned SET extras = '' where extras = 'null' or extras is NULL;

 -- Second runner_orders.
 DROP TABLE IF EXISTS runner_orders_cleaned;
CREATE TABLE runner_orders_cleaned SELECT * FROM runner_orders LIMIT 0;

INSERT INTO runner_orders_cleaned
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');

 UPDATE runner_orders_cleaned SET pickup_time = 'Order Cancelled' where cancellation LIKE '%Cancellation';
 UPDATE runner_orders_cleaned SET distance = '0km' where cancellation  LIKE '%Cancellation';
 UPDATE runner_orders_cleaned SET Duration = '0 minutes' where cancellation LIKE '%Cancellation';
 UPDATE runner_orders_cleaned SET cancellation = 'No Cancellation' where cancellation = '' or cancellation = 'null' or cancellation is NULL;

--  A. PIZZA METRICS
-- 1) How many pizzas were ordered?
Select count(pizza_id) AS 'No. of Pizzas Ordered' from customer_orders_cleaned;

-- 2)  How many unique customer orders were made?
Select count(distinct customer_id) AS 'Unique Customer Orders' from  customer_orders_cleaned;

-- 3)  How many successful orders were delivered by each runner?
Select runner_id AS Runner, COUNT(order_id) as 'Successful Orders' FROM runner_orders_cleaned where cancellation = 'No Cancellation' group by Runner;

-- 4)  How many of each type of pizza was delivered?
SELECT customer_orders_cleaned.pizza_id as 'Pizza Type', count(customer_orders_cleaned.pizza_id) As 'number of Pizza Delivered'
FROM customer_orders_cleaned
JOIN runner_orders_cleaned ON customer_orders_cleaned.order_id = runner_orders_cleaned.order_id   where  runner_orders_cleaned.cancellation = 'No Cancellation' group  by customer_orders_cleaned.pizza_id;

-- 5) How many Vegetarian and Meatlovers were ordered by each customer?
SELECT customer_id,
    SUM(
        CASE
            WHEN pizza_id = 1 THEN 1
            ELSE 0
        END
    ) as meatlovers,
    SUM(
        CASE
            WHEN pizza_id = 2 THEN 1
            ELSE 0
        END
    ) as vegetarians
FROM customer_orders_cleaned
GROUP BY customer_id
ORDER BY customer_id; 

-- 6) What was the maximum number of pizzas delivered in a single order?
SELECT order_id, COUNT(pizza_id) as Delivered_Pizzas_Per_Order
FROM customer_orders_cleaned
GROUP BY order_id
ORDER BY Delivered_Pizzas_Per_Order DESC; 

-- 7) For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
select customer_id,
	SUM(CASE
		WHEN (
        exclusions <> '0'
        Or
        extras <> 'None'
        
        )THEN 1
		
		ELSE 0
	END
) as change_on_order,

SUM(CASE
		WHEN (
        exclusions = '0'
        AND
        extras  = 'None'
        
        )THEN 1
		
		ELSE 0
	END
) as no_change_on_order
From customer_orders_cleaned
GROUP BY customer_id
ORDER BY customer_id;

-- 8) How many pizzas were delivered that had both exclusions and extras?
select customer_orders_cleaned.pizza_id, 
	sum(CASE
			WHEN(
				customer_orders_cleaned.exclusions <> '0'
				AND
				customer_orders_cleaned.extras <> 'None'
			)THEN 1
            ELSE 0
		END
) AS Total_delivered_Pizza_exclusions_extras
FROM customer_orders_cleaned
JOIN runner_orders_cleaned ON customer_orders_cleaned.order_id = runner_orders_cleaned.order_id   where  runner_orders_cleaned.cancellation = 'No Cancellation' 
;

-- 9) What was the total volume of pizzas ordered for each hour of the day?
	SELECT hour(order_time) AS Hours,count(pizza_id) as total_order_per_hour
    from customer_orders_cleaned
    group by Hours
    order by Hours;
    
    
-- 10) What was the volume of orders for each day of the week?	
	SELECT DAYNAME(order_time) AS days_of_week,count(pizza_id) as total_order_on_Day
    from customer_orders_cleaned
    group by days_of_week
    order by days_of_week;
    

					-- B Runner and Customer Experience

-- 1)	How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
Select registration_date, week(registration_date) as weeks, count( runner_id)  as number_of_runners_registered FROM runners group by weeks ; 

-- 2)	What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
Select runner_id, round(avg(duration))  FROM runner_orders_cleaned where cancellation = 'No Cancellation' group by runner_id;


-- 3)	Is there any relationship between the number of pizzas and how long the order takes to prepare?
select customer_orders_cleaned.order_id, count(customer_orders_cleaned.order_id), (customer_orders_cleaned.order_time), runner_orders_cleaned.pickup_time, minute(timediff(runner_orders_cleaned.pickup_time, customer_orders_cleaned.order_time)) as Preparation_time_min
from customer_orders_cleaned
join runner_orders_cleaned on customer_orders_cleaned.order_id = runner_orders_cleaned.order_id where runner_orders_cleaned.cancellation = 'No Cancellation' group by order_id order by preparation_time_min DESC;

-- from the table generated by the SQL query above, it shows that time taken to prepare the  3 pizzas in order id 4 is 29 minutes as against the lower time for theother orders. this therefore shows that the time taken tp prepare 
-- a higher number of pizzas will be higher and therefore there is a relationship between number of orders and preparation time.

-- 4)	What was the average distance travelled for each customer?
select customer_orders_cleaned.customer_id, customer_orders_cleaned.order_id,count(customer_orders_cleaned.order_id) as No_of_Orders, runner_orders_cleaned.runner_id, avg(runner_orders_cleaned.distance)     
from customer_orders_cleaned
join runner_orders_cleaned on customer_orders_cleaned.order_id = runner_orders_cleaned.order_id where runner_orders_cleaned.cancellation = 'No Cancellation' group by customer_orders_cleaned.customer_id;

-- 5)	What was the difference between the longest and shortest delivery times for all orders?
select  max_duration - min_duration as delivery_time_diff_in_minutes
from
(
Select max(duration) as max_duration, min(duration) as min_duration from runner_orders_cleaned where cancellation = 'No cancellation'
) as duration_calculation;

-- 6)	What was the average speed for each runner for each delivery and do you notice any trend for these values?
select runner_id, distance, round(distance/duration_in_hours) as speed
from
	(Select runner_id, distance, duration/60 as duration_in_hours 
	from runner_orders_cleaned where cancellation = 'No Cancellation' order by runner_id) as timing;

-- 7)	What is the successful delivery percentage for each runner?

SELECT runner_id as Runner, 
 Round(100 * sum(CASE WHEN cancellation ='No Cancellation' THEN 1
  ELSE 0
  END) / COUNT(cancellation)) AS Delivery_success_percentage
FROM runner_orders_cleaned
GROUP BY runner_id;


									-- C. Ingredient Optimisation
-- 1)	What are the standard ingredients for each pizza?

Select * FROM pizza_names;
SELECT pizza_names.pizza_id, pizza_names.pizza_name, pizza_recipes.toppings 
FROM pizza_names
JOIN pizza_recipes  
ON pizza_names.pizza_id = pizza_recipes.pizza_id;  

drop table if exists pizza_recipes1;
create table pizza_ingredients 
(
 pizza_id INT,toppings INT);
 
insert into pizza_ingredients
(pizza_id, toppings) 
values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,8),
(1,10),
(2,4),
(2,6),
(2,7),
(2,9),
(2,11),
(2,12);
 
with cte as 
(select pizza_ingredients.pizza_id, pizza_names.pizza_name, pizza_toppings.topping_name
from pizza_ingredients
inner join pizza_toppings
on pizza_ingredients.toppings = pizza_toppings.topping_id
inner join pizza_names
on pizza_names.pizza_id = pizza_ingredients.pizza_id
order by pizza_name, pizza_ingredients.pizza_id)
select pizza_id, pizza_name, group_concat(topping_name) as Standard_Ingredients
from cte
group by pizza_name;

-- 2)	What was the most commonly added extra?

create table order_toppings
as
SELECT customer_orders_cleaned.order_id,  SUBSTRING_INDEX(SUBSTRING_INDEX(customer_orders_cleaned.extras, ',', numbers.num), ',', -1) as extra_toppings
from
	numbers inner join customer_orders_cleaned
    on CHAR_LENGTH(customer_orders_cleaned.extras)
     -CHAR_LENGTH(REPLACE(customer_orders_cleaned.extras, ',', ''))>=numbers.num-1
     where customer_orders_cleaned.extras <> 'None'
 order by 
		customer_orders_cleaned.order_id;

select order_toppings.extra_toppings, pizza_toppings.topping_name, count(order_toppings.extra_toppings) as amount_of_usage
from order_toppings
inner join pizza_toppings
on order_toppings.extra_toppings = pizza_toppings.topping_id

group by order_toppings.extra_toppings;

-- 3)	What was the most common exclusion?

create table order_exclusions
as
SELECT customer_orders_cleaned.order_id,  SUBSTRING_INDEX(SUBSTRING_INDEX(customer_orders_cleaned.exclusions, ',', numbers.num), ',', -1) as order_exclusions
from
	numbers inner join customer_orders_cleaned
    on CHAR_LENGTH(customer_orders_cleaned.exclusions)
     -CHAR_LENGTH(REPLACE(customer_orders_cleaned.exclusions, ',', ''))>=numbers.num-1
     where customer_orders_cleaned.exclusions <> '0'
 order by 
		customer_orders_cleaned.order_id;

select order_exclusions.order_exclusions, pizza_toppings.topping_name as exclusion_name, count(order_exclusions.order_exclusions) as exclusions_count
from order_exclusions
inner join pizza_toppings
on order_exclusions.order_exclusions = pizza_toppings.topping_id

group by order_exclusions.order_exclusions
order by exclusions_count DESC;


-- 5)	Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
				-- For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"

-- first create a table to enumerate the various toppings in each Piza type

drop table pizza_details;
create table pizza_details
as
select  pizza_ingredients.pizza_id, pizza_names.pizza_name, GROUP_CONCAT(pizza_toppings.topping_name) AS ingredients
FROM pizza_ingredients
JOIN pizza_toppings on pizza_ingredients.toppings = pizza_toppings.topping_id
join pizza_names on pizza_ingredients.pizza_id = pizza_names.pizza_id
GROUP BY pizza_ingredients.pizza_id;

drop table full_pizza_details;
create table full_pizza_details
as
select customer_orders_cleaned.order_id,customer_orders_cleaned.pizza_id, pizza_details.pizza_name, pizza_details.ingredients, 
customer_orders_cleaned.exclusions, customer_orders_cleaned.extras
from customer_orders_cleaned
join pizza_details
on customer_orders_cleaned.pizza_id = pizza_details.pizza_id;

-- changing the exclusions to the topping names in text
UPDATE full_pizza_details
		INNER JOIN pizza_toppings ON full_pizza_details.exclusions = cast(pizza_toppings.topping_id as char)
		SET full_pizza_details.exclusions = pizza_toppings.topping_name
		WHERE full_pizza_details.exclusions <> '';

-- changing the extras to the topping names in text

UPDATE full_pizza_details
		INNER JOIN pizza_toppings 
        ON full_pizza_details.extras =  cast(pizza_toppings.topping_id as char)  
        -- full_pizza_details.extras = cast(pizza_toppings.topping_id as char)
		set full_pizza_details.extras = pizza_toppings.topping_name
		WHERE full_pizza_details.extras <> '';





select * from  full_pizza_details;
Select * from pizza_details;
Select * from order_exclusions;
Select * from order_toppings;
Select * FROM numbers ;
Select * FROM customer_orders_cleaned ;
Select * FROM runner_orders_cleaned order by runner_id;
Select * FROM runners;
Select * FROM pizza_names;
Select * FROM pizza_recipes;
Select * FROM pizza_toppings;
Select * FROM pizza_ingredients;



