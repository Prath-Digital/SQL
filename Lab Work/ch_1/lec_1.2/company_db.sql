-- Q1
SHOW DATABASES;

DROP DATABASE IF EXISTS company_db;

CREATE DATABASE company_db;

USE company_db;

---
-- Q2
CREATE TABLE
    employees (
        emp_id INT PRIMARY KEY,
        emp_name VARCHAR(50),
        department VARCHAR(50),
        salary DECIMAL(10, 2)
    );

---
-- Q3
INSERT INTO
    employees (emp_id, emp_name, department, salary)
VALUES
    (1, 'Alice Johnson', 'HR', 60000.00),
    (2, 'Bob Smith', 'IT', 75000.00),
    (3, 'Charlie Brown', 'Finance', 50000.00),
    (4, 'Diana Prince', 'Marketing', 65000.00),
    (5, 'Ethan Hunt', 'Operations', 70000.00);

SELECT
    *
FROM
    employees;

SELECT
    emp_name,
    salary
FROM
    employees;

SELECT
    *
FROM
    employees
WHERE
    salary > 50000;

---
-- Q4
INSERT INTO
    employees (emp_id, emp_name, department, salary)
VALUES
    (6, 'Fiona Glenanne', 'IT', 80000.00);

UPDATE employees
SET
    salary = 85000.00
WHERE
    emp_id = 6;

DELETE FROM employees
WHERE
    emp_id = 6;

---
-- Q5
CREATE TABLE
    products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(50),
        category VARCHAR(50),
        price DECIMAL(10, 2),
        stock_quantity INT
    );

INSERT INTO
    products (
        product_id,
        product_name,
        category,
        price,
        stock_quantity
    )
VALUES
    (1, 'Laptop', 'Electronics', 1200.00, 10),
    (2, 'Smartphone', 'Electronics', 800.00, 20),
    (3, 'Desk Chair', 'Furniture', 150.00, 15),
    (4, 'Notebook', 'Stationery', 5.00, 100),
    (5, 'Pen', 'Stationery', 2.00, 200);

---
-- Q6
SELECT
    *
FROM
    products;

SELECT
    *
FROM
    products
WHERE
    category = 'Electronics';

SELECT
    *
FROM
    products
WHERE
    price < 100;

---
-- Q7
UPDATE products
SET
    price = price * 1.10
WHERE
    category = 'Clothing';

UPDATE products
SET
    stock_quantity = stock_quantity + 5
WHERE
    product_id = 1;

---
-- Q8
DELETE FROM products
WHERE
    product_id = 5;

DELETE FROM products
WHERE
    stock_quantity = 0;

---