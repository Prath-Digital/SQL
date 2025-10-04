-- ==========================================================
-- Database: business_insights_db
-- Purpose : Manage employees, departments, projects, tasks
-- Author  : Prath Digital (Prath Udhnawala)
-- ==========================================================
-- Drop and recreate database
DROP DATABASE IF EXISTS business_insights_db;

CREATE DATABASE business_insights_db;

USE business_insights_db;

-- ==========================================================
-- Table: sales
-- ==========================================================
CREATE TABLE
    sales (
        sale_id INT AUTO_INCREMENT PRIMARY KEY,
        sale_date DATETIME NOT NULL,
        customer_id INT,
        amount DECIMAL(10, 2)
    );

-- ==========================================================
-- Table: orders
-- ==========================================================
CREATE TABLE
    orders (
        order_id INT AUTO_INCREMENT PRIMARY KEY,
        order_date DATETIME NOT NULL,
        delivery_date DATETIME,
        customer_id INT
    );

-- ==========================================================
-- Table: logs
-- ==========================================================
CREATE TABLE
    logs (
        log_id INT AUTO_INCREMENT PRIMARY KEY,
        timestamp DATETIME NOT NULL,
        action VARCHAR(100)
    );

-- ==========================================================
-- Table: employees
-- ==========================================================
CREATE TABLE
    employees (
        emp_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_name VARCHAR(100) NOT NULL,
        join_date DATE,
        email VARCHAR(100)
    );

-- ==========================================================
-- Table: customers
-- ==========================================================
CREATE TABLE
    customers (
        customer_id INT AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        join_date DATE,
        purchase_date DATE
    );

-- ==========================================================
-- Table: products
-- ==========================================================
CREATE TABLE
    products (
        product_id INT AUTO_INCREMENT PRIMARY KEY,
        product_code VARCHAR(50),
        product_name VARCHAR(100)
    );

-- ==========================================================
-- Table: addresses
-- ==========================================================
CREATE TABLE
    addresses (
        address_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_id INT,
        city VARCHAR(100)
    );

-- ==========================================================
-- Table: users
-- ==========================================================
CREATE TABLE
    users (
        user_id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(100),
        email VARCHAR(100)
    );

-- ==========================================================
-- Table: companies
-- ==========================================================
CREATE TABLE
    companies (
        company_id INT AUTO_INCREMENT PRIMARY KEY,
        company_name VARCHAR(100)
    );

-- ==========================================================
-- Sample Data Inserts
-- ==========================================================
INSERT INTO
    sales (sale_date, customer_id, amount)
VALUES
    ('2024-10-01 14:30:00', 1, 100.00),
    ('2024-10-05 09:15:00', 2, 150.00),
    ('2024-10-06 13:45:00', 3, 200.00),
    ('2024-11-01 10:00:00', 1, 120.00),
    ('2025-01-04 08:00:00', 4, 180.00);

INSERT INTO
    orders (order_date, delivery_date, customer_id)
VALUES
    ('2025-01-01 10:00:00', '2025-01-05 12:00:00', 1),
    ('2025-01-04 15:00:00', '2025-01-07 09:00:00', 2),
    ('2025-01-05 14:00:00', '2025-01-08 11:00:00', 3),
    ('2025-10-04 09:00:00', NULL, 4);

INSERT INTO
    logs (timestamp, action)
VALUES
    ('2025-10-04 07:02:00', 'Login'),
    ('2025-10-04 07:15:00', 'Logout'),
    ('2025-10-04 08:00:00', 'Update');

INSERT INTO
    employees (emp_name, join_date, email)
VALUES
    ('Alice', '2024-01-01', 'alice@org.com'),
    ('Bob', '2024-06-15', 'bob@org.com'),
    ('Charlie', '2025-01-01', 'charlie@org.com');

INSERT INTO
    customers (first_name, last_name, join_date, purchase_date)
VALUES
    ('John', 'Doe', '2024-01-01', '2024-10-04'),
    ('Jane', 'Smith', '2024-06-01', '2025-01-01'),
    ('Mike', 'Johnson', '2025-01-01', NULL),
    ('Sarah', 'Williams', '2025-09-01', NULL);

INSERT INTO
    products (product_code, product_name)
VALUES
    ('ABC123', 'Widget A'),
    ('XYZ789', 'Widget B'),
    ('DEF456', 'Widget C');

INSERT INTO
    addresses (customer_id, city)
VALUES
    (1, 'New York'),
    (2, 'los angeles'),
    (3, 'chicago');

INSERT INTO
    users (username, email)
VALUES
    ('user1', 'user1@example.com'),
    ('user2', 'user2@test.co.uk');

INSERT INTO
    companies (company_name)
VALUES
    ('Inc.'),
    ('LLC');

-- ==========================================================
-- QUESTIONS & ANSWERS (Q1 - Q30)
-- ==========================================================
-- Q1: Retrieve the year, month, and day separately from a sales_date column in the sales table
SELECT
    "Q1: Retrieve the year, month, and day separately from a sales_date column in the sales table";

SELECT
    YEAR (sale_date) AS year,
    MONTH (sale_date) AS month,
    DAY (sale_date) AS day
FROM
    sales;

-- Q2: Extract the hour and minute from a timestamp column in the logs table
SELECT
    "Q2: Extract the hour and minute from a timestamp column in the logs table";

SELECT
    HOUR (timestamp) AS hour,
    MINUTE (timestamp) AS minute
FROM
    logs;

-- Q3: Format the order_date column to display in DD-MM-YYYY format
SELECT
    "Q3: Format the order_date column to display in DD-MM-YYYY format";

SELECT
    DATE_FORMAT (order_date, '%d-%m-%Y') AS formatted_date
FROM
    orders;

-- Q4: Convert a datetime column to only show the date part
SELECT
    "Q4: Convert a datetime column to only show the date part";

SELECT
    DATE (sale_date) AS date_only
FROM
    sales;

-- Q5: Retrieve all records where the order was placed on a weekend
SELECT
    "Q5: Retrieve all records where the order was placed on a weekend";

SELECT
    *
FROM
    orders
WHERE
    DAYOFWEEK (order_date) IN (1, 7);

-- Q6: Calculate the difference in days between the order date and delivery date in an orders table
SELECT
    "Q6: Calculate the difference in days between the order date and delivery date in an orders table";

SELECT
    order_id,
    DATEDIFF (delivery_date, order_date) AS days_difference
FROM
    orders;

-- Q7: Find the number of employees who joined in the last 6 months
SELECT
    "Q7: Find the number of employees who joined in the last 6 months";

SELECT
    COUNT(*) AS new_employees
FROM
    employees
WHERE
    join_date >= DATE_SUB (CURDATE (), INTERVAL 6 MONTH);

-- Q8: Identify customers who have not made a purchase in the last year
SELECT
    "Q8: Identify customers who have not made a purchase in the last year";

SELECT
    first_name,
    last_name
FROM
    customers
WHERE
    purchase_date IS NULL
    OR purchase_date < DATE_SUB (CURDATE (), INTERVAL 1 YEAR);

-- Q9: Retrieve all records where the event date is within the next 30 days
SELECT
    "Q9: Retrieve all records where the event date is within the next 30 days";

SELECT
    *
FROM
    orders
WHERE
    delivery_date BETWEEN CURDATE () AND DATE_ADD  (CURDATE (), INTERVAL 30 DAY);

-- Q10: Determine the total revenue generated in the last quarter
SELECT
    "Q10: Determine the total revenue generated in the last quarter";

SELECT
    SUM(amount) AS total_revenue
FROM
    sales
WHERE
    sale_date >= DATE_SUB (CURDATE (), INTERVAL 3 MONTH)
    AND sale_date < CURDATE ();

-- Q11: Identify the most active hour of the day based on login timestamps
SELECT
    "Q11: Identify the most active hour of the day based on login timestamps";

SELECT
    HOUR (timestamp) AS hour,
    COUNT(*) AS login_count
FROM
    logs
WHERE
    action = 'Login'
GROUP BY
    HOUR (timestamp)
ORDER BY
    login_count DESC
LIMIT
    1;

-- Q12: Compare sales performance between the current month and the previous month
SELECT
    "Q12: Compare sales performance between the current month and the previous month";

SELECT
    SUM(
        CASE
            WHEN MONTH (sale_date) = MONTH (CURDATE ()) THEN amount
            ELSE 0
        END
    ) AS current_month_sales,
    SUM(
        CASE
            WHEN MONTH (sale_date) = MONTH (DATE_SUB (CURDATE (), INTERVAL 1 MONTH)) THEN amount
            ELSE 0
        END
    ) AS previous_month_sales
FROM
    sales
WHERE
    YEAR (sale_date) = YEAR (CURDATE ())
    AND (
        MONTH (sale_date) = MONTH (CURDATE ())
        OR MONTH (sale_date) = MONTH (DATE_SUB (CURDATE (), INTERVAL 1 MONTH))
    );

-- Q13: Retrieve the highest and lowest transaction amounts for each month in a year
SELECT
    "Q13: Retrieve the highest and lowest transaction amounts for each month in a year";

SELECT
    YEAR (sale_date) AS year,
    MONTH (sale_date) AS month,
    MAX(amount) AS highest_amount,
    MIN(amount) AS lowest_amount
FROM
    sales
GROUP BY
    YEAR (sale_date),
    MONTH (sale_date);

-- Q14: Calculate the average time taken for order delivery using DATEDIFF()
SELECT
    "Q14: Calculate the average time taken for order delivery using DATEDIFF()";

SELECT
    AVG(DATEDIFF (delivery_date, order_date)) AS avg_delivery_time
FROM
    orders
WHERE
    delivery_date IS NOT NULL;

-- Q15: Find customers whose first purchase was exactly one year ago today
SELECT
    "Q15: Find customers whose first purchase was exactly one year ago today";

SELECT
    first_name,
    last_name
FROM
    customers
WHERE
    purchase_date = DATE_SUB (CURDATE (), INTERVAL 1 YEAR);

-- Q16: Combine first and last names from the customers table into a single column as "Full Name"
SELECT
    "Q16: Combine first and last names from the customers table into a single column as 'Full Name'";

SELECT
    CONCAT (first_name, ' ', last_name) AS 'Full Name'
FROM
    customers;

-- Q17: Extract the first three characters from product codes in the products table
SELECT
    "Q17: Extract the first three characters from product codes in the products table";

SELECT
    LEFT (product_code, 3) AS first_three_chars
FROM
    products;

-- Q18: Convert all city names in the addresses table to uppercase
SELECT
    "Q18: Convert all city names in the addresses table to uppercase";

SELECT
    UPPER(city) AS city
FROM
    addresses;

-- Q19: Trim any leading or trailing spaces from the username column in the users table
SELECT
    "Q19: Trim any leading or trailing spaces from the username column in the users table";

SELECT
    TRIM(username) AS username
FROM
    users;

-- Q20: Replace all instances of "Inc." with "LLC" in the company_name column
SELECT
    "Q20: Replace all instances of 'Inc.' with 'LLC' in the company_name column";

SELECT
    REPLACE (company_name, 'Inc.', 'LLC') AS company_name
FROM
    companies;

-- Q21: Find all email addresses from the employees table that contain ".org"
SELECT
    "Q21: Find all email addresses from the employees table that contain '.org'";

SELECT
    email
FROM
    employees
WHERE
    email LIKE '%.org%';

-- Q22: Remove special characters from phone numbers in the contacts table
SELECT
    "Q22: Remove special characters from phone numbers in the contacts table";

-- Note: Assuming a contacts table with a phone column for this example
CREATE TABLE
    contacts (
        contact_id INT AUTO_INCREMENT PRIMARY KEY,
        phone VARCHAR(20)
    );

INSERT INTO
    contacts (phone)
VALUES
    ('123-456-7890'),
    ('(987)654-3210');

SELECT
    REGEXP_REPLACE (phone, '[^0-9]', '') AS clean_phone
FROM
    contacts;

-- Q23: Standardize product codes by ensuring they are always 8 characters long, padding with zeros if necessary
SELECT
    "Q23: Standardize product codes by ensuring they are always 8 characters long, padding with zeros if necessary";

SELECT
    LPAD (product_code, 8, '0') AS standardized_code
FROM
    products;

-- Q24: Extract domain names from email addresses in the users table
SELECT
    "Q24: Extract domain names from email addresses in the users table";

SELECT
    SUBSTRING_INDEX (SUBSTRING_INDEX (email, '@', -1), '.', 1) AS domain
FROM
    users;

-- Q25: Identify and fix inconsistencies in capitalization within the categories table
SELECT
    "Q25: Identify and fix inconsistencies in capitalization within the categories table";

-- Note: Assuming a categories table with a category_name column for this example
CREATE TABLE
    categories (
        category_id INT AUTO_INCREMENT PRIMARY KEY,
        category_name VARCHAR(100)
    );

INSERT INTO
    categories (category_name)
VALUES
    ('electronics'),
    ('Books'),
    ('Clothing');

SELECT
    category_name,
    UPPER(category_name) AS standardized_name
FROM
    categories;

-- Q26: Count the number of words in product descriptions in the products table
SELECT
    "Q26: Count the number of words in product descriptions in the products table";

-- Note: Assuming product_name as description for this example
SELECT
    product_name,
    LENGTH (product_name) - LENGTH (REPLACE (product_name, ' ', '')) + 1 AS word_count
FROM
    products;

-- Q27: Find the most frequently occurring first letter in customer names
SELECT
    "Q27: Find the most frequently occurring first letter in customer names";

SELECT
    LEFT (first_name, 1) AS first_letter,
    COUNT(*) AS frequency
FROM
    customers
GROUP BY
    first_letter
ORDER BY
    frequency DESC
LIMIT
    1;

-- Q28: Detect and replace duplicate whitespace characters in comments text fields
SELECT
    "Q28: Detect and replace duplicate whitespace characters in comments text fields";

-- Note: Assuming a comments table with a comment column for this example
CREATE TABLE
    comments (
        comment_id INT AUTO_INCREMENT PRIMARY KEY,
        comment TEXT
    );

INSERT INTO
    comments (comment)
VALUES
    ('This   is   a   test'),
    ('Another    test');

SELECT
    REGEXP_REPLACE (comment, '[ ]+', ' ') AS cleaned_comment
FROM
    comments;

-- Q29: Generate a slug (URL-friendly string) from product names by replacing spaces with hyphens
SELECT
    "Q29: Generate a slug (URL-friendly string) from product names by replacing spaces with hyphens";

SELECT
    LOWER(REPLACE (product_name, ' ', '-')) AS slug
FROM
    products;

-- Q30: Extract numeric values from alphanumeric product codes for further analysis
SELECT
    "Q30: Extract numeric values from alphanumeric product codes for further analysis";

SELECT
    REGEXP_REPLACE (product_code, '[^0-9]', '') AS numeric_value
FROM
    products;