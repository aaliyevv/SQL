-- ========================================
-- LESSON 4: Logical Operators
-- ========================================
-- Learning Objectives:
-- 1. Learn AND, OR, NOT operators
-- 2. Master IN operator for multiple values
-- 3. Use BETWEEN for range queries
-- 4. Apply LIKE for pattern matching
-- 5. Handle NULL values with IS NULL/IS NOT NULL

-- ========================================
-- 4.1 AND OPERATOR
-- ========================================

/*
AND operator requires ALL conditions to be true.
If any condition is false, the row is not returned.

Syntax: WHERE condition1 AND condition2 AND condition3...
*/

-- Example 1: Find employees in Engineering (dept 1) hired after 2020
SELECT first_name, last_name, hire_date, department_id
FROM employees
WHERE department_id = 1 AND hire_date > '2020-01-01';

-- Example 2: Find active projects with budget > $100,000
SELECT project_name, status, budget
FROM projects
WHERE status = 'ACTIVE' AND budget > 100000;

-- Example 3: Find departments in USA with budget > $300,000
SELECT d.department_name, d.budget, l.country
FROM departments d, locations l
WHERE d.location_id = l.location_id 
  AND l.country = 'USA' 
  AND d.budget > 300000;

-- Example 4: Multiple AND conditions
SELECT first_name, last_name, job_title, hire_date
FROM employees
WHERE department_id = 1 
  AND hire_date >= '2021-01-01' 
  AND hire_date <= '2022-12-31';

-- ========================================
-- 4.2 OR OPERATOR
-- ========================================

/*
OR operator requires AT LEAST ONE condition to be true.
If any condition is true, the row is returned.

Syntax: WHERE condition1 OR condition2 OR condition3...
*/

-- Example 5: Find employees in Engineering OR Marketing departments
SELECT first_name, last_name, job_title, department_id
FROM employees
WHERE department_id = 1 OR department_id = 2;

-- Example 6: Find projects that are ACTIVE OR COMPLETED
SELECT project_name, status, budget
FROM projects
WHERE status = 'ACTIVE' OR status = 'COMPLETED';

-- Example 7: Find employees with 'Manager' OR 'Director' in title
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title LIKE '%Manager%' OR job_title LIKE '%Director%';

-- Example 8: Find locations in USA OR UK
SELECT city, country, address
FROM locations
WHERE country = 'USA' OR country = 'UK';

-- ========================================
-- 4.3 COMBINING AND & OR (Use Parentheses!)
-- ========================================

/*
When combining AND and OR, use parentheses to make your logic clear.
Without parentheses, AND has higher precedence than OR.
*/

-- Example 9: Find employees in (Engineering OR Marketing) AND hired after 2020
SELECT first_name, last_name, job_title, department_id, hire_date
FROM employees
WHERE (department_id = 1 OR department_id = 2) 
  AND hire_date > '2020-01-01';

-- Example 10: Find (ACTIVE projects with budget > $100k) OR (COMPLETED projects)
SELECT project_name, status, budget
FROM projects
WHERE (status = 'ACTIVE' AND budget > 100000) 
   OR status = 'COMPLETED';

-- ========================================
-- 4.4 NOT OPERATOR
-- ========================================

/*
NOT operator negates a condition.
It returns rows where the condition is FALSE.
*/

-- Example 11: Find employees NOT in Engineering department
SELECT first_name, last_name, job_title, department_id
FROM employees
WHERE NOT department_id = 1;

-- Example 12: Find projects that are NOT active
SELECT project_name, status, budget
FROM projects
WHERE NOT status = 'ACTIVE';

-- Example 13: Employees NOT hired in 2020
SELECT first_name, last_name, hire_date
FROM employees
WHERE NOT (hire_date >= '2020-01-01' AND hire_date <= '2020-12-31');

-- ========================================
-- 4.5 IN OPERATOR
-- ========================================

/*
IN operator lets you specify multiple values in a WHERE clause.
It's shorthand for multiple OR conditions.

WHERE column IN (value1, value2, value3)
is equivalent to:
WHERE column = value1 OR column = value2 OR column = value3
*/

-- Example 14: Find employees in Engineering, Marketing, or Sales
SELECT first_name, last_name, job_title, department_id
FROM employees
WHERE department_id IN (1, 2, 3);

-- Example 15: Find projects with specific statuses
SELECT project_name, status, budget
FROM projects
WHERE status IN ('ACTIVE', 'COMPLETED');

-- Example 16: Find locations in multiple countries
SELECT city, country
FROM locations
WHERE country IN ('USA', 'UK', 'Japan');

-- Example 17: Find employees with specific job titles
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title IN ('Senior Developer', 'Marketing Director', 'Sales Manager');

-- Example 18: NOT IN - exclude specific values
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id NOT IN (1, 2);

-- ========================================
-- 4.6 BETWEEN OPERATOR
-- ========================================

/*
BETWEEN operator selects values within a range (inclusive).
BETWEEN value1 AND value2 includes both endpoints.

WHERE column BETWEEN value1 AND value2
is equivalent to:
WHERE column >= value1 AND column <= value2
*/

-- Example 19: Find projects with budget between $50,000 and $200,000
SELECT project_name, budget, status
FROM projects
WHERE budget BETWEEN 50000 AND 200000;

-- Example 20: Find employees hired between 2020 and 2021
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-12-31';

-- Example 21: Find salaries between $70,000 and $90,000
SELECT employee_id, salary_amount, start_date
FROM salaries
WHERE salary_amount BETWEEN 70000 AND 90000;

-- Example 22: NOT BETWEEN - exclude a range
SELECT project_name, budget
FROM projects
WHERE budget NOT BETWEEN 100000 AND 200000;

-- ========================================
-- 4.7 LIKE OPERATOR (Pattern Matching)
-- ========================================

/*
LIKE operator is used for pattern matching in text.
Wildcards:
- % matches any sequence of characters (including zero characters)
- _ matches exactly one character
*/

-- Example 23: Find employees whose first name starts with 'J'
SELECT first_name, last_name, job_title
FROM employees
WHERE first_name LIKE 'J%';

-- Example 24: Find employees whose last name ends with 'son'
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%son';

-- Example 25: Find employees with 'Manager' anywhere in job title
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title LIKE '%Manager%';

-- Example 26: Find projects with 'App' in the name
SELECT project_name, status
FROM projects
WHERE project_name LIKE '%App%';

-- Example 27: Find emails from company.com domain
SELECT first_name, last_name, email
FROM employees
WHERE email LIKE '%@company.com';

-- Example 28: Using underscore - find employees with 4-letter first names
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '____';  -- 4 underscores = exactly 4 characters

-- Example 29: NOT LIKE - exclude patterns
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title NOT LIKE '%Manager%';

-- ========================================
-- 4.8 IS NULL and IS NOT NULL
-- ========================================

/*
NULL represents missing or unknown data.
You cannot use = or != with NULL values.
Use IS NULL or IS NOT NULL instead.
*/

-- First, let's add some NULL values for demonstration
UPDATE employees SET phone = NULL WHERE employee_id IN (3, 7);

-- Example 30: Find employees with missing phone numbers
SELECT first_name, last_name, phone
FROM employees
WHERE phone IS NULL;

-- Example 31: Find employees with phone numbers
SELECT first_name, last_name, phone
FROM employees
WHERE phone IS NOT NULL;

-- Example 32: Find current salaries (end_date is NULL)
SELECT employee_id, salary_amount, start_date, end_date
FROM salaries
WHERE end_date IS NULL;

-- Example 33: Find historical salaries (end_date is not NULL)
SELECT employee_id, salary_amount, start_date, end_date
FROM salaries
WHERE end_date IS NOT NULL;

-- Clean up our demo NULL values
UPDATE employees SET phone = '555-0103' WHERE employee_id = 3;
UPDATE employees SET phone = '555-0107' WHERE employee_id = 7;

-- ========================================
-- 4.9 COMPLEX COMBINATIONS
-- ========================================

-- Example 34: Complex query combining multiple operators
SELECT first_name, last_name, job_title, hire_date, department_id
FROM employees
WHERE (department_id IN (1, 2, 3))
  AND (hire_date BETWEEN '2020-01-01' AND '2022-12-31')
  AND (job_title LIKE '%Developer%' OR job_title LIKE '%Manager%')
  AND first_name NOT LIKE 'D%';

-- Example 35: Another complex example
SELECT project_name, status, budget, start_date
FROM projects
WHERE (status IN ('ACTIVE', 'PLANNING'))
  AND (budget BETWEEN 100000 AND 300000)
  AND (start_date >= '2023-01-01')
  AND project_name NOT LIKE '%Audit%';

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Try these exercises:

1. Find employees in HR (dept 4) OR Finance (dept 5) departments

2. Find projects with budget between $80,000 and $150,000

3. Find employees whose last name starts with 'W' or 'B'

4. Find active projects with budget NOT between $50,000 and $100,000

5. Find employees hired in 2021 AND working in departments 1, 2, or 3

6. Find projects whose name contains 'System' OR 'App'

7. Find employees whose job title contains 'Developer' but NOT 'Senior'

8. Find current salaries (end_date IS NULL) greater than $85,000

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. HR or Finance employees
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id = 4 OR department_id = 5;
-- Alternative: WHERE department_id IN (4, 5);

-- 2. Projects in budget range
SELECT project_name, budget, status
FROM projects
WHERE budget BETWEEN 80000 AND 150000;

-- 3. Last names starting with W or B
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'W%' OR last_name LIKE 'B%';

-- 4. Active projects outside budget range
SELECT project_name, budget, status
FROM projects
WHERE status = 'ACTIVE' 
  AND budget NOT BETWEEN 50000 AND 100000;

-- 5. 2021 hires in specific departments
SELECT first_name, last_name, hire_date, department_id
FROM employees
WHERE hire_date BETWEEN '2021-01-01' AND '2021-12-31'
  AND department_id IN (1, 2, 3);

-- 6. Projects with System or App
SELECT project_name, status
FROM projects
WHERE project_name LIKE '%System%' OR project_name LIKE '%App%';

-- 7. Developers but not Senior
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title LIKE '%Developer%' 
  AND job_title NOT LIKE '%Senior%';

-- 8. High current salaries
SELECT employee_id, salary_amount, start_date
FROM salaries
WHERE end_date IS NULL AND salary_amount > 85000;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. AND requires ALL conditions to be true
2. OR requires AT LEAST ONE condition to be true
3. NOT negates a condition
4. IN checks for multiple possible values
5. BETWEEN checks for ranges (inclusive)
6. LIKE does pattern matching with % and _
7. IS NULL/IS NOT NULL handle missing data
8. Use parentheses to clarify complex logic

✅ Next lesson: 05_sorting_distinct.sql
   We'll learn ORDER BY and DISTINCT!
*/

SELECT 'Lesson 4 Complete! 🎉' as status;
SELECT 'Next: 05_sorting_distinct.sql' as next_lesson; 