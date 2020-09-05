/*  Answers Question 1 

--Use MIN to find earliest year / MAX for latest
select MAX(f.yearid) from people p inner join pitching i on p.playerid = i.playerid					   
					   inner join batting b on p.playerid = b.playerid
					   inner join fielding f on p.playerid = f.playerid

	Answers Question 2

select height, namefirst, namelast, debut, finalgame, b.teamid
from people p inner join batting b on p.playerid = b.playerid
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

	Answers Question 5 (rates of both strikeouts and HRs are increasing decade over decade)

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

select distinct ROUND(AVG(hr_per_game) OVER(PARTITION BY decade), 2) as avg_hr_per_game, 
       ROUND(AVG(so_per_game) OVER(PARTITION BY decade), 2) as avg_so_per_game,
	   decade
	   from

(select ROUND(CAST(h.total_hr / CAST(t.total_games AS float) AS numeric), 2) AS hr_per_game,
       ROUND(CAST(s.total_strikeouts / CAST(t.total_games AS float) AS numeric), 2) AS so_per_game,
	   (10 * DATE_PART('decade', TO_DATE(h.yearid::text, 'YYYY'))) as decade
  from hr_per_year h inner join total_games_per_year t 
    on h.yearid = t.yearid
	inner join total_so_per_year s
	on h.yearid = s.yearid) as foo

ORDER BY decade

	Answers Question 6 - Chris Owings

select 100 * (sb / (sb + cs)::float) as stolen_base_pct, p.namefirst, p.namelast, sb, cs from batting b inner join people p on p.playerid = b.playerid where b.yearid = '2016' and sb + cs >= 20
ORDER BY stolen_base_pct


	Answers Question 7 (maybe double check this)
	Most Wins no Series - 2001 Mariners
	Least Wins with Series - LA Dodgers 1981 strike, Atlanta Braves 1995 also a strike, but smaller
	Pct Series winner won most: 22.6%

select yearid, name, /*MIN*/MAX(w)from teams
where yearid >= 1970 AND yearid <> 1981 AND wswin = 'N' /*'Y'*/
GROUP BY yearid, name
ORDER BY /*MIN*/MAX(w) DESC;	

WITH sub AS (select distinct yearid, MAX(w) OVER (PARTITION BY yearid) as top_wins from teams
where yearid >= 1970 ORDER BY yearid)

select (select COUNT(*) from teams t inner join sub s on t.yearid = s.yearid
WHERE top_wins = w AND t.wswin = 'Y') / 
	   (select COUNT(*) from teams t inner join sub s on t.yearid = s.yearid
WHERE top_wins = w)::float

	Answer to Number 8

select team, h.park, p.park_name, (attendance / games::numeric) as avg_attend 
from homegames h inner join parks p on
h.park = p.park
where year = '2016' AND games >= 10
ORDER BY avg_attend DESC --ORDER BY avg_attend ASC
Limit 5

*/
WITH al_awards AS (select a.yearid AS al_year, m.teamid AS al_team, p.namefirst, p.namelast, awardid AS al_award, a.playerid, a.lgid from 
				   managers m inner join awardsmanagers a 
				   on m.playerid = a.playerid AND
				      m.yearid = a.yearid AND
				      m.lgid = a.lgid
				   inner join people p on p.playerid = m.playerid				   
WHERE awardid = 'TSN Manager of the Year' AND a.lgid = 'AL'),
	 nl_awards AS (select a.yearid AS nl_year, m.teamid AS nl_team, p.namefirst, p.namelast, awardid AS nl_award, a.playerid, a.lgid from 
				   managers m inner join awardsmanagers a 
				   on m.playerid = a.playerid AND
				      m.yearid = a.yearid AND
				      m.lgid = a.lgid
				   inner join people p on p.playerid = m.playerid				   
WHERE awardid = 'TSN Manager of the Year' AND a.lgid = 'NL')

select distinct al_award, nl_award, al_year, nl_year, al_team, nl_team, a.namefirst, a.namelast 
  from al_awards a inner join nl_awards n on a.playerid = n.playerid





