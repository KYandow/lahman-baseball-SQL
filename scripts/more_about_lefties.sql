select ROUND(AVG(Babip)::numeric, 3) as Batting_Average_On_Balls_in_Play, 
	   ROUND(AVG(era)::numeric, 2) as Earned_Run_Average,
	   ROUND(AVG(k9)::numeric, 2) as Strikeouts_Per_9, 
	   ROUND(AVG(hr9)::numeric, 2) as Opponent_Home_Runs_Per_9, 
	   ROUND(AVG(vfa)::numeric, 2) as Velocity_Of_Fastball,
	   throws from pitching_2015_fg_names 
	   where throws in ('L', 'R')
	   group by throws
	   
select count(*) from pitching_2015_fg_names where throws = 'L'
select count(*) from pitching_2015_fg_names where throws = 'R'


