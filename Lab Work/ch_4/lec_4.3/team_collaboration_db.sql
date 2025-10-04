-- ==========================================================
-- Database: team_collaboration_db
-- Purpose : Manage employees, departments, projects, tasks
-- Author  : Prath Digital (Prath Udhnawala)
-- ==========================================================
-- Drop and recreate database
DROP DATABASE IF EXISTS team_collaboration_db;

CREATE DATABASE team_collaboration_db;

USE team_collaboration_db;

-- ==========================================================
-- Table: departments
-- ==========================================================
CREATE TABLE
    departments (
        dept_id INT AUTO_INCREMENT PRIMARY KEY,
        dept_name VARCHAR(100) NOT NULL UNIQUE
    );

-- ==========================================================
-- Table: employees
-- ==========================================================
CREATE TABLE
    employees (
        emp_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_name VARCHAR(100) NOT NULL,
        job_title VARCHAR(100),
        salary DECIMAL(10, 2),
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
    );

-- ==========================================================
-- Table: projects
-- ==========================================================
CREATE TABLE
    projects (
        project_id INT AUTO_INCREMENT PRIMARY KEY,
        project_name VARCHAR(100) NOT NULL UNIQUE,
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
    );

-- ==========================================================
-- Table: tasks
-- ==========================================================
CREATE TABLE
    tasks (
        task_id INT AUTO_INCREMENT PRIMARY KEY,
        task_name VARCHAR(100) NOT NULL,
        project_id INT,
        FOREIGN KEY (project_id) REFERENCES projects (project_id)
    );

-- ==========================================================
-- Table: project_assignments
-- ==========================================================
CREATE TABLE
    project_assignments (
        assignment_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_id INT,
        project_id INT,
        assigned_date DATE,
        FOREIGN KEY (emp_id) REFERENCES employees (emp_id),
        FOREIGN KEY (project_id) REFERENCES projects (project_id)
    );

-- ==========================================================
-- Sample Data Inserts
-- ==========================================================
INSERT INTO
    departments (dept_name)
VALUES
    ('IT'),
    ('Finance'),
    ('HR');

INSERT INTO
    employees (emp_name, job_title, salary, dept_id)
VALUES
    ('Alice', 'Manager', 75000.00, 1),
    ('Bob', 'Developer', 55000.00, 1),
    ('Charlie', 'Tester', 45000.00, 2),
    ('David', 'HR Specialist', 40000.00, 3),
    ('Eve', 'Accountant', 50000.00, 2);

INSERT INTO
    projects (project_name, dept_id)
VALUES
    ('ERP Upgrade', 1),
    ('Payroll System', 2),
    ('Recruitment Drive', 3);

INSERT INTO
    tasks (task_name, project_id)
VALUES
    ('Design DB Schema', 1),
    ('Develop APIs', 1),
    ('Testing Module', 2),
    ('Prepare Job Ads', 3),
    ('Conduct Interviews', 3);

INSERT INTO
    project_assignments (emp_id, project_id, assigned_date)
VALUES
    (1, 1, '2025-01-01'),
    (2, 1, '2025-01-05'),
    (3, 2, '2025-01-10'),
    (4, 3, '2025-01-15'),
    (5, 2, '2025-01-20');

-- ==========================================================
-- QUESTIONS & ANSWERS (Q1 - Q15)
-- ==========================================================
-- Q1: Retrieve a list of employees who earn more than the average salary of all employees
SELECT
    "Q1: Retrieve a list of employees who earn more than the average salary of all employees";

SELECT
    emp_name,
    job_title,
    salary
FROM
    employees
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            employees
    );

-- Q2: Find customers who have placed at least one order in the orders table
SELECT
    "Q2: Find customers who have placed at least one order in the orders table";

-- Note: Assuming a customers table and orders table for this example
CREATE TABLE
    customers (
        customer_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_name VARCHAR(100) NOT NULL
    );

CREATE TABLE
    orders (
        order_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
    );

INSERT INTO
    customers (customer_name)
VALUES
    ('John'),
    ('Jane'),
    ('Mike');

INSERT INTO
    orders (customer_id, order_date)
VALUES
    (1, '2025-01-01'),
    (1, '2025-01-02'),
    (2, '2025-01-03');

SELECT
    c.customer_name
FROM
    customers c
WHERE
    EXISTS (
        SELECT
            1
        FROM
            orders o
        WHERE
            o.customer_id = c.customer_id
    );

-- Q3: Identify products that are priced higher than the average product price in the products table
SELECT
    "Q3: Identify products that are priced higher than the average product price in the products table";

-- Note: Assuming a products table for this example
CREATE TABLE
    products (
        product_id INT AUTO_INCREMENT PRIMARY KEY,
        product_name VARCHAR(100) NOT NULL,
        price DECIMAL(10, 2)
    );

INSERT INTO
    products (product_name, price)
VALUES
    ('Laptop', 1000.00),
    ('Mouse', 20.00),
    ('Keyboard', 50.00);

SELECT
    product_name,
    price
FROM
    products
WHERE
    price > (
        SELECT
            AVG(price)
        FROM
            products
    );

-- Q4: Retrieve students who scored above the class average in an exam results table
SELECT
    "Q4: Retrieve students who scored above the class average in an exam results table";

-- Note: Assuming an exam_results table for this example
CREATE TABLE
    exam_results (
        student_id INT AUTO_INCREMENT PRIMARY KEY,
        student_name VARCHAR(100) NOT NULL,
        score INT
    );

INSERT INTO
    exam_results (student_name, score)
VALUES
    ('Tom', 85),
    ('Jerry', 90),
    ('Spike', 70);

SELECT
    student_name,
    score
FROM
    exam_results
WHERE
    score > (
        SELECT
            AVG(score)
        FROM
            exam_results
    );

-- Q5: Find departments that have more than five employees using a subquery
SELECT
    "Q5: Find departments that have more than five employees using a subquery";

SELECT
    dept_name
FROM
    departments d
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            employees e
        WHERE
            e.dept_id = d.dept_id
    ) > 5;

-- Q6: Retrieve the names of customers who have purchased the most expensive product from the orders table
SELECT
    "Q6: Retrieve the names of customers who have purchased the most expensive product from the orders table";

-- Note: Assuming an orders and order_details table for this example
CREATE TABLE
    order_details (
        order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
        order_id INT,
        product_id INT,
        price DECIMAL(10, 2),
        FOREIGN KEY (order_id) REFERENCES orders (order_id)
    );

INSERT INTO
    order_details (order_id, product_id, price)
VALUES
    (1, 1, 1000.00),
    (2, 2, 20.00),
    (3, 3, 50.00);

SELECT
    c.customer_name
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
WHERE
    od.price = (
        SELECT
            MAX(price)
        FROM
            order_details
    );

-- Q7: Find employees who work in the same department as a specific employee using a nested query
SELECT
    "Q7: Find employees who work in the same department as a specific employee using a nested query";

SELECT
    emp_name
FROM
    employees
WHERE
    dept_id = (
        SELECT
            dept_id
        FROM
            employees
        WHERE
            emp_name = 'Alice'
    )
    AND emp_name != 'Alice';

-- Q8: Identify suppliers who supply at least one product that has been ordered more than 100 times
SELECT
    "Q8: Identify suppliers who supply at least one product that has been ordered more than 100 times";

-- Note: Assuming a suppliers and order_details table with order count
CREATE TABLE
    suppliers (
        supplier_id INT AUTO_INCREMENT PRIMARY KEY,
        supplier_name VARCHAR(100) NOT NULL
    );

CREATE TABLE
    product_suppliers (
        product_id INT,
        supplier_id INT,
        FOREIGN KEY (product_id) REFERENCES products (product_id),
        FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id)
    );

INSERT INTO
    suppliers (supplier_name)
VALUES
    ('SupplierA'),
    ('SupplierB');

INSERT INTO
    product_suppliers (product_id, supplier_id)
VALUES
    (1, 1),
    (2, 2);

SELECT
    s.supplier_name
FROM
    suppliers s
    JOIN product_suppliers ps ON s.supplier_id = ps.supplier_id
    JOIN products p ON ps.product_id = p.product_id
WHERE
    p.product_id IN (
        SELECT
            product_id
        FROM
            order_details
        GROUP BY
            product_id
        HAVING
            COUNT(*) > 100
    );

-- Q9: Retrieve the top 5 most expensive orders placed by customers
SELECT
    "Q9: Retrieve the top 5 most expensive orders placed by customers";

SELECT
    c.customer_name,
    od.price
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
ORDER BY
    od.price DESC
LIMIT
    5;

-- Q10: Find movies that have higher ratings than the average rating of a specific genre
SELECT
    "Q10: Find movies that have higher ratings than the average rating of a specific genre";

-- Note: Assuming a movies and movie_ratings table for this example
CREATE TABLE
    movies (
        movie_id INT AUTO_INCREMENT PRIMARY KEY,
        movie_name VARCHAR(100) NOT NULL,
        genre VARCHAR(50)
    );

CREATE TABLE
    movie_ratings (
        rating_id INT AUTO_INCREMENT PRIMARY KEY,
        movie_id INT,
        rating DECIMAL(3, 1),
        FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
    );

INSERT INTO
    movies (movie_name, genre)
VALUES
    ('MovieA', 'Action'),
    ('MovieB', 'Action'),
    ('MovieC', 'Drama');

INSERT INTO
    movie_ratings (movie_id, rating)
VALUES
    (1, 8.5),
    (2, 7.0),
    (3, 6.5);

SELECT
    m.movie_name,
    mr.rating
FROM
    movies m
    JOIN movie_ratings mr ON m.movie_id = mr.movie_id
WHERE
    m.genre = 'Action'
    AND mr.rating > (
        SELECT
            AVG(rating)
        FROM
            movie_ratings mr2
            JOIN movies m2 ON mr2.movie_id = m2.movie_id
        WHERE
            m2.genre = 'Action'
    );

-- Q11: Identify the second highest salary in an employees table without using LIMIT
SELECT
    "Q11: Identify the second highest salary in an employees table without using LIMIT";

SELECT
    MAX(salary) AS second_highest_salary
FROM
    employees
WHERE
    salary < (
        SELECT
            MAX(salary)
        FROM
            employees
    );

-- Q12: Retrieve the names of students who have scored higher than any student in another specific section
SELECT
    "Q12: Retrieve the names of students who have scored higher than any student in another specific section";

-- Note: Assuming a students table with section for this example
CREATE TABLE
    students (
        student_id INT AUTO_INCREMENT PRIMARY KEY,
        student_name VARCHAR(100) NOT NULL,
        score INT,
        section VARCHAR(10)
    );

INSERT INTO
    students (student_name, score, section)
VALUES
    ('Tom', 85, 'A'),
    ('Jerry', 70, 'B'),
    ('Spike', 60, 'B');

SELECT
    student_name,
    score
FROM
    students
WHERE
    section = 'A'
    AND score > ALL (
        SELECT
            score
        FROM
            students
        WHERE
            section = 'B'
    );

-- Q13: Find customers who have not placed any orders using a subquery inside a NOT IN condition
SELECT
    "Q13: Find customers who have not placed any orders using a subquery inside a NOT IN condition";

SELECT
    customer_name
FROM
    customers
WHERE
    customer_id NOT IN (
        SELECT
            customer_id
        FROM
            orders
    );

-- Q14: Retrieve the list of employees whose salaries are greater than the average salary in their department
SELECT
    "Q14: Retrieve the list of employees whose salaries are greater than the average salary in their department";

SELECT
    e.emp_name,
    e.salary,
    d.dept_name
FROM
    employees e
    JOIN departments d ON e.dept_id = d.dept_id
WHERE
    e.salary > (
        SELECT
            AVG(salary)
        FROM
            employees e2
        WHERE
            e2.dept_id = e.dept_id
    );

-- Q15: Identify the best-selling product by finding the product with the highest total sales
SELECT
    "Q15: Identify the best-selling product by finding the product with the highest total sales";

SELECT
    p.product_name,
    SUM(od.price) AS total_sales
FROM
    products p
    JOIN order_details od ON p.product_id = od.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_sales DESC
LIMIT
    1;