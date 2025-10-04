-- ==========================================================
-- Database: enterprise_data_db
-- Purpose : Manage employees, departments, projects, customers, flights, restaurants, and more
-- Author  : Prath Digital (Prath Udhnawala)
-- ==========================================================
-- Drop and recreate database
DROP DATABASE IF EXISTS enterprise_data_db;

CREATE DATABASE enterprise_data_db;

USE enterprise_data_db;

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
        manager_id INT,
        FOREIGN KEY (dept_id) REFERENCES departments (dept_id),
        FOREIGN KEY (manager_id) REFERENCES employees (emp_id)
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
-- Table: customers
-- ==========================================================
CREATE TABLE
    customers (
        customer_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_name VARCHAR(100) NOT NULL,
        referrer_id INT,
        FOREIGN KEY (referrer_id) REFERENCES customers (customer_id)
    );

-- ==========================================================
-- Table: flights
-- ==========================================================
CREATE TABLE
    flights (
        flight_id INT AUTO_INCREMENT PRIMARY KEY,
        source_city VARCHAR(100),
        destination_city VARCHAR(100)
    );

-- ==========================================================
-- Table: restaurants
-- ==========================================================
CREATE TABLE
    restaurants (
        restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
        restaurant_name VARCHAR(100) NOT NULL
    );

-- ==========================================================
-- Table: delivery_locations
-- ==========================================================
CREATE TABLE
    delivery_locations (
        location_id INT AUTO_INCREMENT PRIMARY KEY,
        location_name VARCHAR(100) NOT NULL
    );

-- ==========================================================
-- Table: hotels
-- ==========================================================
CREATE TABLE
    hotels (
        hotel_id INT AUTO_INCREMENT PRIMARY KEY,
        hotel_name VARCHAR(100) NOT NULL
    );

-- ==========================================================
-- Table: seasons
-- ==========================================================
CREATE TABLE
    seasons (
        season_id INT AUTO_INCREMENT PRIMARY KEY,
        season_name VARCHAR(100) NOT NULL
    );

-- ==========================================================
-- Table: sales_employees
-- ==========================================================
CREATE TABLE
    sales_employees (
        emp_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_name VARCHAR(100) NOT NULL
    );

-- ==========================================================
-- Table: sales_targets
-- ==========================================================
CREATE TABLE
    sales_targets (
        target_id INT AUTO_INCREMENT PRIMARY KEY,
        target_value DECIMAL(10, 2)
    );

-- ==========================================================
-- Table: students
-- ==========================================================
CREATE TABLE
    students (
        student_id INT AUTO_INCREMENT PRIMARY KEY,
        student_name VARCHAR(100) NOT NULL
    );

-- ==========================================================
-- Table: courses
-- ==========================================================
CREATE TABLE
    courses (
        course_id INT AUTO_INCREMENT PRIMARY KEY,
        course_name VARCHAR(100) NOT NULL
    );

-- ==========================================================
-- Table: enrollments
-- ==========================================================
CREATE TABLE
    enrollments (
        enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
        student_id INT,
        course_id INT,
        FOREIGN KEY (student_id) REFERENCES students (student_id),
        FOREIGN KEY (course_id) REFERENCES courses (course_id)
    );

-- ==========================================================
-- Table: orders
-- ==========================================================
CREATE TABLE
    orders (
        order_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
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
    employees (emp_name, job_title, salary, dept_id, manager_id)
VALUES
    ('Alice', 'Manager', 75000.00, 1, NULL),
    ('Bob', 'Developer', 55000.00, 1, 1),
    ('Charlie', 'Tester', 45000.00, 2, 1),
    ('David', 'HR Specialist', 40000.00, 3, 1),
    ('Eve', 'Accountant', 50000.00, 2, 1);

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

INSERT INTO
    customers (customer_name, referrer_id)
VALUES
    ('Customer A', NULL),
    ('Customer B', 1),
    ('Customer C', 2),
    ('Customer D', 1);

INSERT INTO
    flights (source_city, destination_city)
VALUES
    ('New York', 'London'),
    ('London', 'Paris'),
    ('Paris', 'New York');

INSERT INTO
    restaurants (restaurant_name)
VALUES
    ('Pizza Palace'),
    ('Sushi Spot');

INSERT INTO
    delivery_locations (location_name)
VALUES
    ('Downtown'),
    ('Uptown');

INSERT INTO
    hotels (hotel_name)
VALUES
    ('Grand Hotel'),
    ('Ocean View');

INSERT INTO
    seasons (season_name)
VALUES
    ('Summer'),
    ('Winter');

INSERT INTO
    sales_employees (emp_name)
VALUES
    ('Salesperson 1'),
    ('Salesperson 2');

INSERT INTO
    sales_targets (target_value)
VALUES
    (10000.00),
    (15000.00);

INSERT INTO
    students (student_name)
VALUES
    ('Student 1'),
    ('Student 2'),
    ('Student 3');

INSERT INTO
    courses (course_name)
VALUES
    ('Math'),
    ('Science');

INSERT INTO
    enrollments (student_id, course_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 2);

INSERT INTO
    orders (customer_id, order_date)
VALUES
    (1, '2025-01-01'),
    (1, '2025-02-01'),
    (2, '2025-01-15'),
    (2, '2025-03-01');

-- ==========================================================
-- QUESTIONS & ANSWERS (Q1 - Q3)
-- ==========================================================
-- Q1: CROSS JOIN Tasks
-- Q1.1: Create two tables: products and customers. Perform a task to generate all possible product-customer combinations.
SELECT
    "Q1.1: All possible product-customer combinations";

SELECT
    p.product_name,
    c.customer_name
FROM
    (
        SELECT
            'Product 1' AS product_name
        UNION
        SELECT
            'Product 2'
    ) p
    CROSS JOIN (
        SELECT
            customer_name
        FROM
            customers
    ) c;

-- Q1.2: Create a sales table containing employee_id and a target goals table with different sales targets. Find all possible assignments of sales targets to employees.
SELECT
    "Q1.2: All possible assignments of sales targets to employees";

SELECT
    se.emp_name,
    st.target_value
FROM
    sales_employees se
    CROSS JOIN sales_targets st;

-- Q1.3: Generate all possible pairings of restaurants and available delivery locations from two separate tables.
SELECT
    "Q1.3: All possible pairings of restaurants and delivery locations";

SELECT
    r.restaurant_name,
    dl.location_name
FROM
    restaurants r
    CROSS JOIN delivery_locations dl;

-- Q1.4: Create a list of all possible course-student enrollments, assuming every student can enroll in any course.
SELECT
    "Q1.4: All possible course-student enrollments";

SELECT
    s.student_name,
    c.course_name
FROM
    students s
    CROSS JOIN courses c;

-- Q1.5: Given two tables, hotels and seasons, generate all possible price variations for hotels during different seasons.
SELECT
    "Q1.5: All possible price variations for hotels during seasons";

SELECT
    h.hotel_name,
    s.season_name,
    ROUND(RAND () * 100 + 100, 2) AS price
FROM
    hotels h
    CROSS JOIN seasons s;

-- Q2: SELF JOIN Tasks
-- Q2.1: Create an employees table with a manager_id column. Retrieve a list of employees along with their managers using a SELF JOIN.
SELECT
    "Q2.1: Employees with their managers";

SELECT
    e1.emp_name AS employee,
    e2.emp_name AS manager
FROM
    employees e1
    LEFT JOIN employees e2 ON e1.manager_id = e2.emp_id;

-- Q2.2: Create a customers table where customers refer other customers (referrer_id). Find all customers who were referred by others.
SELECT
    "Q2.2: Customers referred by others";

SELECT
    c1.customer_name AS customer,
    c2.customer_name AS referrer
FROM
    customers c1
    LEFT JOIN customers c2 ON c1.referrer_id = c2.customer_id
WHERE
    c1.referrer_id IS NOT NULL;

-- Q2.3: Analyze hierarchical data within an organizations table, retrieving each department and its parent department.
SELECT
    "Q2.3: Departments with parent departments";

SELECT
    d1.dept_name AS department,
    d2.dept_name AS parent_department
FROM
    departments d1
    LEFT JOIN departments d2 ON d1.dept_id = d2.dept_id + 1;

-- Q2.4: Given a flights table with source_city and destination_city, find all possible connected flight routes.
SELECT
    "Q2.4: All possible connected flight routes";

SELECT
    f1.source_city,
    f1.destination_city,
    f2.destination_city AS next_destination
FROM
    flights f1
    LEFT JOIN flights f2 ON f1.destination_city = f2.source_city
WHERE
    f1.destination_city != f2.destination_city;

-- Q2.5: Find all employees who share the same department or job role within a company.
SELECT
    "Q2.5: Employees sharing department or job role";

SELECT
    e1.emp_name AS employee1,
    e2.emp_name AS employee2,
    d.dept_name,
    e1.job_title
FROM
    employees e1
    JOIN employees e2 ON e1.dept_id = e2.dept_id
    OR e1.job_title = e2.job_title
    JOIN departments d ON e1.dept_id = d.dept_id
WHERE
    e1.emp_id != e2.emp_id;

-- Q3: Real-World Data Analysis with Joins
-- Q3.1: Identify all possible supplier-product relationships by CROSS JOIN using the suppliers and products tables.
SELECT
    "Q3.1: All possible supplier-product relationships";

SELECT
    p.product_name,
    c.customer_name AS supplier
FROM
    (
        SELECT
            'Product 1' AS product_name
        UNION
        SELECT
            'Product 2'
    ) p
    CROSS JOIN (
        SELECT
            customer_name
        FROM
            customers
    ) c;

-- Q3.2: Generate a combination of all marketing campaigns and potential customer segments using CROSS JOIN.
SELECT
    "Q3.2: Combinations of marketing campaigns and customer segments";

SELECT
    m.campaign_name,
    c.customer_name AS segment
FROM
    (
        SELECT
            'Campaign 1' AS campaign_name
        UNION
        SELECT
            'Campaign 2'
    ) m
    CROSS JOIN (
        SELECT
            customer_name
        FROM
            customers
    ) c;

-- Q3.3: Find all direct and indirect reporting relationships within an organization using a SELF JOIN.
SELECT
    "Q3.3: Direct and indirect reporting relationships";

SELECT
    e1.emp_name AS employee,
    e2.emp_name AS manager,
    e3.emp_name AS grand_manager
FROM
    employees e1
    LEFT JOIN employees e2 ON e1.manager_id = e2.emp_id
    LEFT JOIN employees e3 ON e2.manager_id = e3.emp_id;

-- Q3.4: Retrieve a list of customers who placed multiple orders and compare each order with their previous one using a SELF JOIN.
SELECT
    "Q3.4: Customers with multiple orders and previous order comparison";

SELECT
    c.customer_name,
    o1.order_date AS order_date,
    o2.order_date AS previous_order_date
FROM
    customers c
    JOIN orders o1 ON c.customer_id = o1.customer_id
    LEFT JOIN orders o2 ON c.customer_id = o2.customer_id
    AND o1.order_date > o2.order_date
WHERE
    o2.order_id IS NOT NULL
ORDER BY
    c.customer_name,
    o1.order_date;

-- Q3.5: Identify pairs of students who have enrolled in the same course using a SELF JOIN on the enrollments table.
SELECT
    "Q3.5: Pairs of students enrolled in the same course";

SELECT
    e1.student_id AS student1,
    s1.student_name AS name1,
    e2.student_id AS student2,
    s2.student_name AS name2,
    c.course_name
FROM
    enrollments e1
    JOIN enrollments e2 ON e1.course_id = e2.course_id
    AND e1.student_id < e2.student_id
    JOIN students s1 ON e1.student_id = s1.student_id
    JOIN students s2 ON e2.student_id = s2.student_id
    JOIN courses c ON e1.course_id = c.course_id;