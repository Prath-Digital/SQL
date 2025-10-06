-- ==========================================================
-- Database: hr_management_db
-- Purpose : Manage employees, departments, projects, tasks
-- Author  : Prath Digital (Prath Udhnawala)
-- ==========================================================
-- Drop and recreate database
DROP DATABASE IF EXISTS hr_management_db;

CREATE DATABASE hr_management_db;

USE hr_management_db;

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
-- QUESTIONS & ANSWERS (Q1)
-- ==========================================================
-- Q1.1: Assign a row number to each order in the orders table based on the order date (most recent first)
SELECT
    "Q1.1: Assign a row number to each order in the orders table based on the order date (most recent first)";

SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            assigned_date DESC
    ) AS row_num,
    emp_id,
    project_id,
    assigned_date
FROM
    project_assignments;

-- Q1.2: Calculate the running total of sales for each product category in the sales table
SELECT
    "Q1.2: Calculate the running total of sales for each product category in the sales table";

SELECT
    p.project_name AS category,
    pa.assigned_date,
    COUNT(pa.assignment_id) AS sales_count,
    SUM(COUNT(pa.assignment_id)) OVER (
        PARTITION BY
            p.project_name
        ORDER BY
            pa.assigned_date
    ) AS running_total
FROM
    project_assignments pa
    JOIN projects p ON pa.project_id = p.project_id
GROUP BY
    p.project_name,
    pa.assigned_date;

-- Q1.3: Find the average salary for employees in each department while keeping individual employee salaries visible
SELECT
    "Q1.3: Find the average salary for employees in each department while keeping individual employee salaries visible";

SELECT
    e.emp_name,
    d.dept_name,
    e.salary,
    AVG(e.salary) OVER (
        PARTITION BY
            d.dept_name
    ) AS dept_avg_salary
FROM
    employees e
    JOIN departments d ON e.dept_id = d.dept_id;

-- Q1.4: Rank customers based on their total purchase amount, with ties getting the same rank
SELECT
    "Q1.4: Rank customers based on their total purchase amount, with ties getting the same rank";

SELECT
    e.emp_name,
    COUNT(pa.assignment_id) AS total_assignments,
    RANK() OVER (
        ORDER BY
            COUNT(pa.assignment_id) DESC
    ) AS rank
FROM
    employees e
    LEFT JOIN project_assignments pa ON e.emp_id = pa.emp_id
GROUP BY
    e.emp_name;

-- Q1.5: Compute the difference between each order's sales and the average sales for its category
SELECT
    "Q1.5: Compute the difference between each order's sales and the average sales for its category";

SELECT
    pa.assignment_id,
    p.project_name AS category,
    COUNT(pa.assignment_id) AS order_sales,
    AVG(COUNT(pa.assignment_id)) OVER (
        PARTITION BY
            p.project_name
    ) AS category_avg_sales,
    (
        COUNT(pa.assignment_id) - AVG(COUNT(pa.assignment_id)) OVER (
            PARTITION BY
                p.project_name
        )
    ) AS sales_difference
FROM
    project_assignments pa
    JOIN projects p ON pa.project_id = p.project_id
GROUP BY
    pa.assignment_id,
    p.project_name;

-- ==========================================================
-- QUESTIONS & ANSWERS (Q2)
-- ==========================================================
-- Q2.1: Identify the top 3 highest-selling products per category using a ranking function
SELECT
    "Q2.1: Identify the top 3 highest-selling products per category using a ranking function";

SELECT
    p.project_name,
    d.dept_name AS category,
    COUNT(pa.assignment_id) AS sales_count,
    RANK() OVER (
        PARTITION BY
            d.dept_name
        ORDER BY
            COUNT(pa.assignment_id) DESC
    ) AS sales_rank
FROM
    projects p
    JOIN departments d ON p.dept_id = d.dept_id
    LEFT JOIN project_assignments pa ON p.project_id = pa.project_id
GROUP BY
    p.project_name,
    d.dept_name
HAVING
    RANK() OVER (
        PARTITION BY
            d.dept_name
        ORDER BY
            COUNT(pa.assignment_id) DESC
    ) <= 3;

-- Q2.2: Calculate the percentage contribution of each employee's salary to the total salary in their department
SELECT
    "Q2.2: Calculate the percentage contribution of each employee's salary to the total salary in their department";

SELECT
    e.emp_name,
    d.dept_name,
    e.salary,
    SUM(e.salary) OVER (
        PARTITION BY
            d.dept_name
    ) AS dept_total_salary,
    (
        e.salary / SUM(e.salary) OVER (
            PARTITION BY
                d.dept_name
        ) * 100
    ) AS percentage_contribution
FROM
    employees e
    JOIN departments d ON e.dept_id = d.dept_id;

-- Q2.3: Retrieve the previous and next order date for each customer to analyze purchase patterns
SELECT
    "Q2.3: Retrieve the previous and next order date for each customer to analyze purchase patterns";

SELECT
    e.emp_name,
    pa.assigned_date,
    LAG (pa.assigned_date) OVER (
        PARTITION BY
            e.emp_name
        ORDER BY
            pa.assigned_date
    ) AS previous_date,
    LEAD (pa.assigned_date) OVER (
        PARTITION BY
            e.emp_name
        ORDER BY
            pa.assigned_date
    ) AS next_date
FROM
    employees e
    LEFT JOIN project_assignments pa ON e.emp_id = pa.emp_id;

-- Q2.4: Calculate a moving average of sales over the last 7 days for each product
SELECT
    "Q2.4: Calculate a moving average of sales over the last 7 days for each product";

SELECT
    p.project_name,
    pa.assigned_date,
    COUNT(pa.assignment_id) AS daily_sales,
    AVG(COUNT(pa.assignment_id)) OVER (
        PARTITION BY
            p.project_name
        ORDER BY
            pa.assigned_date ROWS BETWEEN 6 PRECEDING
            AND CURRENT ROW
    ) AS moving_avg_sales
FROM
    project_assignments pa
    JOIN projects p ON pa.project_id = p.project_id
GROUP BY
    p.project_name,
    pa.assigned_date;

-- Q2.5: Find the highest and lowest sales for each region while keeping all sales records visible
SELECT
    "Q2.5: Find the highest and lowest sales for each region while keeping all sales records visible";

SELECT
    d.dept_name AS region,
    p.project_name,
    COUNT(pa.assignment_id) AS sales,
    MAX(COUNT(pa.assignment_id)) OVER (
        PARTITION BY
            d.dept_name
    ) AS highest_sales,
    MIN(COUNT(pa.assignment_id)) OVER (
        PARTITION BY
            d.dept_name
    ) AS lowest_sales
FROM
    projects p
    JOIN departments d ON p.dept_id = d.dept_id
    LEFT JOIN project_assignments pa ON p.project_id = pa.project_id
GROUP BY
    d.dept_name,
    p.project_name;