-- Customer Data Analysis for Enhanced Banking Insights
-- Step 1: Data Exploration
/* 1.1 View the first few records to understand the structure of the data. */

SELECT * 
FROM CustomerAnalytics.customers
LIMIT 10;

-- 1.2 Get Summary of Columns and Data Types
-- To understand the data structure, such as column types and NULL values.

DESCRIBE CustomerAnalytics.customers;

-- 1.3 Count the Total Number of Rows
-- To see the total number of customers in the database:

SELECT COUNT(*) AS Total_Customers
FROM CustomerAnalytics.customers;

-- Step 2: Data Cleaning
-- 2.1.1 Check for missing or null DateOfBirth values

SELECT COUNT(*) AS Null_DateOfBirth
FROM CustomerAnalytics.customers
WHERE DateOfBirth IS NULL;

-- 2.1.2 Check for missing or null Email addresses

SELECT COUNT(*) AS Null_ContactEmail
FROM CustomerAnalytics.customers
WHERE Contact_Email IS NULL;

-- 2.1.3 Check for missing or null Phone numbers

SELECT COUNT(*) AS Null_ContactPhone
FROM CustomerAnalytics.customers
WHERE Contact_Phone IS NULL;

-- 2.2 Check for Invalid Emails (e.g., missing "@" symbol)

SELECT COUNT(*) AS Invalid_Emails
FROM CustomerAnalytics.customers
WHERE Contact_Email NOT LIKE '%@%.%';

-- 2.3 Handle Invalid Date Values
-- Ensure all DateOfBirth values are valid (e.g., not 0000-00-00).

SELECT COUNT(*) AS Invalid_DateOfBirth
FROM CustomerAnalytics.customers
WHERE DateOfBirth = '0000-00-00';

-- Step 3: Data Analysis
-- 3.1 Calculate Customer Age Based on DateOfBirth

SELECT CustomerID, FirstName, LastName, DateOfBirth,
       TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) AS Age
FROM CustomerAnalytics.customers;

-- 3.2 Count Customers by Account Type
-- Analyze the distribution of different account types (e.g., "Savings", "Checking").

SELECT Account_Type, COUNT(*) AS Customer_Count
FROM CustomerAnalytics.customers
GROUP BY Account_Type;

-- 3.3 Count Customers by Employment Status
-- Determine how many customers are employed, unemployed, etc.

SELECT Employment_Status, COUNT(*) AS Customer_Count
FROM CustomerAnalytics.customers
GROUP BY Employment_Status;

-- 3.4 Find Customers Who Opened Accounts in the Last Year
-- Track customers who opened accounts within the past year.

SELECT CustomerID, FirstName, LastName, Account_Open_Date
FROM CustomerAnalytics.customers
WHERE Account_Open_Date >= CURDATE() - INTERVAL 2 YEAR;

-- 3.5 Calculate the Average Age of Customers
-- Get the average age of customers based on their DateOfBirth.

SELECT AVG(TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE())) AS Average_Age
FROM CustomerAnalytics.customers;

-- 3.6 Identify Customers with Invalid Emails or Missing Contact Info
-- identify customers who have missing or invalid contact information.

SELECT CustomerID, FirstName, LastName, Contact_Email, Contact_Phone
FROM CustomerAnalytics.customers
WHERE Contact_Email IS NULL OR Contact_Phone IS NULL OR Contact_Email NOT LIKE '%@%.%';

-- Step 4: Data Aggregation and Insights
-- 4.1 Top 5 Customers Who Opened Accounts the Longest Ago
-- find out who has been a customer the longest.

SELECT CustomerID, FirstName, LastName, Account_Open_Date
FROM CustomerAnalytics.customers
ORDER BY Account_Open_Date ASC
LIMIT 5;

-- 4.2 Customers Who Are 30 Years Old or Older
-- Retrieve customers who are older than 30 years based on their DateOfBirth.

SELECT CustomerID, FirstName, LastName, DateOfBirth
FROM CustomerAnalytics.customers
WHERE TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) >= 30;

-- 4.3 Average Length of Time Customers Have Been with the Company
-- Calculate the average number of years customers have been with the company.

SELECT AVG(TIMESTAMPDIFF(YEAR, Account_Open_Date, CURDATE())) AS Average_Years_With_Company
FROM CustomerAnalytics.customers;

-- 5.1 Identify Correlation Between Employment Status and Account Type
-- Analyze how different employment statuses correlate with different account types.

SELECT Employment_Status, Account_Type, COUNT(*) AS Customer_Count
FROM CustomerAnalytics.customers
GROUP BY Employment_Status, Account_Type;

-- 5.2 Customers with Multiple Accounts (Potential Duplicate Accounts)
-- Check for customers with multiple accounts by their CustomerID.

SELECT CustomerID, COUNT(DISTINCT Account_Number) AS Account_Count
FROM CustomerAnalytics.customers
GROUP BY CustomerID
HAVING Account_Count > 1;


