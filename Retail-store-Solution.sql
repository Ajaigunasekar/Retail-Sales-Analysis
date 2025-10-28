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

select * from Retail_sales

select * from Retail_sales
where transactions_id is null or sale_date is null	or sale_time is null or	customer_id is null or
gender is null or age is null or category is null or quantiy is null or	price_per_unit is null or 
cogs is null or total_sale is null	

Delete from Retail_sales
where transactions_id is null or sale_date is null	or sale_time is null or	customer_id is null or
gender is null or age is null or category is null or quantiy is null or	price_per_unit is null or 
cogs is null or total_sale is null	


-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from Retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 4 in the month of Nov-2022

select * from Retail_sales
where category = 'Clothing'
and quantiy >= '4'
and To_char(sale_date, 'yyyy-mm')= '2022-11'

-- Q.3 Write a SQL query to calculate the total sales for each category.

select
    category,
    sum(total_sale) as net_sale
from Retail_sales
group by category
order by net_sale desc;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
   ROUND(avg(age),2) as Avg_age
from Retail_sales
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from Retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
   category,
   gender,
   count(transactions_id) as Total_trans
from Retail_sales
group by  
   category,
   gender
order by category;
   
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
   extract (month from sale_date)as Months,
   Round(Avg(total_sale)::numeric,2)as Avg_sale
from Retail_sales
group by Months
order by Months;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

Select customer_id,
       sum(total_sale) as Total_sales
from Retail_sales
group by customer_id
order by Total_sales desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select
   category,
   count( distinct customer_id) as cust_count
from Retail_sales
group by category   
order by cust_count desc ;

-- Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17)

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



