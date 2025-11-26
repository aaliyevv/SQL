-- ========================================
-- SQL & JOIN Course - Database Setup
-- ========================================
-- This file creates the learning database with sample data
-- RUN THIS FIRST before proceeding with other lessons

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS employee_projects;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;

-- ========================================
-- 1. LOCATIONS TABLE
-- ========================================
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    address VARCHAR(100)
);

-- ========================================
-- 2. DEPARTMENTS TABLE
-- ========================================
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location_id INT,
    manager_id INT,
    budget DECIMAL(12,2),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- ========================================
-- 3. EMPLOYEES TABLE
-- ========================================
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    department_id INT,
    manager_id INT,
    job_title VARCHAR(100),
    phone VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- ========================================
-- 4. PROJECTS TABLE
-- ========================================
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12,2),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ========================================
-- 5. EMPLOYEE_PROJECTS TABLE (Many-to-Many)
-- ========================================
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_allocated INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- ========================================
-- 6. SALARIES TABLE
-- ========================================
CREATE TABLE salaries (
    salary_id INT PRIMARY KEY,
    employee_id INT,
    salary_amount DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- ========================================
-- INSERT SAMPLE DATA
-- ========================================

-- Insert Locations
INSERT INTO locations (location_id, city, country, address) VALUES
(1, 'New York', 'USA', '123 Broadway St'),
(2, 'London', 'UK', '456 Oxford St'),
(3, 'Tokyo', 'Japan', '789 Shibuya Crossing'),
(4, 'San Francisco', 'USA', '321 Market St'),
(5, 'Berlin', 'Germany', '654 Unter den Linden');

-- Insert Departments
INSERT INTO departments (department_id, department_name, location_id, manager_id, budget) VALUES
(1, 'Engineering', 4, NULL, 2000000.00),
(2, 'Marketing', 1, NULL, 500000.00),
(3, 'Sales', 1, NULL, 800000.00),
(4, 'HR', 2, NULL, 300000.00),
(5, 'Finance', 1, NULL, 400000.00),
(6, 'IT Support', 3, NULL, 250000.00);

-- Insert Employees (Note: We'll update manager_ids after inserting)
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, department_id, manager_id, job_title, phone) VALUES
(1, 'John', 'Smith', 'john.smith@company.com', '2020-01-15', 1, NULL, 'Engineering Manager', '555-0101'),
(2, 'Sarah', 'Johnson', 'sarah.johnson@company.com', '2019-03-20', 2, NULL, 'Marketing Director', '555-0102'),
(3, 'Mike', 'Brown', 'mike.brown@company.com', '2021-06-10', 1, 1, 'Senior Developer', '555-0103'),
(4, 'Emily', 'Davis', 'emily.davis@company.com', '2020-09-05', 3, NULL, 'Sales Manager', '555-0104'),
(5, 'David', 'Wilson', 'david.wilson@company.com', '2022-01-20', 1, 1, 'Junior Developer', '555-0105'),
(6, 'Lisa', 'Anderson', 'lisa.anderson@company.com', '2018-11-30', 4, NULL, 'HR Director', '555-0106'),
(7, 'Tom', 'Garcia', 'tom.garcia@company.com', '2021-04-18', 2, 2, 'Marketing Specialist', '555-0107'),
(8, 'Anna', 'Martinez', 'anna.martinez@company.com', '2020-07-22', 3, 4, 'Sales Representative', '555-0108'),
(9, 'Chris', 'Taylor', 'chris.taylor@company.com', '2019-05-14', 5, NULL, 'Finance Manager', '555-0109'),
(10, 'Jessica', 'White', 'jessica.white@company.com', '2022-03-08', 1, 1, 'DevOps Engineer', '555-0110'),
(11, 'Robert', 'Lee', 'robert.lee@company.com', '2021-08-12', 6, NULL, 'IT Manager', '555-0111'),
(12, 'Maria', 'Lopez', 'maria.lopez@company.com', '2020-12-03', 4, 6, 'HR Coordinator', '555-0112');

-- Update manager_ids for departments
UPDATE departments SET manager_id = 1 WHERE department_id = 1;
UPDATE departments SET manager_id = 2 WHERE department_id = 2;
UPDATE departments SET manager_id = 4 WHERE department_id = 3;
UPDATE departments SET manager_id = 6 WHERE department_id = 4;
UPDATE departments SET manager_id = 9 WHERE department_id = 5;
UPDATE departments SET manager_id = 11 WHERE department_id = 6;

-- Insert Projects
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, department_id) VALUES
(1, 'Website Redesign', '2023-01-01', '2023-06-30', 150000.00, 'COMPLETED', 1),
(2, 'Mobile App Development', '2023-03-15', '2023-12-31', 300000.00, 'ACTIVE', 1),
(3, 'Brand Campaign 2023', '2023-02-01', '2023-05-31', 80000.00, 'COMPLETED', 2),
(4, 'Sales Training Program', '2023-04-01', '2023-08-31', 45000.00, 'ACTIVE', 3),
(5, 'HR System Upgrade', '2023-01-15', '2023-09-30', 120000.00, 'ACTIVE', 4),
(6, 'Financial Audit 2023', '2023-06-01', '2023-07-31', 60000.00, 'ACTIVE', 5),
(7, 'Network Infrastructure', '2023-05-01', '2023-11-30', 200000.00, 'ACTIVE', 6),
(8, 'Customer Portal', '2023-07-01', '2024-02-28', 250000.00, 'PLANNING', 1);

-- Insert Employee-Project Assignments
INSERT INTO employee_projects (employee_id, project_id, role, hours_allocated) VALUES
(1, 1, 'Project Manager', 120),
(1, 2, 'Technical Lead', 80),
(3, 1, 'Lead Developer', 160),
(3, 2, 'Senior Developer', 140),
(5, 1, 'Developer', 120),
(5, 2, 'Developer', 160),
(10, 2, 'DevOps Engineer', 100),
(10, 7, 'Infrastructure Lead', 140),
(2, 3, 'Campaign Manager', 100),
(7, 3, 'Marketing Specialist', 120),
(4, 4, 'Program Manager', 80),
(8, 4, 'Training Coordinator', 60),
(6, 5, 'Project Sponsor', 40),
(12, 5, 'Implementation Lead', 100),
(9, 6, 'Audit Lead', 80),
(11, 7, 'Project Manager', 100);

-- Insert Salary History
INSERT INTO salaries (salary_id, employee_id, salary_amount, start_date, end_date) VALUES
(1, 1, 95000.00, '2020-01-15', '2020-12-31'),
(2, 1, 105000.00, '2021-01-01', '2021-12-31'),
(3, 1, 115000.00, '2022-01-01', NULL),
(4, 2, 78000.00, '2019-03-20', '2019-12-31'),
(5, 2, 85000.00, '2020-01-01', '2020-12-31'),
(6, 2, 92000.00, '2021-01-01', '2021-12-31'),
(7, 2, 98000.00, '2022-01-01', NULL),
(8, 3, 75000.00, '2021-06-10', '2021-12-31'),
(9, 3, 82000.00, '2022-01-01', '2022-12-31'),
(10, 3, 88000.00, '2023-01-01', NULL),
(11, 4, 70000.00, '2020-09-05', '2021-08-31'),
(12, 4, 76000.00, '2021-09-01', '2022-08-31'),
(13, 4, 82000.00, '2022-09-01', NULL),
(14, 5, 55000.00, '2022-01-20', '2022-12-31'),
(15, 5, 62000.00, '2023-01-01', NULL),
(16, 6, 72000.00, '2018-11-30', '2019-11-29'),
(17, 6, 78000.00, '2019-11-30', '2020-11-29'),
(18, 6, 84000.00, '2020-11-30', '2021-11-29'),
(19, 6, 90000.00, '2021-11-30', NULL);

-- ========================================
-- VERIFY DATA SETUP
-- ========================================
-- Let's check our data was inserted correctly

SELECT 'LOCATIONS' as table_name, COUNT(*) as record_count FROM locations
UNION ALL
SELECT 'DEPARTMENTS', COUNT(*) FROM departments
UNION ALL
SELECT 'EMPLOYEES', COUNT(*) FROM employees
UNION ALL
SELECT 'PROJECTS', COUNT(*) FROM projects
UNION ALL
SELECT 'EMPLOYEE_PROJECTS', COUNT(*) FROM employee_projects
UNION ALL
SELECT 'SALARIES', COUNT(*) FROM salaries;

-- Display a sample of our data
SELECT 'Sample Employee Data:' as info;
SELECT employee_id, first_name, last_name, job_title, department_id 
FROM employees 
LIMIT 5;

SELECT 'Database setup complete! 🎉' as status;
SELECT 'You can now proceed to lesson 02_basic_select.sql' as next_step; 