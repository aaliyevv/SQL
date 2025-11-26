-- ========================================
-- LESSON 8: Table and Column Aliases
-- ========================================
-- Learning Objectives:
-- 1. Understand what aliases are and why they're useful
-- 2. Learn table aliases with AS keyword
-- 3. Use shorter table aliases for cleaner code
-- 4. Apply column aliases for better output names
-- 5. Prepare for JOINs by mastering alias usage

-- ========================================
-- 8.1 WHAT ARE ALIASES?
-- ========================================

/*
ALIASES are temporary names you give to tables or columns during a query.
They make queries more readable and are essential for JOINs.

Two types:
1. TABLE ALIASES: Shorter names for tables
2. COLUMN ALIASES: Custom names for output columns

Syntax:
    table_name AS alias_name  (or just: table_name alias_name)
    column_name AS alias_name
*/

-- ========================================
-- 8.2 BASIC TABLE ALIASES
-- ========================================

-- Example 1: Basic table alias with AS keyword
SELECT e.first_name, e.last_name, e.job_title
FROM employees AS e;

-- Example 2: Table alias without AS keyword (also valid)
SELECT e.first_name, e.last_name, e.job_title
FROM employees e;

-- Example 3: Using alias to qualify column names
SELECT e.employee_id, e.first_name, e.last_name, e.department_id
FROM employees e
WHERE e.department_id = 1;

-- Example 4: Departments with alias
SELECT d.department_name, d.budget, d.location_id
FROM departments d
ORDER BY d.budget DESC;

-- ========================================
-- 8.3 WHY USE TABLE ALIASES?
-- ========================================

/*
Benefits of table aliases:
1. Shorter, cleaner code
2. Required when joining tables with same column names
3. Clearer which table a column comes from
4. Easier to read complex queries
*/

-- Example 5: Without alias (longer, less clear)
SELECT employees.first_name, employees.last_name, employees.job_title
FROM employees
WHERE employees.department_id = 1;

-- Example 6: With alias (shorter, cleaner)
SELECT e.first_name, e.last_name, e.job_title
FROM employees e
WHERE e.department_id = 1;

-- Example 7: Projects with meaningful alias
SELECT proj.project_name, proj.status, proj.budget
FROM projects proj
WHERE proj.status = 'ACTIVE';

-- ========================================
-- 8.4 COLUMN ALIASES
-- ========================================

-- Example 8: Column aliases for better output names
SELECT 
    first_name AS employee_first_name,
    last_name AS employee_last_name,
    job_title AS position,
    hire_date AS start_date
FROM employees;

-- Example 9: Column aliases without AS keyword
SELECT 
    first_name employee_first_name,
    last_name employee_last_name,
    job_title position,
    hire_date start_date
FROM employees;

-- Example 10: Aliases for calculated columns
SELECT 
    project_name,
    budget,
    budget * 0.15 AS tax_amount,
    budget * 1.15 AS total_with_tax
FROM projects;

-- Example 11: Aggregate functions with aliases
SELECT 
    COUNT(*) AS total_employees,
    AVG(salary_amount) AS average_salary,
    MIN(salary_amount) AS minimum_salary,
    MAX(salary_amount) AS maximum_salary
FROM salaries
WHERE end_date IS NULL;

-- ========================================
-- 8.5 COMBINING TABLE AND COLUMN ALIASES
-- ========================================

-- Example 12: Both table and column aliases
SELECT 
    e.first_name AS employee_name,
    e.last_name AS family_name,
    e.job_title AS position,
    e.hire_date AS employment_start
FROM employees e
WHERE e.department_id = 1;

-- Example 13: Department analysis with aliases
SELECT 
    d.department_name AS dept_name,
    d.budget AS department_budget,
    d.location_id AS office_location
FROM departments d
ORDER BY d.budget DESC;

-- Example 14: Project summary with aliases
SELECT 
    p.project_name AS project_title,
    p.status AS current_status,
    p.budget AS allocated_budget,
    p.start_date AS launch_date
FROM projects p
WHERE p.budget > 100000;

-- ========================================
-- 8.6 ALIASES IN WHERE CLAUSES
-- ========================================

-- Example 15: Using table alias in WHERE clause
SELECT e.first_name, e.last_name, e.job_title
FROM employees e
WHERE e.hire_date > '2020-01-01'
  AND e.department_id IN (1, 2, 3);

-- Example 16: Complex WHERE with aliases
SELECT 
    p.project_name AS title,
    p.budget AS cost,
    p.status AS current_state
FROM projects p
WHERE p.status = 'ACTIVE' 
  AND p.budget BETWEEN 50000 AND 200000;

-- ========================================
-- 8.7 ALIASES WITH FUNCTIONS AND EXPRESSIONS
-- ========================================

-- Example 17: String functions with aliases
SELECT 
    UPPER(e.first_name) AS first_name_caps,
    LOWER(e.last_name) AS last_name_lower,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees e;

-- Example 18: Date functions with aliases
SELECT 
    e.first_name,
    e.hire_date,
    EXTRACT(YEAR FROM e.hire_date) AS hire_year,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.hire_date) AS years_employed
FROM employees e;

-- Example 19: Mathematical expressions with aliases
SELECT 
    p.project_name,
    p.budget,
    p.budget / 12 AS monthly_budget,
    ROUND(p.budget * 0.08, 2) AS management_fee
FROM projects p;

-- ========================================
-- 8.8 ALIASES IN GROUP BY AND ORDER BY
-- ========================================

-- Example 20: GROUP BY with table aliases
SELECT 
    e.department_id,
    COUNT(*) AS employee_count,
    AVG(s.salary_amount) AS avg_salary
FROM employees e, salaries s
WHERE e.employee_id = s.employee_id 
  AND s.end_date IS NULL
GROUP BY e.department_id
ORDER BY avg_salary DESC;

-- Example 21: Can't use column aliases in WHERE, but can in ORDER BY
SELECT 
    p.project_name AS title,
    p.budget AS cost
FROM projects p
-- WHERE cost > 100000;  -- ❌ This would cause an error
WHERE p.budget > 100000  -- ✅ Use the actual column name
ORDER BY cost DESC;      -- ✅ Can use alias in ORDER BY

-- ========================================
-- 8.9 MEANINGFUL ALIAS NAMES
-- ========================================

-- Example 22: Good vs. bad alias naming
-- Bad: unclear aliases
SELECT 
    e.first_name AS fn,
    e.last_name AS ln,
    e.job_title AS jt
FROM employees e;

-- Good: clear, meaningful aliases
SELECT 
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    e.job_title AS job_position
FROM employees e;

-- Example 23: Business-friendly column names
SELECT 
    d.department_name AS "Department Name",
    d.budget AS "Annual Budget",
    COUNT(e.employee_id) AS "Number of Employees"
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, d.budget;

-- ========================================
-- 8.10 ALIASES WITH CASE STATEMENTS
-- ========================================

-- Example 24: CASE with aliases for categorization
SELECT 
    e.first_name,
    e.last_name,
    s.salary_amount,
    CASE 
        WHEN s.salary_amount < 70000 THEN 'Entry Level'
        WHEN s.salary_amount BETWEEN 70000 AND 90000 THEN 'Mid Level'
        ELSE 'Senior Level'
    END AS salary_category
FROM employees e, salaries s
WHERE e.employee_id = s.employee_id 
  AND s.end_date IS NULL;

-- Example 25: Project status descriptions
SELECT 
    p.project_name,
    p.status,
    CASE p.status
        WHEN 'ACTIVE' THEN 'Currently in progress'
        WHEN 'COMPLETED' THEN 'Successfully finished'
        WHEN 'PLANNING' THEN 'In planning phase'
        ELSE 'Unknown status'
    END AS status_description
FROM projects p;

-- ========================================
-- 8.11 PREPARING FOR JOINS
-- ========================================

/*
Aliases become essential when working with multiple tables (JOINs).
They help distinguish columns with the same name from different tables.
*/

-- Example 26: Preview of JOIN syntax with aliases (we'll learn JOINs next!)
SELECT 
    e.first_name AS employee_name,
    e.last_name AS employee_surname,
    d.department_name AS dept_name,
    l.city AS office_city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id;

-- ========================================
-- 8.12 BEST PRACTICES FOR ALIASES
-- ========================================

-- Example 27: Consistent alias naming patterns
SELECT 
    emp.first_name AS employee_first_name,
    emp.last_name AS employee_last_name,
    dept.department_name AS department_name,
    sal.salary_amount AS current_salary
FROM employees emp, departments dept, salaries sal
WHERE emp.department_id = dept.department_id
  AND emp.employee_id = sal.employee_id
  AND sal.end_date IS NULL;

-- Example 28: Short but clear aliases
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    p.project_name,
    ep.role AS project_role
FROM employees e, departments d, projects p, employee_projects ep
WHERE e.department_id = d.department_id
  AND e.employee_id = ep.employee_id
  AND p.project_id = ep.project_id;

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Try these exercises using aliases:

1. Select employee names and job titles using table alias 'emp'

2. Create a query showing project names as 'Project Title' and budgets as 'Budget Amount'

3. Use aliases to show department names as 'Department' and their budgets as 'Annual Budget'

4. Create salary categories (Low: <70k, Medium: 70k-90k, High: >90k) with alias 'salary_level'

5. Show employee count by department with column alias 'team_size'

6. Calculate years of employment for each employee with alias 'years_with_company'

7. Show project budget divided by 1000 with alias 'budget_in_thousands'

8. Create a full name column (first + last) with alias 'employee_full_name'

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. Employee info with table alias
SELECT emp.first_name, emp.last_name, emp.job_title
FROM employees emp;

-- 2. Project info with column aliases
SELECT 
    project_name AS "Project Title",
    budget AS "Budget Amount"
FROM projects;

-- 3. Department info with aliases
SELECT 
    department_name AS "Department",
    budget AS "Annual Budget"
FROM departments;

-- 4. Salary categories
SELECT 
    e.first_name,
    e.last_name,
    s.salary_amount,
    CASE 
        WHEN s.salary_amount < 70000 THEN 'Low'
        WHEN s.salary_amount BETWEEN 70000 AND 90000 THEN 'Medium'
        ELSE 'High'
    END AS salary_level
FROM employees e, salaries s
WHERE e.employee_id = s.employee_id AND s.end_date IS NULL;

-- 5. Employee count by department
SELECT 
    department_id,
    COUNT(*) AS team_size
FROM employees
GROUP BY department_id;

-- 6. Years of employment
SELECT 
    first_name,
    last_name,
    hire_date,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM hire_date) AS years_with_company
FROM employees;

-- 7. Budget in thousands
SELECT 
    project_name,
    budget,
    ROUND(budget / 1000, 1) AS budget_in_thousands
FROM projects;

-- 8. Full name column
SELECT 
    CONCAT(first_name, ' ', last_name) AS employee_full_name,
    job_title
FROM employees;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. Aliases create temporary names for tables and columns
2. Table aliases make queries shorter and cleaner
3. Column aliases create meaningful output names
4. AS keyword is optional but recommended for clarity
5. Table aliases are essential for multi-table queries
6. Column aliases can be used in ORDER BY but not WHERE
7. Choose meaningful, consistent alias names
8. Aliases are crucial preparation for JOINs

✅ Next lesson: 09_understanding_joins.sql
   Now we'll start learning how to combine data from multiple tables!
*/

SELECT 'Lesson 8 Complete! 🎉' as status;
SELECT 'Module 1 (SQL Fundamentals) Complete! 🎓' as milestone;
SELECT 'Next: 09_understanding_joins.sql - Beginning Module 2!' as next_lesson; 