#   Monday Coffee Expansion Analysis
![image](https://github.com/user-attachments/assets/31596355-ed23-4ba7-836e-bff66b2a4c41)


##   Project Overview

This project provides a SQL-based analysis to support the expansion of the "Monday Coffee" business into India's top three major cities. The analysis uses sales data to identify and recommend the most promising cities for new coffee shop locations.

##   Objectives

* To analyze sales data and provide insights for recommending the top three cities for expansion.

##   Data

The analysis is based on sales data, customer data, city data (including population and estimated rent), and product data.
![ERD](https://github.com/user-attachments/assets/920f01be-843d-4e08-9e35-b96aad9b62f7)


##   SQL Queries

The project includes SQL queries to answer the following questions:

**Easy-Medium Questions**

* How many people in each city are estimated to consume coffee, given that 25% of the population does?
* What is the total revenue generated from coffee sales across all cities?
* How many units of each coffee product have been sold?
* What is the average sales amount per customer in each city?
* Provide a list of cities along with their populations and estimated coffee consumers?

**Medium Questions**

* What are the top 3 selling products in each city based on sales volume?
* How many unique customers are there in each city who have purchased coffee products?
* Find each city and their average sale per customer and average rent per customer?

**Advanced Questions & Analysis**

* Calculate the percentage growth (or decline) in sales over different time periods (monthly)?
* Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer?

##   Recommended Cities for Expansion

Based on the analysis, the top three cities recommended for expansion are:

1.  **Pune**
2.  **Jaipur**
3.  **Delhi**

##   Reasons for Recommendations

* **Pune:** High total revenue, low average rent per customer, and high average sales per customer.
* **Jaipur:** Lowest average rent per customer, highest number of customers, and high average sales per customer.
* **Delhi:** Highest estimated coffee consumers, good total revenue, and low average rent per customer.

##   GitHub Repository Contents

This repository contains:

* SQL scripts for performing the analysis.
* Datasets
* Data files (ERD , Presentation).
* This README file.

##   How to Use

1.  Set up a database (e.g., MySQL, PostgreSQL).
2.  Import the data into the database.
3.  Execute the SQL scripts to perform the analysis.

##   Dependencies

* A relational database management system (RDBMS) such as MySQL or PostgreSQL.

##   Author

Keshav Bansal
