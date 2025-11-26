-- ========================================
-- LESSON 3: Filtering Data with WHERE
-- ========================================
-- Learning Objectives:
-- 1. Understand the WHERE clause
-- 2. Learn comparison operators (=, >, <, >=, <=, !=, <>)
-- 3. Filter records based on conditions
-- 4. Work with different data types in conditions

-- ========================================
-- 3.1 INTRODUCTION TO WHERE CLAUSE
-- ========================================

/*
The WHERE clause is used to filter records.
It allows you to specify conditions that rows must meet to be included in results.

Syntax:
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition;

Only rows that meet the condition will be returned.
*/

-- ========================================
-- 3.2 EQUALITY OPERATOR (=)
-- ========================================

-- Example 1: Find employees in Engineering department (department_id = 1)
SELECT first_name, last_name, job_title
FROM employees
WHERE department_id = 1;

-- Example 2: Find projects with ACTIVE status
SELECT project_name, status, budget
FROM projects
WHERE status = 'ACTIVE';

-- Example 3: Find employees with specific job title
SELECT first_name, last_name, email
FROM employees
WHERE job_title = 'Senior Developer';

-- Example 4: Find departments in New York (location_id = 1)
SELECT department_name, budget
FROM departments
WHERE location_id = 1;

-- ========================================
-- 3.3 INEQUALITY OPERATORS (!= and <>)
-- ========================================

-- Example 5: Find projects that are NOT active (using !=)
SELECT project_name, status, budget
FROM projects
WHERE status != 'ACTIVE';

-- Example 6: Same query using <> (alternative inequality operator)
SELECT project_name, status, budget
FROM projects
WHERE status <> 'ACTIVE';

-- Both != and <> mean "not equal to" - use whichever you prefer

-- Example 7: Find employees not in Engineering department
SELECT first_name, last_name, job_title, department_id
FROM employees
WHERE department_id != 1;

-- ========================================
-- 3.4 GREATER THAN (>) and GREATER THAN OR EQUAL (>=)
-- ========================================

-- Example 8: Find projects with budget greater than $100,000
SELECT project_name, budget, status
FROM projects
WHERE budget > 100000;

-- Example 9: Find projects with budget >= $150,000
SELECT project_name, budget, status
FROM projects
WHERE budget >= 150000;

-- Example 10: Find employees hired after 2021
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > '2021-01-01';

-- Example 11: Find departments with budget >= $500,000
SELECT department_name, budget
FROM departments
WHERE budget >= 500000;

-- ========================================
-- 3.5 LESS THAN (<) and LESS THAN OR EQUAL (<=)
-- ========================================

-- Example 12: Find projects with budget less than $100,000
SELECT project_name, budget, status
FROM projects
WHERE budget < 100000;

-- Example 13: Find projects with budget <= $80,000
SELECT project_name, budget, status
FROM projects
WHERE budget <= 80000;

-- Example 14: Find employees hired before 2021
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date < '2021-01-01';

-- Example 15: Find salaries less than or equal to $80,000
SELECT employee_id, salary_amount, start_date
FROM salaries
WHERE salary_amount <= 80000;

-- ========================================
-- 3.6 WORKING WITH DATES
-- ========================================

-- Example 16: Find employees hired in 2020
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '2020-01-01' AND hire_date <= '2020-12-31';

-- Example 17: Find projects starting after March 2023
SELECT project_name, start_date, status
FROM projects
WHERE start_date > '2023-03-01';

-- Example 18: Find completed projects (end date in the past)
SELECT project_name, end_date, status
FROM projects
WHERE end_date < '2023-12-31';

-- ========================================
-- 3.7 WORKING WITH NUMERIC DATA
-- ========================================

-- Example 19: Find high-budget departments (> $400,000)
SELECT department_name, budget
FROM departments
WHERE budget > 400000;

-- Example 20: Find specific employee by ID
SELECT first_name, last_name, job_title
FROM employees
WHERE employee_id = 5;

-- Example 21: Find projects with exactly $150,000 budget
SELECT project_name, budget
FROM projects
WHERE budget = 150000;

-- ========================================
-- 3.8 WORKING WITH TEXT DATA
-- ========================================

-- Example 22: Find employees with 'Manager' in job title
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title = 'Engineering Manager';

-- Example 23: Find locations in USA
SELECT city, country, address
FROM locations
WHERE country = 'USA';

-- Example 24: Find specific department
SELECT *
FROM departments
WHERE department_name = 'Marketing';

-- ========================================
-- 3.9 COMBINING SELECT WITH WHERE
-- ========================================

-- Example 25: Get specific columns for filtered data
SELECT project_name, budget
FROM projects
WHERE status = 'COMPLETED';

-- Example 26: Filter and select relevant employee info
SELECT first_name, last_name, email, hire_date
FROM employees
WHERE department_id = 2;

-- Example 27: Show project details for active projects
SELECT project_name, start_date, end_date, budget
FROM projects
WHERE status = 'ACTIVE';

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Try these exercises:

1. Find all employees in department 3 (Sales)

2. Find all projects with budget greater than $200,000

3. Find employees hired before 2020

4. Find departments with budget less than $500,000

5. Find all locations in Europe (UK and Germany)

6. Find projects that are in PLANNING status

7. Find employees with employee_id greater than 8

8. Find salaries greater than $90,000

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. Employees in Sales department
SELECT first_name, last_name, job_title
FROM employees
WHERE department_id = 3;

-- 2. High budget projects
SELECT project_name, budget, status
FROM projects
WHERE budget > 200000;

-- 3. Employees hired before 2020
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date < '2020-01-01';

-- 4. Lower budget departments
SELECT department_name, budget
FROM departments
WHERE budget < 500000;

-- 5. European locations
SELECT city, country
FROM locations
WHERE country = 'UK'
   OR country = 'Germany';

-- 6. Projects in planning
SELECT project_name, status
FROM projects
WHERE status = 'PLANNING';

-- 7. Employees with higher IDs
SELECT first_name, last_name, employee_id
FROM employees
WHERE employee_id > 8;

-- 8. High salaries
SELECT employee_id, salary_amount
FROM salaries
WHERE salary_amount > 90000;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. WHERE clause filters rows based on conditions
2. = tests for equality
3. != and <> test for inequality  
4. >, >= test for greater than (or equal)
5. <, <= test for less than (or equal)
6. Conditions work with text, numbers, and dates
7. Only rows meeting the condition are returned

✅ Next lesson: 04_logical_operators.sql
   We'll learn AND, OR, NOT, IN, BETWEEN, LIKE, and IS NULL!
*/

SELECT 'Lesson 3 Complete! 🎉' as status;
SELECT 'Next: 04_logical_operators.sql' as next_lesson; 