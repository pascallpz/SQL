--select * from athlete_events
--where sex not in ('M','F')

--update athlete_events set name= name+sex,sex=age,age=Height,Height=Weight,Weight=team,Team=noc,NOC=games,Games=year,Year=Season,Season=city,city=Sport
--,Sport=Event,Event=Medal,Medal=null
--where sex not in ('M','F')


--select event, medal from athlete_events
--where medal not in ('na','gold','silver','bronze')

--update athlete_events set event = event + medal from athlete_events
--where medal not in ('na','gold','silver','bronze')


--select medal from athlete_events

--update athlete_events set  Medal= 'Gold'where Event like ('%Gold')

--select event,medal from athlete_events where Event  like ('%,Silver')

--update athlete_events set  Medal= 'Silver'where Event like ('%Silver')

--update athlete_events set  Medal= 'Bronze'where Event like ('%Bronze')

--select event from athlete_events
--where event like '%",NA'

--update athlete_events set Event= left(event,CHARINDEX(',',event,0)) from athlete_events where event like '%",NA'

--select event from athlete_events
--where event like '%",Gold'

--update athlete_events set Event= left(event,CHARINDEX(',',event,0)) from athlete_events where event like '%",Gold'

--select event from athlete_events
--where event like '%",Silver'


--update athlete_events set Event= left(event,CHARINDEX(',',event,0)) from athlete_events where event like '%",Silver'

--update athlete_events set Event= left(event,CHARINDEX(',',event,0)) from athlete_events where event like '%",Bronze'

--select * from athlete_events
--where Games like'___'



--update athlete_events set NOC=games,Games=Year,Year=season,Season=city,city=Sport  from athlete_events
--where Games like'___'


--01 How many olympics games have been held?
select count(distinct (games))  from athlete_events

--02 list down all olympics games held so far
select distinct (games) from athlete_events
order by Games

--03 Mention the total no of nations who participated in each olympics game?
select games,count(distinct(region)) from athlete_events a
join noc_regions n
on n.noc= a.noc
group by games

--04 Which year saw the highest and lowest no of countries participating in olympics?

--05. Which nation has participated in all of the olympic games

select count(distinct (games))  from athlete_events

with ctea as (select count(x.NOC)con,NOC from ( select noc, games from athlete_events
group by noc, games)x
group by x.noc
) select ctea.NOC from ctea where ctea.con=(select count(distinct (games))  from athlete_events)



--06. Identify the sport which was played in all summer olympics.

with ctex as (select sport,Year from athlete_events
where Season= 'summer'and sport is not null 
group by Year,sport)
select count (ctex.Sport)count,Sport from ctex
group by Sport
having count (ctex.Sport) = (select count(*) from (select season ,Year from athlete_events
where Season= 'summer'
group by season,Year)x)


--07. Which Sports were just played only once in the olympics.
with ctes as (select Year, sport from athlete_events
where Sport is not null
group by year,Sport
)
select count(ctes.sport),Sport from ctes
group by Sport
having  count(ctes.sport)=1

--8. Fetch the total no of sports played in each olympic games.
select count(distinct(sport)),Year from athlete_events
group by Year

--9. Fetch oldest athletes to win a gold medal
select top (2) * from athlete_events
where Medal= 'gold'and age != 'NA'
order by age desc


--10 Find the Ratio of male and female athletes participated in all olympic games.
select  (select cast(count(sex) as float) from athlete_events
where sex='M')/(select count(sex) from athlete_events
where sex='F')

--11. Fetch the top 5 athletes who have won the most gold medals.
with cte as (select count(name)coun,name, medal from athlete_events
where Medal= 'Gold'
group by name, Medal
) 
select top(5)* from cte
order by coun desc

--12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
with cte1 as (select count(name)coun ,name from athlete_events
where medal !='NA'
group by name)
select sum(coun) over (partition by name),Name from cte1
order by coun desc

--13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
select top (5) count(noc)coun,noc from athlete_events
where Medal!= 'NA'
group by noc
order by count(noc) desc

--14. List down total gold, silver and bronze medals won by each country.
with ctea as (select count(noc)coun,noc,medal from athlete_events
where Medal!= 'NA'
group by noc,medal
) select * from ctea
pivot 
(
sum(coun)
for Medal
in ([bronze],[silver],[gold])
)
as ptable


--15. List down total gold, silver and bronze medals won by each country corresponding to each olympic games.
with cte as (select Games, Noc, count(Medal)coun,Medal from athlete_events
where medal!= 'NA' or NOC!=Null
group by Games, Noc,Medal
)
select * from cte
pivot
(
sum(coun)
for medal
in ([gold],[silver],[bronze])
)as ptable
order by Games



--16. Identify which country won the most gold, most silver and most bronze medals in each olympic games.
with cte as (select ROW_NUMBER() over (partition by games order by count(medal) desc)row,Games, Noc, count(Medal)coun,Medal from athlete_events
where medal!= 'NA' or NOC!=Null
group by Games, Noc,Medal
)
select * from cte
where row in (1,2,3)




--17. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
select NOC, count(Medal),Medal from athlete_events
where medal!= 'NA' or NOC!=Null
group by rollup (NOc, Medal)

--18. Which countries have never won gold medal but have won silver/bronze medals?
select  NOC,Medal,count(medal) from athlete_events
where Medal not in ('NA','Gold')
group by noc,medal




--19. In which Sport/event, India has won highest medals.
select top(1)count(sport),Sport from athlete_events
where NOC='Ind'  and medal!= 'NA'
group by Sport
order by count(sport) desc


--20 Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
select games,count(Medal)coun from athlete_events
where NOC='Ind' and Sport= 'Hockey' and medal!= 'NA'
group by games
