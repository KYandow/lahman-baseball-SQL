# Lahman Baseball Database Exploration

### Use these resources to answer the questions below, then pick an open-ended question to explore further:
- [Sean Lahman's baseball database](http://www.seanlahman.com/baseball-archive/statistics)
- [The database's data dictionary](http://www.seanlahman.com/files/database/readme2016.txt)

![image](https://user-images.githubusercontent.com/31106403/101530538-a9e18800-3957-11eb-9854-1329519b707b.png)

:baseball:  **Initial Questions**  :baseball:

[My answers with code can be found here.](https://github.com/KYandow/lahman-baseball-SQL/files/5661529/lahman-sql-answers.pdf)

1. 
<details>
    <summary>What range of years does the provided database cover?

    #### 1871 to 2016
```sql
--Use MIN to find earliest year / MAX for latest
SELECT MAX(f.yearid) 
  FROM people p 
       INNER JOIN pitching i 
       ON p.playerid = i.playerid	
       INNER JOIN batting b
       ON p.playerid = b.playerid  
       INNER JOIN fielding f 
       ON p.playerid = f.playerid
```

</details>

1. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?
   

1. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
	

2. Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.
   
1. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?
   

1. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
	

1.  From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? What is the smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?


8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.


8. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award.


:baseball:  **Open-ended question I chose to explore**  :baseball:


1. It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. Investigate this claim and present evidence to either support or dispute this claim. First, determine just how rare left-handed pitchers are compared with right-handed pitchers. Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame?

  
