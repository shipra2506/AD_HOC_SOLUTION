Atliq Hardwares Data Analytics Challenge:

Welcome to the Atliq Hardwares Data Analytics Challenge! As an aspiring junior data analyst, your task is to analyze the given dataset and provide insights to address the 10 ad hoc requests outlined in the 'ad-hoc-requests.pdf' file. The goal is to help the top-level management at Atliq Hardwares make quick and informed decisions based on data.

Project Overview:

Atliq Hardwares is a leading computer hardware producer in India, with a global presence. The management has identified the need for better insights to support decision-making. To assess potential candidates for the data analytics team, Tony Sharma, the data analytics director, has designed a SQL challenge to evaluate both technical and soft skills.

Task Details:

Data Analysis: Utilize SQL queries to address the 10 ad hoc requests specified in 'ad-hoc-requests.pdf.' Analyze the data from the 'gdb023' (atliq_hardware_db) database.

Target Audience: The insights will be presented to the top-level management. Therefore, your presentation should be tailored to this audience.

Presentation: Be creative with your presentation. Consider creating an audio/video presentation to enhance your communication of insights.

Tools Used:

SQL: For querying and analyzing data in the 'gdb023' database. Power BI: To visualize and create interactive dashboards. PowerPoint: For crafting a compelling presentation.

Dataset Overview:

dim_customer Table: customer_code: Unique identification codes for customers. customer: Names of customers. platform: Means of selling products ("Brick & Mortar" or "E-Commerce"). channel: Distribution methods ("Retailers," "Direct," "Distributors"). market: Countries in which customers are located. region: Geographic categorization ("APAC," "EU," "NA," "LATAM"). sub_zone: Further breakdown of regions into sub-regions.

dim_product Table: product_code: Unique identification codes for each product. division: Categorization of products into groups. segment: Further categorization of products within divisions. category: Classification of products into subcategories. product: Names of individual products. variant: Classification of products based on features, prices, etc.

fact_gross_price Table: product_code: Unique identification codes for each product. fiscal_year: Fiscal period of product sale. gross_price: Initial price of a product.

fact_manufacturing_cost Table: product_code: Unique identification codes for each product. cost_year: Fiscal year in which the product was manufactured. manufacturing_cost: Total cost for the production of a product.

fact_pre_invoice_deductions Table: customer_code: Unique identification codes for customers. fiscal_year: Fiscal period when the sale occurred. pre_invoice_discount_pct: Percentage of pre-invoice deductions for each product.

fact_sales_monthly Table: date: Date of product sale in monthly format for 2020 and 2021. product_code: Unique identification code for each product. customer_code: Unique identification codes for customers. sold_quantity: Number of units sold. fiscal_year: Fiscal period when the sale occurred. Feel free to be creative in your analysis and presentation. Good luck with the challenge.
