-- ========================================
-- LESSON 11: LEFT JOIN (LEFT OUTER JOIN)
-- ========================================
-- Learning Objectives:
-- 1. Understand what LEFT JOIN does
-- 2. Learn when to use LEFT JOIN vs INNER JOIN
-- 3. Practice finding unmatched records
-- 4. Master NULL handling in LEFT JOINs
-- 5. Combine LEFT JOINs with aggregates

-- ========================================
-- 11.1 WHAT IS LEFT JOIN?
-- ========================================

/*
LEFT JOIN returns ALL rows from the left table, and matching rows from the right table.
If no match is found, NULL values are returned for right table columns.

Syntax:
    SELECT columns
    FROM left_table
    LEFT JOIN right_table ON left_table.column = right_table.column

Key points:
- ALL rows from left table are included
- Matching rows from right table are included
- NULL values for non-matching right table columns
- More inclusive than INNER JOIN
*/

-- ========================================
-- 11.2 LEFT JOIN vs INNER JOIN Comparison
-- ========================================

-- First, let's see what we get with INNER JOIN
SELECT 'INNER JOIN - Only matching records:' as join_type;
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

-- Now with LEFT JOIN - includes all departments
SELECT 'LEFT JOIN - All left table records:' as join_type;
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

-- ========================================
-- 11.3 BASIC LEFT JOIN Examples
-- ========================================

-- Example 1: All departments with their employees (including empty departments)
SELECT 
    d.department_name,
    e.first_name,
    e.last_name,
    e.job_title
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
ORDER BY d.department_name, e.last_name;

-- Example 2: All employees with their project assignments (including those not on projects)
SELECT 
    e.first_name,
    e.last_name,
    p.project_name,
    ep.role
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
LEFT JOIN projects p ON ep.project_id = p.project_id
ORDER BY e.last_name, p.project_name;

-- Example 3: All projects with their team members (including projects with no team)
SELECT 
    p.project_name,
    p.status,
    e.first_name,
    e.last_name,
    ep.role
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON ep.employee_id = e.employee_id
ORDER BY p.project_name, e.last_name;

-- ========================================
-- 11.4 FINDING UNMATCHED RECORDS
-- ========================================

-- Example 4: Departments with NO employees
SELECT 
    d.department_name,
    d.budget
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- Example 5: Employees NOT assigned to any projects
SELECT 
    e.first_name,
    e.last_name,
    e.job_title
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL;

-- Example 6: Projects with NO team members assigned
SELECT 
    p.project_name,
    p.status,
    p.budget
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
WHERE ep.project_id IS NULL;

-- ========================================
-- 11.5 LEFT JOIN with WHERE Conditions
-- ========================================

-- Example 7: All departments in USA with their employees
SELECT 
    d.department_name,
    l.city,
    e.first_name,
    e.last_name
FROM departments d
LEFT JOIN locations l ON d.location_id = l.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE l.country = 'USA'
ORDER BY d.department_name, e.last_name;

-- Example 8: All active projects with their team members
SELECT 
    p.project_name,
    p.budget,
    e.first_name,
    e.last_name,
    ep.role
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON ep.employee_id = e.employee_id
WHERE p.status = 'ACTIVE'
ORDER BY p.project_name, e.last_name;

-- ========================================
-- 11.6 LEFT JOIN with Aggregates
-- ========================================

-- Example 9: Count employees per department (including departments with 0 employees)
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count,
    COALESCE(SUM(s.salary_amount), 0) as total_salary_cost
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY d.department_id, d.department_name
ORDER BY employee_count DESC;

-- Example 10: Average project team size (including projects with no team)
SELECT 
    p.project_name,
    p.status,
    COUNT(ep.employee_id) as team_size,
    COALESCE(SUM(ep.hours_allocated), 0) as total_hours
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, p.status
ORDER BY team_size DESC;

-- Example 11: Employee project workload (including employees with no projects)
SELECT 
    e.first_name,
    e.last_name,
    COUNT(ep.project_id) as project_count,
    COALESCE(SUM(ep.hours_allocated), 0) as total_hours
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY project_count DESC, total_hours DESC;

-- ========================================
-- 11.7 HANDLING NULL VALUES
-- ========================================

-- Example 12: Using COALESCE to handle NULLs
SELECT 
    d.department_name,
    COALESCE(e.first_name, 'No employees') as employee_name,
    COALESCE(e.job_title, 'N/A') as job_title
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
ORDER BY d.department_name, e.last_name;

-- Example 13: Using CASE to handle NULLs
SELECT 
    p.project_name,
    p.status,
    CASE 
        WHEN e.first_name IS NULL THEN 'No team assigned'
        ELSE CONCAT(e.first_name, ' ', e.last_name)
    END as team_member,
    COALESCE(ep.role, 'N/A') as role
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON ep.employee_id = e.employee_id
ORDER BY p.project_name, e.last_name;

-- ========================================
-- 11.8 MULTIPLE LEFT JOINs
-- ========================================

-- Example 14: Complete department overview
SELECT 
    d.department_name,
    l.city,
    l.country,
    COUNT(e.employee_id) as employee_count,
    COUNT(p.project_id) as project_count,
    COALESCE(SUM(s.salary_amount), 0) as total_salary_cost
FROM departments d
LEFT JOIN locations l ON d.location_id = l.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN projects p ON d.department_id = p.department_id
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY d.department_id, d.department_name, l.city, l.country
ORDER BY employee_count DESC;

-- Example 15: Employee complete profile (including those without projects/salaries)
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    e.hire_date,
    d.department_name,
    COUNT(ep.project_id) as project_count,
    COALESCE(s.salary_amount, 0) as current_salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY e.employee_id, e.first_name, e.last_name, e.job_title, e.hire_date, d.department_name, s.salary_amount
ORDER BY e.last_name;

-- ========================================
-- 11.9 LEFT JOIN for Data Quality Analysis
-- ========================================

-- Example 16: Find data inconsistencies
SELECT 'Departments without employees:' as data_quality_check;
SELECT d.department_name, d.budget
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

SELECT 'Employees without current salary:' as data_quality_check;
SELECT e.first_name, e.last_name, e.job_title
FROM employees e
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
WHERE s.salary_id IS NULL;

SELECT 'Projects without team members:' as data_quality_check;
SELECT p.project_name, p.status, p.budget
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
WHERE ep.employee_id IS NULL;

-- ========================================
-- 11.10 PRACTICAL BUSINESS SCENARIOS
-- ========================================

-- Example 17: Department utilization report
SELECT 
    d.department_name,
    d.budget as department_budget,
    COUNT(e.employee_id) as staff_count,
    COUNT(p.project_id) as active_projects,
    CASE 
        WHEN COUNT(e.employee_id) = 0 THEN 'Understaffed'
        WHEN COUNT(p.project_id) = 0 THEN 'No active projects'
        WHEN COUNT(p.project_id) > COUNT(e.employee_id) THEN 'Overloaded'
        ELSE 'Normal workload'
    END as utilization_status
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN projects p ON d.department_id = p.department_id AND p.status = 'ACTIVE'
GROUP BY d.department_id, d.department_name, d.budget
ORDER BY d.department_name;

-- Example 18: Employee engagement report
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.hire_date) as years_employed,
    COUNT(ep.project_id) as current_projects,
    CASE 
        WHEN COUNT(ep.project_id) = 0 THEN 'Not engaged in projects'
        WHEN COUNT(ep.project_id) = 1 THEN 'Single project focus'
        WHEN COUNT(ep.project_id) > 3 THEN 'High workload'
        ELSE 'Balanced workload'
    END as engagement_level
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
LEFT JOIN projects p ON ep.project_id = p.project_id AND p.status = 'ACTIVE'
GROUP BY e.employee_id, e.first_name, e.last_name, e.job_title, e.hire_date
ORDER BY current_projects DESC, e.last_name;

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Practice LEFT JOINs with these exercises:

1. Show all departments with their employee count (including departments with 0 employees)

2. Find all employees who are NOT assigned to any projects

3. List all projects and show their team size (including projects with no team)

4. Show all locations with their department count (including locations with no departments)

5. Find departments that have no active projects

6. Create a report showing all employees with their manager names (include employees without managers)

7. Show all projects with total hours allocated (including projects with 0 hours)

8. Find all employees who don't have a current salary record

9. Create a complete location summary with department and employee counts

10. Show all departments in New York with their projects (including departments with no projects)

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. All departments with employee count
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY employee_count DESC;

-- 2. Employees not assigned to projects
SELECT 
    e.first_name,
    e.last_name,
    e.job_title
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL;

-- 3. Projects with team sizes
SELECT 
    p.project_name,
    p.status,
    COUNT(ep.employee_id) as team_size
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, p.status
ORDER BY team_size DESC;

-- 4. Locations with department count
SELECT 
    l.city,
    l.country,
    COUNT(d.department_id) as department_count
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id
GROUP BY l.location_id, l.city, l.country;

-- 5. Departments with no active projects
SELECT 
    d.department_name,
    d.budget
FROM departments d
LEFT JOIN projects p ON d.department_id = p.department_id AND p.status = 'ACTIVE'
WHERE p.project_id IS NULL;

-- 6. Employees with managers (including those without)
SELECT 
    e.first_name as employee_name,
    e.last_name as employee_surname,
    COALESCE(m.first_name, 'No manager') as manager_name,
    COALESCE(m.last_name, '') as manager_surname
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.last_name;

-- 7. Projects with total hours
SELECT 
    p.project_name,
    p.status,
    COALESCE(SUM(ep.hours_allocated), 0) as total_hours
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, p.status
ORDER BY total_hours DESC;

-- 8. Employees without current salary
SELECT 
    e.first_name,
    e.last_name,
    e.job_title
FROM employees e
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
WHERE s.salary_id IS NULL;

-- 9. Complete location summary
SELECT 
    l.city,
    l.country,
    COUNT(DISTINCT d.department_id) as department_count,
    COUNT(DISTINCT e.employee_id) as employee_count
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY l.location_id, l.city, l.country
ORDER BY employee_count DESC;

-- 10. New York departments with projects
SELECT 
    d.department_name,
    COUNT(p.project_id) as project_count,
    COALESCE(SUM(p.budget), 0) as total_project_budget
FROM departments d
LEFT JOIN locations l ON d.location_id = l.location_id
LEFT JOIN projects p ON d.department_id = p.department_id
WHERE l.city = 'New York'
GROUP BY d.department_id, d.department_name;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. LEFT JOIN returns ALL rows from left table + matching from right
2. NULL values appear for non-matching right table columns
3. Perfect for finding missing/unmatched records
4. Use WHERE column IS NULL to find non-matches
5. COALESCE() and CASE help handle NULL values gracefully
6. Essential for data quality analysis and complete reporting
7. More inclusive than INNER JOIN
8. Common pattern: LEFT JOIN to include all records, then filter NULLs

✅ Next lesson: 12_right_join.sql
   We'll learn RIGHT JOIN (less common but important to understand)!
*/

SELECT 'Lesson 11 Complete! 🎉' as status;
SELECT 'Next: 12_right_join.sql' as next_lesson; 