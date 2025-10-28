# Retailstore Sales Analysis

## overview 
This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

## Question Performed 
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


## Project Structure
## Database Setup
- Database Creation: The project starts by creating a database named p1_retail_db.
- Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
  
 ```sql
create table Retail_sales 
   (
    transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(6),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT ,
	total_sale FLOAT
	);
```

## Data Analysis & Findings
- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
```sql
select * from Retail_sales
where sale_date = '2022-11-05';
```
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 4 in the month of Nov-2022
```sql
select * from Retail_sales
where category = 'Clothing'
and quantiy >= '4'
and To_char(sale_date, 'yyyy-mm')= '2022-11'
```
-- Q.3 Write a SQL query to calculate the total sales for each category.
```sql
select
    category,
    sum(total_sale) as net_sale
from Retail_sales
group by category
order by net_sale desc;
```
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
```sql
select 
   ROUND(avg(age),2) as Avg_age
from Retail_sales
where category = 'Beauty'
```
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
```sql
select * from Retail_sales
where total_sale > 1000
```
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
```sql
select 
   category,
   gender,
   count(transactions_id) as Total_trans
from Retail_sales
group by  
   category,
   gender
order by category;
   ```
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
```sql
select
   extract (month from sale_date)as Months,
   Round(Avg(total_sale)::numeric,2)as Avg_sale
from Retail_sales
group by Months
order by Months;
```
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
```sql
Select customer_id,
       sum(total_sale) as Total_sales
from Retail_sales
group by customer_id
order by Total_sales desc
limit 5;
```
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
```sql
select
   category,
   count( distinct customer_id) as cust_count
from Retail_sales
group by category   
order by cust_count desc ;
```
-- Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17)
```sql
with Hours_table as

(select *,
  extract(hour from sale_time) as Hours
from Retail_sales)

select count(*), 
case
   when Hours < 12 then 'Morning'
   when Hours between 12 and 17 then 'Afternoon'
   else 'Evening'
end as shift
from Hours_table
group by shift ;
```






