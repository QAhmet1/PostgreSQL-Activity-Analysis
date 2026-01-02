PostgreSQL: User Engagement & Configuration Analysis
This project demonstrates advanced SQL querying techniques using real-world database schemas. The analysis focuses on the relationship between user configurations and their daily activities within an internship management system.

📊 Database Overview
The project utilizes two primary tables from a PostgreSQL database:

UserSettings: Stores user-specific settings such as survey completion status and system preferences (e.g., survey1, hasGoogleLoginDialogDisplayed).

DailyActivities: A high-volume table (3.2M records) tracking user interactions, including activity types and internship program associations.

🚀 SQL Techniques Demonstrated
CTEs (Common Table Expressions): Used to simplify complex logic and improve query readability.

Joins: Utilization of INNER JOIN for intersection and LEFT JOIN to identify inactive users without losing data.

Aggregations: Data summarization using COUNT, GROUP BY, and HAVING.

Subqueries: Implementing correlated and nested subqueries for cross-table validation.

Pattern Matching: Using LIKE for flexible string searching in configuration names.

🔍 Key Insights & Queries
1. Inactive User Detection
Using LEFT JOIN and COUNT, we identify users who have a specific setting record but zero activity logs. This is crucial for identifying "drop-off" points in the user journey.

2. Configuration vs. Activity Correlation
We analyze if users with certain flags enabled (like hasGoogleLoginDialogDisplayed) show higher activity rates in specific internship programs.

3. Data Integrity Checks
A query is designed to find users whose settings were updated after their last recorded activity, highlighting potential synchronization issues.

🛠️ How to Use
Clone the repository.

Run the queries.sql file in any PostgreSQL environment (e.g., DBeaver, pgAdmin, or VS Code with SQL tools).

Review the comments in the SQL file for step-by-step logic explanations.
