-- ========================================
-- LESSON 10: INNER JOIN
-- ========================================
-- Learning Objectives:
-- 1. Understand what INNER JOIN does
-- 2. Learn INNER JOIN syntax
-- 3. Master joining two tables
-- 4. Practice multiple INNER JOINs
-- 5. Combine JOINs with WHERE, ORDER BY, GROUP BY

-- ========================================
-- 10.1 WHAT IS INNER JOIN?
-- ========================================

/*
INNER JOIN returns only rows that have matching values in BOTH tables.
If there's no match, the row is excluded from the result.

Syntax:
    SELECT columns
    FROM table1
    INNER JOIN table2 ON table1.column = table2.column

Key points:
- Only matching rows are returned
- No NULLs for unmatched records
- Most restrictive JOIN type
- Most commonly used JOIN
*/

-- ========================================
-- 10.2 BASIC INNER JOIN - Two Tables
-- ========================================

-- Example 1: Employees with their department names
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- Note: INNER keyword is optional - these are equivalent:
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Example 2: Projects with their department names
SELECT 
    p.project_name,
    p.status,
    p.budget,
    d.department_name
FROM projects p
INNER JOIN departments d ON p.department_id = d.department_id;

-- Example 3: Departments with their location information
SELECT 
    d.department_name,
    d.budget,
    l.city,
    l.country
FROM departments d
INNER JOIN locations l ON d.location_id = l.location_id;

-- ========================================
-- 10.3 INNER JOIN with WHERE Clause
-- ========================================

-- Example 4: Engineering employees with department info
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    d.department_name,
    d.budget
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';

-- Example 5: Active projects with department names
SELECT 
    p.project_name,
    p.budget,
    p.start_date,
    d.department_name
FROM projects p
INNER JOIN departments d ON p.department_id = d.department_id
WHERE p.status = 'ACTIVE';

-- Example 6: High-budget projects with department and location
SELECT 
    p.project_name,
    p.budget,
    d.department_name,
    l.city
FROM projects p
INNER JOIN departments d ON p.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE p.budget > 100000;

-- ========================================
-- 10.4 MULTIPLE INNER JOINs
-- ========================================

-- Example 7: Employees with department and location info
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    d.department_name,
    l.city,
    l.country
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;

-- Example 8: Employee salary information with names
SELECT 
    e.first_name,
    e.last_name,
    s.salary_amount,
    s.start_date,
    s.end_date
FROM employees e
INNER JOIN salaries s ON e.employee_id = s.employee_id
ORDER BY e.last_name, s.start_date DESC;

-- Example 9: Current employees with current salaries and department info
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    s.salary_amount,
    d.department_name
FROM employees e
INNER JOIN salaries s ON e.employee_id = s.employee_id
INNER JOIN departments d ON e.department_id = d.department_id
WHERE s.end_date IS NULL  -- Current salary
ORDER BY s.salary_amount DESC;

-- ========================================
-- 10.5 INNER JOIN with Aggregate Functions
-- ========================================

-- Example 10: Employee count by department (using JOIN)
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY employee_count DESC;

-- Example 11: Total salary cost by department
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count,
    SUM(s.salary_amount) as total_salary_cost,
    AVG(s.salary_amount) as average_salary
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL  -- Current salaries only
GROUP BY d.department_id, d.department_name
ORDER BY total_salary_cost DESC;

-- Example 12: Project budget by location
SELECT 
    l.city,
    l.country,
    COUNT(p.project_id) as project_count,
    SUM(p.budget) as total_budget,
    AVG(p.budget) as average_budget
FROM locations l
INNER JOIN departments d ON l.location_id = d.location_id
INNER JOIN projects p ON d.department_id = p.department_id
GROUP BY l.location_id, l.city, l.country
ORDER BY total_budget DESC;

-- ========================================
-- 10.6 INNER JOIN with Many-to-Many Relationships
-- ========================================

-- Example 13: Employees and their project assignments
SELECT 
    e.first_name,
    e.last_name,
    p.project_name,
    ep.role,
    ep.hours_allocated
FROM employees e
INNER JOIN employee_projects ep ON e.employee_id = ep.employee_id
INNER JOIN projects p ON ep.project_id = p.project_id
ORDER BY e.last_name, p.project_name;

-- Example 14: Project teams (employees working on each project)
SELECT 
    p.project_name,
    p.status,
    e.first_name,
    e.last_name,
    ep.role,
    d.department_name
FROM projects p
INNER JOIN employee_projects ep ON p.project_id = ep.project_id
INNER JOIN employees e ON ep.employee_id = e.employee_id
INNER JOIN departments d ON e.department_id = d.department_id
ORDER BY p.project_name, ep.role;

-- Example 15: Employee workload (total hours across all projects)
SELECT 
    e.first_name,
    e.last_name,
    COUNT(ep.project_id) as project_count,
    SUM(ep.hours_allocated) as total_hours
FROM employees e
INNER JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_hours DESC;

-- ========================================
-- 10.7 SELF JOIN (Special INNER JOIN)
-- ========================================

-- Example 16: Employees with their managers
SELECT 
    emp.first_name as employee_first_name,
    emp.last_name as employee_last_name,
    emp.job_title as employee_title,
    mgr.first_name as manager_first_name,
    mgr.last_name as manager_last_name,
    mgr.job_title as manager_title
FROM employees emp
INNER JOIN employees mgr ON emp.manager_id = mgr.employee_id;

-- Example 17: Count of direct reports per manager
SELECT 
    mgr.first_name as manager_first_name,
    mgr.last_name as manager_last_name,
    COUNT(emp.employee_id) as direct_reports
FROM employees mgr
INNER JOIN employees emp ON mgr.employee_id = emp.manager_id
GROUP BY mgr.employee_id, mgr.first_name, mgr.last_name
ORDER BY direct_reports DESC;

-- ========================================
-- 10.8 COMPLEX INNER JOIN Examples
-- ========================================

-- Example 18: Complete employee information
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    e.hire_date,
    d.department_name,
    l.city as office_city,
    s.salary_amount as current_salary,
    mgr.first_name as manager_first_name,
    mgr.last_name as manager_last_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
LEFT JOIN employees mgr ON e.manager_id = mgr.employee_id  -- LEFT JOIN for managers (some employees have no manager)
ORDER BY d.department_name, e.last_name;

-- Example 19: Project performance analysis
SELECT 
    p.project_name,
    p.status,
    p.budget,
    d.department_name,
    l.city,
    COUNT(ep.employee_id) as team_size,
    SUM(ep.hours_allocated) as total_hours,
    ROUND(p.budget / SUM(ep.hours_allocated), 2) as budget_per_hour
FROM projects p
INNER JOIN departments d ON p.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, p.status, p.budget, d.department_name, l.city
ORDER BY budget_per_hour DESC;

-- ========================================
-- 10.9 INNER JOIN vs WHERE (Traditional)
-- ========================================

-- Example 20: Same query written two ways

-- Modern INNER JOIN syntax
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.budget > 500000;

-- Traditional WHERE syntax (equivalent result)
SELECT e.first_name, e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
  AND d.budget > 500000;

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Practice INNER JOINs with these exercises:

1. Show all employees with their department names and office cities

2. Find all active projects with their department names

3. Show employees working on the 'Mobile App Development' project

4. Get employee names, job titles, and current salaries for Engineering department

5. Count the number of projects per department (show department names)

6. Find all employees who have managers (show employee and manager names)

7. Show project names with their team sizes (count of assigned employees)

8. Get the total budget for all projects by city

9. Find employees hired after 2020 with their department and location info

10. Show the highest paid employee in each department with full details

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. Employees with departments and cities
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    l.city
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;

-- 2. Active projects with department names
SELECT 
    p.project_name,
    p.budget,
    d.department_name
FROM projects p
INNER JOIN departments d ON p.department_id = d.department_id
WHERE p.status = 'ACTIVE';

-- 3. Employees on Mobile App Development project
SELECT 
    e.first_name,
    e.last_name,
    ep.role
FROM employees e
INNER JOIN employee_projects ep ON e.employee_id = ep.employee_id
INNER JOIN projects p ON ep.project_id = p.project_id
WHERE p.project_name = 'Mobile App Development';

-- 4. Engineering employees with current salaries
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    s.salary_amount
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE d.department_name = 'Engineering' AND s.end_date IS NULL;

-- 5. Project count by department
SELECT 
    d.department_name,
    COUNT(p.project_id) as project_count
FROM departments d
INNER JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name;

-- 6. Employees with their managers
SELECT 
    emp.first_name as employee_name,
    emp.last_name as employee_surname,
    mgr.first_name as manager_name,
    mgr.last_name as manager_surname
FROM employees emp
INNER JOIN employees mgr ON emp.manager_id = mgr.employee_id;

-- 7. Projects with team sizes
SELECT 
    p.project_name,
    COUNT(ep.employee_id) as team_size
FROM projects p
INNER JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name
ORDER BY team_size DESC;

-- 8. Total project budget by city
SELECT 
    l.city,
    SUM(p.budget) as total_budget
FROM locations l
INNER JOIN departments d ON l.location_id = d.location_id
INNER JOIN projects p ON d.department_id = p.department_id
GROUP BY l.location_id, l.city;

-- 9. Recent hires with location info
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    d.department_name,
    l.city
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE e.hire_date > '2020-01-01'
ORDER BY e.hire_date DESC;

-- 10. Highest paid employee per department
SELECT 
    d.department_name,
    e.first_name,
    e.last_name,
    s.salary_amount,
    l.city
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
  AND s.salary_amount = (
    SELECT MAX(s2.salary_amount)
    FROM salaries s2
    INNER JOIN employees e2 ON s2.employee_id = e2.employee_id
    WHERE e2.department_id = e.department_id AND s2.end_date IS NULL
  )
ORDER BY s.salary_amount DESC;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. INNER JOIN returns only matching rows from both tables
2. Syntax: FROM table1 INNER JOIN table2 ON condition
3. INNER keyword is optional (JOIN = INNER JOIN)
4. Can join multiple tables by chaining JOINs
5. Combine with WHERE, GROUP BY, ORDER BY, aggregates
6. Self-joins allow joining a table to itself
7. Most restrictive JOIN type - no unmatched rows
8. Most commonly used JOIN in practice

✅ Next lesson: 11_left_join.sql
   We'll learn LEFT JOIN to include unmatched rows!
*/

SELECT 'Lesson 10 Complete! 🎉' as status;
SELECT 'Next: 11_left_join.sql' as next_lesson; 