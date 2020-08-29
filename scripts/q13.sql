WITH pitchers AS
(select playerid, SUM(g) AS total_games from pitching
group by playerid
having SUM(g) > 30)
foo AS
select count from foo where throws = 'L'

(select distinct count(p.playerid) OVER (PARTITION BY throws) , p.throws from people p inner join pitchers i on p.playerid = i.playerid
group by p.playerid) 


