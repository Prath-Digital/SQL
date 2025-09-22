# SQL Questions and Answers

## Q1: What is the purpose of the WHERE clause in SQL, and how is it used to filter records?
The WHERE clause is used to filter records based on a specified condition. It retrieves only the rows that meet the condition.

Example:
```sql
SELECT * FROM employees WHERE department = 'Sales';
```

## Q2: How does the HAVING clause differ from the WHERE clause? Provide examples.
The WHERE clause filters rows before aggregation, while the HAVING clause filters groups after aggregation. WHERE cannot be used with aggregate functions, but HAVING can.

Examples:
- WHERE:
```sql
SELECT * FROM employees WHERE salary > 50000;
```
- HAVING:
```sql
SELECT department, COUNT(*) FROM employees GROUP BY department HAVING COUNT(*) > 5;
```

## Q3: Explain the use of the LIMIT clause in SQL and provide a query to retrieve the top 5 rows from a table.
The LIMIT clause restricts the number of rows returned by a query. It’s useful for pagination or retrieving a specific number of records.

Example:
```sql
SELECT * FROM employees LIMIT 5;
```

## Q4: What is the purpose of logical operators (AND, OR, NOT) in SQL, and how are they used in queries?
Logical operators (AND, OR, NOT) combine or negate conditions to filter records. AND requires all conditions to be true, OR requires at least one, and NOT negates a condition.

## Q5: Write a query using the AND operator to filter records based on two conditions.
```sql
SELECT * FROM employees WHERE department = 'Sales' AND salary > 50000;
```

## Q6: Provide an example of using the OR operator to retrieve records that satisfy at least one condition.
```sql
SELECT * FROM employees WHERE department = 'Sales' OR department = 'Marketing';
```

## Q7: How does the NOT operator work in SQL? Provide a query example to exclude specific rows.
The NOT operator negates a condition, excluding rows that match it.

Example:
```sql
SELECT * FROM employees WHERE NOT department = 'Sales';
```

## Q8: What is the ORDER BY keyword in SQL, and how is it used to sort query results?
The ORDER BY keyword sorts the result set based on one or more columns, either in ascending (default) or descending order.

## Q9: How can you sort query results in ascending and descending order using ORDER BY? Provide examples.
- Ascending:
```sql
SELECT * FROM employees ORDER BY salary ASC;
```
- Descending:
```sql
SELECT * FROM employees ORDER BY salary DESC;
```

## Q10: Write a query to sort a table by multiple columns using the ORDER BY clause.
```sql
SELECT * FROM employees ORDER BY department ASC, salary DESC;
```

## Q11: What is the purpose of the GROUP BY statement in SQL? How does it help organize data?
The GROUP BY statement groups rows that have the same values in specified columns into summary rows, often used with aggregate functions to organize and summarize data.

## Q12: Write an SQL query to group data by a specific column and apply an aggregate function like SUM.
```sql
SELECT department, SUM(salary) FROM employees GROUP BY department;
```

## Q13: What are aggregate functions in SQL, and how are they used for summarizing data?
Aggregate functions (SUM, AVG, MAX, MIN, COUNT) perform calculations on a set of values and return a single value, summarizing data like total, average, maximum, minimum, or count.

## Q14: Write queries to demonstrate the use of SUM, AVG, MAX, MIN, and COUNT functions.
- SUM:
```sql
SELECT SUM(salary) FROM employees;
```
- AVG:
```sql
SELECT AVG(salary) FROM employees;
```
- MAX:
```sql
SELECT MAX(salary) FROM employees;
```
- MIN:
```sql
SELECT MIN(salary) FROM employees;
```
- COUNT:
```sql
SELECT COUNT(*) FROM employees;
```

## Q15: How can aggregate functions be used in conjunction with the GROUP BY clause? Provide an example query.
Aggregate functions can summarize data within each group created by GROUP BY.

Example:
```sql
SELECT department, COUNT(*), AVG(salary) FROM employees GROUP BY department;
```