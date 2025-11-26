-- ========================================
-- LESSON 5: Sorting and Distinct Values
-- ========================================
-- Learning Objectives:
-- 1. Learn ORDER BY for sorting results
-- 2. Sort by multiple columns
-- 3. Use ASC (ascending) and DESC (descending)
-- 4. Understand DISTINCT for unique values
-- 5. Combine DISTINCT with ORDER BY

-- ========================================
-- 5.1 BASIC SORTING with ORDER BY
-- ========================================

/*
ORDER BY sorts the result set by one or more columns.
Default sort order is ASCENDING (ASC).

Syntax:
    SELECT columns
    FROM table
    WHERE conditions
    ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...
*/

-- Example 1: Sort employees by last name (ascending - default)
SELECT first_name, last_name, job_title
FROM employees
ORDER BY last_name;

-- Example 2: Sort employees by last name explicitly ascending
SELECT first_name, last_name, job_title
FROM employees
ORDER BY last_name ASC;

-- Example 3: Sort employees by hire date (newest first)
SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC;

-- Example 4: Sort projects by budget (highest first)
SELECT project_name, budget, status
FROM projects
ORDER BY budget DESC;

-- ========================================
-- 5.2 SORTING BY MULTIPLE COLUMNS
-- ========================================

/*
You can sort by multiple columns. SQL sorts by the first column,
then by the second column for rows with the same first column value, etc.
*/

-- Example 5: Sort by department, then by last name within department
SELECT first_name, last_name, department_id, job_title
FROM employees
ORDER BY department_id, last_name;

-- Example 6: Sort by department (ascending), then by hire date (newest first)
SELECT first_name, last_name, department_id, hire_date
FROM employees
ORDER BY department_id ASC, hire_date DESC;

-- Example 7: Sort projects by status, then by budget (highest first)
SELECT project_name, status, budget
FROM projects
ORDER BY status, budget DESC;

-- Example 8: Sort salaries by employee, then by start date (newest first)
SELECT employee_id, salary_amount, start_date, end_date
FROM salaries
ORDER BY employee_id, start_date DESC;

-- ========================================
-- 5.3 SORTING WITH WHERE CLAUSES
-- ========================================

-- Example 9: Find Engineering employees, sorted by hire date
SELECT first_name, last_name, hire_date, job_title
FROM employees
WHERE department_id = 1
ORDER BY hire_date;

-- Example 10: Find active projects, sorted by budget (highest first)
SELECT project_name, budget, start_date
FROM projects
WHERE status = 'ACTIVE'
ORDER BY budget DESC;

-- Example 11: Find employees hired after 2020, sorted by department then name
SELECT first_name, last_name, department_id, hire_date
FROM employees
WHERE hire_date > '2020-01-01'
ORDER BY department_id, last_name;

-- ========================================
-- 5.4 SORTING BY COLUMN POSITION
-- ========================================

/*
You can reference columns by their position number in the SELECT clause.
This is useful for complex expressions but less readable.
*/

-- Example 12: Sort by the 3rd column (hire_date)
SELECT first_name, last_name, hire_date, job_title
FROM employees
ORDER BY 3 DESC;

-- Example 13: Sort by multiple positions
SELECT first_name, last_name, department_id, hire_date
FROM employees
ORDER BY 3, 2;  -- department_id, then last_name

-- ========================================
-- 5.5 DISTINCT - Removing Duplicates
-- ========================================

/*
DISTINCT removes duplicate rows from the result set.
It applies to the entire SELECT clause.
*/

-- Example 14: Get unique department IDs
SELECT DISTINCT department_id
FROM employees;

-- Example 15: Get unique job titles
SELECT DISTINCT job_title
FROM employees
ORDER BY job_title;

-- Example 16: Get unique project statuses
SELECT DISTINCT status
FROM projects;

-- Example 17: Get unique countries
SELECT DISTINCT country
FROM locations
ORDER BY country;

-- ========================================
-- 5.6 DISTINCT with Multiple Columns
-- ========================================

/*
When using DISTINCT with multiple columns, it considers
the combination of values to determine uniqueness.
*/

-- Example 18: Get unique combinations of department and job title
SELECT DISTINCT department_id, job_title
FROM employees
ORDER BY department_id, job_title;

-- Example 19: Get unique combinations of status and budget ranges
SELECT DISTINCT status, 
       CASE 
           WHEN budget < 100000 THEN 'Low'
           WHEN budget BETWEEN 100000 AND 200000 THEN 'Medium'
           ELSE 'High'
       END as budget_category
FROM projects
ORDER BY status;

-- Example 20: Get unique employee-department combinations (should be same as just employees)
SELECT DISTINCT employee_id, department_id
FROM employees
ORDER BY employee_id;

-- ========================================
-- 5.7 COMBINING DISTINCT with WHERE
-- ========================================

-- Example 21: Get unique job titles in Engineering department
SELECT DISTINCT job_title
FROM employees
WHERE department_id = 1
ORDER BY job_title;

-- Example 22: Get unique project statuses for projects after 2023
SELECT DISTINCT status
FROM projects
WHERE start_date >= '2023-01-01';

-- Example 23: Get unique cities in USA
SELECT DISTINCT city
FROM locations
WHERE country = 'USA'
ORDER BY city;

-- ========================================
-- 5.8 SORTING TEXT DATA
-- ========================================

-- Example 24: Sort departments by name alphabetically
SELECT department_name, budget
FROM departments
ORDER BY department_name;

-- Example 25: Sort projects by name (reverse alphabetical)
SELECT project_name, status, budget
FROM projects
ORDER BY project_name DESC;

-- Example 26: Sort by job title, then by last name
SELECT first_name, last_name, job_title
FROM employees
ORDER BY job_title, last_name;

-- ========================================
-- 5.9 SORTING NULL VALUES
-- ========================================

/*
NULL values in ORDER BY:
- With ASC: NULLs typically appear last
- With DESC: NULLs typically appear first
(Behavior can vary by database system)
*/

-- Example 27: Sort salaries by end_date (NULLs will appear first with DESC)
SELECT employee_id, salary_amount, start_date, end_date
FROM salaries
ORDER BY end_date DESC;

-- Example 28: Sort salaries by end_date ascending (NULLs appear last)
SELECT employee_id, salary_amount, start_date, end_date
FROM salaries
ORDER BY end_date ASC;

-- ========================================
-- 5.10 PRACTICAL COMBINATIONS
-- ========================================

-- Example 29: Get unique departments with their budgets, sorted by budget
SELECT DISTINCT d.department_name, d.budget
FROM departments d
ORDER BY d.budget DESC;

-- Example 30: Find unique combinations of country and city, sorted
SELECT DISTINCT country, city
FROM locations
ORDER BY country, city;

-- Example 31: Active projects sorted by start date, then budget
SELECT project_name, start_date, budget, status
FROM projects
WHERE status = 'ACTIVE'
ORDER BY start_date, budget DESC;

-- Example 32: Employee report: unique job titles per department
SELECT DISTINCT department_id, job_title
FROM employees
WHERE department_id IN (1, 2, 3)
ORDER BY department_id, job_title;

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Try these exercises:

1. Get all employees sorted by hire date (newest first)

2. Get unique countries from locations, sorted alphabetically

3. Find employees in departments 1-3, sorted by department then last name

4. Get projects sorted by status, then by budget (highest first)

5. Find unique job titles that contain 'Manager', sorted alphabetically

6. Get all salaries sorted by employee_id, then by start_date (newest first)

7. Find unique department names where budget > $300,000, sorted by name

8. Get employees hired in 2021, sorted by last name

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. Employees by hire date (newest first)
SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC;

-- 2. Unique countries sorted
SELECT DISTINCT country
FROM locations
ORDER BY country;

-- 3. Employees in depts 1-3, sorted by dept then name
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN (1, 2, 3)
ORDER BY department_id, last_name;

-- 4. Projects sorted by status, then budget
SELECT project_name, status, budget
FROM projects
ORDER BY status, budget DESC;

-- 5. Unique Manager job titles
SELECT DISTINCT job_title
FROM employees
WHERE job_title LIKE '%Manager%'
ORDER BY job_title;

-- 6. Salaries sorted by employee, then date
SELECT employee_id, salary_amount, start_date, end_date
FROM salaries
ORDER BY employee_id, start_date DESC;

-- 7. High-budget department names
SELECT DISTINCT department_name
FROM departments
WHERE budget > 300000
ORDER BY department_name;

-- 8. 2021 employees by last name
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2021-01-01' AND '2021-12-31'
ORDER BY last_name;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. ORDER BY sorts results in ascending (ASC) or descending (DESC) order
2. You can sort by multiple columns
3. ASC is the default sort order
4. DISTINCT removes duplicate rows
5. DISTINCT works with multiple columns (considers combinations)
6. You can combine WHERE, DISTINCT, and ORDER BY
7. NULL values have special sorting behavior
8. Column positions can be used in ORDER BY (but names are clearer)

✅ Next lesson: 06_aggregate_functions.sql
   We'll learn COUNT, SUM, AVG, MIN, MAX!
*/

SELECT 'Lesson 5 Complete! 🎉' as status;
SELECT 'Next: 06_aggregate_functions.sql' as next_lesson; 