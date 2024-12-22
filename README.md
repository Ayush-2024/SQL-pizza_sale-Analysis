# Pizza Sale Analysis

## Project Overview

This project involves analyzing the sales data of a pizza restaurant using SQL queries. The goal was to extract valuable insights about sales performance, revenue distribution, and customer preferences. By using advanced SQL techniques like **Joins**, **Subqueries**, **Aggregate Functions**, and **Window Functions**, this analysis identifies trends in pizza orders and helps to optimize inventory, pricing, and marketing strategies.

## Key Features

- **Total Revenue Analysis**: Calculated total revenue generated from pizza sales by joining relevant tables and performing aggregation.
- **Pizza Type and Size Insights**: Identified the most common pizza types, sizes, and revenue-generating pizzas based on historical sales data.
- **Time-Based Analysis**: Analyzed sales distribution by hours of the day and over time, providing insights into peak hours and trends.
- **Category-Based Performance**: Determined the most ordered pizza types per category and calculated their percentage contribution to overall revenue.
- **Advanced Query Techniques**: Utilized nested queries, window functions, and subqueries to perform deep-dive analysis and derive advanced insights.

## Technologies Used

- **SQL**: Utilized MySQL/PostgreSQL (or the relevant SQL dialect) to query and analyze data.
- **Joins**: Combined multiple tables (e.g., `orders`, `pizzas`, `pizza_types`, `order_details`) to generate comprehensive insights.
- **Aggregate Functions**: Used functions like `SUM()`, `COUNT()`, and `AVG()` to calculate total revenue, order counts, and average values.
- **Window Functions**: Applied window functions (`DENSE_RANK()`, `PARTITION BY`) to analyze top-performing pizza categories.
- **Subqueries**: Leveraged nested queries for advanced analysis, such as calculating percentage contributions to total revenue.

## Key Insights & Analysis

- **Total Orders and Revenue**: 
  - Total number of orders placed.
  - Total revenue generated from pizza sales.

- **Most Popular Pizza Types**: 
  - Identified the top 5 most ordered pizza types based on quantity.
  
- **Pizza Size Trends**: 
  - Analyzed the most common pizza size ordered by customers.

- **Category-Wise Performance**: 
  - Analyzed sales performance by pizza categories and identified the top-selling categories.

- **Revenue Distribution**: 
  - Analyzed cumulative revenue generated over time and identified high-performing periods.

## Results

- **Revenue Optimization**: The analysis provides actionable insights for improving pizza menu pricing and identifying top-selling pizza types.
- **Operational Efficiency**: Insights from time-based analysis help optimize restaurant operations, particularly for peak sales hours.
- **Strategic Insights**: The percentage revenue breakdown by pizza categories enables better inventory and marketing decisions.

## How to Use

1. Clone the repository to your local machine.
2. Open the SQL files to explore the queries and analysis steps.
3. Run the queries on your preferred SQL database (e.g., MySQL, PostgreSQL) after importing the `pizzahut` database.
4. Modify the queries to adapt them to your specific dataset or add new queries for additional analysis.

## Future Improvements

- **Visualization**: Plan to integrate SQL results with data visualization tools like Power BI or Tableau to create interactive dashboards.
- **Advanced Predictive Modeling**: Apply machine learning algorithms to predict future pizza sales based on historical trends.
- **Customer Segmentation**: Extend the analysis to include customer data (if available) for more targeted sales and marketing strategies.

## Sample Queries

Below are some of the key SQL queries used for this analysis:

### 1. Total Revenue from Pizza Sales

```sql
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM 
    order_details
    JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;
