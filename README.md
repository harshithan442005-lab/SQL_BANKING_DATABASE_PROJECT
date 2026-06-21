# SQL_BANKING_DATABASE_PROJECT
SQL_BANKING_ANALYTICS

Overview

This project is a Banking Database Analysis system built using PostgreSQL. It simulates real-world banking data and performs SQL-based analysis to extract business insights from customers, accounts, branches, and transactions.
The project demonstrates practical SQL skills used in data analytics such as joins, aggregations, subqueries, CTEs, window functions, and CASE WHEN logic.

Tools & Technologies Used

PostgreSQL, 
SQL, 
Joins, 
Aggregations (GROUP BY, HAVING), 
Subqueries, 
Common Table Expressions (CTE),
Window Functions (RANK, SUM OVER, LAG),
CASE WHEN

Database Schema

The project consists of the following tables:

customers → Stores customer personal details
accounts → Stores account type and balances
branches → Bank branch information
transactions → Deposit and withdrawal records

Key Analysis Performed

🔹 Customer Analysis
Identified top customers by account balance
Filtered customers above average balance
Classified customers using CASE WHEN (Age groups)

🔹 Branch Analysis
Branch with highest number of customers
Branch with highest total balance

🔹 Transaction Analysis
Total deposits vs withdrawals
Highest single transaction
Customers with highest total transaction value

🔹 Advanced SQL Analysis
Ranking customers using RANK()
Running total using SUM OVER()
Previous transaction tracking using LAG()
Customer-level aggregation using CTE

Key Insights

A small group of customers holds the highest account balances
Certain branches contribute more to overall deposits
Transaction patterns show clear deposit dominance
Window functions help track financial trends over time
CASE WHEN enables customer segmentation for analysis

How to Run This Project

1.Install PostgreSQL
Create database:
SQL
CREATE DATABASE banking_project;
Run schema file:
SQL
\i schema.sql

2.Insert data:
SQL
\i data.sql

3.Run analysis queries:
SQL
\i queries.sql

Author
Harshitha N
Data Analyst
Skills: SQL | PostgreSQL | Power BI | Python 
