with cte as (
select * from [dbo].['2018$'] union
select * from[dbo].['2019$'] union
select * from[dbo].['2020$'])
select  cte.arrival_date_year, round(sum(cte.adr*(cte.stays_in_week_nights+stays_in_weekend_nights) ),2)as revenue  from cte
group by cte.arrival_date_year

with cte as (
select * from [dbo].['2018$'] union
select * from[dbo].['2019$'] union
select * from[dbo].['2020$'])
select *  from cte
LEFT JOIN 
market_segment$ ON 
CTE. market_segment= market_segment$.market_segment
LEFT JOIN
meal_cost$ ON
CTE.meal= meal_cost$.meal
