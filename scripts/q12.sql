--Answers Question 12

--Shows correlation between the rate of wins for a season and the attendance for that season "t.yearid = a.year"
--OR adjust join to match on prior year: "t.yearid = a.year - 1"
SELECT corr(win_rate, attend_per_game) as correlation from
(select t.yearid AS wins_year, ROUND((t.w/t.g::numeric), 2) AS one_yr_win_rate, a.year AS attendance_year, a.team, a.games AS attendance_games, a.attendance, ROUND((a.attendance / a.games::numeric), 0) AS attend_per_game 
  from homegames a inner join teams t 
    on t.teamid = a.team AND t.yearid = a.year - 1
where year >= '2012' AND games > 50) as sub

--Additional subquery finds win rate over multiple seasons - higher correlation for more historically recent seasons
--Lower correlation for larger ranges of years
select corr(avg_win_rate, avg_attend) as correlation from
(select AVG(attend_per_game) as avg_attend, attendance_year, team, AVG(AVG(win_rate)) OVER (PARTITION BY attendance_year, team) AS avg_win_rate FROM
(select t.yearid AS wins_year, ROUND((t.w/t.g::numeric), 2) AS win_rate, a.year AS attendance_year, a.team, a.games AS attendance_games, a.attendance, ROUND((a.attendance / a.games::numeric), 0) AS attend_per_game 
  from homegames a inner join teams t 
    on t.teamid = a.team AND t.yearid <= a.year - 1 AND t.yearid > a.year - 8
where year >= '1950' AND games > 50) as sub
GROUP BY attendance_year, team) grouped_sub


--Playoff attendance appears to improve attendance in subsequent seasons (but hard to tell if that is causal)
--Teams that sell more tickets in the first place might just have more money for good players leading them to end up
--In the playoffs...
--Doesn't matter the level of playoff - any spot in the playoffs has seemingly about equal chance to improve attendance

WITH teams_appended AS
(select yearid, teamid,
  CASE WHEN wswin = 'Y' THEN '1World Series'
       WHEN lgwin = 'Y' THEN '2League'
	   WHEN divwin = 'Y' THEN '3Division'
	   WHEN wcwin = 'Y' THEN '4Wild Card' 
	   ELSE null END as furthest from teams)	   

select furthest, AVG(AVG(ROUND((a.attendance / a.games::numeric), 0))) OVER (PARTITION BY furthest) AS avg_attend_per_game 
  from homegames a inner join teams_appended t 
    on t.teamid = a.team AND t.yearid = a.year - 1
where a.year >= '1970' AND a.games > 50  --Use years since 1970 because that is start of the divisions
GROUP BY furthest





