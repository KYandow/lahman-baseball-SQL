WITH pitchers AS
     (SELECT yearid, playerid, SUM(g) AS total_games 
        FROM pitching
       GROUP BY playerid, yearid
	           HAVING SUM(g) > 10)

SELECT ROUND(
       (SELECT COUNT(*) as lefties 
	     FROM people p 
               INNER JOIN pitchers i 
               ON p.playerid = i.playerid
	    WHERE throws = 'L') /
	  
       (SELECT COUNT(*) as throws_r_l 
          FROM people p 
               INNER JOIN pitchers i 
               ON p.playerid = i.playerid
	    WHERE throws in ('L', 'R'))
       ::numeric, 2) as pct;
		
WITH pitchers AS
     (SELECT yearid, playerid, SUM(g) AS total_games 
        FROM pitching
       GROUP BY playerid, yearid
      HAVING SUM(g) > 10)

SELECT ROUND(
       (SELECT COUNT(*) 
          FROM pitchers p 
               INNER JOIN awardsplayers a 
               ON p.playerid = a.playerid 
                  AND p.yearid = a.yearid 
               INNER JOIN people e 
               ON p.playerid = e.playerid
	   WHERE throws = 'L' 
          AND awardid = 'Cy Young Award') /

	  (SELECT COUNT(*) 
          FROM pitchers p 
               INNER JOIN awardsplayers a 
               ON p.playerid = a.playerid 
                  AND p.yearid = a.yearid 
               INNER JOIN people e 
               ON p.playerid = e.playerid
	    WHERE awardid = 'Cy Young Award')
        ::numeric, 2) as pct;

WITH pitchers AS
     (SELECT yearid, playerid, SUM(g) AS total_games 
        FROM pitching
       GROUP BY playerid, yearid
                HAVING SUM(g) > 10)

SELECT ROUND(
       (SELECT COUNT(*) 
          FROM pitchers p 
               INNER JOIN halloffame a 
               ON p.playerid = a.playerid 
               INNER JOIN people e 
               ON p.playerid = e.playerid
	    WHERE throws = 'L' 
           AND inducted = 'Y') /

	  (SELECT COUNT(*) 
          FROM pitchers p 
               INNER JOIN halloffame a 
               ON p.playerid = a.playerid 
               INNER JOIN people e 
               ON p.playerid = e.playerid
	    WHERE inducted = 'Y')::numeric, 2) as pct
	      












