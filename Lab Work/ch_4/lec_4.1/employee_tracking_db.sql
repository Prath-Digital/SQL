-- ==========================================================
-- Database: employee_tracking_db
-- Purpose: Manage employees, departments, projects, tasks, customers, orders, and sales
-- Author: Prath Digital (Prath Udhnawala)
-- ==========================================================
-- Drop and recreate database
DROP DATABASE IF EXISTS employee_tracking_db;

CREATE DATABASE employee_tracking_db;

USE employee_tracking_db;

-- ==========================================================
-- Table: departments
-- ==========================================================
CREATE TABLE
    departments (
        dept_id INT AUTO_INCREMENT PRIMARY KEY,
        dept_name VARCHAR(100) NOT NULL UNIQUE,
        dept_location VARCHAR(100) -- Adding location for better context
    );

-- ==========================================================
-- Table: employees
-- ==========================================================
CREATE TABLE
    employees (
        emp_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_name VARCHAR(100) NOT NULL,
        job_title VARCHAR(100) NOT NULL,
        salary DECIMAL(10, 2) CHECK (salary >= 0),
        dept_id INT,
        hire_date DATE,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id) ON DELETE SET NULL
    );

-- ==========================================================
-- Table: projects
-- ==========================================================
CREATE TABLE
    projects (
        project_id INT AUTO_INCREMENT PRIMARY KEY,
        project_name VARCHAR(100) NOT NULL UNIQUE,
        dept_id INT,
        start_date DATE,
        end_date DATE,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id) ON DELETE SET NULL
    );

-- ==========================================================
-- Table: tasks
-- ==========================================================
CREATE TABLE
    tasks (
        task_id INT AUTO_INCREMENT PRIMARY KEY,
        task_name VARCHAR(100) NOT NULL,
        project_id INT,
        priority ENUM ('Low', 'Medium', 'High') DEFAULT 'Medium',
        FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE
    );

-- ==========================================================
-- Table: project_assignments
-- ==========================================================
CREATE TABLE
    project_assignments (
        assignment_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_id INT NOT NULL,
        project_id INT NOT NULL,
        assigned_date DATE NOT NULL,
        status ENUM ('Active', 'Completed') DEFAULT 'Active',
        FOREIGN KEY (emp_id) REFERENCES employees (emp_id) ON DELETE CASCADE,
        FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE,
        UNIQUE (emp_id, project_id) -- Prevent duplicate assignments
    );

-- ==========================================================
-- Table: customers
-- ==========================================================
CREATE TABLE
    customers (
        customer_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_name VARCHAR(100) NOT NULL,
        contact_email VARCHAR(100) UNIQUE
    );

-- ==========================================================
-- Table: suppliers
-- ==========================================================
CREATE TABLE
    suppliers (
        supplier_id INT AUTO_INCREMENT PRIMARY KEY,
        supplier_name VARCHAR(100) NOT NULL,
        contact_phone VARCHAR(20) UNIQUE
    );

-- ==========================================================
-- Table: orders
-- ==========================================================
CREATE TABLE
    orders (
        order_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_id INT,
        product_name VARCHAR(100) NOT NULL,
        order_date DATE NOT NULL,
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE SET NULL
    );

-- ==========================================================
-- Table: sales
-- ==========================================================
CREATE TABLE
    sales (
        sale_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_id INT,
        customer_id INT,
        sale_amount DECIMAL(10, 2) CHECK (sale_amount >= 0),
        sale_date DATE NOT NULL,
        FOREIGN KEY (emp_id) REFERENCES employees (emp_id) ON DELETE SET NULL,
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE SET NULL
    );

-- ==========================================================
-- Sample Data Inserts
-- ==========================================================
INSERT INTO
    departments (dept_name, dept_location)
VALUES
    ('IT', 'Building A'),
    ('Finance', 'Building B'),
    ('HR', 'Building C');

INSERT INTO
    employees (emp_name, job_title, salary, dept_id, hire_date)
VALUES
    ('Alice', 'Manager', 75000.00, 1, '2023-01-15'),
    ('Bob', 'Developer', 55000.00, 1, '2023-03-10'),
    ('Charlie', 'Tester', 45000.00, 2, '2023-06-01'),
    (
        'David',
        'HR Specialist',
        40000.00,
        3,
        '2023-09-20'
    ),
    ('Eve', 'Accountant', 50000.00, 2, '2023-11-05'),
    (
        'Frank',
        'Consultant',
        48000.00,
        NULL,
        '2024-02-01'
    );

INSERT INTO
    projects (project_name, dept_id, start_date, end_date)
VALUES
    ('ERP Upgrade', 1, '2025-01-01', '2025-12-31'),
    ('Payroll System', 2, '2025-02-01', '2025-11-30'),
    (
        'Recruitment Drive',
        3,
        '2025-03-01',
        '2025-10-15'
    );

INSERT INTO
    tasks (task_name, project_id, priority)
VALUES
    ('Design DB Schema', 1, 'High'),
    ('Develop APIs', 1, 'Medium'),
    ('Testing Module', 2, 'High'),
    ('Prepare Job Ads', 3, 'Low'),
    ('Conduct Interviews', 3, 'Medium');

INSERT INTO
    project_assignments (emp_id, project_id, assigned_date, status)
VALUES
    (1, 1, '2025-01-01', 'Active'),
    (2, 1, '2025-01-05', 'Active'),
    (3, 2, '2025-01-10', 'Completed'),
    (4, 3, '2025-01-15', 'Active'),
    (5, 2, '2025-01-20', 'Active');

INSERT INTO
    customers (customer_name, contact_email)
VALUES
    ('Customer A', 'a@example.com'),
    ('Customer B', 'b@example.com'),
    ('Customer C', 'c@example.com');

INSERT INTO
    suppliers (supplier_name, contact_phone)
VALUES
    ('Supplier X', '+1-555-0101'),
    ('Supplier Y', '+1-555-0102');

INSERT INTO
    orders (customer_id, product_name, order_date)
VALUES
    (1, 'Product X', '2025-09-01'),
    (2, 'Product Y', '2025-09-02'),
    (3, 'Product Z', '2025-09-03');

INSERT INTO
    sales (emp_id, customer_id, sale_amount, sale_date)
VALUES
    (1, 1, 10000.00, '2025-09-01'),
    (2, 2, 15000.00, '2025-09-02'),
    (3, 3, 8000.00, '2025-09-03');

-- ==========================================================
-- QUESTIONS & ANSWERS (Q1 - Q6)
-- ==========================================================
-- Q1: Create two tables: employees and departments
SELECT
    "Q1: Create two tables: employees and departments";

-- Tables already created above
-- Populate both tables with sample data
SELECT
    "Q1: Populate both tables with sample data";

-- Sample data already inserted above
-- Define relationships using dept_id as a common column
SELECT
    "Q1: Define relationships using dept_id as a common column";

-- Relationships already defined with FOREIGN KEY above
-- Q2: INNER JOIN Tasks
SELECT
    "Q2: Retrieve a list of employees along with their department names";

SELECT
    e.emp_name,
    d.dept_name
FROM
    employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id;

SELECT
    "Q2: Find employees who are assigned to a department (excluding those without a department)";

SELECT
    e.emp_name,
    d.dept_name
FROM
    employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id;

SELECT
    "Q2: Retrieve all departments that have employees working in them";

SELECT
    d.dept_name,
    COUNT(e.emp_id) AS employee_count
FROM
    departments d
    INNER JOIN employees e ON d.dept_id = e.dept_id
GROUP BY
    d.dept_name;

SELECT
    "Q2: Join employees with projects to find employees working on projects";

SELECT
    e.emp_name,
    p.project_name
FROM
    employees e
    INNER JOIN project_assignments pa ON e.emp_id = pa.emp_id
    INNER JOIN projects p ON pa.project_id = p.project_id;

-- Q3: LEFT JOIN Tasks
SELECT
    "Q3: Retrieve all employees, including those who are not assigned to any department";

SELECT
    e.emp_name,
    d.dept_name
FROM
    employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id;

SELECT
    "Q3: Identify employees who do not belong to any department";

SELECT
    e.emp_name
FROM
    employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE
    d.dept_id IS NULL;

SELECT
    "Q3: Retrieve all projects and the employees assigned to them, showing projects even if no employees are assigned";

SELECT
    p.project_name,
    e.emp_name
FROM
    projects p
    LEFT JOIN project_assignments pa ON p.project_id = pa.project_id
    LEFT JOIN employees e ON pa.emp_id = e.emp_id;

SELECT
    "Q3: Find all customers and their recent purchases, ensuring customers without purchases are still displayed";

SELECT
    c.customer_name,
    o.product_name,
    o.order_date
FROM
    customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Q4: RIGHT JOIN Tasks
SELECT
    "Q4: Retrieve all departments and their employees, ensuring departments without employees are still included";

SELECT
    d.dept_name,
    e.emp_name
FROM
    departments d
    RIGHT JOIN employees e ON d.dept_id = e.dept_id;

SELECT
    "Q4: Identify departments that do not have any employees";

SELECT
    d.dept_name
FROM
    departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE
    e.emp_id IS NULL;

SELECT
    "Q4: List all project teams and the employees assigned to them, showing all teams even if no employees are assigned";

SELECT
    p.project_name,
    e.emp_name
FROM
    projects p
    LEFT JOIN project_assignments pa ON p.project_id = pa.project_id
    LEFT JOIN employees e ON pa.emp_id = e.emp_id;

SELECT
    "Q4: Retrieve all sales representatives and their assigned customers, ensuring all representatives are displayed";

SELECT
    e.emp_name,
    c.customer_name
FROM
    employees e
    LEFT JOIN sales s ON e.emp_id = s.emp_id
    LEFT JOIN customers c ON s.customer_id = c.customer_id;

-- Q5: FULL OUTER JOIN Tasks
SELECT
    "Q5: Retrieve all employees and departments, including employees without a department and departments without employees";

SELECT
    e.emp_name,
    d.dept_name
FROM
    employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT
    e.emp_name,
    d.dept_name
FROM
    employees e
    RIGHT JOIN departments d ON e.dept_id = d.dept_id
WHERE
    e.emp_id IS NULL;

SELECT
    "Q5: Identify employees and departments that do not have a matching record in the other table";

SELECT
    e.emp_name AS unmatched_employee
FROM
    employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE
    d.dept_id IS NULL
UNION
SELECT
    d.dept_name AS unmatched_department
FROM
    departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE
    e.emp_id IS NULL;

SELECT
    "Q5: Retrieve all suppliers and customers, showing all records from both even if there is no match";

SELECT
    c.customer_name AS entity
FROM
    customers c
UNION
SELECT
    s.supplier_name AS entity
FROM
    suppliers s;

SELECT
    "Q5: Find all products and sales transactions, ensuring products with no sales and sales with missing product details are included";

SELECT
    o.product_name,
    s.sale_amount
FROM
    orders o
    LEFT JOIN sales s ON o.order_id = s.sale_id
UNION
SELECT
    o.product_name,
    s.sale_amount
FROM
    orders o
    RIGHT JOIN sales s ON o.order_id = s.sale_id
WHERE
    o.order_id IS NULL;

-- Q6: Multi-Table Joins & Data Analysis Tasks
SELECT
    "Q6: Retrieve a list of employees, their departments, and the projects they are working on";

SELECT
    e.emp_name,
    d.dept_name,
    p.project_name
FROM
    employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id
    LEFT JOIN project_assignments pa ON e.emp_id = pa.emp_id
    LEFT JOIN projects p ON pa.project_id = p.project_id;

SELECT
    "Q6: Find employees who have made sales, along with their department and customer details";

SELECT
    e.emp_name,
    d.dept_name,
    c.customer_name,
    s.sale_amount
FROM
    employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id
    LEFT JOIN sales s ON e.emp_id = s.emp_id
    LEFT JOIN customers c ON s.customer_id = c.customer_id
WHERE
    s.sale_amount IS NOT NULL;

SELECT
    "Q6: Retrieve a report showing customers, their orders, and the products they have purchased";

SELECT
    c.customer_name,
    o.product_name,
    o.order_date
FROM
    customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT
    "Q6: Analyze total sales per department by joining employees, departments, and sales";

SELECT
    d.dept_name,
    COALESCE(SUM(s.sale_amount), 0) AS total_sales
FROM
    departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id
    LEFT JOIN sales s ON e.emp_id = s.emp_id
GROUP BY
    d.dept_name;