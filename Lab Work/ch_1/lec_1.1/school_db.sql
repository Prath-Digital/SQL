-- Create Database named school_db
DROP DATABASE IF EXISTS school_db;

CREATE DATABASE school_db;

-- Use Database
USE school_db;

-- Create Table named students with columns id, name, age, class, and grade
CREATE TABLE
    students (
        id INTEGER PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50) NOT NULL,
        age INTEGER (2) NOT NULL,
        class VARCHAR(50) NOT NULL,
        grade CHAR(2)
    );

-- Insert at least 5 records into the students table
INSERT INTO
    students (name, age, class, grade)
VALUES
    ('Prath Udhnawala', 10, '4th class', 'A+'),
    ('Hesth Udhnawala', 9, '3rd class', 'A+'),
    ('Kathan Jogi', 13, '7th class', 'F-'),
    ('Daksh Chiniwala', 15, '11th class', 'A'),
    ('Darsh Revdiwala', 8, '2nd class', 'C');