-- ==========================================================
-- Database: company_management_db
-- Purpose : Manage employees, departments, projects, tasks
-- Author  : Prath Digital (Prath Udhnawala)
-- ==========================================================
-- Drop and recreate database
DROP DATABASE IF EXISTS company_management_db;

CREATE DATABASE company_management_db;

USE company_management_db;

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
-- QUESTIONS & ANSWERS (Q1 - Q9)
-- ==========================================================
-- Q1: List all employees
SELECT
    "Q1: List all employees";

SELECT
    *
FROM
    employees;

-- Q2: List all departments
SELECT
    "Q2: List all departments";

SELECT
    *
FROM
    departments;

-- Q3: Show employees with their departments
SELECT
    "Q3: Show employees with their departments";

SELECT
    e.emp_name,
    d.dept_name
FROM
    employees e
    JOIN departments d ON e.dept_id = d.dept_id;

-- Q4: Show all projects with department names
SELECT
    "Q4: Show all projects with department names";

SELECT
    p.project_name,
    d.dept_name
FROM
    projects p
    JOIN departments d ON p.dept_id = d.dept_id;

-- Q5: Show tasks under each project
SELECT
    "Q5: Show tasks under each project";

SELECT
    t.task_name,
    p.project_name
FROM
    tasks t
    JOIN projects p ON t.project_id = p.project_id;

-- Q6: Show employees assigned to projects
SELECT
    "Q6: Show employees assigned to projects";

SELECT
    e.emp_name,
    p.project_name,
    pa.assigned_date
FROM
    employees e
    JOIN project_assignments pa ON e.emp_id = pa.emp_id
    JOIN projects p ON pa.project_id = p.project_id;

-- Q7: Show tasks with project and department
SELECT
    "Q7: Show tasks with project and department";

SELECT
    t.task_name,
    p.project_name,
    d.dept_name
FROM
    tasks t
    JOIN projects p ON t.project_id = p.project_id
    JOIN departments d ON p.dept_id = d.dept_id;

-- Q8: Find employees with salary > 50000
SELECT
    "Q8: Find employees with salary > 50000";

SELECT
    emp_name,
    job_title,
    salary
FROM
    employees
WHERE
    salary > 50000;

-- Q9: Count employees per department
SELECT
    "Q9: Count employees per department";

SELECT
    d.dept_name,
    COUNT(e.emp_id) AS total_employees
FROM
    departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY
    d.dept_name;