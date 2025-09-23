# MySQL Primary and Foreign Keys Questions and Answers

## Q1: What is a primary key in MySQL, and why is it important for database tables?

A primary key is a unique identifier for each record in a table. It ensures no duplicate or NULL values exist, making data retrieval and relationships efficient. It’s crucial for maintaining data integrity and serving as a reference point in joins.

## Q2: Can a primary key contain NULL values? Explain your answer.

No, a primary key cannot contain NULL values. MySQL enforces that a primary key must be unique and not null to ensure each row is distinctly identifiable.

## Q3: How do you define a primary key when creating a table in MySQL? Provide an example query.

You define a primary key using the `PRIMARY KEY` constraint in the `CREATE TABLE` statement.  
Example:

```sql
CREATE TABLE students (
    id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (id)
);
```

## Q4: What is the difference between a single-column primary key and a composite primary key? Provide examples of both.

A single-column primary key uses one column to uniquely identify a row, while a composite primary key uses multiple columns.

- Single-column example:
  ```sql
  CREATE TABLE users (
      user_id INT PRIMARY KEY,
      username VARCHAR(50)
  );
  ```
- Composite example:
  ```sql
  CREATE TABLE order_details (
      order_id INT,
      product_id INT,
      PRIMARY KEY (order_id, product_id)
  );
  ```

## Q5: How can you modify an existing table to add a primary key constraint? Write a query example.

You can add a primary key using `ALTER TABLE` with `ADD PRIMARY KEY`.  
Example:

```sql
ALTER TABLE employees
ADD PRIMARY KEY (emp_id);
```

## Q6: What is a foreign key in MySQL, and how does it help establish relationships between tables?

A foreign key is a column (or set of columns) in one table that links to the primary key of another table. It helps enforce referential integrity and establishes relationships, like one-to-many or many-to-many, between tables.

## Q7: Can a foreign key reference a column that is not a primary key? Explain with reasons.

Yes, a foreign key can reference a column that is a UNIQUE key (not necessarily a primary key), as long as it ensures uniqueness. This is allowed because a UNIQUE constraint also guarantees no duplicates, maintaining referential integrity.

## Q8: How do you create a foreign key constraint while creating a table in MySQL? Provide a query example.

You define a foreign key using the `FOREIGN KEY` constraint in the `CREATE TABLE` statement.  
Example:

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

## Q9: What is the difference between ON DELETE CASCADE and ON DELETE SET NULL when defining a foreign key?

- `ON DELETE CASCADE`: Deletes rows in the child table when the referenced row in the parent table is deleted.
- `ON DELETE SET NULL`: Sets the foreign key column in the child table to NULL when the referenced row is deleted, provided the column allows NULL values.

## Q10: Explain the role of foreign keys in enforcing referential integrity in a database.

Foreign keys ensure that relationships between tables remain consistent by preventing actions that would leave orphaned records (e.g., deleting a parent row with dependent child rows). They maintain valid references between tables.

## Q11: Write a query to create two tables with a one-to-many relationship using primary and foreign keys.

Example:

```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

## Q12: How do primary keys and foreign keys help in normalizing a database? Provide an example scenario.

Primary and foreign keys help by reducing redundancy and ensuring data integrity during normalization. They link related data across tables.  
Example scenario: In a library system, a `Books` table (with `book_id` as primary key) and a `Borrowers` table (with `borrower_id` and `book_id` as foreign key) avoid duplicating book details, storing only the relationship.
