/*  Answers Question 1

select MIN(f.yearid) from people p inner join pitching i on p.playerid = i.playerid					   
					   inner join batting b on p.playerid = b.playerid
					   inner join fielding f on p.playerid = f.playerid

	Answers Question 2

select height, namefirst, namelast
from people
where height = (select MIN(height) from people)

	Answers Question 3

select SUM(sa.salary) as dough, s.schoolname, p.namefirst, p.namelast  from schools s inner join collegeplaying c on s.schoolid = c.schoolid
							   inner join people p on p.playerid = c.playerid
							   inner join salaries sa on p.playerid = sa.playerid
WHERE LOWER(s.schoolname) LIKE '%vanderbilt%'
GROUP BY namefirst, namelast, s.schoolname
ORDER BY dough DESC

	Answers Question 4

select SUM(PO) as putouts, 
	CASE WHEN pos in ('SS', '1B', '2B', '3B') THEN 'Infield'
		 WHEN pos = 'OF' THEN 'Outfield'
		 WHEN pos in ('P', 'C') THEN 'Battery' END as positional_family
from fielding
WHERE yearid = '2016'
GROUP BY positional_family

	Answers Question 5 **EXCEPT BY DECADE** (rates of both strikeouts and HRs are increasing year over year)

WITH hr_per_year AS (select yearid, SUM(HR) as total_hr, SUM(HRA) from teams
WHERE yearid >= '1920'
GROUP BY yearid),
total_games_per_year AS
(select yearid, SUM(g) / 2 as total_games from teams
WHERE yearid >= '1920'
GROUP BY yearid),
total_so_per_year AS
(select yearid, SUM(so) as total_strikeouts from teams
WHERE yearid >= '1920'
GROUP BY yearid)

select ROUND(CAST(h.total_hr / CAST(t.total_games AS float) AS numeric), 2) AS hr_per_game,
       ROUND(CAST(s.total_strikeouts / CAST(t.total_games AS float) AS numeric), 2) AS so_per_game,
	   h.yearid 
  from hr_per_year h inner join total_games_per_year t 
    on h.yearid = t.yearid
	inner join total_so_per_year s
	on h.yearid = s.yearid
ORDER BY yearid

	Answers Question 6 - Chris Owings

select 100 * (sb / CAST((sb + cs) as float)) as stolen_base_pct, p.namefirst, p.namelast, sb, cs from batting b inner join people p on p.playerid = b.playerid where b.yearid = '2016' and sb + cs >= 20
ORDER BY stolen_base_pct
*/
