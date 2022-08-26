----- most updated as of 8/2022 -------

select 
 date_trunc(b.paid_start_dt, month) as signup_mn, 
case when s.slam_show_nm in ("Building Star Trek") then "Building Star Trek"
when s.slam_show_nm in ("P+ Channels - Star Trek","Star Trek", "Star Trek (2009)") then "Star Trek (2009)"
when s.slam_show_nm in ("Star Trek Beyond","Paramount+ Movies - Star Trek Beyond") then "Star Trek Beyond"
when s.slam_show_nm in ("Star Trek Day") then "Star Trek Day"
when s.slam_show_nm in ("Star Trek II: The Wrath of Khan") then "Star Trek II: The Wrath of Khan"
when s.slam_show_nm in ("Star Trek III: The Search for Spock") then "Star Trek III: The Search for Spock"
when s.slam_show_nm in ("Star Trek Into Darkness") then "Star Trek Into Darkness"
when s.slam_show_nm in ("Star Trek IV: The Voyage Home") then "Star Trek IV: The Voyage Home"
when s.slam_show_nm in ("Star Trek IX: Insurrection") then "Star Trek IX: Insurrection"
when s.slam_show_nm in ("Star Trek V: The Final Frontier") then "Star Trek V: The Final Frontier"
when s.slam_show_nm in ("Star Trek VI: The Undiscovered Country") then "Star Trek VI: The Undiscovered Country"
when s.slam_show_nm in ("Star Trek VII: Generations","Star Trek: Generations","Paramount+ Movies - Star Trek: Generations") then "Star Trek VII: Generations"
when s.slam_show_nm in ("Star Trek VIII: First Contact") then "Star Trek VIII: First Contact"
when s.slam_show_nm in ("Star Trek X: Nemesis") then "Star Trek: Nemesis"
when s.slam_show_nm in ("Star Trek: Strange New Worlds") then "Star Trek: Strange New Worlds"
when s.slam_show_nm in ("Star Trek: The Motion Picture - The Director's Edition") then "Star Trek: The Motion Picture - The Directors Edition"
when s.slam_show_nm in ("Star Trek: The Motion Picture") then "Star Trek: The Motion Picture"
else s.slam_show_nm end as sub_type,
count(distinct s.subscription_guid) paid_Starts
 from ent_vw.subscription_slam_attribution_fct s  
join ent_vw.subscription_fct b on s.reg_cookie = b.cbs_reg_user_id_cd
 where 
s.activation_dt  between '2021-03-01' and '2022-07-31'  
and s.src_system_id in (115)   
-- and subscription_platform_cd not in ("TMOBILE","TMOBILE-AMDOCS")
and b.paid_start_dt between '2021-03-01' and '2022-07-31' 
and lower(s.slam_show_gp_nm) like '%star%trek%'
and lower(s.slam_show_gp_nm) not like '%woman%motion%'
and lower(s.slam_show_gp_nm) not like '%trailer%'
 group by 1,2
 
 ------------
 
 select   
"CBS Platform" as platform,
case when s.category in ("Building Star Trek") then "Building Star Trek"
when s.category in ("P+ Channels - Star Trek","Star Trek", "Star Trek (2009)") then "Star Trek (2009)"
when s.category in ("Star Trek Beyond","Paramount+ Movies - Star Trek Beyond") then "Star Trek Beyond"
when s.category in ("Star Trek Day") then "Star Trek Day"
when s.category in ("Star Trek II: The Wrath of Khan") then "Star Trek II: The Wrath of Khan"
when s.category in ("Star Trek III: The Search for Spock") then "Star Trek III: The Search for Spock"
when s.category in ("Star Trek Into Darkness") then "Star Trek Into Darkness"
when s.category in ("Star Trek IV: The Voyage Home") then "Star Trek IV: The Voyage Home"
when s.category in ("Star Trek IX: Insurrection") then "Star Trek IX: Insurrection"
when s.category in ("Star Trek V: The Final Frontier") then "Star Trek V: The Final Frontier"
when s.category in ("Star Trek VI: The Undiscovered Country") then "Star Trek VI: The Undiscovered Country"
when s.category in ("Star Trek VII: Generations","Star Trek: Generations","Paramount+ Movies - Star Trek: Generations") then "Star Trek VII: Generations"
when s.category in ("Star Trek VIII: First Contact") then "Star Trek VIII: First Contact"
when s.category in ("Star Trek X: Nemesis") then "Star Trek: Nemesis"
when s.category in ("Star Trek: Strange New Worlds") then "Star Trek: Strange New Worlds"
when s.category in ("Star Trek: The Motion Picture - The Director's Edition") then "Star Trek: The Motion Picture - The Directors Edition"
when s.category in ("Star Trek: The Motion Picture") then "Star Trek: The Motion Picture"
else s.category end category,
s.signup_mn as signup_m,       
max(s.paid_Starts) over (partition by s.signup_mn,s.category) as paids,     
c.cancel_mn as cancel_m,
c.paid_cancels,     
sum(coalesce(c.paid_cancels,0)) over (partition by c.signup_mn,c.category order by c.cancel_mn rows unbounded preceding) CUM_cancels,     
(max(s.paid_Starts) over (partition by s.signup_mn,s.category)-sum(coalesce(c.paid_cancels,0)) over (partition by c.signup_mn,c.category order by c.cancel_mn rows unbounded preceding)) as retention   
from
(
select 	 
slam_show_nm category,
 date_trunc(b.paid_start_dt, month) as signup_mn, 
count(distinct s.subscription_guid) paid_Starts
 from ent_vw.subscription_slam_attribution_fct s  
join ent_vw.subscription_fct b on s.reg_cookie = b.cbs_reg_user_id_cd
 where 
s.activation_dt  between '2021-03-01' and '2022-07-31'  
and s.src_system_id in (115)   
-- and s.subscription_platform_cd in ("RECURLY-SHO-ADDON")
and b.paid_start_dt between '2021-03-01' and '2022-07-31' 
 group by 1,2

)s
join
(
select 	 

slam_show_nm category,
 date_trunc(b.paid_start_dt, month) as signup_mn, 
 DATE_DIFF(b.expiration_dt,b.paid_start_dt,month)+1 as cancel_mn,
--count(distinct (case when  service in ('Trial to Paid','Direct to Paid') then att.subscription_guid else null end)) as paid_cancels
count(distinct s.subscription_guid) paid_cancels
 from ent_vw.subscription_slam_attribution_fct s  
join ent_vw.subscription_fct b on s.reg_cookie = b.cbs_reg_user_id_cd 
 where s.activation_dt between '2021-03-01' and '2022-07-31'    
 and s.src_system_id in (115)   
 and b.paid_start_dt between '2021-03-01' and '2022-07-31' 
-- and s.subscription_platform_cd  in ("RECURLY-SHO-ADDON")
and b.expiration_dt is not null and b.expiration_dt>=b.paid_start_dt
and b.expiration_dt<="2022-07-31" ---End of the last month 
group by 1,2,3)c 
on s.category=c.category
and s.signup_mn=c.signup_mn

where lower(s.category) like '%star%trek%'
and lower(s.category) not like '%woman%motion%'
and lower(s.category) not like '%trailer%'
