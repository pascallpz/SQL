--creating table OYO using 5 other tables
--select 
--f.booking_id ,f.property_id,f.check_in_date,f.checkout_date,f.no_guests,f.booking_platform,f.ratings_given,f.revenue_generated,F.revenue_realized,
--d.day_type,r.room_class,h.property_name,h.category,h.city,a.successful_bookings,a.capacity,f.booking_status
--from [dbo].[fact_bookings] f 
--left join
--dim_date d on 
--f.check_in_date= d.date
--left join
--dim_rooms r on 
--f.room_category= r.room_id
--join dim_hotels h
--on f. property_id=h.property_id
--join [dbo].[fact_aggregated_bookings] a
--on 
--f.check_in_date=a.check_in_date and f.property_id=a.property_id and f.room_category=a.room_category




--using database OYO
use oyo 

--checking table oyo
select * from [dbo].[oyo]

--total no of bookings
select count(booking_id) as total_no_of_bookings  from oyo
--134590

--total bookings that are successful
select count(booking_id)as 'total bookings that are successful'   from oyo
where booking_status not like 'checked out'
--40179

--total bookings that are no shows
select count(booking_id) as'total bookings that are no shows'   from oyo
where booking_status  like 'no %'
--6759


--total bookings that are cancelled
select count(booking_id)  as 'total bookings that are cancelled'  from oyo
where booking_status  like 'cance%'
--33420


--COMPLEX MEASURES
--calculate revenue hotel wise
select property_id,sum(revenue_realized) as Rev_property_wise from oyo
group by property_id
order by property_id


--calculating adr
select check_in_date, property_id,sum(revenue_realized) from oyo
group by check_in_date,property_id

--calculation of revpar
select round(revenue_realized/capacity,2) as RerPar from oyo


--calculate revenue hotel wise and room class wise
select property_id,room_class,sum(revenue_realized) as Rev_room_class_wise from oyo
group by property_id,room_class
order by property_id

--calculate revenue  room categorywise
select category,sum(revenue_realized) as Rev_category_wise from oyo
group by category

--occupancy %
select property_id,round((successful_bookings/capacity)*100,2) as 'Occ%' from oyo
group by property_id,(successful_bookings/capacity)*100

--average rating
select property_id,round(avg(ratings_given),2) as AVG_ratings from oyo
group by property_id 

--no of days
select datediff(dd,check_in_date,checkout_date) as no_of_days_stay ,* from oyo

--cancellation percent
select count(booking_status)/(select count(booking_status) from oyo where booking_status like 'cancelled') as 'cancellation%' from oyo

--total checkouts
select count(booking_status)as 'checkout%'from oyo where booking_status like 'check%' 

--no show %
select (count(booking_status)/(select count(booking_status) from oyo where booking_status like 'no %')) as 'no_show %' from oyo

--booking by platform
select booking_platform,count(booking_platform)  as Total_bookings_OTA from oyo
group by booking_platform
order by Total_bookings_OTA 


--booking by platform and property
select property_id,booking_platform,count(booking_platform)  as Total_bookings_OTA_per_property from oyo
group by property_id,booking_platform 
order by property_id

--Total_bookings_OTAay
select count(booking_id) as Total_bookings_by_day,check_in_date from Oyo
group by check_in_date
order by 1

--total bookings by day and property
select count(booking_id)Total_bookings_by_day,check_in_date,property_id from Oyo
group by check_in_date,property_id
order by 3

--rooms available for sale per day
select distinct check_in_date, capacity-successful_bookings as rooms_for_sale,property_id from Oyo
group by property_id,capacity-successful_bookings,check_in_date
order by 1 
 

--wow revenue change
select distinct DATEPART(ww,check_in_date)as week ,((sum(revenue_realized)-lag(sum(revenue_realized)) over (order by DATEPART(ww,check_in_date)))/lag(sum(revenue_realized)) over (order by DATEPART(ww,check_in_date))*100) as wow_Rev_change
from oyo
group by  DATEPART(ww,check_in_date)
order by DATEPART(ww,check_in_date) asc

--wow adr change
select distinct DATEPART(ww,check_in_date)as week ,((sum(revenue_realized/successful_bookings)-lag(sum(revenue_realized/successful_bookings)) over (order by DATEPART(ww,check_in_date)))/lag(sum(revenue_realized/successful_bookings)) over (order by DATEPART(ww,check_in_date))*100)as WOW_ADR_change
from oyo
group by  DATEPART(ww,check_in_date)
order by DATEPART(ww,check_in_date) asc

--wow revpar change
select distinct DATEPART(ww,check_in_date)as week ,((sum(revenue_realized/capacity)-lag(sum(revenue_realized/capacity)) over (order by DATEPART(ww,check_in_date)))/lag(sum(revenue_realized/capacity)) over (order by DATEPART(ww,check_in_date))*100) as wow_revpar_change
from oyo
group by  DATEPART(ww,check_in_date)
order by DATEPART(ww,check_in_date) asc

--DSRN
select round(capacity/ (datepart(dd,checkout_date)-datepart(dd,check_in_date)),2)
from oyo

select datepart(ww,check_in_date),sum(revenue_realized),property_id from oyo
group by property_id,datepart(ww,check_in_date)
order by property_id,datepart(ww,check_in_date)


















