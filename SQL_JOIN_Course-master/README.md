# SQL & JOIN Course - Step-by-Step Learning Project

Welcome to your comprehensive SQL learning journey! This project is designed to teach you SQL fundamentals and JOINs through hands-on practice.

## 🗄️ Database Schema

Our learning database simulates a **Company Management System** with the following tables:

- **employees** - Employee information (12 employees)
- **departments** - Company departments (6 departments) 
- **projects** - Company projects (8 projects)
- **employee_projects** - Many-to-many relationship between employees and projects
- **salaries** - Employee salary history (progressive salary data)
- **locations** - Office locations (5 global offices)

## 🚀 Quick Start Guide

### Step 1: Database Setup
```sql
-- Execute this first to create your learning environment
-- File: 01_setup_database.sql
```

### Step 2: Verify Setup
```sql
-- Check that data was loaded correctly
SELECT 'EMPLOYEES' as table_name, COUNT(*) as records FROM employees
UNION ALL
SELECT 'DEPARTMENTS', COUNT(*) FROM departments
UNION ALL  
SELECT 'PROJECTS', COUNT(*) FROM projects;
-- Should show: EMPLOYEES(12), DEPARTMENTS(6), PROJECTS(8)
```

### Step 3: Start Learning!
Begin with `02_basic_select.sql` and work through each lesson sequentially.

## 📚 Learning Structure

### Module 1: SQL Fundamentals (Lessons 1-8)
1. **01_setup_database.sql** - Create tables and insert sample data ⚙️
2. **02_basic_select.sql** - SELECT, FROM, basic queries 📋
3. **03_filtering_data.sql** - WHERE, comparison operators 🔍  
4. **04_logical_operators.sql** - AND, OR, NOT, IN, BETWEEN, LIKE 🧠
5. **05_sorting_distinct.sql** - ORDER BY, DISTINCT 📊
6. **06_aggregate_functions.sql** - COUNT, SUM, AVG, MIN, MAX 📈
7. **07_grouping_data.sql** - GROUP BY, HAVING 👥
8. **08_table_aliases.sql** - Using aliases for readability 🏷️

### Module 2: SQL JOINs (Lessons 9-17)
9. **09_understanding_joins.sql** - Introduction to JOINs and relationships 🔗
10. **10_inner_join.sql** - INNER JOIN examples 🎯
11. **11_left_join.sql** - LEFT JOIN examples ⬅️
12. **12_right_join.sql** - RIGHT JOIN examples ➡️ 
13. **13_full_join.sql** - FULL OUTER JOIN examples ↔️
14. **14_self_join.sql** - SELF JOIN examples 🪞
15. **15_cross_join.sql** - CROSS JOIN examples ❌
16. **16_multiple_joins.sql** - Joining multiple tables 🔗🔗🔗
17. **17_practical_exercises.sql** - Real-world scenarios 💼

## 🎯 Learning Objectives

By the end of this course, you will:
- ✅ Understand relational database concepts
- ✅ Master basic SQL operations (SELECT, WHERE, ORDER BY)
- ✅ Know how to filter, sort, and aggregate data
- ✅ Understand different types of JOINs and when to use them
- ✅ Be able to write complex queries joining multiple tables
- ✅ Have practical experience with real-world business scenarios
- ✅ Create comprehensive reports and data analysis queries

## 💡 Study Tips & Best Practices

### 🔄 **Recommended Learning Flow:**
1. **Read First**: Review comments and objectives before running queries
2. **Execute Step-by-Step**: Run each query individually, observe results
3. **Experiment**: Modify queries to see how results change
4. **Practice**: Complete exercises at the end of each lesson
5. **Review**: Revisit previous lessons if concepts are unclear

### 📝 **Note-Taking Tips:**
- Keep a separate notepad for key concepts
- Write down your own query variations
- Document any patterns you notice
- Track which JOIN types work best for different scenarios

### 🧪 **Experimentation Ideas:**
- Change WHERE conditions to see different results
- Try different ORDER BY columns
- Modify GROUP BY clauses
- Create your own queries combining concepts

## 🛠️ DataGrip Usage Tips

### Running Queries:
- **Execute Selection**: Highlight specific queries and press `Ctrl+Enter` (Windows/Linux) or `Cmd+Enter` (Mac)
- **Execute All**: `Ctrl+Shift+Enter` to run entire file
- **Comment/Uncomment**: `Ctrl+/` to toggle comments

### Navigation:
- **File Search**: `Ctrl+Shift+N` to quickly find lesson files
- **Database Explorer**: Use left panel to view table structure
- **Query History**: View previously executed queries

## 🔧 Troubleshooting

### Common Issues & Solutions:

**Q: "Table doesn't exist" error**
**A:** Make sure you've run `01_setup_database.sql` first

**Q: "No data returned from query"**  
**A:** Check if you have the expected sample data using:
```sql
SELECT COUNT(*) FROM employees; -- Should return 12
```

**Q: "Syntax error in JOIN"**
**A:** Ensure you're using the correct ON clause and table aliases

**Q: "Performance is slow"**
**A:** This is normal for learning - our dataset is small and optimized for education

### Getting Help:
- Review the comments in each lesson file
- Check previous lessons for similar examples
- Refer to SQL documentation for specific functions
- Practice with simpler queries first, then build complexity

## 📊 Progress Tracking

Create a learning checklist:
- [ ] Module 1 Complete (Lessons 1-8)
- [ ] Module 2 Complete (Lessons 9-17)  
- [ ] All Exercises Completed
- [ ] Created Own Custom Queries
- [ ] Ready for Real-World SQL!

## 🎉 Next Steps After Completion

Once you've mastered this course:
1. **Practice with Real Data**: Find public datasets to analyze
2. **Learn Advanced Topics**: Window functions, CTEs, stored procedures
3. **Database Design**: Learn about normalization and database architecture
4. **Performance Optimization**: Study indexes, query optimization
5. **Different SQL Dialects**: Explore PostgreSQL, MySQL, SQL Server specifics

---

**Happy Learning! 🚀 You're on your way to becoming an SQL expert!** 