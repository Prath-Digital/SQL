-- ==========================================================
-- Database: ecommerce_management_db
-- Purpose : Manage employees, customers, products, and orders
-- Author  : Prath Digital (Prath Udhnawala)
-- ==========================================================
-- Drop and recreate database
DROP DATABASE IF EXISTS ecommerce_management_db;

CREATE DATABASE ecommerce_management_db;

USE ecommerce_management_db;

-- ==========================================================
-- Table: products
-- ==========================================================
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- ==========================================================
-- Table: customers
-- ==========================================================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    total_purchases INT DEFAULT 0
);

-- ==========================================================
-- Table: employees
-- ==========================================================
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    years_experience INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5)
);

-- ==========================================================
-- Table: orders
-- ==========================================================
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10, 2),
    delay_days INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

-- ==========================================================
-- Sample Data Inserts
-- ==========================================================
INSERT INTO products (product_name, price) VALUES
    ('Laptop', 1200.00),
    ('Mouse', 25.00),
    ('Monitor', 300.00),
    ('Keyboard', 50.00),
    ('Headset', 80.00);

INSERT INTO customers (customer_name, total_purchases) VALUES
    ('Alice', 5),
    ('Bob', 15),
    ('Charlie', 25),
    ('David', 2),
    ('Eve', 10);

INSERT INTO employees (emp_name, years_experience, rating) VALUES
    ('Alice', 2, 3),
    ('Bob', 5, 4),
    ('Charlie', 8, 5),
    ('David', 1, 2),
    ('Eve', 6, 4);

INSERT INTO orders (customer_id, order_amount, delay_days, quantity) VALUES
    (1, 100.00, 2, 5),
    (2, 200.00, 5, 10),
    (3, 500.00, 10, 20),
    (4, 50.00, 1, 2),
    (5, 300.00, 0, 15);

-- ==========================================================
-- QUESTIONS & ANSWERS (Q1.1 - Q2.5)
-- ==========================================================
-- Q1.1: Categorize products in the products table as "Low", "Medium", or "High" based on their price range
SELECT
    "Q1.1: Categorize products in the products table as 'Low', 'Medium', or 'High' based on their price range";

SELECT
    product_name,
    CASE
        WHEN price < 100 THEN 'Low'
        WHEN price BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS price_category
FROM
    products;
z
-- Q1.2: Assign customer loyalty levels ("New", "Regular", "VIP") based on their total number of purchases
SELECT
    "Q1.2: Assign customer loyalty levels ('New', 'Regular', 'VIP') based on their total number of purchases";

SELECT
    customer_name,
    CASE
        WHEN total_purchases < 5 THEN 'New'
        WHEN total_purchases BETWEEN 5 AND 15 THEN 'Regular'
        ELSE 'VIP'
    END AS loyalty_level
FROM
    customers;

-- Q1.3: Label employees as "Junior", "Mid-Level", or "Senior" based on years of experience
SELECT
    "Q1.3: Label employees as 'Junior', 'Mid-Level', or 'Senior' based on years of experience";

SELECT
    emp_name,
    CASE
        WHEN years_experience < 3 THEN 'Junior'
        WHEN years_experience BETWEEN 3 AND 6 THEN 'Mid-Level'
        ELSE 'Senior'
    END AS experience_level
FROM
    employees;

-- Q1.4: Convert numerical ratings (1-5) into descriptive labels like "Poor", "Average", "Good", and "Excellent"
SELECT
    "Q1.4: Convert numerical ratings (1-5) into descriptive labels like 'Poor', 'Average', 'Good', and 'Excellent'";

SELECT
    emp_name,
    CASE
        WHEN rating = 1 THEN 'Poor'
        WHEN rating = 2 THEN 'Average'
        WHEN rating = 3 THEN 'Good'
        WHEN rating = 4 THEN 'Excellent'
        ELSE 'Excellent'
    END AS rating_label
FROM
    employees;

-- Q1.5: Determine shipping cost categories ("Free", "Standard", and "Express") based on the order amount
SELECT
    "Q1.5: Determine shipping cost categories ('Free', 'Standard', and 'Express') based on the order amount";

SELECT
    order_id,
    CASE
        WHEN order_amount >= 300 THEN 'Free'
        WHEN order_amount >= 100 THEN 'Standard'
        ELSE 'Express'
    END AS shipping_category
FROM
    orders;

-- Q2.1: Create a custom discount percentage based on the quantity of items purchased
SELECT
    "Q2.1: Create a custom discount percentage based on the quantity of items purchased";

SELECT
    order_id,
    quantity,
    CASE
        WHEN quantity < 5 THEN 0
        WHEN quantity BETWEEN 5 AND 10 THEN 5
        WHEN quantity BETWEEN 11 AND 15 THEN 10
        ELSE 15
    END AS discount_percentage
FROM
    orders;

-- Q2.2: Identify overdue orders and classify them as "Slightly Late", "Late", or "Critical" based on the delay
SELECT
    "Q2.2: Identify overdue orders and classify them as 'Slightly Late', 'Late', or 'Critical' based on the delay";

SELECT
    order_id,
    delay_days,
    CASE
        WHEN delay_days <= 2 THEN 'Slightly Late'
        WHEN delay_days BETWEEN 3 AND 7 THEN 'Late'
        ELSE 'Critical'
    END AS delay_status
FROM
    orders
WHERE
    delay_days > 0;

-- Q2.3: Assign customers a risk score based on their transaction history and payment behaviour
SELECT
    "Q2.3: Assign customers a risk score based on their transaction history and payment behaviour";

SELECT
    customer_name,
    CASE
        WHEN total_purchases < 5 AND delay_days > 0 THEN 3
        WHEN total_purchases BETWEEN 5 AND 15 AND delay_days > 0 THEN 2
        WHEN total_purchases > 15 AND delay_days = 0 THEN 1
        ELSE 0
    END AS risk_score
FROM
    customers
    LEFT JOIN orders ON customers.customer_id = orders.customer_id;

-- Q2.4: Adjust employee bonuses dynamically based on performance review scores
SELECT
    "Q2.4: Adjust employee bonuses dynamically based on performance review scores";

SELECT
    emp_name,
    rating,
    salary,
    CASE
        WHEN rating = 1 THEN salary * 0
        WHEN rating = 2 THEN salary * 0.02
        WHEN rating = 3 THEN salary * 0.05
        WHEN rating = 4 THEN salary * 0.10
        ELSE salary * 0.15
    END AS bonus
FROM
    employees;

-- Q2.5: Classify stores as "Profitable", "Breaking Even", or "Unprofitable" based on their revenue
SELECT
    "Q2.5: Classify stores as 'Profitable', 'Breaking Even', or 'Unprofitable' based on their revenue";

SELECT
    order_id,
    order_amount,
    CASE
        WHEN order_amount > 300 THEN 'Profitable'
        WHEN order_amount = 300 THEN 'Breaking Even'
        ELSE 'Unprofitable'
    END AS store_status
FROM
    orders;