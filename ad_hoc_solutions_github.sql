-- Q1). Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.
-- Created Store Procedures By market_list_by_customers
	SELECT 
		distinct market
FROM
	dim_customer
WHERE
		customer ="Atliq Exclusive"
			AND
		region = "APAC";
        
-- Q2). What is the percentage of unique product increase in 2021 vs. 2020? 
-- The final output contains these fields, unique_products_2020, unique_products_2021, percentage_chg.
	
   SELECT X.A AS unique_product_2020, Y.B AS unique_products_2021, ROUND((B-A)*100/A, 2) AS percentage_chg
FROM
     (
      (SELECT COUNT(DISTINCT(product_code)) AS A FROM fact_sales_monthly
      WHERE fiscal_year = 2020) X,
      (SELECT COUNT(DISTINCT(product_code)) AS B FROM fact_sales_monthly
      WHERE fiscal_year = 2021) Y 
	 );
     
-- Q3). Provide a report with all the unique product counts for each segment and sort them in descending order
-- of product counts. The final output contains 2 fields, segment product_count

	SELECT
		segment, count(distinct product_code) AS product_count
FROM
		dim_product
GROUP BY
		segment
ORDER BY
		product_count desc;


-- Q4). Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
-- The final output contains these fields segment, product_count_2020, product_count_2021, difference

With cte as (SELECT segment,
    COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END) AS a,
    COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN product_code END) AS b
FROM
		dim_product p 
        JOIN
        fact_sales_monthly s
			using(product_code)
GROUP BY 1)

Select cte.segment, cte.a as product_count_2020, cte.b product_count_2021, abs(round((a-b))) as difference
From cte;

-- Q5). Get the products that have the highest and lowest manufacturing costs. 
-- The final output should contain these fields, product_code, product, manufacturing_cost

SELECT F.product_code, P.product, F.manufacturing_cost 
FROM fact_manufacturing_cost F JOIN dim_product P
ON F.product_code = P.product_code
WHERE manufacturing_cost
IN (
	SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost
    UNION
    SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost
    ) 
ORDER BY manufacturing_cost DESC ;

-- Q6). Generate a report which contains the top 5 customers who received an average high 
-- pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. 
-- The final output contains these fields, customer_code, customer, average_discount_percentage.

SELECT 
		c.customer_code, c.customer, Round(avg(pre_invoice_discount_pct),4) as average_discount_percentage
FROM 
		dim_customer c
        JOIN
        fact_pre_invoice_deductions id
        using(customer_code)
Where
		fiscal_year = 2021
        AND
        market = 'India'
GROUP BY
		c.customer_code, c.customer
ORDER BY 
		average_discount_percentage desc
Limit 5;

-- Q7). Get the complete report of the Gross sales amount for the customer Atliq Exclusive 
-- for each month. This analysis helps to get an idea of low and high-performing months and take 
-- strategic decisions. The final report contains these columns: Month,Year, Gross sales Amount

SELECT
		MONTH(date) as Month, YEAR(date) as Year, SUM((sold_quantity*gross_price)) as Gross_sales_Amt
fROM 
	fact_sales_monthly f
    JOIN
    fact_gross_price g
    using(product_code,fiscal_year)
    JOIN
    dim_customer
    using(customer_code)
Where customer = 'Atliq Exclusive'
GROUP BY
		Month,Year
ORDER BY Year,Month;


-- Q8). In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these 
-- fields sorted by the total_sold_quantity, Quarter, total_sold_quantity

SELECT 
		CASE 
			WHEN MONTH(date) in (9,10,11)  THEN 'Q1'
			WHEN MONTH(date) IN (12,1,2) THEN 'Q2'
			WHEN MONTH(date) IN (3,4,5) THEN 'Q3'
			ELSE 'Q4'
        END AS QUARTER,
        SUM(sold_quantity) as total_sold_quantity
FROM fact_sales_monthly 
WHERE fiscal_year = 2020
GROUP BY 
		QUARTER
ORDER By
		total_sold_quantity desc;


-- Q9). Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of 
-- contribution? The final output contains these fields, channel,gross_sales_mln,percentage

WITH cte as (
SELECT 
		channel, ROUND(SUM((sold_quantity*gross_price))/1000000,2) as gross_sales_mln
FROM 
	fact_sales_monthly f
    JOIN
    fact_gross_price g
    using(product_code,fiscal_year)
    JOIN
    dim_customer
    using(customer_code)
WHERE 
		fiscal_year = 2021
GROUP By
		channel)

SELECT 
		channel, gross_sales_mln , ROUND((gross_sales_mln/sum(gross_sales_mln) OVER())*100,2) as percentage
FROM
		cte
GROUP by 1,2;


-- Q10). Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
-- The final output contains these fields,division,product_code,product,total_sold_quantity,rank_order

SELECT *
FROM ( SELECT 
		division, product_code, product, SUM(sold_quantity) as total_sold_quantity, dense_rank() over(partition by division order by SUM(sold_quantity) desc) as rnk
FROM 
	fact_sales_monthly f
    JOIN
    dim_product p
    using(product_code)
GROUP BY
		division, product_code, product) t
WHERE
		rnk <=3;







	
	






        
        

