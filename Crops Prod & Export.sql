use crops

select * from Products

select distinct([PRODUCT GROUP]) from Products

select product,[PRODUCT GROUP] from Products

select [PRODUCT GROUP],sum(qty) as total_prdt_grp from Products
group by [PRODUCT GROUP]

select PRODUCT,sum(qty) as total_prdts from Products
group by [PRODUCT]

select PRODUCT,sum(qty) as total_prdts,YEAR from Products
group by [PRODUCT],YEAR

select [PRODUCT GROUP],sum(qty) as total_prdts,YEAR from Products
group by YEAR,[PRODUCT group] 

select [PRODUCT GROUP],sum([Rs# Lacs]) as total_prdts_Rs,sum(US$)as USD,YEAR from Products
group by YEAR,[PRODUCT group]

select [PRODUCT GROUP],sum(qty)as total_qty,YEAR from Products
where year='2019-2020'
group by [PRODUCT GROUP],YEAR
order by 2 desc

select [PRODUCT GROUP],sum(qty)as total_qty,YEAR from Products
where year='2020-2021'
group by [PRODUCT GROUP],YEAR
order by 2 desc

select [PRODUCT GROUP],sum(qty)as total_qty,YEAR from Products
where year='2021-2022'
group by [PRODUCT GROUP],YEAR
order by 2 desc

select top 10 [PRODUCT GROUP],sum(qty) as total_qty, year from Products
group by [PRODUCT GROUP],YEAR
order by 2 desc 

with x as (select [PRODUCT GROUP],sum([Rs# Lacs]) as total_prdts_Rs,sum(US$)as USD,YEAR from Products
group by YEAR,[PRODUCT group])
select *,round(lead(total_prdts_rs) over (partition by [PRODUCT GROUP] order by [PRODUCT GROUP])-total_prdts_Rs,2)as growth_in_qty from x


with x as (select [PRODUCT GROUP],sum([Rs# Lacs]) as total_prdts_Rs,sum(US$)as USD,YEAR from Products
group by YEAR,[PRODUCT group])
select *,round(lead(total_prdts_rs) over (partition by [PRODUCT GROUP] order by [PRODUCT GROUP])/total_prdts_Rs,2)as [growth%_in_qty] from x


with x as (select [PRODUCT GROUP],sum([Rs# Lacs]) as total_prdts_Rs,sum(US$)as USD,YEAR from Products
group by YEAR,[PRODUCT group])
select *,round(lead(usd) over (partition by [PRODUCT GROUP] order by [PRODUCT GROUP])-usd,2)as [growth%_in_usd] from x


with x as (select [PRODUCT GROUP],sum([Rs# Lacs]) as total_prdts_Rs,sum(US$)as USD,YEAR from Products
group by YEAR,[PRODUCT group])
select *,round(lead(usd) over (partition by [PRODUCT GROUP] order by [PRODUCT GROUP])/usd,2)as [growth%_in_usd] from x

select sum([Rs# Lacs]) as Total_price_rs, sum(US$)Total_price_usd from Products

select sum([Rs# Lacs]) as Total_price_rs, sum(US$)Total_price_usd,YEAR from Products
group by YEAR


select sum([Rs# Lacs]) as Total_price_rs, sum(US$)Total_price_usd,YEAR,[PRODUCT GROUP] from Products
group by YEAR,[PRODUCT GROUP]

select product,avg(US$) over (partition by product)from Products
order by PRODUCT

select product,avg([Rs# Lacs])  as average from Products
group by PRODUCT