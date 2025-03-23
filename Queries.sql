-- Monday Coffee Expansion Analysis 
-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

SELECT 
    City_name,
    ROUND((population * 0.25) / 1000000, 2) AS estimated_population_in_Milliions,
    city_rank
FROM
    city
ORDER BY 2 DESC;


-- -- Q.2
-- Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?


SELECT 
    City.city_name, SUM(total) AS Total_revenue
FROM
    sales AS S
        JOIN
    Customers AS C ON s.customer_id = c.customer_id
        JOIN
    city ON city.city_id = c.city_id
WHERE
    sale_date BETWEEN '2023-10-01' AND '2023-12-31'
GROUP BY City.city_id
ORDER BY 2 DESC;



-- Q.3
-- Sales Count for Each Product
-- How many units of each coffee product have been sold?


SELECT 
    p.product_name as Coffee, COUNT(sale_id) as Total_Sales
FROM
    sales AS S
        JOIN
    Products AS P ON S.product_id = p.product_id
GROUP BY p.product_name
ORDER BY 2 DESC;


-- Q.4
-- Average Sales Amount per City
-- What is the average sales amount per customer in each city?


SELECT 
    Ci.city_name AS CITY,
    SUM(s.total) AS Total_Sale,
    COUNT(DISTINCT s.customer_id) AS Total_Customer,
    ROUND((SUM(s.total) / COUNT(DISTINCT s.customer_id)),
            0) AS Average_Sale_per_Customer
FROM
    sales AS S
        JOIN
    Customers AS C ON s.customer_id = c.customer_id
        JOIN
    City AS Ci ON c.city_id = Ci.city_id
GROUP BY Ci.city_name
ORDER BY 4 DESC;


-- -- Q.5
-- City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current cx, estimated coffee consumers (25%)

WITH A as (
SELECT 
    City_name,
    ROUND((population / 1000000), 2) AS population_in_million,
    ROUND(((population * 0.25) / 1000000), 2) AS estimated_coffee_consumers
FROM
    city
),

B as (
SELECT 
    city.city_name,
    COUNT(DISTINCT c.customer_id) AS Unique_customer
FROM
    sales AS s
        JOIN
    customers AS c ON c.customer_id = s.customer_id
        JOIN
    city ON city.city_id = c.city_id
GROUP BY city.city_name
)

SELECT 
    a.city_name,
    a.population_in_million,
    a.estimated_coffee_consumers,
    b.Unique_customer
FROM
    a
        JOIN
    b ON a.city_name = b.city_name;

-- -- Q6
-- Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?


SELECT
    *
FROM
    (
        SELECT
            city.city_name,
            p.product_name,
            COUNT(S.product_id) AS total_order,
            DENSE_RANK() OVER (PARTITION BY city.city_name ORDER BY COUNT(S.product_id) DESC) AS r
        FROM
            sales AS S
            JOIN customers AS C ON S.customer_id = C.customer_id
            JOIN city ON C.city_id = city.city_id
            JOIN products AS p ON p.product_id = S.product_id
        GROUP BY
            city.city_name,
            p.product_name
    ) AS T1
WHERE
    r <= 3
ORDER BY
    total_order DESC;
        

-- Q.7
-- Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?


SELECT 
    city.city_name as City,
    COUNT(DISTINCT s.customer_id) as Total_Cust
FROM
    sales AS S
        JOIN
    customers AS C ON c.customer_id = s.customer_id
        JOIN
    city ON city.city_id = c.city_id
WHERE
    s.product_id IN (1 , 2, 3,  4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)
GROUP BY 
	city.city_name;



-- -- Q.8
-- Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer


WITH A AS (
    SELECT
        Ci.city_name AS CITY,
        COUNT(DISTINCT s.customer_id) AS Total_Customer,
        ROUND(
            (SUM(s.total) / COUNT(DISTINCT s.customer_id)),
            0
        ) AS Average_Sale_per_Customer
    FROM
        sales AS S
        JOIN Customers AS C ON s.customer_id = c.customer_id
        JOIN City AS Ci ON c.city_id = Ci.city_id
    GROUP BY
        Ci.city_name
    ORDER BY
        3 DESC
),
B AS (
    SELECT
        estimated_rent AS Rent,
        city_name
    FROM
        city
)
SELECT
    a.CITY,
    a.Total_Customer,
    a.Average_Sale_per_Customer,
    b.Rent,
    ROUND((b.Rent / a.Total_Customer), 2) AS Average_Rent_per_Cust
FROM
    A
    JOIN B ON a.CITY = b.city_name
ORDER BY
    3 DESC;


-- Q.9
-- Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- by each city


WITH A AS (
    SELECT
        Ci.city_name AS City,
        EXTRACT(MONTH FROM sale_date) AS MONTH,
        EXTRACT(YEAR FROM sale_date) AS YEAR,
        SUM(s.total) AS Current_month_sale
    FROM
        sales AS S
        JOIN Customers AS C ON s.customer_id = c.customer_id
        JOIN City AS Ci ON c.city_id = Ci.city_id
    GROUP BY
        1, 3, 2
    ORDER BY
        1, 3, 2
),
B AS (
    SELECT
        City,
        MONTH,
        YEAR,
        Current_month_sale,
        LAG(Current_month_sale, 1) OVER (PARTITION BY City ORDER BY Year, Month) AS last_month_sale
    FROM
        A
)
SELECT
    City,
    MONTH,
    YEAR,
    Current_month_sale,
    last_month_sale,
    ROUND(((Current_month_sale - last_month_sale) / last_month_sale) * 100, 2) AS Growth_Ratio
FROM
    B
WHERE 
	last_month_sale IS NOT NULL;



-- Q.10
-- Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer


WITH A AS (
    SELECT
        Ci.city_name AS CITY,
        SUM(s.total) as Total_Revenue,
        COUNT(DISTINCT s.customer_id) AS Total_Customer,
        ROUND(
            (SUM(s.total) / COUNT(DISTINCT s.customer_id)),
            0
        ) AS Average_Sale_per_Customer
    FROM
        sales AS S
        JOIN Customers AS C ON s.customer_id = c.customer_id
        JOIN City AS Ci ON c.city_id = Ci.city_id
    GROUP BY
        Ci.city_name
    ORDER BY
        4 DESC
),
B AS (
    SELECT
        estimated_rent AS Rent,
        city_name,
		round((population*0.25)/1000000,2) as Estimated_Coffee_Consumer
    FROM
        city
)
SELECT
    a.CITY,
    a.Total_Revenue,
    a.Total_Customer,
    b.Rent,
    b.Estimated_Coffee_Consumer,
    a.Average_Sale_per_Customer,
    ROUND((b.Rent / a.Total_Customer), 2) AS Average_Rent_per_Cust
FROM
    A
    JOIN B ON a.CITY = b.city_name
ORDER BY
    2 DESC;