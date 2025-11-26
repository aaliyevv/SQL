-- ========================================
-- LESSON 13: FULL OUTER JOIN
-- ========================================
-- Learning Objectives:
-- 1. Understand FULL OUTER JOIN concept  
-- 2. Learn when to use FULL OUTER JOIN
-- 3. Practice FULL OUTER JOIN examples
-- 4. Compare with other JOIN types

-- ========================================
-- 13.1 WHAT IS FULL OUTER JOIN?
-- ========================================

/*
FULL OUTER JOIN returns ALL rows from BOTH tables.
If no match is found, NULL values are returned for the non-matching table columns.

Syntax:
    SELECT columns
    FROM table1
    FULL OUTER JOIN table2 ON table1.column = table2.column

Key points:
- ALL rows from BOTH tables are included
- NULL values for non-matching columns from either table
- Most inclusive JOIN type
- Useful for finding all records whether they match or not
*/

-- ========================================
-- 13.2 FULL OUTER JOIN Examples
-- ========================================

-- Example 1: All departments and all employees (whether they match or not)
SELECT 
    COALESCE(d.department_name, 'No Department') as department_name,
    COALESCE(e.first_name, 'No Employee') as first_name,
    COALESCE(e.last_name, '') as last_name
FROM departments d
FULL OUTER JOIN employees e ON d.department_id = e.department_id
ORDER BY d.department_name NULLS LAST, e.last_name NULLS LAST;

-- Example 2: Compare employees and projects (show all whether connected or not)
SELECT 
    COALESCE(e.first_name || ' ' || e.last_name, 'No Employee') as employee_name,
    COALESCE(p.project_name, 'No Project') as project_name,
    ep.role
FROM employees e
FULL OUTER JOIN employee_projects ep ON e.employee_id = ep.employee_id
FULL OUTER JOIN projects p ON ep.project_id = p.project_id
ORDER BY employee_name, project_name;

-- ========================================
-- 13.3 Data Analysis with FULL OUTER JOIN
-- ========================================

-- Example 3: Complete overview of departments and their projects
SELECT 
    COALESCE(d.department_name, 'Orphaned Project') as department_name,
    COALESCE(p.project_name, 'No Projects') as project_name,
    p.status,
    p.budget
FROM departments d
FULL OUTER JOIN projects p ON d.department_id = p.department_id
ORDER BY d.department_name NULLS LAST, p.project_name NULLS LAST;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. FULL OUTER JOIN returns ALL rows from BOTH tables
2. Most inclusive JOIN type - shows everything
3. Useful for comprehensive data analysis
4. Use COALESCE to handle NULL values nicely
5. Less commonly used but powerful for certain scenarios

✅ Next lesson: 14_self_join.sql
*/

SELECT 'Lesson 13 Complete! 🎉' as status; 