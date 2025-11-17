use [pizza]
go


---total revenu
create or alter view total_revenu as
select sum(total_price) as total_revenu
from pizza_sales$
go
---- average order value
create or alter view average_order_value as
select sum(total_price)/COUNT(distinct order_id) as average_order_value
from pizza_sales$
go
---no of order
create or alter view no_of_order as
select COUNT(distinct order_id) as no_order
from pizza_sales$
go
-- quantity of pizza
create or alter view quantity_of_pizza as
select sum(quantity) as total_quantity
from pizza_sales$
 go

 -- average pizza sales per  order
 create or alter view averag_pizza_sales_per_order as
 select round(sum(quantity)/COUNT(distinct order_id),2) as average_pizza_per_order
from pizza_sales$
go
------ كتابه اسم اليوم

-- عمل عمود جديد
--begin transaction
--alter table pizza_sales$
--add  day_name nvarchar(20)
--commit



 
--- اضافه اسم اليوم في العمود الجديد
--begin transaction
--update pizza_sales$
--set day_name = FORMAT(order_date,'dddd')
--from pizza_sales$
--commit

-----حساب المبيعات quantity باسم اليوم
create or alter view quantity_per_day as
select  day_name, sum(quantity) as quantity_per_day
from pizza_sales$
group by day_name
go

----حساب عدد الاوردارات باسم اليوم
create or alter view order_per_day as
select  day_name, COUNT(distinct order_id) as total_order
from pizza_sales$
group by day_name
go


----حساب البيع باسم اليوم
create or alter view sales_per_day as
select  day_name, sum(total_price) as total_order
from pizza_sales$
group by day_name
go




---حساب عدد البيتزات  باليوم
create or alter view quantity_per_day as
select  day_name, sum(quantity) as quantity
from pizza_sales$
group by day_name
go
-------حل اخر








-----  عدد  البيتزات في الشهر
create or alter view quantity_per_month as
select datename(MONTH,order_date) as month_name,sum(quantity) as quantity
from pizza_sales$
group by datename(MONTH,order_date)
go

-------عدد الاوردارات في الشهر
create or alter view order_per_month as
select datename(MONTH,order_date) as month_name,count(distinct order_id) as total_order
from pizza_sales$
group by datename(MONTH,order_date)
go
------عدد الاوردارات و الكميات في الشهر 
create or alter view order_and_q_per_month as
select datename(MONTH,order_date) as month_name,sum(quantity) as quantity 
,count(distinct order_id) as total_order
from pizza_sales$
group by datename(MONTH,order_date)
go
----------------------------
---pizza sales category 
create or alter view pizza_sales_category  as
select pizza_category,round(SUM(total_price),2) as  'total revenu' ,round(SUM(total_price) *100/sum(SUM(total_price) ) over (),2) as prcentage
from pizza_sales$
group by pizza_category
go
------declare @totalsales
--elect @totalsales = SUM(total_price)
--from pizza_sales$
--select pizza_category,round(SUM(total_price),2) as  'total revenu' 
--,cast(round(SUM(total_price),2)*100/@totalsales) over()
--from pizza_sales$
--group by pizza_category-----
-------------------

----total sales by size and prcentage
create or alter view total_sales_by_size_and_prcentage as
select pizza_size,round(sum(total_price),2) as total_revenu,
round(sum(total_price)*100/sum(sum(total_price)) over() ,2) as percentage
from pizza_sales$
group by pizza_size

go
----- Total Pizzas Sold by Pizza Category
create or alter view Total_Pizzas_Sold_by_Pizza_Category as
select pizza_category,sum(quantity) as total_quantity
from pizza_sales$
group by pizza_category
go

----G. Top 5 Pizzas by Revenue
create or alter view Top5_Pizzas_by_Revenue as
select top 5 pizza_name,sum(total_price) as total_sales
from pizza_sales$
group by pizza_name
order by sum(total_price) desc
go
---Bottom 5 Pizzas by Revenue
create or alter view Bottom5_Pizzas_by_Revenue as
select top 5 pizza_name,sum(total_price) as total_sales
from pizza_sales$
group by pizza_name
order by sum(total_price) 
go
---- Top 5 Pizzas by Quantity
create or alter view Top5_Pizzas_by_Quantity as
select top 5 pizza_name,sum(quantity) as total_quantity
from pizza_sales$
group by pizza_name
order by sum(quantity) desc
go
---Bottom 5 Pizzas by Quantity
create or alter view Bottom5_Pizzas_by_Quantity as
select top 5 pizza_name,sum(quantity) as total_quantity
from pizza_sales$
group by pizza_name
order by sum(quantity) 
go
---K. Top 5 Pizzas by Total Orders
create or alter view Top5_Pizzas_by_Total_Orders as
select top 5 pizza_name,count(distinct order_id) as total_order
from pizza_sales$
group by pizza_name
order by count(distinct order_id) desc
go
---Borrom 5 Pizzas by Total Orders
create or alter view Borrom5_Pizzas_by_Total_Order as
select top 5 pizza_name,count(distinct order_id) as total_order
from pizza_sales$
group by pizza_name
order by count(distinct order_id) 
go