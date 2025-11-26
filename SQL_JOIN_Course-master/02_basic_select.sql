-- ========================================
-- LESSON 2: Basic SELECT and FROM
-- ========================================
-- Learning Objectives:
-- 1. Understand what is a database and tables
-- 2. Learn basic SELECT syntax
-- 3. Understand the FROM clause
-- 4. Practice retrieving data from tables

-- ========================================
-- 1.1 WHAT IS A DATABASE?
-- ========================================

/*
A DATABASE is a collection of related data organized in a structured way.
A RELATIONAL DATABASE stores data in TABLES (like spreadsheets).

TABLES contain:
- ROWS (also called RECORDS): Each row represents one instance/item
- COLUMNS (also called FIELDS/ATTRIBUTES): Each column represents a property

Think of our EMPLOYEES table:
- Each ROW = One Employee 
- Each COLUMN = An attribute like name, email, hire_date, etc.
*/

-- Let's see what tables we have in our database
-- (This query might not work in all database systems, but let's see our main tables)

-- ========================================
-- 1.2 BASIC SELECT SYNTAX
-- ========================================

/*
The SELECT statement is used to retrieve data from tables.
Basic syntax:
    SELECT column1, column2, ...
    FROM table_name;

Let's start with simple examples:
*/

-- Example 1: Select specific columns from employees table
SELECT first_name, last_name
FROM employees;

-- Run this query and observe:
-- - You get only the columns you requested
-- - All rows are returned
-- - Data is displayed in the order stored in the table

-- Example 2: Select all columns using * (asterisk)
SELECT *
FROM employees;

-- The * means "all columns" - very useful for exploring data
-- Notice all the information about each employee

-- Example 3: Select different columns
SELECT employee_id, email, job_title
FROM employees;

-- Example 4: Select from departments table
SELECT *
FROM departments;

-- Example 5: Select specific columns from departments
SELECT department_name, budget
FROM departments;

-- ========================================
-- 1.3 UNDERSTANDING THE FROM CLAUSE
-- ========================================

/*
The FROM clause specifies which table to retrieve data from.
You MUST include a FROM clause in SELECT statements (in most databases).

FROM table_name tells SQL where to look for the data.
*/

-- Example 6: Explore the projects table
SELECT *
FROM projects;

-- Example 7: Look at specific project information
SELECT project_name, status, budget
FROM projects;

-- Example 8: Explore locations table  
SELECT *
FROM locations;

-- Example 9: See city and country information
SELECT city, country
FROM locations;

-- ========================================
-- 1.4 COLUMN ORDER MATTERS
-- ========================================

-- Example 10: Different column orders give different results
SELECT first_name, last_name, job_title
FROM employees;

-- vs.

SELECT job_title, last_name, first_name  
FROM employees;

-- Notice how the order of columns in your SELECT determines 
-- the order they appear in the results

-- ========================================
-- 1.5 DATA TYPES IN ACTION
-- ========================================

-- Let's see different data types in our tables:

-- Example 11: Text data (VARCHAR)
SELECT first_name, last_name, email
FROM employees;

-- Example 12: Numeric data (INT, DECIMAL)
SELECT employee_id, department_id  
FROM employees;

-- Example 13: Date data (DATE)
SELECT first_name, last_name, hire_date
FROM employees;

-- Example 14: Mix of data types
SELECT project_name, budget, start_date, end_date
FROM projects;

-- ========================================
-- 1.6 EXPLORING ALL OUR TABLES
-- ========================================

-- Let's look at each table to understand our data structure:

-- Locations (where offices are)
SELECT 'LOCATIONS TABLE:' as table_info;
SELECT * FROM locations;

-- Departments (company divisions)
SELECT 'DEPARTMENTS TABLE:' as table_info;
SELECT * FROM departments;

-- Employees (our people)
SELECT 'EMPLOYEES TABLE:' as table_info;
SELECT * FROM employees;

-- Projects (work being done)
SELECT 'PROJECTS TABLE:' as table_info;
SELECT * FROM projects;

-- Employee-Projects (who works on what)
SELECT 'EMPLOYEE-PROJECTS TABLE:' as table_info;
SELECT * FROM employee_projects;

-- Salaries (compensation history)
SELECT 'SALARIES TABLE:' as table_info;
SELECT * FROM salaries;

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Try these exercises on your own:

1. Select only the employee names (first and last) from the employees table

2. Select all information from the projects table

3. Select project name and budget from projects table

4. Select city and address from locations table

5. Select employee_id and salary_amount from salaries table

6. Try selecting columns in different orders and see how it affects the output

SOLUTIONS BELOW (try first, then check):
*/

-- Exercise Solutions:

-- 1. Employee names only
SELECT first_name, last_name FROM employees;

-- 2. All project information  
SELECT * FROM projects;

-- 3. Project names and budgets
SELECT project_name, budget FROM projects;

-- 4. City and address
SELECT city, address FROM locations;

-- 5. Employee ID and salary amounts
SELECT employee_id, salary_amount FROM salaries;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. Databases store data in tables with rows and columns
2. SELECT retrieves data from tables
3. FROM specifies which table to query
4. You can select specific columns or all columns (*)
5. Column order in SELECT determines output order
6. Tables can contain different data types (text, numbers, dates)

✅ Next lesson: 03_filtering_data.sql
   We'll learn how to filter data using WHERE clauses!
*/

SELECT 'Lesson 2 Complete! 🎉' as status;
SELECT 'Next: 03_filtering_data.sql' as next_lesson; 