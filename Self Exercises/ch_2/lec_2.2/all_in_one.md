# Database Normalization and MySQL Guide

## Q1: What is database normalization, and why is it important in MySQL?

Database normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. In MySQL, it’s important because it helps avoid anomalies during data insertion, updates, or deletions, ensuring efficient storage and query performance.

## Q2: Explain the concept of the First Normal Form (1NF) and provide an example.

First Normal Form (1NF) requires that a table has no repeating groups or arrays, and each column must contain atomic (indivisible) values with a unique primary key.  
**Example:**  
Unnormalized: A table with a column `Orders` containing multiple values like "Book, Pen".  
Normalized (1NF):  
| OrderID | Item |  
|---------|---------|  
| 1 | Book |  
| 1 | Pen |

## Q3: What are the rules for achieving Second Normal Form (2NF)? Provide an example.

Second Normal Form (2NF) builds on 1NF and requires that all non-key attributes be fully functionally dependent on the primary key. It eliminates partial dependencies.  
**Rules:**

- Table must be in 1NF.
- No non-key attribute depends on part of a composite primary key.  
  **Example:**  
  Unnormalized (1NF with partial dependency):  
  | OrderID | ProductID | ProductName | OrderDate |  
  |---------|-----------|-------------|-----------|  
  | 1 | 101 | Laptop | 2023-01-01|  
  Normalized (2NF):  
  | OrderID | ProductID | OrderDate |  
  |---------|-----------|-----------|  
  | 1 | 101 | 2023-01-01|  
  Separate table:  
  | ProductID | ProductName |  
  |-----------|-------------|  
  | 101 | Laptop |

## Q4: What is Third Normal Form (3NF), and how does it differ from 2NF?

Third Normal Form (3NF) builds on 2NF by ensuring that all non-key attributes are independent of each other and fully dependent only on the primary key, removing transitive dependencies.  
**Difference from 2NF:** 2NF removes partial dependencies, while 3NF removes transitive dependencies.  
**Example (3NF):**  
From 2NF table, if `OrderDate` depended on `CustomerID` (transitive), it would be moved to a `Customers` table.

## Q5: What are the potential drawbacks of over-normalizing a database?

Over-normalizing can lead to excessive table splits, increasing the number of JOIN operations, which may slow down queries. It can also complicate data retrieval and increase storage overhead due to additional tables.

## Q6: What is a primary key in MySQL, and why is it used?

A primary key in MySQL is a unique identifier for each row in a table, ensuring no duplicate or NULL values. It’s used to enforce entity integrity and establish relationships with other tables.

## Q7: Can a table have multiple primary keys? Explain your answer.

No, a table cannot have multiple primary keys. However, it can have a composite primary key (made up of multiple columns) to uniquely identify rows.

## Q8: How do you define a primary key when creating a table in MySQL? Provide a query example.

You define a primary key using the `PRIMARY KEY` constraint in the `CREATE TABLE` statement.  
**Example:**

```sql
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);
```

## Q9: What is a foreign key, and how does it establish relationships between tables in MySQL?

A foreign key is a column (or set of columns) in one table that links to the primary key of another table, establishing a relationship (e.g., one-to-many). It ensures referential integrity.

## Q10: Explain the concept of referential integrity enforced by foreign keys.

Referential integrity ensures that a foreign key value in one table must match an existing primary key value in the referenced table or be NULL, maintaining consistent relationships.

## Q11: Write a query to create a foreign key constraint between two tables in MySQL and explain its components.

**Query:**

```sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);
```

**Components:**

- `FOREIGN KEY (CustomerID)`: Defines the foreign key column in `Orders`.
- `REFERENCES Customers(CustomerID)`: Links to the primary key in the `Customers` table.
- Ensures `CustomerID` in `Orders` matches a valid `CustomerID` in `Customers`.
