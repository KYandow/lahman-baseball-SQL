select ROUND(AVG(Babip)::numeric, 3) as Batting_Average_On_Balls_in_Play, 
	   ROUND(AVG(era)::numeric, 2) as Earned_Run_Average,
	   ROUND(AVG(k9)::numeric, 2) as Strikeouts_Per_9, 
	   ROUND(AVG(hr9)::numeric, 2) as Opponent_Home_Runs_Per_9,
	   ROUND(AVG(war)::numeric, 2) as Wins_Above_Replacement,
	   ROUND(AVG(fip)::numeric, 2) as Fielding_Independent_Pitching,	   
	   ROUND(AVG(vfa)::numeric, 2) as Velocity_Of_Fastball,
	   ROUND(AVG(vsl)::numeric, 2) as Velocity_Of_Slider,
	   ROUND(AVG(vch)::numeric, 2) as Velocity_Of_ChangeUp,
	   ROUND((AVG(fapct)::numeric) / 100::numeric, 2) as Proportion_Of_Fastball,
	   ROUND((AVG(slpct)::numeric) / 100::numeric, 2) as Proportion_Of_Slider,
	   ROUND((AVG(chpct)::numeric) / 100::numeric, 2) as Proportion_Of_ChangeUp,
	   ROUND(AVG(wfa)::numeric, 2) as Success_Weight_Of_Fastball,
	   ROUND(AVG(wsl)::numeric, 2) as Success_Weight_Of_Slider,
	   ROUND(AVG(wch)::numeric, 2) as Success_Weight_Of_ChangeUp,
	   ROUND(AVG(fax)::numeric, 2) as HMove_Of_Fastball,
	   ROUND(AVG(chx)::numeric, 2) as HMove_Of_Slider,
	   ROUND(AVG(slx)::numeric, 2) as HMove_Of_ChangeUp,
	   ROUND(AVG(faz)::numeric, 2) as VMove_Of_Fastball,
	   ROUND(AVG(chz)::numeric, 2) as VMove_Of_Slider,
	   ROUND(AVG(slz)::numeric, 2) as VMove_Of_ChangeUp,
	   throws from pitching_2015_fg_names p1 inner join pitch_movement_2015 p2 on p1.player_name = p2.player_name
	   where throws in ('L', 'R') AND ip >= 20
	   group by throws
	   
select count(*) from pitching_2015_fg_names where throws = 'L' and ip >= 20
select count(*) from pitching_2015_fg_names where throws = 'R' and ip >= 20


