-- Task 1
SELECT
    c.country,
    SUM(p.amount) AS total_payment
FROM
    customers c
    JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY
    c.country;

-- Task 2
SELECT
    o.country,
    SUM(p.amount) as TotalAmount
FROM
    payments as p
    JOIN customers as c ON c.customerNumber = p.customerNumber
    JOIN employees as e ON e.employeeNumber = c.salesRepEmployeeNumber
    JOIN offices as o ON e.officeCode = o.officeCode
GROUP BY
    o.country
ORDER BY
    TotalAmount DESC;