# SQL Questions and Answers

## Q1. What is SQL, and why is it widely used for managing databases?
SQL (Structured Query Language) is a standard language for managing and manipulating relational databases. It is widely used because it allows users to create, read, update, and delete data efficiently, and it is supported by most relational database management systems (RDBMS) like MySQL, PostgreSQL, and SQL Server.

## Q2. Explain the difference between SQL and NoSQL databases.
SQL databases are relational, using structured query language and tables with fixed schemas to store data. NoSQL databases are non-relational, offering flexible schemas and are designed for unstructured or semi-structured data, such as document-based, key-value, column-family, or graph formats.

## Q3. What are some common features of SQL that make it essential for database management?
- Data query and retrieval
- Data insertion, update, and deletion
- Data definition and structure management
- Transaction control for data integrity
- Support for joins and complex queries

## Q4. What are the four main types of SQL commands, and what is the purpose of each?
- **DDL (Data Definition Language):** Defines and modifies database structures (e.g., CREATE, ALTER, DROP).
- **DML (Data Manipulation Language):** Manages data within tables (e.g., INSERT, UPDATE, DELETE).
- **DCL (Data Control Language):** Controls access and permissions (e.g., GRANT, REVOKE).
- **DQL (Data Query Language):** Retrieves data from databases (e.g., SELECT).

## Q5. Explain the difference between DDL (Data Definition Language) and DML (Data Manipulation Language) commands.
DDL commands are used to define or modify the structure of database objects (e.g., tables, schemas), while DML commands are used to manipulate the data within those structures (e.g., inserting or updating records).

## Q6. What is the purpose of DCL (Data Control Language) commands? Provide examples.
DCL commands manage access and permissions in a database. They ensure data security by granting or revoking privileges. Examples include:
- `GRANT SELECT ON employees TO user1;`
- `REVOKE DELETE ON employees FROM user1;`

## Q7. What are DQL (Data Query Language) commands, and how are