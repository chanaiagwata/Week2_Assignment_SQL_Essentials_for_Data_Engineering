-- Section 1 – Core SQL Concepts

-- Q1: Write a SQL query to list all customers located in Nairobi. Show only full_name and location.
Select full_name, location  FROM customer_info
WHERE location = 'Nairobi';

-- Q2: Write a SQL query to display each customer along with the products they purchased. Include full_name, product_name, and price.

Select ci.full_name, p.product_name, p.price
FROM sales s
LEFT JOIN customer_info ci
ON s.customer_id = ci.customer_id
LEFT JOIN products p
ON p.product_id = s.product_id


-- Q3: Write a SQL query to find the total sales amount for each customer. Display full_name and the total amount spent, sorted in descending order.
Select ci.full_name, ROUND(sum(p.price)) Total_amount_spent
FROM sales s
LEFT JOIN customer_info ci
ON s.customer_id = ci.customer_id
LEFT JOIN products p
ON p.product_id = s.product_id

GROUP BY ci.full_name
ORDER BY Total_amount_spent DESC;

-- Q4: Write a SQL query to find all customers who have purchased products priced above 10,000.
Select ci.full_name, ROUND(sum(p.price))
FROM sales s
LEFT JOIN customer_info ci
ON s.customer_id = ci.customer_id
LEFT JOIN products p
ON p.product_id = s.product_id
GROUP BY ci.full_name
HAVING sum(p.price) > 10000

-- Q5: Write a SQL query to find the top 3 customers with the highest total sales.

Select ci.full_name, ROUND(sum(p.price)) total_Sales
FROM sales s
LEFT JOIN customer_info ci
ON s.customer_id = ci.customer_id
LEFT JOIN products p
ON p.product_id = s.product_id
GROUP BY ci.full_name
ORDER BY  total_Sales DESC
LIMIT 3;

-- Section 2 – Advanced SQL Techniques

-- Q6: Write a CTE that calculates the average sales per customer and then returns customers whose total sales are above that average.

WITH customer_sales AS (Select ci.full_name, p.price
FROM sales s
LEFT JOIN customer_info ci
ON s.customer_id = ci.customer_id
LEFT JOIN products p
ON p.product_id = s.product_id
)
SELECT full_name, ROUND(AVG(price))
FROM customer_sales
GROUP BY  full_name
HAVING SUM(price) > AVG(price)

-- Q7: Write a Window Function query that ranks products by their total sales in descending order. Display product_name, total_sales, and rank.
Select ci.full_name, p.product_name, ROUND(sum(p.price)) Total_sales,
RANK() OVER(PARTITION BY p.product_name ORDER BY Total_sales) AS RNK
FROM sales s
LEFT JOIN customer_info ci
ON s.customer_id = ci.customer_id
LEFT JOIN products p
ON p.product_id = s.product_id



