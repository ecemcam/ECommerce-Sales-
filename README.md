 # Ecommerce Sales Dashboard Project
 
## Project Overview
This project presents an end-to-end Sales Dashboard using Power BI, powered by a SQL backend. It is designed for a US-based e-commerce company to analyze Year-To-Date (YTD) Sales, Profit, Quantity, and more.

## Objectives
Provide key business insights using interactive visualizations.

Track performance by product, region, state, and shipping type.

Identify top/bottom-performing products and regions.

Analyze trends through YoY comparisons and sparklines.

## Dataset & SQL Structure
SQL Script: EcommerceEDA.sql

Database: ecommerce

Tables:

ecommerce: Contains customer, order, sales, and shipment data.

states: Holds latitude, longitude, and names of U.S. states for geo-mapping.

Key Columns in ecommerce:
order_date, ship_date, order_id

customer_id, customer_region, customer_state

sales_per_order, order_quantity, profit_per_order

shipping_type, delivery_status

Key Queries Include:
YTD and PYTD Sales, Profit, and Quantity

Year-over-Year growth metrics

Top 5 / Bottom 5 Products by Sales

Sales by Region, State, and Shipping Type

## Dashboard Features
KPI Banner with YTD metrics and profit margin

Sparklines showing trends over time

Interactive charts for customer segments and regions

Trend icons indicating growth or decline

Geo maps using state coordinates from states table

## Tools & Technologies
SQL (Data preparation & ETL)

Power BI (Visualization & Dashboard)

PostgreSQL / MySQL (Any supported RDBMS)

