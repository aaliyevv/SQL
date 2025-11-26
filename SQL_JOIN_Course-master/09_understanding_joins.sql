-- ========================================
-- LESSON 9: Understanding JOINs & Relationships
-- ========================================
-- Learning Objectives:
-- 1. Understand why we need JOINs
-- 2. Learn about table relationships
-- 3. Master Primary Keys (PK) and Foreign Keys (FK)
-- 4. Understand different types of JOINs
-- 5. Prepare for hands-on JOIN practice

-- ========================================
-- 9.1 WHY DO WE NEED JOINS?
-- ========================================

/*
In relational databases, data is often split across multiple tables to:
1. Avoid data duplication (normalization)
2. Maintain data integrity
3. Make data management easier
4. Improve performance

JOINS allow us to combine related data from different tables in a single query.

Example: Employee data is split across multiple tables:
- employees table: basic info (name, hire_date, department_id)
- departments table: department info (name, budget, location_id)
- salaries table: salary history
- locations table: office locations

To get complete information, we need to JOIN these tables!
*/

-- ========================================
-- 9.2 OUR DATABASE RELATIONSHIPS
-- ========================================

/*
Let's examine our database structure and relationships:

LOCATIONS (location_id PK)
    ↓ (one-to-many)
DEPARTMENTS (department_id PK, location_id FK)
    ↓ (one-to-many)
EMPLOYEES (employee_id PK, department_id FK, manager_id FK)
    ↓ (one-to-many)
SALARIES (salary_id PK, employee_id FK)

EMPLOYEES ←→ PROJECTS (many-to-many via EMPLOYEE_PROJECTS)

Key relationships:
- One location can have many departments
- One department can have many employees  
- One employee can have many salary records
- Employees and projects have many-to-many relationship
*/

-- Let's examine our table structures:

-- Example 1: Look at the employees table structure
SELECT 'EMPLOYEES TABLE SAMPLE:' as info;
SELECT employee_id, first_name, last_name, department_id, manager_id 
FROM employees 
LIMIT 5;

-- Example 2: Look at departments table
SELECT 'DEPARTMENTS TABLE SAMPLE:' as info;
SELECT department_id, department_name, location_id, manager_id 
FROM departments;

-- Example 3: Look at locations table
SELECT 'LOCATIONS TABLE SAMPLE:' as info;
SELECT location_id, city, country 
FROM locations;

-- ========================================
-- 9.3 PRIMARY KEYS (PK)
-- ========================================

/*
PRIMARY KEY (PK) is a column that uniquely identifies each row in a table.

Characteristics:
- Must be UNIQUE (no duplicates)
- Cannot be NULL
- Each table can have only ONE primary key
- Often used in relationships as foreign keys

In our tables:
- employees.employee_id (PK)
- departments.department_id (PK)
- locations.location_id (PK)
- projects.project_id (PK)
- salaries.salary_id (PK)
*/

-- Example 4: Show all employee IDs (each should be unique)
SELECT employee_id, first_name, last_name
FROM employees
ORDER BY employee_id;

-- Example 5: Show all department IDs
SELECT department_id, department_name
FROM departments
ORDER BY department_id;

-- Example 6: Count distinct vs total (should be same for PKs)
SELECT 
    COUNT(*) as total_employees,
    COUNT(DISTINCT employee_id) as unique_employee_ids
FROM employees;

-- ========================================
-- 9.4 FOREIGN KEYS (FK)
-- ========================================

/*
FOREIGN KEY (FK) is a column that refers to the primary key in another table.
It creates a link/relationship between tables.

Characteristics:
- References a primary key in another table
- Can have duplicate values
- Can be NULL (unless specified otherwise)
- Maintains referential integrity

In our tables:
- employees.department_id → departments.department_id
- employees.manager_id → employees.employee_id (self-reference!)
- departments.location_id → locations.location_id
- projects.department_id → departments.department_id
- salaries.employee_id → employees.employee_id
*/

-- Example 7: Show foreign key relationships
SELECT 'EMPLOYEE → DEPARTMENT RELATIONSHIP:' as info;
SELECT employee_id, first_name, last_name, department_id 
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id, employee_id;

-- Example 8: Show department → location relationship
SELECT 'DEPARTMENT → LOCATION RELATIONSHIP:' as info;
SELECT department_id, department_name, location_id 
FROM departments
ORDER BY location_id, department_id;

-- ========================================
-- 9.5 ONE-TO-MANY RELATIONSHIPS
-- ========================================

/*
One-to-Many: One record in Table A relates to many records in Table B.

Examples in our database:
- One DEPARTMENT → Many EMPLOYEES
- One LOCATION → Many DEPARTMENTS  
- One EMPLOYEE → Many SALARY records
*/

-- Example 9: Show one department with its many employees
SELECT 'ENGINEERING DEPARTMENT EMPLOYEES:' as info;
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE department_id = 1;  -- Engineering department

-- Example 10: Count employees per department (one-to-many relationship)
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) as employee_count
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY employee_count DESC;

-- ========================================
-- 9.6 MANY-TO-MANY RELATIONSHIPS
-- ========================================

/*
Many-to-Many: Records in Table A can relate to many records in Table B,
and vice versa. Requires a junction/bridge table.

Example: EMPLOYEES ↔ PROJECTS (via EMPLOYEE_PROJECTS table)
- One employee can work on many projects
- One project can have many employees
*/

-- Example 11: Show the many-to-many relationship
SELECT 'EMPLOYEE-PROJECT RELATIONSHIPS:' as info;
SELECT employee_id, project_id, role, hours_allocated
FROM employee_projects
ORDER BY employee_id, project_id;

-- Example 12: Count projects per employee
SELECT 
    employee_id,
    COUNT(project_id) as project_count,
    SUM(hours_allocated) as total_hours
FROM employee_projects
GROUP BY employee_id
ORDER BY project_count DESC;

-- ========================================
-- 9.7 TYPES OF JOINS
-- ========================================

/*
Different JOIN types return different results:

1. INNER JOIN: Only matching records from both tables
2. LEFT JOIN: All records from left table + matching from right
3. RIGHT JOIN: All records from right table + matching from left  
4. FULL JOIN: All records from both tables
5. SELF JOIN: Join a table to itself
6. CROSS JOIN: Every row from table A combined with every row from table B

We'll learn each type in detail in the next lessons!
*/

-- ========================================
-- 9.8 UNDERSTANDING MATCHING vs NON-MATCHING
-- ========================================

-- Example 13: Are there any employees without departments? (bad data)
SELECT 'EMPLOYEES WITHOUT DEPARTMENTS:' as info;
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE department_id IS NULL;

-- Example 14: Are there departments without employees?
SELECT 'DEPARTMENTS WITHOUT EMPLOYEES:' as info;
SELECT d.department_id, d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.department_id
);

-- Example 15: Projects without any team members assigned
SELECT 'PROJECTS WITHOUT TEAM MEMBERS:' as info;
SELECT p.project_id, p.project_name
FROM projects p
WHERE NOT EXISTS (
    SELECT 1 FROM employee_projects ep 
    WHERE ep.project_id = p.project_id
);

-- ========================================
-- 9.9 TRADITIONAL JOIN SYNTAX vs MODERN SYNTAX
-- ========================================

/*
There are two ways to write JOINs:

1. Traditional (WHERE clause):
   SELECT columns FROM table1, table2 WHERE table1.id = table2.id

2. Modern (explicit JOIN):
   SELECT columns FROM table1 JOIN table2 ON table1.id = table2.id

We'll use modern syntax as it's clearer and more standard.
*/

-- Example 16: Traditional syntax (implicit join)
SELECT e.first_name, e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- Example 17: Modern syntax (explicit join) - same result
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- ========================================
-- 9.10 VISUALIZING RELATIONSHIPS
-- ========================================

-- Example 18: Complete relationship chain
SELECT 'COMPLETE RELATIONSHIP CHAIN:' as info;
SELECT 
    l.city as office_city,
    d.department_name,
    e.first_name,
    e.last_name,
    e.job_title
FROM locations l, departments d, employees e
WHERE l.location_id = d.location_id
  AND d.department_id = e.department_id
ORDER BY l.city, d.department_name, e.last_name;

-- Example 19: Employee-Project-Department relationships
SELECT 'EMPLOYEE PROJECT ASSIGNMENTS:' as info;
SELECT 
    e.first_name,
    e.last_name,
    p.project_name,
    ep.role,
    d.department_name
FROM employees e, projects p, employee_projects ep, departments d
WHERE e.employee_id = ep.employee_id
  AND p.project_id = ep.project_id
  AND e.department_id = d.department_id
ORDER BY e.last_name, p.project_name;

-- ========================================
-- 🎯 UNDERSTANDING EXERCISES
-- ========================================

/*
Before moving to specific JOIN types, test your understanding:

1. What is the primary key of the employees table?

2. What foreign keys does the employees table have?

3. How many employees work in department 1 (Engineering)?

4. Which departments have no employees assigned?

5. How many projects is employee_id 1 working on?

6. What type of relationship exists between employees and departments?

7. What type of relationship exists between employees and projects?

8. Why do we need the employee_projects table?

THINK ABOUT THESE, THEN CHECK SOLUTIONS BELOW:
*/

-- Exercise Solutions:

-- 1. Primary key of employees table
SELECT 'employee_id is the primary key' as answer;

-- 2. Foreign keys in employees table
SELECT 'department_id (→departments) and manager_id (→employees)' as foreign_keys;

-- 3. Engineering employees count
SELECT COUNT(*) as engineering_employees 
FROM employees 
WHERE department_id = 1;

-- 4. Departments with no employees
SELECT d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.department_id
);

-- 5. Projects for employee 1
SELECT COUNT(*) as project_count
FROM employee_projects
WHERE employee_id = 1;

-- 6. Employee-Department relationship
SELECT 'One-to-Many (one department, many employees)' as relationship_type;

-- 7. Employee-Project relationship  
SELECT 'Many-to-Many (via employee_projects table)' as relationship_type;

-- 8. Why employee_projects table needed
SELECT 'To resolve many-to-many relationship between employees and projects' as reason;

-- ========================================
-- 🎓 KEY TAKEAWAYS
-- ========================================

/*
✅ What you learned:
1. JOINs combine related data from multiple tables
2. Primary Keys uniquely identify rows in a table
3. Foreign Keys create relationships between tables
4. One-to-Many: One record relates to many in another table
5. Many-to-Many: Requires a junction table
6. Different JOIN types return different result sets
7. Modern JOIN syntax is clearer than traditional WHERE clauses
8. Understanding relationships is crucial for effective JOINs

✅ Next lesson: 10_inner_join.sql
   We'll start with INNER JOIN - the most common type!
*/

SELECT 'Lesson 9 Complete! 🎉' as status;
SELECT 'Ready to learn specific JOIN types!' as next_step;
SELECT 'Next: 10_inner_join.sql' as next_lesson; 