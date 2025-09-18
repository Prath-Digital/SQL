SHOW DATABASES;

DROP DATABASE IF EXISTS college_management_db;

CREATE DATABASE college_management_db;

USE college_management_db;

-- Q1
CREATE TABLE
    students (
        student_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        age INT NOT NULL,
        grade VARCHAR(10) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

INSERT INTO
    students (name, age, grade, email)
VALUES
    ('Alice', 20, 'A', 'alice@example.com'),
    ('Bob', 22, 'B', 'bob@example.com'),
    ('Charlie', 21, 'A', 'charlie@example.com');

---
-- Q2
CREATE TABLE
    products (
        product_id INT AUTO_INCREMENT PRIMARY KEY,
        product_name VARCHAR(50) NOT NULL,
        category VARCHAR(30) NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        stock_quantity INT NOT NULL
    );

INSERT INTO
    products (product_name, category, price, stock_quantity)
VALUES
    ('Laptop', 'Electronics', 999.99, 10),
    ('Smartphone', 'Electronics', 499.99, 25),
    ('Tablet', 'Electronics', 299.99, 15),
    ('Headphones', 'Accessories', 199.99, 30),
    ('Charger', 'Accessories', 29.99, 100);

---
-- Q3
SELECT
    *
FROM
    students;

SELECT
    name,
    grade
FROM
    students;

---
-- Q4
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
    price > 500;

---
-- Q5
SELECT DISTINCT
    category
FROM
    products;

---
-- Q6
UPDATE students
SET
    grade = 'A'
WHERE
    student_id = 2;

---
-- Q7
UPDATE products
SET
    price = price * 1.1;

UPDATE products
SET
    stock_quantity = 50
WHERE
    product_id = 3;

---
-- Q8
UPDATE students
SET
    email = 'gradeA@example.com'
WHERE
    grade = 'A';

---
-- Q9
DELETE FROM students
WHERE
    student_id = 3;

---
-- Q10
DELETE FROM products
WHERE
    stock_quantity = 0;

---
-- Q11
DELETE FROM students
WHERE
    age > 21;

---
-- Q12
INSERT INTO
    products (
        product_id,
        product_name,
        category,
        price,
        stock_quantity
    )
VALUES
    (6, 'Smartphone', 'Electronics', 699.99, 20);

UPDATE products
SET
    price = 749.99
WHERE
    product_id = 6;

DELETE FROM products
WHERE
    product_id = 6;

---
-- Q13
ALTER TABLE students
ADD COLUMN address VARCHAR(100);

INSERT INTO
    students (name, age, grade, email, address)
VALUES
    (
        'David',
        23,
        'A',
        'david@example.com',
        '123 Main St'
    );

UPDATE students
SET
    address = 'Unknown'
WHERE
    address IS NULL;

DELETE FROM students
WHERE
    grade = 'B';