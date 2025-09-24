DROP DATABASE IF EXISTS school_store_db;

CREATE DATABASE school_store_db;

USE school_store_db;

-- 1st Normal Form (1NF)
-- Q1: Create a table orders with the following structure
CREATE TABLE
    orders (
        order_id INT,
        customer_name VARCHAR(50),
        products VARCHAR(100), -- Example: 'Laptop, Mouse, Keyboard'
        order_date DATE
    );

-- Q1: Insert 3 records with multiple products stored as a single value in the products column
INSERT INTO
    orders (order_id, customer_name, products, order_date)
VALUES
    (
        1,
        'John Doe',
        'Laptop, Mouse, Keyboard',
        '2025-09-01'
    ),
    (2, 'Jane Smith', 'Monitor, Printer', '2025-09-02'),
    (3, 'Alice Brown', 'Mouse, Keyboard', '2025-09-03');

-- Q1: Normalize the table to 1NF by creating a new table order_details where each product gets its own row
CREATE TABLE
    order_details (order_id INT, product_name VARCHAR(50));

-- Q1: Insert normalized data into order_details
INSERT INTO
    order_details (order_id, product_name)
VALUES
    (1, 'Laptop'),
    (1, 'Mouse'),
    (1, 'Keyboard'),
    (2, 'Monitor'),
    (2, 'Printer'),
    (3, 'Mouse'),
    (3, 'Keyboard');

-- 2nd Normal Form (2NF)
-- Q2: Create a table student_courses with the following structure
CREATE TABLE
    student_courses (
        student_id INT,
        student_name VARCHAR(50),
        course_id INT,
        course_name VARCHAR(50)
    );

-- Q2: Insert records where each student is enrolled in multiple courses
INSERT INTO
    student_courses (student_id, student_name, course_id, course_name)
VALUES
    (1, 'Tom Hanks', 101, 'Math'),
    (1, 'Tom Hanks', 102, 'Science'),
    (2, 'Emma Stone', 101, 'Math'),
    (2, 'Emma Stone', 103, 'History');

-- Q2: Normalize the table to 2NF by splitting it into
-- A students table with columns: student_id, student_name
CREATE TABLE
    students (
        student_id INT PRIMARY KEY,
        student_name VARCHAR(50)
    );

-- A courses table with columns: course_id, course_name
CREATE TABLE
    courses (
        course_id INT PRIMARY KEY,
        course_name VARCHAR(50)
    );

-- A linking table student_course_mapping with columns: student_id, course_id
CREATE TABLE
    student_course_mapping (
        student_id INT,
        course_id INT,
        FOREIGN KEY (student_id) REFERENCES students (student_id),
        FOREIGN KEY (course_id) REFERENCES courses (course_id)
    );

-- Q2: Insert data into normalized tables
INSERT INTO
    students (student_id, student_name)
VALUES
    (1, 'Tom Hanks'),
    (2, 'Emma Stone');

INSERT INTO
    courses (course_id, course_name)
VALUES
    (101, 'Math'),
    (102, 'Science'),
    (103, 'History');

INSERT INTO
    student_course_mapping (student_id, course_id)
VALUES
    (1, 101),
    (1, 102),
    (2, 101),
    (2, 103);

-- 3rd Normal Form (3NF)
-- Q3: Create a table employees with the following structure
CREATE TABLE
    employees (
        emp_id INT,
        emp_name VARCHAR(50),
        department_id INT,
        department_name VARCHAR(50),
        manager_name VARCHAR(50)
    );

-- Q3: Insert records where department_name depends only on department_id, not on the full primary key
INSERT INTO
    employees (
        emp_id,
        emp_name,
        department_id,
        department_name,
        manager_name
    )
VALUES
    (1, 'Mike Ross', 101, 'HR', 'Sarah Lee'),
    (2, 'Rachel Zane', 102, 'IT', 'John Smith'),
    (3, 'Harvey Specter', 101, 'HR', 'Sarah Lee');

-- Q3: Normalize the table to 3NF by splitting it into
-- An employees table with columns: emp_id, emp_name, department_id
CREATE TABLE
    employees_normalized (
        emp_id INT PRIMARY KEY,
        emp_name VARCHAR(50),
        department_id INT
    );

-- A departments table with columns: department_id, department_name, manager_name
CREATE TABLE
    departments (
        department_id INT PRIMARY KEY,
        department_name VARCHAR(50),
        manager_name VARCHAR(50)
    );

-- Q3: Insert data into normalized tables
INSERT INTO
    departments (department_id, department_name, manager_name)
VALUES
    (101, 'HR', 'Sarah Lee'),
    (102, 'IT', 'John Smith');

INSERT INTO
    employees_normalized (emp_id, emp_name, department_id)
VALUES
    (1, 'Mike Ross', 101),
    (2, 'Rachel Zane', 102),
    (3, 'Harvey Specter', 101);

-- Q4: Create a table products with the following structure
CREATE TABLE
    products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(50),
        price DECIMAL(10, 2)
    );

-- Q4: Insert 3 records into the products table
INSERT INTO
    products (product_id, product_name, price)
VALUES
    (1, 'Laptop', 999.99),
    (2, 'Mouse', 29.99),
    (3, 'Keyboard', 59.99);

-- Q4: Try inserting a duplicate value for product_id and observe the result
-- INSERT INTO products (product_id, product_name, price) VALUES (1, 'Laptop', 999.99); -- This will fail due to PRIMARY KEY constraint
-- Q5: Create a table customers with the following structure
CREATE TABLE
    customers (
        customer_id INT PRIMARY KEY,
        customer_name VARCHAR(50),
        email VARCHAR(100)
    );

-- Q5: Insert 3 customer records and ensure each customer_id is unique
INSERT INTO
    customers (customer_id, customer_name, email)
VALUES
    (1, 'John Doe', 'john@example.com'),
    (2, 'Jane Smith', 'jane@example.com'),
    (3, 'Alice Brown', 'alice@example.com');

-- Q6: Create a table orders with the following structure
CREATE TABLE
    orders_full (
        order_id INT PRIMARY KEY,
        customer_id INT,
        product_id INT,
        order_date DATE,
        quantity INT,
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
        FOREIGN KEY (product_id) REFERENCES products (product_id)
    );

-- Q6: Insert 3 orders into the table using valid customer_id and product_id values
INSERT INTO
    orders_full (
        order_id,
        customer_id,
        product_id,
        order_date,
        quantity
    )
VALUES
    (1, 1, 1, '2025-09-01', 2),
    (2, 2, 2, '2025-09-02', 1),
    (3, 3, 3, '2025-09-03', 3);

-- Q6: Try inserting a record with an invalid customer_id or product_id and observe the error
-- INSERT INTO orders_full (order_id, customer_id, product_id, order_date, quantity) VALUES (4, 99, 1, '2025-09-04', 1); -- This will fail due to FOREIGN KEY constraint
-- Q7: Write queries to:
-- Retrieve all orders along with customer names and product names using JOIN
SELECT
    o.order_id,
    c.customer_name,
    p.product_name
FROM
    orders_full o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON o.product_id = p.product_id;

-- Count the total number of orders placed by each customer
SELECT
    c.customer_name,
    COUNT(o.order_id) as total_orders
FROM
    customers c
    LEFT JOIN orders_full o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_name;

-- Calculate the total revenue generated for each product
SELECT
    p.product_name,
    SUM(o.quantity * p.price) as total_revenue
FROM
    products p
    LEFT JOIN orders_full o ON p.product_id = o.product_id
GROUP BY
    p.product_name;

-- Q8: Modify the orders table to include the ON DELETE CASCADE option for the customer_id and product_id foreign keys
DROP TABLE IF EXISTS orders;

CREATE TABLE
    orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        product_id INT,
        order_date DATE,
        quantity INT,
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
    );

-- Q8: Insert the same data into the modified orders table
INSERT INTO
    orders (
        order_id,
        customer_id,
        product_id,
        order_date,
        quantity
    )
VALUES
    (1, 1, 1, '2025-09-01', 2),
    (2, 2, 2, '2025-09-02', 1),
    (3, 3, 3, '2025-09-03', 3);

-- Q8: Delete a record from the customers table and observe the cascading effect on the orders table
-- DELETE FROM customers WHERE customer_id = 1; -- This will delete the customer and associated orders due to ON DELETE CASCADE