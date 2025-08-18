-- Section 1 – Core SQL Concepts

-- Q1: Write a SQL query to list all customers located in Nairobi. Show only full_name and location.
Select full_name, location  FROM customer_info
WHERE location = 'Nairobi';

-- Q2: Write a SQL query to display each customer along with the products they purchased. Include full_name, product_name, and price.

Select ci.full_name, p.product_name, p.price
FROM sales 
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
SELECT p.product_name, s.total_sales,
RANK() OVER(PARTITION BY  p.product_id, p.product_name ORDER BY s.total_sales DESC) AS RNK
From products p
LEFT JOIN  sales s 
ON p.product_id = s.product_id 

-- Q8: Create a View called high_value_customers that lists all customers with total sales greater than 15,000.
CREATE VIEW high_value_customers AS
Select ci.full_name, ROUND(sum(p.price)) AS total_sales
FROM sales s
LEFT JOIN customer_info ci
ON s.customer_id = ci.customer_id
LEFT JOIN products p
ON p.product_id = s.product_id
GROUP BY ci.full_name
HAVING sum(p.price) > 15000

-- Q9: Create a Stored Procedure that accepts a location as input and returns all customers and their total spending from that location.
DELIMITER $$
CREATE PROCEDURE GetCustomersByLocation(location VARCHAR(120))
BEGIN
Select ci.full_name, ROUND(SUM(p.price)),  ci.location FROM customer_info ci
LEFT JOIN sales s  ON ci.customer_id = s.customer_id 
LEFT JOIN products p on s.product_id = p.product_id 
GROUP BY ci.full_name, ci.location;
END$$;
DELIMITER ;
CALL GetCustomersByLocation('Thika');


-- Q10: Write a recursive query to display all sales transactions in order by sales_id, along with a running total of sales.
With RECURSIVE Sales_transactions AS (
Select s.sales_id, s.total_sales, s.total_sales AS runningtotal   From sales s
WHERE s.sales_id = 1
UNION ALL
SELECT
s1.sales_id, s1.total_sales, st.runningtotal+s1.total_sales
FROM sales s1
INNER JOIN Sales_transactions st
ON s1.sales_id = st.sales_id + 1
AND s1.sales_id <= (SELECT MAX(sales_id) FROM sales)

)
select * From Sales_transactions;

-- Section 3 – Query Optimization & Execution Plans
EXPLAIN SELECT * FROM sales WHERE total_sales > 5000;
-- Explain two changes you would make to improve its performance and then write the optimized SQL query.
-- 1. Query specific columns instead of select all (*)
-- 2. Use WHERE and index columns like sale_id
-- Q12: Create an index on a column that would improve queries filtering by customer location, then write a query to test the improvement.

CREATE INDEX idx_location ON customer_info(location);

EXPLAIN 
SELECT s.sales_id, s.total_sales, ci.full_name, ci.location FROM sales s
JOIN customer_info ci
ON s.customer_id = ci.customer_id
WHERE ci.location = 'Nairobi'
-- challenge: Interpreting the query execution plans

-- Section 4 – Data Modeling
-- Q13: Redesign the given schema into 3rd Normal Form (3NF) and provide the new CREATE TABLE statements.
-- Which 'given schema' is being referred to?
-- Q14: Create a Star Schema design for analyzing sales by product and customer location. Include the fact table and dimension tables with their fields.
-- 1. fact table
CREATE TABLE sales(
    sales_id INT PRIMARY KEY,
    total_sales FLOAT,
    product_id INT,
    customer_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id)
);
-- 2. dimension tables
CREATE TABLE customer_info(
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(120),
    location VARCHAR(90)
);
CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(120),
    price FLOAT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id)
);
-- Q15: Explain a scenario where denormalization would improve performance for reporting queries, and demonstrate the SQL table creation for that denormalized structure.

-- 1. When you want to improve query perfromance by reducing the number of joins.
-- 2. When you want to improve the process of updating the database by reducing the number of tables.
-- 3. When you want to make it easier to analyze data, since relationsips are easier to identify.
-- 4. Reduce server load due to less computational overload.  

-- Example:
-- Normalized Structure
-- Students table
-- student_id | student_name
-- 
-- Teacher Table
-- class_id | class_name | Teacher
-- 
-- Class Table
-- class_Id | student_id | Teacher

-- Denormalized Structure
-- student_id |student_name |class_name | Teacher




