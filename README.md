# Lahman Baseball Database Exploration

### Use these resources to answer the questions below, then pick an open-ended question to explore further:
- [Sean Lahman's baseball database](http://www.seanlahman.com/baseball-archive/statistics)
- [The database's data dictionary](http://www.seanlahman.com/files/database/readme2016.txt)

![image](https://user-images.githubusercontent.com/31106403/101530538-a9e18800-3957-11eb-9854-1329519b707b.png)

:baseball:  **Initial Questions**  :baseball:

[My answers with code can be found here,](https://github.com/KYandow/lahman-baseball-SQL/files/5661529/lahman-sql-answers.pdf) or by clicking each question below.

<details>
    <summary>1. What range of years does the provided database cover?</summary>

#### 1871 to 2016
```sql
SELECT MAX(f.yearid) --Use MIN for earliest
  FROM people p 
       INNER JOIN pitching i 
       ON p.playerid = i.playerid	
       INNER JOIN batting b
       ON p.playerid = b.playerid  
       INNER JOIN fielding f 
       ON p.playerid = f.playerid
```

</details>

<details>
    <summary>2. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?</summary>

#### 43 inches, Eddie Gaedel, Saint Louis Browns
```sql
SELECT height, namefirst, namelast, debut, finalgame, b.teamid
  FROM people p 
       INNER JOIN batting b 
       ON p.playerid = b.playerid
 WHERE height = 
       (SELECT MIN(height) FROM people)
```

</details>

<details>
    <summary>3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?</summary>

Earnings | schoolname | namefirst | namelast
---------|------------|-----------|----------
$245,553,888 | Vanderbilt |	David	| Price
$62,045,112	| Vanderbilt | Pedro	| Alvarez
$21,500,000	| Vanderbilt | Scott	| Sanderson
$20,512,500	| Vanderbilt | Mike |	Minor
$16,867,500	| Vanderbilt |	Joey |	Cora
$12,800,000	| Vanderbilt | Mark	| Prior
$12,183,000	| Vanderbilt | Ryan	| Flaherty
$7,920,000	| Vanderbilt | Josh	| Paul
$4,627,500	| Vanderbilt | Sonny | Gray
$4,188,836	| Vanderbilt | Mike	| Baxter
$3,702,000	| Vanderbilt | Jensen	| Lewis
$3,180,000	| Vanderbilt | Matt	| Kata
$2,000,000	| Vanderbilt | Nick	| Christiani
$1,154,400	| Vanderbilt | Jeremy	| Sowers
$540,000	| Vanderbilt | Scotti	| Madison


```sql
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
```

</details>
	

2. Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.
   
1. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?
   

1. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
	

1.  From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? What is the smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?


8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.


8. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award.


:baseball:  **Open-ended question I chose to explore**  :baseball:


1. It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. Investigate this claim and present evidence to either support or dispute this claim. First, determine just how rare left-handed pitchers are compared with right-handed pitchers. Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame?

  
