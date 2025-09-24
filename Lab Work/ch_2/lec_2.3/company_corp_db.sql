DROP DATABASE IF EXISTS company_corp_db;

CREATE DATABASE company_corp_db;

USE company_corp_db;

-- Q1: Create a table employees with the following structure:
CREATE TABLE
    employees (
        emp_id INT PRIMARY KEY,
        emp_name VARCHAR(50),
        position VARCHAR(50),
        salary DECIMAL(10, 2)
    );

-- Insert at least 5 records into the table
INSERT INTO
    employees (emp_id, emp_name, position, salary)
VALUES
    (1, 'John Doe', 'Manager', 75000.00),
    (2, 'Jane Smith', 'Developer', 65000.00),
    (3, 'Alice Johnson', 'Analyst', 55000.00),
    (4, 'Bob Brown', 'Designer', 60000.00),
    (5, 'Charlie Wilson', 'Tester', 50000.00);

-- Try inserting a duplicate value for emp_id and observe the error message
INSERT INTO
    employees (emp_id, emp_name, position, salary)
VALUES
    (1, 'Duplicate John', 'Manager', 75000.00);

-- This will fail due to PRIMARY KEY constraint
-- Q2: Create a table departments with the following structure:
CREATE TABLE
    departments (dept_id INT, dept_name VARCHAR(50));

-- Alter the table to add a primary key on the dept_id column
ALTER TABLE departments ADD PRIMARY KEY (dept_id);

-- Q3: Create a table project_assignments with the following structure:
CREATE TABLE
    project_assignments (
        emp_id INT,
        project_id INT,
        assigned_date DATE,
        PRIMARY KEY (emp_id, project_id)
    );

-- Insert at least 3 records into the table with unique combinations of emp_id and project_id
INSERT INTO
    project_assignments (emp_id, project_id, assigned_date)
VALUES
    (1, 101, '2025-09-01'),
    (2, 102, '2025-09-02'),
    (3, 103, '2025-09-03');

-- Q4: Create a table student_enrollments with the following structure:
CREATE TABLE
    student_enrollments (
        student_id INT,
        course_id INT,
        enrollment_date DATE,
        PRIMARY KEY (student_id, course_id)
    );

-- Insert 3 records with unique combinations of student_id and course_id
INSERT INTO
    student_enrollments (student_id, course_id, enrollment_date)
VALUES
    (1, 201, '2025-09-10'),
    (2, 202, '2025-09-11'),
    (3, 203, '2025-09-12');

-- Try inserting a duplicate record and observe the result
INSERT INTO
    student_enrollments (student_id, course_id, enrollment_date)
VALUES
    (1, 201, '2025-09-13');

-- This will fail due to PRIMARY KEY constraint
-- Q5: Create a table departments with the following structure:
CREATE TABLE
    departments (
        dept_id INT PRIMARY KEY, dept_name VARCHAR(50)
    );

-- Create a table employees with the following structure:
CREATE TABLE
    employees (
        emp_id INT PRIMARY KEY,
        emp_name VARCHAR(50),
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
    );

-- Insert 3 records into the departments table
INSERT INTO
    departments (dept_id, dept_name)
VALUES
    (10, 'HR'),
    (20, 'IT'),
    (30, 'Finance');

-- Insert 5 records into the employees table, ensuring the dept_id values match the records in the departments table
INSERT INTO
    employees (emp_id, emp_name, dept_id)
VALUES
    (1, 'John Doe', 10),
    (2, 'Jane Smith', 20),
    (3, 'Alice Johnson', 20),
    (4, 'Bob Brown', 30),
    (5, 'Charlie Wilson', 10);

-- Q6: Create a table projects with the following structure:
CREATE TABLE
    projects (
        project_id INT PRIMARY KEY,
        project_name VARCHAR(50),
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
    );

-- Insert 2 projects into the table, ensuring the dept_id values reference existing departments
INSERT INTO
    projects (project_id, project_name, dept_id)
VALUES
    (101, 'Project A', 20),
    (102, 'Project B', 10);

-- Q7: Modify the employees table to include the ON DELETE CASCADE option for the dept_id foreign key
ALTER TABLE employees
DROP FOREIGN KEY employees_ibfk_1;

-- Assuming default foreign key name, adjust if different
ALTER TABLE employees ADD FOREIGN KEY (dept_id) REFERENCES departments (dept_id) ON DELETE CASCADE;

-- Delete a record from the departments table and observe how the employees table is affected
DELETE FROM departments
WHERE
    dept_id = 10;

-- This will also delete employees with dept_id 10
-- Q8: Create a table tasks with the following structure:
CREATE TABLE
    tasks (
        task_id INT PRIMARY KEY,
        task_name VARCHAR(50),
        project_id INT,
        FOREIGN KEY (project_id) REFERENCES projects (project_id)
    );

-- Insert records into the tasks table linked to existing projects
INSERT INTO
    tasks (task_id, task_name, project_id)
VALUES
    (1001, 'Task 1', 101),
    (1002, 'Task 2', 102);

-- Write a query to retrieve:
-- - task_name
-- - project_name
-- - dept_name
SELECT
    t.task_name,
    p.project_name,
    d.dept_name
FROM
    tasks t
    JOIN projects p ON t.project_id = p.project_id
    JOIN departments d ON p.dept_id = d.dept_id;

-- Q9: Simulate a company database with the following tables:
DROP DATABASE IF EXISTS company2_corp_db;

CREATE DATABASE company2_corp_db;

USE company2_corp_db;

CREATE TABLE
    departments (dept_id INT PRIMARY KEY);

CREATE TABLE
    employees (
        emp_id INT PRIMARY KEY,
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
    );

CREATE TABLE
    projects (
        project_id INT PRIMARY KEY,
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
    );

CREATE TABLE
    project_assignments (
        emp_id INT,
        project_id INT,
        FOREIGN KEY (emp_id) REFERENCES employees (emp_id),
        FOREIGN KEY (project_id) REFERENCES projects (project_id),
        PRIMARY KEY (emp_id, project_id)
    );