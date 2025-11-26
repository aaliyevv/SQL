-- ========================================
-- LESSON 12: RIGHT JOIN (RIGHT OUTER JOIN)
-- ========================================
-- Learning Objectives:
-- 1. Understand RIGHT JOIN concept
-- 2. Compare RIGHT JOIN vs LEFT JOIN
-- 3. Practice RIGHT JOIN examples
-- 4. Learn when RIGHT JOIN is useful

-- ========================================
-- 12.1 WHAT IS RIGHT JOIN?
-- ========================================

/*
RIGHT JOIN returns ALL rows from the right table, and matching rows from the left table.
If no match is found, NULL values are returned for left table columns.

Syntax:
    SELECT columns
    FROM left_table
    RIGHT JOIN right_table ON left_table.column = right_table.column

Key points:
- ALL rows from RIGHT table are included
- Matching rows from LEFT table are included
- NULL values for non-matching LEFT table columns
- Less commonly used than LEFT JOIN
*/

-- ========================================
-- 12.2 RIGHT JOIN Examples
-- ========================================

-- Example 1: All departments with their employees (RIGHT JOIN version)
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, e.last_name;

-- Example 2: All projects with their team members  
SELECT 
    ep.role,
    e.first_name,
    e.last_name,
    p.project_name
FROM employee_projects ep
RIGHT JOIN projects p ON ep.project_id = p.project_id
LEFT JOIN employees e ON ep.employee_id = e.employee_id
ORDER BY p.project_name;

-- ========================================
-- 12.3 RIGHT JOIN vs LEFT JOIN
-- ========================================

-- These queries produce the same result:

-- Using LEFT JOIN
SELECT d.department_name, e.first_name, e.last_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

-- Using RIGHT JOIN (same result, different table order)
SELECT d.department_name, e.first_name, e.last_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. RIGHT JOIN returns ALL rows from right table + matching from left
2. Less commonly used than LEFT JOIN
3. Often can be rewritten as LEFT JOIN by switching table order
4. Useful when you want to emphasize the "right" table as primary

✅ Next lesson: 13_full_join.sql
*/

SELECT 'Lesson 12 Complete! 🎉' as status; 