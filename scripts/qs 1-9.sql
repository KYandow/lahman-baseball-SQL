--Answers Question 1 

--Use MIN to find earliest year / MAX for latest
SELECT MAX(f.yearid) 
  FROM people p 
       INNER JOIN pitching i 
       ON p.playerid = i.playerid	
       INNER JOIN batting b
       ON p.playerid = b.playerid  
       INNER JOIN fielding f 
       ON p.playerid = f.playerid

--Answers Question 2

SELECT height, namefirst, namelast, debut, finalgame, b.teamid
  FROM people p 
       INNER JOIN batting b 
       ON p.playerid = b.playerid
 WHERE height = 
       (SELECT MIN(height) FROM people)

--Answers Question 3

SELECT SUM(sa.salary) AS dough, 
       s.schoolname, p.namefirst, p.namelast  
  FROM schools s 
       INNER JOIN collegeplaying c 
       ON s.schoolid = c.schoolid
	  INNER JOIN people p 
       ON p.playerid = c.playerid
	  INNER JOIN salaries sa 
       ON p.playerid = sa.playerid
 WHERE LOWER(s.schoolname) LIKE '%vanderbilt%'
 GROUP BY namefirst, namelast, s.schoolname
 ORDER BY dough DESC

--Answers Question 4

SELECT SUM(PO) AS putouts, 
	  CASE WHEN pos in ('SS', '1B', '2B', '3B') 
            THEN 'Infield'
	       WHEN pos = 'OF' 
            THEN 'Outfield'
	       WHEN pos in ('P', 'C') 
            THEN 'Battery' 
            END AS positional_family
FROM fielding
WHERE yearid = '2016'
GROUP BY positional_family

--Answers Question 5
--Rates of both strikeouts and HRs are increasing.

WITH hr_per_year AS 
     (SELECT yearid, SUM(HR) AS total_hr, SUM(HRA) 
        FROM teams
       WHERE yearid >= '1920'
       GROUP BY yearid),
     total_games_per_year AS
     (SELECT yearid, SUM(g) / 2 AS total_games 
        FROM teams
       WHERE yearid >= '1920'
       GROUP BY yearid),
     total_so_per_year AS
     (SELECT yearid, SUM(so) AS total_strikeouts FROM teams
       WHERE yearid >= '1920'
       GROUP BY yearid);

SELECT DISTINCT ROUND(AVG(hr_per_game) 
       OVER(PARTITION BY decade), 2) AS avg_hr_per_game, 
       ROUND(AVG(so_per_game) 
       OVER(PARTITION BY decade), 2) AS avg_so_per_game,
	  decade 
  FROM (SELECT ROUND(CAST(h.total_hr / CAST(t.total_games AS             float) AS numeric), 2) AS hr_per_game, ROUND(CAST(s.total_strikeouts / CAST(t.total_games AS float) AS numeric), 2) AS so_per_game,
	   (10 * DATE_PART('decade', TO_DATE(h.yearid::text, 'YYYY'))) AS decade
  FROM hr_per_year h 
       INNER JOIN total_games_per_year t 
       ON h.yearid = t.yearid
	  INNER JOIN total_so_per_year s
	  ON h.yearid = s.yearid) AS foo
 ORDER BY decade

-- Answers Question 6 - Chris Owings

SELECT 100 * (sb / (sb + cs)::float) AS stolen_base_pct,
       p.namefirst, p.namelast, sb, cs 
  FROM batting b 
       INNER JOIN people p 
       ON p.playerid = b.playerid 
 WHERE b.yearid = '2016' and sb + cs >= 20
 ORDER BY stolen_base_pct

--Answers Question 7
--Most Wins no Series - 2001 Mariners
--Least Wins with Series - LA Dodgers 
--1981 strike, Atlanta Braves 
--1995 also a strike, but smaller
--Pct Series winner won most: 22.6%

SELECT yearid, name, /*MIN*/MAX(w)FROM teams
 WHERE yearid >= 1970 
   AND yearid <> 1981 
   AND wswin = 'N' /*'Y'*/
 GROUP BY yearid, name
 ORDER BY /*MIN*/MAX(w) DESC;	

WITH sub AS 
     (SELECT distinct yearid, MAX(w) 
        OVER (PARTITION BY yearid) AS top_wins 
        FROM teams
       WHERE yearid >= 1970 ORDER BY yearid)

SELECT 
	 (SELECT COUNT(*) 
         FROM teams t 
              INNER JOIN sub s 
              ON t.yearid = s.yearid
        WHERE top_wins = w 
              AND t.wswin = 'Y') / 
	 (SELECT COUNT(*) 
         FROM teams t 
              INNER JOIN sub s 
              ON t.yearid = s.yearid
        WHERE top_wins = w)::float

--Answer to Number 8

SELECT team, h.park, p.park_name, 
       (attendance / games::numeric) AS avg_attend 
  FROM homegames h 
       INNER JOIN parks p 
       ON h.park = p.park
 WHERE year = '2016' 
       AND games >= 10
 ORDER BY avg_attend DESC --ORDER BY avg_attend ASC
 LIMIT 5;

--Answer to Number 9

 WITH al_awards AS 
      (SELECT a.yearid AS al_year, m.teamid AS al_team,        	  	 p.namefirst, p.namelast, 
	 awardid AS al_award, a.playerid, a.lgid 
 FROM managers m 
      INNER JOIN awardsmanagers a 
	 ON m.playerid = a.playerid 
         AND m.yearid = a.yearid 
         AND m.lgid = a.lgid
      INNER JOIN people p 
      ON p.playerid = m.playerid				   
WHERE awardid = 'TSN Manager of the Year' 
  AND a.lgid = 'AL'),
	 
	 nl_awards AS 
      (SELECT a.yearid AS nl_year, m.teamid AS nl_team,                        	 p.namefirst, p.namelast, awardid AS nl_award, 
      a.playerid, a.lgid 
 FROM managers m 
      INNER JOIN awardsmanagers a 
	 ON m.playerid = a.playerid 
         AND m.yearid = a.yearid 
         AND m.lgid = a.lgid
      INNER JOIN people p 
      ON p.playerid = m.playerid				   
WHERE awardid = 'TSN Manager of the Year' 
  AND a.lgid = 'NL')

SELECT DISTINCT al_award, nl_award, 
                al_year, nl_year, 
                al_team, nl_team, a.namefirst, a.namelast 
  FROM al_awards a 
       INNER JOIN nl_awards n 
       ON a.playerid = n.playerid





