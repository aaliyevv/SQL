-- ========================================
-- LESSON 7: Grouping Data (GROUP BY & HAVING)
-- ========================================
-- Learning Objectives:
-- 1. Understand the concept of grouping data
-- 2. Learn GROUP BY syntax and usage
-- 3. Use aggregate functions with GROUP BY
-- 4. Apply HAVING clause to filter groups
-- 5. Understand the difference between WHERE and HAVING

-- ========================================
-- 7.1 WHAT IS GROUPING?
-- ========================================

/*
GROUP BY divides rows into groups based on the values in specified columns.
Aggregate functions then operate on each group separately.

Without GROUP BY: Aggregates work on ALL rows → 1 result
With GROUP BY: Aggregates work on EACH GROUP → 1 result per group

Think of it like organizing data into separate piles, then counting/summing each pile.
*/

-- ========================================
-- 7.2 BASIC GROUP BY
-- ========================================

-- Example 1: Count employees by department
SELECT department_id, COUNT(*) as employee_count
FROM employees
GROUP BY department_id;

-- Example 2: Count projects by status
SELECT status, COUNT(*) as project_count
FROM projects
GROUP BY status;

-- Example 3: Count employees by job title
SELECT job_title, COUNT(*) as employee_count
FROM employees
GROUP BY job_title
ORDER BY employee_count DESC;

-- Example 4: Count locations by country
SELECT country, COUNT(*) as location_count
FROM locations
GROUP BY country;

-- ========================================
-- 7.3 GROUP BY with Multiple Columns
-- ========================================

-- Example 5: Count employees by department and job title
SELECT department_id, job_title, COUNT(*) as employee_count
FROM employees
GROUP BY department_id, job_title
ORDER BY department_id, job_title;

-- Example 6: Count projects by department and status
SELECT department_id, status, COUNT(*) as project_count
FROM projects
GROUP BY department_id, status
ORDER BY department_id, status;

-- ========================================
-- 7.4 GROUP BY with SUM()
-- ========================================

-- Example 7: Total budget by department
SELECT department_id, SUM(budget) as total_budget
FROM projects
GROUP BY department_id
ORDER BY total_budget DESC;

-- Example 8: Total salary by department (current salaries)
SELECT e.department_id, SUM(s.salary_amount) as total_department_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id
ORDER BY total_department_salary DESC;

-- Example 9: Total hours allocated by project
SELECT project_id, SUM(hours_allocated) as total_hours
FROM employee_projects
GROUP BY project_id
ORDER BY total_hours DESC;

-- ========================================
-- 7.5 GROUP BY with AVG()
-- ========================================

-- Example 10: Average salary by department
SELECT e.department_id, AVG(s.salary_amount) as average_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id
ORDER BY average_salary DESC;

-- Example 11: Average project budget by status
SELECT status, AVG(budget) as average_budget
FROM projects
GROUP BY status
ORDER BY average_budget DESC;

-- Example 12: Average hours allocated by project
SELECT project_id, AVG(hours_allocated) as average_hours
FROM employee_projects
GROUP BY project_id;

-- ========================================
-- 7.6 GROUP BY with MIN() and MAX()
-- ========================================

-- Example 13: Salary range by department
SELECT 
    e.department_id,
    MIN(s.salary_amount) as min_salary,
    MAX(s.salary_amount) as max_salary,
    MAX(s.salary_amount) - MIN(s.salary_amount) as salary_range
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id
ORDER BY e.department_id;

-- Example 14: Project duration analysis by status
SELECT 
    status,
    MIN(start_date) as earliest_start,
    MAX(end_date) as latest_end
FROM projects
GROUP BY status;

-- ========================================
-- 7.7 MULTIPLE AGGREGATES with GROUP BY
-- ========================================

-- Example 15: Comprehensive department analysis
SELECT 
    e.department_id,
    COUNT(*) as employee_count,
    AVG(s.salary_amount) as average_salary,
    MIN(s.salary_amount) as min_salary,
    MAX(s.salary_amount) as max_salary,
    SUM(s.salary_amount) as total_payroll
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id
ORDER BY e.department_id;

-- Example 16: Project analysis by status
SELECT 
    status,
    COUNT(*) as project_count,
    SUM(budget) as total_budget,
    AVG(budget) as average_budget,
    MIN(budget) as min_budget,
    MAX(budget) as max_budget
FROM projects
GROUP BY status
ORDER BY total_budget DESC;

-- ========================================
-- 7.8 HAVING Clause - Filtering Groups
-- ========================================

/*
HAVING filters groups AFTER grouping and aggregation.
WHERE filters rows BEFORE grouping.

WHERE → GROUP BY → Aggregation → HAVING

Use HAVING when you need to filter based on aggregate results.
*/

-- Example 17: Departments with more than 2 employees
SELECT department_id, COUNT(*) as employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Example 18: Project statuses with total budget > $200,000
SELECT status, SUM(budget) as total_budget
FROM projects
GROUP BY status
HAVING SUM(budget) > 200000;

-- Example 19: Departments with average salary > $80,000
SELECT 
    e.department_id,
    COUNT(*) as employee_count,
    AVG(s.salary_amount) as average_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id
HAVING AVG(s.salary_amount) > 80000;

-- Example 20: Projects with more than 2 team members
SELECT 
    ep.project_id,
    COUNT(*) as team_size,
    SUM(ep.hours_allocated) as total_hours
FROM employee_projects ep
GROUP BY ep.project_id
HAVING COUNT(*) > 2;

-- ========================================
-- 7.9 COMBINING WHERE and HAVING
-- ========================================

-- Example 21: Active projects by department with total budget > $150,000
SELECT 
    department_id,
    COUNT(*) as active_project_count,
    SUM(budget) as total_active_budget
FROM projects
WHERE status = 'ACTIVE'  -- Filter rows first
GROUP BY department_id
HAVING SUM(budget) > 150000  -- Filter groups after aggregation
ORDER BY total_active_budget DESC;

-- Example 22: Engineering employees hired after 2020, grouped by job title
SELECT 
    job_title,
    COUNT(*) as employee_count,
    AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM hire_date)) as avg_years_employed
FROM employees
WHERE department_id = 1 AND hire_date > '2020-01-01'  -- Filter first
GROUP BY job_title
HAVING COUNT(*) >= 1;  -- Filter groups

-- ========================================
-- 7.10 ORDER BY with GROUP BY
-- ========================================

-- Example 23: Departments ordered by employee count
SELECT department_id, COUNT(*) as employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- Example 24: Job titles ordered by average salary
SELECT 
    job_title,
    COUNT(*) as employee_count,
    AVG(s.salary_amount) as average_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY job_title
ORDER BY average_salary DESC;

-- ========================================
-- 7.11 GROUPING with DATES
-- ========================================

-- Example 25: Employees hired by year
SELECT 
    EXTRACT(YEAR FROM hire_date) as hire_year,
    COUNT(*) as employees_hired
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY hire_year;

-- Example 26: Projects by start year
SELECT 
    EXTRACT(YEAR FROM start_date) as start_year,
    COUNT(*) as projects_started,
    SUM(budget) as total_budget
FROM projects
GROUP BY EXTRACT(YEAR FROM start_date)
ORDER BY start_year;

-- ========================================
-- 7.12 COMMON GROUPING PATTERNS
-- ========================================

-- Example 27: Top departments by total salary cost
SELECT 
    e.department_id,
    COUNT(*) as employee_count,
    SUM(s.salary_amount) as total_salary_cost
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id
ORDER BY total_salary_cost DESC
LIMIT 3;

-- Example 28: Most popular job titles
SELECT 
    job_title,
    COUNT(*) as employee_count
FROM employees
GROUP BY job_title
ORDER BY employee_count DESC;

-- Example 29: Department productivity (projects per employee)
SELECT 
    d.department_name,
    COUNT(DISTINCT e.employee_id) as employee_count,
    COUNT(DISTINCT p.project_id) as project_count,
    ROUND(COUNT(DISTINCT p.project_id) * 1.0 / COUNT(DISTINCT e.employee_id), 2) as projects_per_employee
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name
ORDER BY projects_per_employee DESC;

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Try these exercises:

1. Count employees by department and show the results sorted by count (descending)

2. Find the total budget for each project status

3. Show departments with more than 1 employee

4. Calculate average salary by job title (current salaries only)

5. Find project statuses that have an average budget > $100,000

6. Count projects by department, but only show departments with > 1 project

7. Show the salary range (min and max) for each department

8. Find departments where the total current salary cost > $150,000

9. Count employees hired by year, only showing years with > 1 hire

10. Show job titles with average salary > $85,000

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. Employee count by department
SELECT department_id, COUNT(*) as employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- 2. Total budget by status
SELECT status, SUM(budget) as total_budget
FROM projects
GROUP BY status;

-- 3. Departments with > 1 employee
SELECT department_id, COUNT(*) as employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1;

-- 4. Average salary by job title
SELECT job_title, AVG(s.salary_amount) as average_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY job_title
ORDER BY average_salary DESC;

-- 5. Statuses with average budget > $100,000
SELECT status, AVG(budget) as average_budget
FROM projects
GROUP BY status
HAVING AVG(budget) > 100000;

-- 6. Departments with > 1 project
SELECT department_id, COUNT(*) as project_count
FROM projects
GROUP BY department_id
HAVING COUNT(*) > 1;

-- 7. Salary range by department
SELECT 
    e.department_id,
    MIN(s.salary_amount) as min_salary,
    MAX(s.salary_amount) as max_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id;

-- 8. Departments with high salary costs
SELECT 
    e.department_id,
    SUM(s.salary_amount) as total_salary_cost
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.department_id
HAVING SUM(s.salary_amount) > 150000;

-- 9. Hiring years with > 1 hire
SELECT 
    EXTRACT(YEAR FROM hire_date) as hire_year,
    COUNT(*) as employees_hired
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
HAVING COUNT(*) > 1
ORDER BY hire_year;

-- 10. High-paying job titles
SELECT 
    job_title,
    AVG(s.salary_amount) as average_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY job_title
HAVING AVG(s.salary_amount) > 85000
ORDER BY average_salary DESC;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. GROUP BY organizes rows into groups based on column values
2. Aggregate functions work on each group separately
3. You can group by multiple columns
4. HAVING filters groups after aggregation
5. WHERE filters rows before grouping, HAVING filters after
6. You can combine WHERE and HAVING in the same query
7. ORDER BY can sort groups by aggregate results
8. Grouping is essential for summary reporting and analysis

✅ Next lesson: 08_table_aliases.sql
   We'll learn how to use aliases for cleaner, more readable queries!
*/

SELECT 'Lesson 7 Complete! 🎉' as status;
SELECT 'Next: 08_table_aliases.sql' as next_lesson; 