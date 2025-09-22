-- Q1
DROP DATABASE IF EXISTS sales_company_db;

CREATE DATABASE sales_company_db;

USE sales_company_db;

CREATE TABLE
    sales (
        sale_id INT PRIMARY KEY,
        product_name VARCHAR(50),
        category VARCHAR(50),
        price DECIMAL(10, 2),
        quantity_sold INT,
        sale_date DATE
    );

INSERT INTO
    sales (
        sale_id,
        product_name,
        category,
        price,
        quantity_sold,
        sale_date
    )
VALUES
    (
        1,
        'Laptop',
        'Electronics',
        1200.00,
        5,
        '2024-01-15'
    ),
    (
        2,
        'Smartphone',
        'Electronics',
        800.00,
        10,
        '2024-02-20'
    ),
    (
        3,
        'Tablet',
        'Electronics',
        400.00,
        7,
        '2024-03-10'
    ),
    (
        4,
        'Headphones',
        'Electronics',
        150.00,
        15,
        '2024-01-25'
    ),
    (5, 'TV', 'Electronics', 600.00, 3, '2024-02-05'),
    (
        6,
        'Refrigerator',
        'Home Appliances',
        2000.00,
        2,
        '2024-01-30'
    ),
    (
        7,
        'Washing Machine',
        'Home Appliances',
        1200.00,
        4,
        '2024-02-15'
    ),
    (
        8,
        'Microwave',
        'Home Appliances',
        300.00,
        8,
        '2024-03-01'
    ),
    (
        9,
        'Blender',
        'Home Appliances',
        100.00,
        12,
        '2024-01-10'
    ),
    (
        10,
        'Air Conditioner',
        'Home Appliances',
        1500.00,
        1,
        '2024-02-28'
    );

SELECT
    *
FROM
    sales
WHERE
    category = 'Electronics';

SELECT
    *
FROM
    sales
WHERE
    price > 500;

SELECT
    *
FROM
    sales
WHERE
    sale_date > '2024-01-01';

-- Question over
-- Q2
SELECT
    category,
    SUM(quantity_sold) AS total_quantity_sold
FROM
    sales
GROUP BY
    category;

SELECT
    category,
    SUM(quantity_sold) AS total_quantity_sold
FROM
    sales
GROUP BY
    category;

HAVING
    SUM(quantity_sold) > 50;

-- Question over
-- Q3
SELECT
    *
FROM
    sales
LIMIT
    5;

SELECT
    *
FROM
    sales
ORDER BY
    price DESC
LIMIT
    3;

-- Question over
-- Q4
SELECT
    *
FROM
    sales
WHERE
    category = 'Clothing'
    AND price > 100;

--  Question over
-- Q5
SELECT
    *
FROM
    sales
WHERE
    category IN ('Electronics', 'Furniture');

-- Question over
-- Q6
SELECT
    *
FROM
    sales
WHERE
    category != 'Clothing';

SELECT
    *
FROM
    sales
WHERE
    price <= 300;

-- Question over
-- Q7
SELECT
    *
FROM
    sales
ORDER BY
    price ASC;

SELECT
    *
FROM
    sales
ORDER BY
    sale_date DESC;

SELECT
    *
FROM
    sales
ORDER BY
    category ASC,
    price DESC;

-- Question over
-- Q8
SELECT
    category,
    SUM(price * quantity_sold) AS total_revenue
FROM
    sales
GROUP BY
    category;

SELECT
    category,
    AVG(price) AS average_price
FROM
    sales
GROUP BY
    category;

SELECT
    category,
    AVG(price) AS average_price
FROM
    sales
GROUP BY
    category
HAVING
    AVG(price) > 200;

SELECT
    category,
    product_name,
    SUM(quantity_sold) AS total_quantity_sold
FROM
    sales
GROUP BY
    category,
    product_name;

-- Question over
-- Q9
SELECT
    SUM(price * quantity_sold) AS total_revenue
FROM
    sales;

SELECT
    AVG(price) AS average_price
FROM
    sales;

SELECT
    MAX(price) AS highest_price,
    MIN(price) AS lowest_price
FROM
    sales;

SELECT
    product_name,
    MAX(quantity_sold) AS max_quantity_sold
FROM
    sales
GROUP BY
    product_name
ORDER BY
    max_quantity_sold DESC
LIMIT
    1;

SELECT
    COUNT(*) AS total_sales
FROM
    sales;

SELECT
    COUNT(DISTINCT category) AS distinct_categories
FROM
    sales;

-- Question over
-- Q10
SELECT
    category,
    SUM(price * quantity_sold) AS total_revenue
FROM
    sales
GROUP BY
    category
ORDER BY
    total_revenue DESC
LIMIT
    3;

SELECT
    category,
    SUM(price * quantity_sold) AS total_revenue
FROM
    sales
GROUP BY
    category
ORDER BY
    total_revenue DESC
LIMIT
    3;

-- Question over
-- Q11
SELECT
    *
FROM
    sales
WHERE
    (
        category = 'Electronics'
        OR category = 'Furniture'
    )
    AND price > 200;

-- Question over
-- Q12
SELECT
    sale_date,
    SUM(price * quantity_sold) AS total_revenue
FROM
    sales
GROUP BY
    sale_date;

SELECT
    sale_date,
    SUM(price * quantity_sold) AS total_revenue
FROM
    sales
GROUP BY
    sale_date
ORDER BY
    total_revenue DESC
LIMIT
    3;