WITH pitchers AS
(select yearid, playerid, SUM(g) AS total_games from pitching
group by playerid, yearid
having SUM(g) > 10)

select ROUND((select count(*) as lefties 
	   from people p inner join pitchers i on p.playerid = i.playerid
	   where throws = 'L') /
	   (select count(*) as throws_r_l from people p inner join pitchers i on p.playerid = i.playerid
		where throws in ('L', 'R'))::numeric, 2) as pct
		
WITH pitchers AS
(select yearid, playerid, SUM(g) AS total_games from pitching
group by playerid, yearid
having SUM(g) > 10)

select ROUND((select count(*) from pitchers p inner join awardsplayers a on p.playerid = a.playerid and p.yearid = a.yearid inner join people e on p.playerid = e.playerid
	   where throws = 'L' AND awardid = 'Cy Young Award') /
	   (select count(*) from pitchers p inner join awardsplayers a on p.playerid = a.playerid and p.yearid = a.yearid inner join people e on p.playerid = e.playerid
	   where awardid = 'Cy Young Award')::numeric, 2) as pct

WITH pitchers AS
(select yearid, playerid, SUM(g) AS total_games from pitching
group by playerid, yearid
having SUM(g) > 10)

select ROUND((select count(*) from pitchers p inner join halloffame a on p.playerid = a.playerid inner join people e on p.playerid = e.playerid
	   where throws = 'L' AND inducted = 'Y') /
	   (select count(*) from pitchers p inner join halloffame a on p.playerid = a.playerid inner join people e on p.playerid = e.playerid
	   where inducted = 'Y')::numeric, 2) as pct
	   
/* Less Likely Hall - 22% versus 28% total pop
   More likely Cy Young - 33% versus 28% total pop */
   












