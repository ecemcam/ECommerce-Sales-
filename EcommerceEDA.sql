--Creating Database and necessary tables for my csv Files to be copied.

create database ecommerce;

--This table holds info about the order and Customer.
create table ecommerce(
customer_id	 varchar,
customer_first_name varchar(50),
customer_last_name	varchar(50),
category_name	varchar(50),
product_name	varchar(255),
customer_segment	varchar(50),
customer_city	varchar(50),
customer_state	varchar(50),
customer_country	varchar(50),
customer_region   varchar(50),
delivery_status	varchar(50),
order_date	date,
order_id	varchar,
ship_date	date,
shipping_type	varchar(50),
days_for_shipment_scheduled	int,
days_for_shipment_real	int,
order_item_discount	decimal,
sales_per_order	decimal,
order_quantity	int,
profit_per_order decimal
);

--This table holds info about US States.
create table states(
state	varchar(50),
latitude	decimal, 
longitude	decimal,
name	varchar(50)
);


select *from ecommerce;
select *from states;


--Yearly Sales Amount in US. 
select extract('year' from order_date) as Year, 
		round(sum(sales_per_order),2)|| '$' as Yearly_Sales 
from ecommerce
group by extract('year' from order_date)
order by extract('year' from order_date) asc;


--Yearly Sales Growth Rate 
select 
		Year,
		round(Yearly_Sales,2) || '$' as YTD_Sales, 
		round( lag(Yearly_Sales, 1) over(), 2) || '$' as PYTD_Sales, 
		round( 100.0*( ( Yearly_Sales-(lag(Yearly_Sales, 1) over()) ) / lag(Yearly_Sales, 1) over() ),2) || '%' as Sales_Growth_Rate
		
from (
		select extract('year' from order_date) as Year, 
			sum(sales_per_order) as Yearly_Sales 
		from ecommerce
		group by extract('year' from order_date)
		order by extract('year' from order_date) asc
);

--Sales are decreasing for the next year.


--Sales Growth Rate for a Particular Product Category. 
--Office Supplies and Technology are deacreasing 


select 
		Year,
		round(Yearly_Sales,2) || '$' as YTD_Sales, 
		round( lag(Yearly_Sales, 1) over(), 2) || '$' as PYTD_Sales, 
		round( 100.0*( ( Yearly_Sales-(lag(Yearly_Sales, 1) over()) ) / lag(Yearly_Sales, 1) over() ),2) || '%' as Sales_Growth_Rate
		
from (
		select extract('year' from order_date) as Year, 
			sum(sales_per_order) as Yearly_Sales 
		from ecommerce
		where category_name ilike 'Office Supplies'
		group by extract('year' from order_date)
		order by extract('year' from order_date) asc
);


--Yearly Profit Amount in US. 
select extract('year' from order_date) as Year, 
		round(sum(profit_per_order),2) || '$' as Yearly_Sales 
from ecommerce
group by extract('year' from order_date)
order by extract('year' from order_date) asc;


--Monthly Profit Amount for a particular year in US. 
select to_char(order_date, 'Mon') as Month, 
		round(sum(profit_per_order),2)|| '$' as Yearly_Sales 
from ecommerce
where extract('year' from order_date) = 2022
group by extract('month' from order_date), to_char(order_date, 'Mon')
order by extract('month' from order_date) asc;


-- Yearly Profit Growth Rate. 
select 
		Year,
		round(Yearly_Profit,2) || '$' as YTD_Sales, 
		round( lag(Yearly_Profit, 1) over(), 2) || '$' as PYTD_Profit, 
		round( 100.0*( ( Yearly_Profit-(lag(Yearly_Profit, 1) over()) ) / lag(Yearly_Profit, 1) over() ),2) || '%' as Profit_Growth_Rate
		
from (
		select extract('year' from order_date) as Year, 
			sum(profit_per_order) as Yearly_Profit 
		from ecommerce
		group by extract('year' from order_date)
		order by extract('year' from order_date) asc
);

--Profit is deacreasing for the next year.



--Profit Growth Rate for a Particular Product Category. 
--Furniture is deacreasing.

select 
		Year,
		round(Yearly_Profit,2) || '$' as YTD_Sales, 
		round( lag(Yearly_Profit, 1) over(), 2) || '$' as PYTD_Profit, 
		round( 100.0*( ( Yearly_Profit-(lag(Yearly_Profit, 1) over()) ) / lag(Yearly_Profit, 1) over() ),2) || '%' as Profit_Growth_Rate
		
from (
		select extract('year' from order_date) as Year, 
			sum(profit_per_order) as Yearly_Profit 
		from ecommerce
		where category_name ilike 'Furniture'
		group by extract('year' from order_date)
		order by extract('year' from order_date) asc
);



--Yearly Order Quantity Amount.
select extract('year' from order_date) as Year, 
		sum(order_quantity) as Yearly_Quantity
from ecommerce
group by extract('year' from order_date)
order by extract('year' from order_date) asc;


-- Yearly Order Quantity Growth Rate. 
select 
		Year,
		Yearly_Order_Quantity as YTD_Order_Quantity, 
		lag(Yearly_Order_Quantity , 1) over() as PYTD_Order_Quantity, 
		round( 100.0 *( ( Yearly_Order_Quantity -(lag(Yearly_Order_Quantity , 1) over()) ) / nullif(lag(Yearly_Order_Quantity, 1) over()::decimal, 0) ), 2) || '%' as Order_Quantity_Growth_Rate	
from (
		select extract('year' from order_date) as Year, 
			sum(order_quantity) as Yearly_Order_Quantity 
		from ecommerce
		group by extract('year' from order_date)
		order by extract('year' from order_date) asc
);

--Order Quantity is deacreasing for the next year.


--Yearly and Montly order Quantity Amount. 
select to_char(order_date, 'Mon') as Month, 
		sum(order_quantity) as Yearly_Quantity 
from ecommerce
where extract('year'from order_date) = 2022
group by extract('month' from order_date), to_char(order_date, 'Mon')
order by extract('month' from order_date) asc;


--yearly Profit Margin
--Is increasing for the next year.

select extract('year' from order_date) as Year, 
		round( 100.0* (sum(profit_per_order) / sum(sales_per_order)), 2) || '%' as Profit_Margin
from ecommerce
group by extract('year' from order_date)
order by extract('year' from order_date) asc;


-- Yearly Profit Margin Growth Rate. 
select 
		Year,
		round( Profit_Margin, 2)  as YTD_Profit_Margin, 
		round( lag(Profit_Margin , 1) over() ,2 ) as PYTD_Profit_Margin, 
		round( 100.0 *( ( Profit_Margin -(lag(Profit_Margin , 1) over()) ) / nullif(lag(Profit_Margin, 1) over()::decimal, 0) ), 2) || '%' as Profit_Margin_Growth_Rate	
from (
		select extract('year' from order_date) as Year, 
			sum(profit_per_order) / sum(sales_per_order) as Profit_Margin
		from ecommerce
		group by extract('year' from order_date)
		order by extract('year' from order_date) asc
);



--Sales Yearly Growth per a specific Region.
--Central Region is decreasing. 
select 
		Year,
		customer_region,
		round(Yearly_Sales,2) || '$' as YTD_Sales, 
		round( lag(Yearly_Sales, 1) over(), 2) || '$' as PYTD_Sales, 
		round( 100.0*( ( Yearly_Sales-(lag(Yearly_Sales, 1) over()) ) / lag(Yearly_Sales, 1) over() ),2) || '%' as Sales_Growth_Rate
		
from (
		select extract('year' from order_date) as Year,
			customer_region,
			sum(sales_per_order) as Yearly_Sales 
		from ecommerce
		group by extract('year' from order_date), customer_region
		order by extract('year' from order_date) asc
)
where customer_region ilike 'central';


--Region Sales Percentage for a Specific Year. 
--West Region has the highest Rate. 
select 
		Year,
		customer_region,
		round( ( Yearly_Sales / 1000000) ,2) || '$' as YTD_Sales_Millions, 
		round( 100.0* ( Yearly_Sales / ( sum(Yearly_Sales) over() ) ) ,2 ) || '%' as Sales_Region_Rate
		
from (
		select extract('year' from order_date) as Year,
			customer_region,
			sum(sales_per_order) as Yearly_Sales 
		from ecommerce
		group by extract('year' from order_date), customer_region
		order by extract('year' from order_date) asc
)
where year = 2022;



--Yearly Sales Growth for a Particular State.

select 
		Year,
		customer_state,
		round(Yearly_Sales,2) || '$' as YTD_Sales, 
		round( lag(Yearly_Sales, 1) over(), 2) || '$' as PYTD_Sales, 
		round( 100.0*( ( Yearly_Sales-(lag(Yearly_Sales, 1) over()) ) / lag(Yearly_Sales, 1) over() ),2) || '%' as Sales_Growth_Rate
		
from (
		select extract('year' from order_date) as Year,
			customer_state,
			sum(sales_per_order) as Yearly_Sales 
		from ecommerce
		group by extract('year' from order_date), customer_state
		order by extract('year' from order_date) asc
)
where customer_state ilike 'california';



--Yearly Sales Percentage for a particular Shipping type
--Standard Shipping type has the most sale Percentage
select 
		Year,
		shipping_type,
		round( ( Yearly_Sales / 1000000) ,2) || '$' as YTD_Sales_Millions, 
		round( 100.0* ( Yearly_Sales / ( sum(Yearly_Sales) over() ) ) ,2 ) || '%' as Sales_Shipping_Type_Rate
		
from (
		select extract('year' from order_date) as Year,
			shipping_type,
			sum(sales_per_order) as Yearly_Sales 
		from ecommerce
		group by extract('year' from order_date), shipping_type
		order by extract('year' from order_date) asc
)
where year = 2022
order by round( ( Yearly_Sales / 1000000) ,2) desc;


--Yearly Sales Percentage for a particular Shipping type and Customer Segment
--Standard Shipping type has the most sale Percentage
select 
		Year,
		shipping_type,
		customer_segment,
		round( ( Yearly_Sales / 1000000) ,2) || '$' as YTD_Sales_Millions, 
		round( 100.0* ( Yearly_Sales / ( sum(Yearly_Sales) over() ) ) ,2 ) || '%' as Sales_Shipping_Type_Rate
		
from (
		select extract('year' from order_date) as Year,
			shipping_type,customer_segment,
			
			sum(sales_per_order) as Yearly_Sales 
		from ecommerce
		group by extract('year' from order_date), shipping_type, customer_segment
		order by extract('year' from order_date) asc
)
where year = 2022 and customer_segment ilike 'corporate'
order by round( ( Yearly_Sales / 1000000) ,2) desc;




--Top 5 Product by the highest sales  
select extract('year' from order_date) as Year, 
		product_name, 
		round(sum(sales_per_order),2)|| '$' as Yearly_Sales 
from ecommerce
where extract('year' from order_date) = 2022
group by extract('year' from order_date), product_name
order by round(sum(sales_per_order),2) desc 
limit 5;


--Bottom 5 Product by the lowest sales  
select extract('year' from order_date) as Year, 
		product_name, 
		round(sum(sales_per_order),2)|| '$' as Yearly_Sales 
from ecommerce
where extract('year' from order_date) = 2022
group by extract('year' from order_date), product_name
order by round(sum(sales_per_order),2) asc 
limit 5;






		