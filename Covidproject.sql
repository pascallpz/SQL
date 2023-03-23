select * from [Covid-data]
order by location,date


--Total Deaths round the world
select sum(cast (new_deaths as float)) from [Covid-data]


--Deaths by Location
select location, sum(cast (new_deaths as float)) as deaths from [Covid-data]
group by location
order by location


--Deaths by continent
select continent, sum(cast (new_deaths as float)) as deaths from [Covid-data]
where continent is not null 
group by continent
order by continent

--Deaths by date
select date,sum(cast (new_deaths as float)) from [Covid-data]
group by date
order by date

--Deaths by year
select year(date) as Year,sum(cast (new_deaths as float)) deaths from [Covid-data]
group by year(date) 
order by year

--Deaths by month
select year (date)year,month(date) as month,sum(cast (new_deaths as float)) deaths from [Covid-data]
group by year (date),month(date) 
order by year, month


--Countries having 0 deaths 
select location, deaths from (
select location, sum(cast (new_deaths as float)) as deaths from [Covid-data]
group by location
)x
where deaths = 0

--Countries having min deaths 
select location, deaths from (
select location, sum(cast (new_deaths as float)) as deaths from [Covid-data]
group by location
)x
where deaths = 1


--country with max deaths
select location, sum(cast (new_deaths as float)) as deaths from [Covid-data]
where location not in ('world','high income','upper middle income', 'lower middle income','low income')
group by location
having sum(cast (new_deaths as float)) != 0
order by deaths desc


--death to population percent
select location,
sum(cast (total_deaths as float)) total_deaths,
sum(cast (population as float)) Population ,
round((cast (sum(cast (total_deaths as float))/sum(cast (population as float)) as float))*100,2) as deathvspopulation
from (select * from [Covid-data] where  cast (total_deaths as float)!= 0
and cast (population as float)!= 0)x
group by location
order by location


--Death to cases percent
select location, sum(cast (new_cases as float))newcases,sum(cast (new_deaths as float))newdeaths,
round((sum(cast (new_deaths as float))/ sum(cast (new_cases as float)))*100,2) DeathvsCases from [Covid-data]
where cast (new_cases as float) > 0 and cast (new_deaths as float)>0
group by location
order by location


select location,sum(cast (total_vaccinations as float))total_vaccinated,sum(cast (new_deaths as float))newdeaths,
sum(cast (population as float)) Population
from [Covid-data]
group by location
order by location

--percent of vaccinated
select location,sum(cast (people_fully_vaccinated as float))total_vaccinated,
sum(cast (population as float)) Population,
round(((sum(cast (people_fully_vaccinated as float)))/sum(cast (population as float))*100),2) as percentofvaccinated
from [Covid-data]
where cast (people_fully_vaccinated as float)>0
and cast (population as float)>0
group by location
order by percentofvaccinated desc
