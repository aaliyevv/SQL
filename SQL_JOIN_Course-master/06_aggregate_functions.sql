-- ========================================
-- LESSON 6: Aggregate Functions
-- ========================================
-- Learning Objectives:
-- 1. Understand aggregate functions concept
-- 2. Learn COUNT() for counting rows
-- 3. Use SUM() for totaling numeric values  
-- 4. Apply AVG() for calculating averages
-- 5. Find MIN() and MAX() values
-- 6. Combine aggregates with WHERE clauses

-- ========================================
-- 6.1 WHAT ARE AGGREGATE FUNCTIONS?
-- ========================================

/*
Aggregate functions perform calculations on a set of rows 
and return a single result.

Common aggregate functions:
- COUNT(): Counts rows
- SUM(): Adds up numeric values
- AVG(): Calculates average of numeric values
- MIN(): Finds minimum value
- MAX(): Finds maximum value

They collapse multiple rows into one summary result.
*/

-- ========================================
-- 6.2 COUNT() - Counting Rows
-- ========================================

-- Example 1: Count total number of employees
SELECT COUNT(*) as total_employees
FROM employees;

-- Example 2: Count employees in Engineering department
SELECT COUNT(*) as engineering_employees
FROM employees
WHERE department_id = 1;

-- Example 3: Count active projects
SELECT COUNT(*) as active_projects
FROM projects
WHERE status = 'ACTIVE';

-- Example 4: Count employees with a specific job title
SELECT COUNT(*) as senior_developers
FROM employees
WHERE job_title = 'Senior Developer';

-- Example 5: Count departments with budget > $400,000
SELECT COUNT(*) as high_budget_departments
FROM departments
WHERE budget > 400000;

-- ========================================
-- 6.3 COUNT() with DISTINCT
-- ========================================

-- Example 6: Count unique departments
SELECT COUNT(DISTINCT department_id) as unique_departments
FROM employees;

-- Example 7: Count unique job titles
SELECT COUNT(DISTINCT job_title) as unique_job_titles
FROM employees;

-- Example 8: Count unique project statuses
SELECT COUNT(DISTINCT status) as unique_statuses
FROM projects;

-- Example 9: Count unique countries
SELECT COUNT(DISTINCT country) as unique_countries
FROM locations;

-- ========================================
-- 6.4 COUNT() with Specific Columns
-- ========================================

/*
COUNT(column_name) counts non-NULL values in that column.
COUNT(*) counts all rows regardless of NULL values.
*/

-- Example 10: Count all employees vs. employees with phone numbers
SELECT 
    COUNT(*) as total_employees,
    COUNT(phone) as employees_with_phone
FROM employees;

-- Example 11: Count projects with end dates
SELECT 
    COUNT(*) as total_projects,
    COUNT(end_date) as projects_with_end_date
FROM projects;

-- ========================================
-- 6.5 SUM() - Adding Up Values
-- ========================================

-- Example 12: Total budget of all projects
SELECT SUM(budget) as total_project_budget
FROM projects;

-- Example 13: Total budget of active projects only
SELECT SUM(budget) as active_projects_budget
FROM projects
WHERE status = 'ACTIVE';

-- Example 14: Total department budgets
SELECT SUM(budget) as total_department_budget
FROM departments;

-- Example 15: Total salary payments (current salaries only)
SELECT SUM(salary_amount) as total_current_salaries
FROM salaries
WHERE end_date IS NULL;

-- Example 16: Total hours allocated to projects
SELECT SUM(hours_allocated) as total_hours_allocated
FROM employee_projects;

-- ========================================
-- 6.6 AVG() - Calculating Averages
-- ========================================

-- Example 17: Average project budget
SELECT AVG(budget) as average_project_budget
FROM projects;

-- Example 18: Average salary (current salaries)
SELECT AVG(salary_amount) as average_current_salary
FROM salaries
WHERE end_date IS NULL;

-- Example 19: Average department budget
SELECT AVG(budget) as average_department_budget
FROM departments;

-- Example 20: Average hours allocated per project assignment
SELECT AVG(hours_allocated) as average_hours_per_assignment
FROM employee_projects;

-- Example 21: Average budget for active projects
SELECT AVG(budget) as average_active_project_budget
FROM projects
WHERE status = 'ACTIVE';

-- ========================================
-- 6.7 MIN() - Finding Minimum Values
-- ========================================

-- Example 22: Lowest project budget
SELECT MIN(budget) as lowest_project_budget
FROM projects;

-- Example 23: Earliest hire date
SELECT MIN(hire_date) as earliest_hire_date
FROM employees;

-- Example 24: Lowest current salary
SELECT MIN(salary_amount) as lowest_current_salary
FROM salaries
WHERE end_date IS NULL;

-- Example 25: Minimum department budget
SELECT MIN(budget) as minimum_department_budget
FROM departments;

-- Example 26: Earliest project start date
SELECT MIN(start_date) as earliest_project_start
FROM projects;

-- ========================================
-- 6.8 MAX() - Finding Maximum Values
-- ========================================

-- Example 27: Highest project budget
SELECT MAX(budget) as highest_project_budget
FROM projects;

-- Example 28: Most recent hire date
SELECT MAX(hire_date) as most_recent_hire_date
FROM employees;

-- Example 29: Highest current salary
SELECT MAX(salary_amount) as highest_current_salary
FROM salaries
WHERE end_date IS NULL;

-- Example 30: Maximum department budget
SELECT MAX(budget) as maximum_department_budget
FROM departments;

-- Example 31: Latest project end date
SELECT MAX(end_date) as latest_project_end
FROM projects;

-- ========================================
-- 6.9 COMBINING MULTIPLE AGGREGATES
-- ========================================

-- Example 32: Project budget statistics
SELECT 
    COUNT(*) as total_projects,
    SUM(budget) as total_budget,
    AVG(budget) as average_budget,
    MIN(budget) as minimum_budget,
    MAX(budget) as maximum_budget
FROM projects;

-- Example 33: Current salary statistics
SELECT 
    COUNT(*) as total_employees,
    SUM(salary_amount) as total_payroll,
    AVG(salary_amount) as average_salary,
    MIN(salary_amount) as minimum_salary,
    MAX(salary_amount) as maximum_salary
FROM salaries
WHERE end_date IS NULL;

-- Example 34: Department budget analysis
SELECT 
    COUNT(*) as total_departments,
    SUM(budget) as total_budget,
    AVG(budget) as average_budget,
    MIN(budget) as smallest_budget,
    MAX(budget) as largest_budget
FROM departments;

-- Example 35: Employee hiring trends
SELECT 
    COUNT(*) as total_employees,
    MIN(hire_date) as first_hire,
    MAX(hire_date) as latest_hire
FROM employees;

-- ========================================
-- 6.10 AGGREGATES with WHERE CONDITIONS
-- ========================================

-- Example 36: Engineering department statistics
SELECT 
    COUNT(*) as engineering_employees,
    MIN(hire_date) as first_engineering_hire,
    MAX(hire_date) as latest_engineering_hire
FROM employees
WHERE department_id = 1;

-- Example 37: High-budget project analysis
SELECT 
    COUNT(*) as high_budget_projects,
    AVG(budget) as average_high_budget,
    MIN(budget) as minimum_high_budget,
    MAX(budget) as maximum_high_budget
FROM projects
WHERE budget > 100000;

-- Example 38: Salary analysis for employees hired after 2020
SELECT 
    COUNT(DISTINCT s.employee_id) as employees_hired_after_2020,
    AVG(s.salary_amount) as average_salary,
    MIN(s.salary_amount) as minimum_salary,
    MAX(s.salary_amount) as maximum_salary
FROM salaries s
JOIN employees e ON s.employee_id = e.employee_id
WHERE e.hire_date > '2020-01-01' AND s.end_date IS NULL;

-- ========================================
-- 6.11 USEFUL AGGREGATE PATTERNS
-- ========================================

-- Example 39: Calculate percentage (requires multiple queries or subqueries)
SELECT 
    COUNT(*) as active_projects,
    (SELECT COUNT(*) FROM projects) as total_projects,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM projects)) as active_percentage
FROM projects
WHERE status = 'ACTIVE';

-- Example 40: Find range (difference between max and min)
SELECT 
    MAX(budget) - MIN(budget) as budget_range
FROM projects;

-- Example 41: Count with conditions using CASE
SELECT 
    COUNT(*) as total_projects,
    COUNT(CASE WHEN status = 'ACTIVE' THEN 1 END) as active_projects,
    COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END) as completed_projects,
    COUNT(CASE WHEN status = 'PLANNING' THEN 1 END) as planning_projects
FROM projects;

-- ========================================
-- 🎯 PRACTICE EXERCISES
-- ========================================

/*
Try these exercises:

1. Count total number of departments

2. Find the total budget for all departments

3. Calculate the average salary for current employees

4. Find the earliest and latest project start dates

5. Count how many employees work in department 1 (Engineering)

6. Find the highest and lowest budgets for active projects

7. Calculate total hours allocated across all project assignments

8. Count unique job titles in the company

9. Find the average department budget for departments with budget > $300,000

10. Get statistics (count, sum, avg, min, max) for current salaries

SOLUTIONS BELOW (try first!):
*/

-- Exercise Solutions:

-- 1. Count departments
SELECT COUNT(*) as total_departments FROM departments;

-- 2. Total department budgets
SELECT SUM(budget) as total_department_budget FROM departments;

-- 3. Average current salary
SELECT AVG(salary_amount) as average_current_salary 
FROM salaries WHERE end_date IS NULL;

-- 4. Project date range
SELECT MIN(start_date) as earliest_start, MAX(start_date) as latest_start 
FROM projects;

-- 5. Engineering employee count
SELECT COUNT(*) as engineering_employees 
FROM employees WHERE department_id = 1;

-- 6. Active project budget range
SELECT MIN(budget) as min_active_budget, MAX(budget) as max_active_budget 
FROM projects WHERE status = 'ACTIVE';

-- 7. Total hours allocated
SELECT SUM(hours_allocated) as total_hours FROM employee_projects;

-- 8. Unique job titles
SELECT COUNT(DISTINCT job_title) as unique_job_titles FROM employees;

-- 9. Average budget for high-budget departments
SELECT AVG(budget) as avg_high_budget_dept 
FROM departments WHERE budget > 300000;

-- 10. Current salary statistics
SELECT 
    COUNT(*) as employee_count,
    SUM(salary_amount) as total_payroll,
    AVG(salary_amount) as average_salary,
    MIN(salary_amount) as minimum_salary,
    MAX(salary_amount) as maximum_salary
FROM salaries WHERE end_date IS NULL;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. Aggregate functions summarize multiple rows into single results
2. COUNT(*) counts all rows, COUNT(column) counts non-NULL values
3. COUNT(DISTINCT column) counts unique values
4. SUM() adds up numeric values
5. AVG() calculates the average of numeric values
6. MIN() and MAX() find smallest and largest values
7. You can combine multiple aggregates in one query
8. WHERE clauses filter data before aggregation
9. Aggregates work with any data type (numbers, dates, text)

✅ Next lesson: 07_grouping_data.sql
   We'll learn GROUP BY and HAVING!
*/

SELECT 'Lesson 6 Complete! 🎉' as status;
SELECT 'Next: 07_grouping_data.sql' as next_lesson; 