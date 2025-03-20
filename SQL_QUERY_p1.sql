-- CREATE TABLE 

DROP TABLE IF EXISTS reatil_sales ;
CREATE TABLE retail_saless
(
transactions_id INT ,
sale_date DATE ,
sale_time  TIME,
customer_id	VARCHAR(15),
gender	VARCHAR(15),
age	 INT,
category	VARCHAR(15) ,
quantiy	INT ,
price_per_unit	FLOAT ,
cogs	FLOAT ,
total_sale FLOAT
);

-- SEEING ALL THE DATA 
SELECT * FROM retail_saless 

-- RETREVING ONLY FIRST 10 ROWS DATA
SELECT * FROM retail_saless 
LIMIT 10

-- COUNTING THE TOTAL NUMBER OF ROWS 
SELECT 
COUNT(*)
FROM retail_saless

-- DATA CLEANING
-- SEEING IF WE HAVE ANY NULL VALUE IN ANY COLUMN 
-- FIRST WAY IN WHICH WE ARE RETRIVING THE DATA COLUMN BY COLUMN
SELECT * FROM retail_saless
WHERE transactions_id IS NULL

SELECT * FROM retail_saless
WHERE sale_date IS NULL

-- SECOND WAY IN WHICH WE ARE USIMG "OR" FOR FINDING OUT NULL VALUES
SELECT * FROM retail_saless
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
     sale_time IS NULL
	 OR
     customer_id IS NULL
	 OR
	 gender	IS NULL
	 OR
	 age	IS NULL
	 OR
	 category	IS NULL
	 OR
	 quantiy	IS NULL
	 OR
	 price_per_unit	IS NULL
	 OR
	 cogs	IS NULL
	 OR
	 total_sale IS NULL;

-- DELETING NULL VALUES FROM COLUMNS 
DELETE FROM retail_saless
WHERE
transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
     sale_time IS NULL
	 OR
     customer_id IS NULL
	 OR
	 gender	IS NULL
	 OR
	 age	IS NULL
	 OR
	 category	IS NULL
	 OR
	 quantiy	IS NULL
	 OR
	 price_per_unit	IS NULL
	 OR
	 cogs	IS NULL
	 OR
	 total_sale IS NULL

-- DATA EXPLORATION 

-- HOW MANY SALES WE HAVE ?
SELECT COUNT(*) as total_sale FROM retail_saless

-- HOW MANY UNIQUE CUSTOMER WE HAVE 
SELECT COUNT( DISTINCT customer_id) as total_sale FROM retail_saless


--HOW MANY UNIQUE CATEGORY (with name) WE HAVE 
SELECT  DISTINCT category as total_sale FROM retail_saless


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS AND ANSWERS

-- QUES.1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':

SELECT * FROM retail_saless
WHERE sale_date = '2022-11-05';

--QUES.2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM retail_saless
WHERE 
category = 'Clothing'
AND
quantiy >= 4
AND
TO_CHAR(sale_date , 'YYYY-MM') = '2022-11';

--QUES.3. Write a SQL query to calculate the total sales (total_sale) for each category& the no. of orders:

SELECT 
category ,
SUM(total_sale) as net_sale ,
COUNT (*) as total_orders
FROM  retail_saless
	 GROUP BY 1

--QUES.4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(age) ,2) as avg_age FROM retail_saless
WHERE
category = 'Beauty'

--QUES.5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:	 
	 SELECT * FROM retail_saless
	 WHERE total_sale > '1000'

--QUES.6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
	 
SELECT 
category ,
gender,
COUNT(*) as total_transactions 
FROM retail_saless
GROUP BY 
category ,
gender
ORDER BY 1;

--QUES.7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year , month , avg_sale FROM
(
SELECT 
EXTRACT (YEAR FROM sale_date ) as year , 
EXTRACT (MONTH FROM sale_date ) as  month ,
AVG(total_sale) AS avg_sale,
RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_saless
GROUP BY 1,2
)as t1
WHERE rank = 1

--QUES.8.Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
customer_id ,
SUM(total_sale) as total_sales
FROM retail_saless
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--QUES.9. Write a SQL query to find the number of unique customers who purchased items from each category .

SELECT
category , 
COUNT(DISTINCT customer_id) as unique_customers
FROM retail_saless
GROUP BY category

--QUES.10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_saless
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

--END OF PROJECT 






