# SQL Questions and Answers

## Q1: What are CRUD operations, and why are they essential in database management?
CRUD stands for Create, Read, Update, and Delete. These operations are the foundation of database management as they allow users to create new records, read existing data, update information, and delete unnecessary data, ensuring the database remains functional and up-to-date.

## Q2: Explain the role of SQL in performing Create, Read, Update, and Delete operations on a database.
SQL (Structured Query Language) is the standard language for managing and manipulating relational databases. It provides commands like INSERT (Create), SELECT (Read), UPDATE (Update), and DELETE (Delete) to perform these operations efficiently and consistently.

## Q3: How do you use the INSERT statement to add a single record to a table? Provide an example query.
The INSERT statement adds a new record to a table. Example:
```sql
INSERT INTO employees (first_name, last_name, hire_date) VALUES ('John', 'Doe', '2023-01-15');
```

## Q4: How can you insert multiple rows into a table using a single INSERT statement? Provide an example.
You can insert multiple rows using a single INSERT statement with multiple VALUES clauses. Example:
```sql
INSERT INTO employees (first_name, last_name, hire_date) VALUES 
('John', 'Doe', '2023-01-15'), 
('Jane', 'Smith', '2023-02-01');
```

## Q5: What is the purpose of the SELECT statement in SQL?
The SELECT statement is used to retrieve data from a database table, allowing you to query specific columns or all columns based on conditions.

## Q6: Write an SQL query to retrieve specific columns from a table instead of all columns.
Example:
```sql
SELECT first_name, last_name FROM employees;
```

## Q7: How can you filter records in a table using the WHERE clause? Provide an example query.
The WHERE clause filters records based on a condition. Example:
```sql
SELECT * FROM employees WHERE hire_date > '2023-01-01';
```

## Q8: How do you use the UPDATE statement to modify records in a table? Provide an example query.
The UPDATE statement modifies existing records. Example:
```sql
UPDATE employees SET hire_date = '2023-01-16' WHERE first_name = 'John';
```

## Q9: Write an SQL query to update multiple rows in a table based on a specific condition.
Example:
```sql
UPDATE employees SET department = 'HR' WHERE hire_date < '2023-02-01';
```

## Q10: What is the difference between the DELETE statement and the TRUNCATE command?
The DELETE statement removes specific rows based on a condition and can be rolled back, while TRUNCATE removes all rows from a table quickly and cannot be rolled back.

## Q11: Write an SQL query to delete specific records from a table using the WHERE clause.
Example:
```sql
DELETE FROM employees WHERE last_name = 'Doe';
```

## Q12: How do you delete all rows from a table without deleting the table itself? Provide an example.
You can use TRUNCATE to remove all rows while keeping the table structure. Example:
```sql
TRUNCATE TABLE employees;
```