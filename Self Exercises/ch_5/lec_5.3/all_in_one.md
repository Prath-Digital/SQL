# SQL CASE Expression Questions and Answers

## Q1: What is the CASE expression in SQL, and how does it differ from IF-ELSE statements in procedural languages?

The CASE expression in SQL is a conditional expression that allows you to perform if-then-else logic within a query. It evaluates a list of conditions and returns a value based on the first true condition. There are two forms: Simple CASE and Searched CASE.

Unlike IF-ELSE statements in procedural languages (e.g., C, Java), which are control flow statements executed sequentially, the CASE expression is an expression that returns a value and is evaluated within the context of a SQL query. IF-ELSE alters program flow, while CASE is used to compute values for columns or conditions in a result set.

## Q2: How can you use CASE to create conditional column values? Provide a practical example.

You can use CASE to dynamically assign values to a column based on conditions. Here's a practical example:

Suppose you have an "employees" table with a "salary" column, and you want to categorize salaries into "Low," "Medium," or "High."

```sql
SELECT 
    employee_id,
    salary,
    CASE 
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM employees;
```

This query adds a new column `salary_category` based on the salary range.

## Q3: What is the difference between SIMPLE CASE and SEARCHED CASE in SQL?

- **Simple CASE**: Compares an expression to a set of discrete values. It uses the syntax `CASE expression WHEN value1 THEN result1 WHEN value2 THEN result2 ELSE result3 END`. It's simpler but limited to equality checks.

  Example: `CASE job_title WHEN 'Manager' THEN 'Senior' ELSE 'Junior' END`

- **Searched CASE**: Evaluates a series of Boolean conditions using `WHEN condition THEN result`. It's more flexible, allowing complex conditions (e.g., ranges, multiple criteria).

  Example: `CASE WHEN salary > 100000 THEN 'High' ELSE 'Low' END`

The key difference is that Simple CASE checks for equality, while Searched CASE evaluates arbitrary conditions.

## Q4: Write an SQL query using CASE to categorize employees based on their salary range.

Here's a query to categorize employees into salary ranges:

```sql
SELECT 
    employee_id,
    first_name,
    salary,
    CASE 
        WHEN salary < 40000 THEN 'Low Range'
        WHEN salary BETWEEN 40000 AND 80000 THEN 'Mid Range'
        ELSE 'High Range'
    END AS salary_range
FROM employees;
```

This query creates a `salary_range` column categorizing employees based on their salary.