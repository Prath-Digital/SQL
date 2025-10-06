# MySQL Window Functions Guide

## Q1: What are Window Functions in MySQL, and how do they differ from aggregate functions?

Window functions in MySQL perform calculations across a set of rows related to the current row, without collapsing the result set into a single output like aggregate functions (e.g., SUM, AVG). They allow detailed analysis while retaining individual row details. Aggregate functions, on the other hand, group data and return a single value per group, reducing the row count.

## Q2: Explain the OVER() clause in MySQL. How does it work with window functions?

The `OVER()` clause defines the window (set of rows) for a window function to operate over. It can include `PARTITION BY` to divide data into partitions and `ORDER BY` to specify the order of rows within the window. It works with window functions by specifying the scope and order of the calculation, enabling flexible data analysis.

## Q3: What is the purpose of the RANK() and DENSE_RANK() functions? How are they different?

Both `RANK()` and `DENSE_RANK()` assign ranks to rows within a partition. `RANK()` leaves gaps in ranking after ties (e.g., 1, 1, 3), while `DENSE_RANK()` assigns consecutive ranks (e.g., 1, 1, 2). They help order data, with `RANK()` useful for distinct rankings and `DENSE_RANK()` for continuous sequences.

## Q4: How does the ROW_NUMBER() function work in MySQL? Provide an example.

The `ROW_NUMBER()` function assigns a unique sequential number to each row within a partition, based on the `ORDER BY` clause.  

**Example:**
```sql
SELECT 
    employee_id,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_num
FROM employees;
```
This assigns a unique number to each employee based on their salary in descending order.

## Q5: What is the NTILE() function, and how can it be used in ranking data?

The `NTILE(n)` function divides rows in a partition into `n` buckets and assigns each row a bucket number (1 to n). It’s useful for ranking data into quantiles, like quartiles or deciles, to analyze distribution.

**Example:**
```sql
SELECT 
    employee_id,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) as quartile
FROM employees;
```
This splits employees into 4 quartiles based on salary.

## Q6: Explain the difference between LEAD() and LAG() functions in MySQL. When would you use them?

`LEAD()` accesses data from the next row, while `LAG()` accesses data from the previous row within a partition. Both use an offset and default value. Use `LEAD()` to peek ahead (e.g., next sale) and `LAG()` to look back (e.g., previous status) in time-series or sequential data analysis.

**Example:**
```sql
SELECT 
    order_date,
    amount,
    LAG(amount) OVER (ORDER BY order_date) as prev_amount
FROM orders;
```
This shows the previous order amount for comparison.

## Q7: What are FIRST_VALUE() and LAST_VALUE() functions? How do they help in data analysis?

`FIRST_VALUE()` returns the first value in the window, and `LAST_VALUE()` returns the last value, based on the `ORDER BY` clause. They help identify trends or boundaries, like the first sale or last price in a period, aiding in time-series or range analysis.

**Example:**
```sql
SELECT 
    order_date,
    amount,
    FIRST_VALUE(amount) OVER (ORDER BY order_date) as first_sale
FROM orders;
```
This shows the first sale amount for each row.

## Q8: How can you use the PARTITION BY clause with window functions? Provide an example.

The `PARTITION BY` clause divides the data into partitions to which the window function is applied separately. It’s great for group-wise calculations.

**Example:**
```sql
SELECT 
    department_id,
    employee_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as dept_rank
FROM employees;
```
This ranks employees within each department based on salary.