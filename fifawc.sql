--Total tournaments held 
select count (distinct ([Tournament Id]))  from FIFAwc
where winners is not null

--World cup winning teams
select distinct ([Tournament Id]),winners  from FIFAwc
where winners is not null
and [stage name]like 'final'
group by [tournament id], winners



select * from [FIFAwc]

--UPDATE FIFAwc SET winners = case when [Home Team Win] =1 then [Home Team Name] 
--when [Away Team Win]=1 then [Away Team Name]
--end from FIFAwc 

--update fifawc set winners= 'Germany'
--where winners='West Germany'

--winners of finals
select winners,[match date] from fifawc where [stage name] = 'final' and winners is not null


--World cup wins
select winners,count(winners) world_cup_wins from FIFAwc where [Stage Name]='Final' and winners is not null
group by winners

select winners,year([match date]),sum(count(winners)) over (partition by winners) from FIFAwc where [Stage Name]='Final' and winners is not null
group by winners, year([match date])
order by winners


--matches that have reached finals,semi,quarters

select winners,[match date], [stage name] from fifawc where [stage name] in ('Final','semi-finals', 'quarter-finals')
and  winners is not null


--countries that have reached finals,semi,quarters
select [home team name], [away team name] , [match date], [stage name] from fifawc where [stage name] in ('Final','semi-finals', 'quarter-finals')



--matches that have reached elimination stage
select [home team name], [away team name] , [match date], [stage name] from fifawc where [stage name] in ('Final','semi-finals', 'quarter-finals','round of 16' )



--matched that have led to draw
select * from Fifawc
where winners  is null


--countries that have won finals in penalties
select * from FIFAwc 
where [score penalties] not like '0-0'
and [stage name] = 'Final'


--countries that have won semi finals in penalties
select * from FIFAwc 
where [score penalties] not like '0-0'
and [stage name] = 'semi-finals'


--Games that have reached extra time
select * from fifawc
where [extra time] >0

--countries that have reached penalties
select * from fifawc
where [score penalties ] not like '0-0'

--countries that have won Finals in extra time 
select winners from fifawc
where [extra time] >0
and [stage name] like 'final'
and [score penalties]  like '0-0'

select * from fifawc where [home team id] like 'T-83'
or [away team id] like 'T-83'

update fifawc set [home team name]= 'Germany'
where [home team id] like 'T-83'

update fifawc set [away team name]= 'Germany'
where [away team id] like 'T-83'