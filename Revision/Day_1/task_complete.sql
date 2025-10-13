SELECT
    *
FROM
    (
        SELECT
            1 AS EnsureID,
            'Ensure Table Exists' AS EnsureName
    ) AS Ensure;

-- 1️⃣ Ensure the database exists
CREATE DATABASE IF NOT EXISTS classicModels_db;

-- 2️⃣ Use the database
USE classicModels_db;   

-- Task 1
SELECT
    country,
    COUNT(customerNumber) AS totalNumberOfCustomers
FROM
    customers
GROUP BY
    country;

-- Task 2
SELECT
    customerNumber,
    customerName,
    creditLimit
FROM
    customers
ORDER BY
    creditLimit DESC
LIMIT
    5;

-- Task 3
SELECT
    customerNumber,
    customerName,
    credit_limit
FROM
    customers
ORDER BY
    creditLimit ASC
LIMIT
    5;

-- Task 4
SELECT
    customerNumber,
    customerName,
    creditLimit,
    COUNT(customerNumber) OVER () AS numberOfCustomersWithZeroCreditLimit
FROM
    customers
WHERE
    creditLimit = 0;

-- Task 5
SELECT
    e.employeeNumber,
    e.firstName,
    e.lastName,
    e.extension,
    e.email,
    e.officeCode,
    e.reportsTo,
    e.jobTitle,
    o.city,
    o.country
FROM
    employees e
    JOIN offices o ON e.officeCode = o.officeCode
WHERE
    o.city = 'Tokyo'
    AND o.country = 'Japan';

-- Task 6
SELECT
    *
FROM
    employees e
WHERE
    e.officeCode = 5;

-- Task 7
SELECT
    e.employeeNumber,
    e.firstName,
    e.lastName,
    e.extension,
    e.email,
    e.officeCode,
    e.reportsTo,
    e.jobTitle,
    o.city,
    o.country
FROM
    employees e
    JOIN offices o ON e.officeCode = o.officeCode
WHERE
    e.officeCode = 5;

-- Task 8
SELECT
    e.employeeNumber,
    CONCAT (e.firstName, ' ', e.lastName) AS fullName,
    o.city,
    o.country
FROM
    employees e
    LEFT JOIN offices o ON e.officeCode = o.officeCode;

-- Task 9
SELECT
    c.customerName,
    SUM(p.amount) AS totalPaymentAmount
FROM
    customers c
    JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY
    c.customerNumber;

-- Task 10
SELECT
    c.customerName,
    SUM(od.quantityOrdered) AS totalQuantityOrdered
FROM
    customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    c.customerName;

-- Task 11
SELECT
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS totalOrderValue
FROM
    customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    c.customerName;