-- https://docs.google.com/spreadsheets/d/1X11q0k9LXxvZLQfV4vCHFr1vuZawAa7i_g8KzbwmswQ/edit#gid=194092940
with slam_unified as 
(
select start_dt activation_dt, reg_cookie, subscription_guid, att_level_up, att_gp slam_show_gp_nm
from `i-dss-ent-data.ent_summary.att_20160201_present` 
where start_dt between '2020-11-01' and '2021-03-01'
union all 
select  
activation_dt,
reg_cookie,
subscription_guid,
case when slam_show_gp_nm = 'Big Brother' then 'Big Brother'
when slam_show_gp_nm = 'Big Brother: Over The Top' then 'Big Brother: Over The Top'
when slam_show_gp_nm = 'NFL' then 'NFL'
when slam_show_gp_nm = 'The Good Fight'  then 'The Good Fight'
when slam_show_gp_nm = 'Star Trek: Discovery'  then 'Star Trek: Discovery'
when slam_show_gp_nm = 'No Activity'  then 'No Activity'
when slam_show_gp_nm = 'Celebrity Big Brother' then 'Celebrity Big Brother'
when slam_show_gp_nm = 'Strange Angel' then 'Strange Angel'
when slam_show_gp_nm = 'One Dollar'  then 'One Dollar'
when slam_show_gp_nm = 'Tell Me A Story'  then 'Tell Me A Story'
when slam_show_gp_nm = 'Why Women Kill'  then 'Why Women Kill'
when slam_show_gp_nm = 'The Twilight Zone' then 'The Twilight Zone'
when slam_show_gp_nm = 'Star Trek: Picard' then 'Star Trek: Picard'
when slam_show_gp_nm = 'Interrogation'  then 'Interrogation'
when slam_show_gp_nm = 'Tooning Out The News'  then 'Tooning Out The News'
when slam_show_gp_nm = 'The Thomas John Experience'  then 'The Thomas John Experience'
when slam_show_gp_nm = 'UEFA'  then 'UEFA'
when slam_show_gp_nm = 'Star Trek: Lower Decks' then 'Star Trek: Lower Decks'
when slam_show_gp_nm = 'That Animal Rescue Show' then 'That Animal Rescue Show'
when slam_show_gp_nm = 'Texas 6' then 'Texas 6'
when slam_show_gp_nm = 'The Stand' then 'The Stand'
when slam_show_gp_nm = 'Coyote' then 'Coyote'
when slam_show_gp_nm = 'The SpongeBob Movie: Sponge On The Run' then 'Spongebob Movie'
when slam_show_gp_nm = '76 Days' then '76 Days'
when slam_show_gp_nm  in ('Kamp Koral',"Kamp Koral: SpongeBob's Under Years") then 'Kamp Koral'
when slam_show_gp_nm = "For Heaven's Sake" then "For Heaven's Sake"
when slam_show_gp_nm in ("The Real World Homecoming: New York","The Real World Homecoming","The Real World Homecoming: Los Angeles") then 'Real World Reunion (Comedy Central)'
when slam_show_gp_nm = 'The Challenge: All Stars' then 'The Challenge: All Stars'
when slam_show_gp_nm = 'Younger' then 'Younger'         
when slam_show_gp_nm = 'Concacaf'  then 'Concacaf'
when slam_show_gp_nm = 'Brazil Série A' then 'Brazil'
when slam_show_gp_nm = '60 Minutes+' then '60 Minutes+'
when slam_show_gp_nm = 'Argentina Liga' then 'Argentina' 
when slam_show_gp_nm = 'Cher & the Loneliest Elephant'  then 'Cher'  
when slam_show_gp_nm in ('Rugrats','Rugrats (1991)','Rugrats (2021)') then 'Rugrats'  
when slam_show_gp_nm = 'From Cradle to Stage'  then 'From Cradle to Stage'  
when slam_show_gp_nm='Evil' then 'Evil'
when slam_show_gp_nm in ('iCarly','iCarly (2007)','iCarly (2021)') then 'iCarly' 
when slam_show_gp_nm in ("RuPaul's Drag Race All Stars","RuPaul's Drag Race All Stars Untucked") then 'RuPaul: All Stars' 

when slam_show_gp_nm="PAW Patrol Live! at Home" then 'Paw Patrol Live'
when slam_show_gp_nm='Infinite' then 'Infinite'
when slam_show_gp_nm in ("Sir Alex Ferguson: Never Give In (Trailer)","Sir Alex Ferguson: Never Give In") then 'Sir Alex Ferguson: Never Give In' 
when slam_show_gp_nm in ("Woman In Motion: Nichelle Nichols, Star Trek and the Remaking of NASA",
"Woman In Motion: Nichelle Nichols, Star Trek and the Remaking of NASA (Trailer)") then 'Woman in Motion'  
when slam_show_gp_nm in ("A Quiet Place Part II","A Quiet Place","A Quiet Place Part II (Trailer)","A Quiet Place (Trailer)") then 'A Quiet Place'
when lower(slam_show_gp_nm) like "%behind%music%" then 'Behind the Music'

when slam_show_gp_nm = "Italy Serie A" then 'Serie A'
when slam_show_gp_nm = "Bring Your Own Brigade" then 'Bring Your Own Brigade'
when slam_show_gp_nm = "PAW Patrol: The Movie" then 'PAW Patrol: The Movie' 
--Sep 2021 Additions
when lower(slam_show_gp_nm) like '%harper%house%' then "Harper House"
when lower(slam_show_gp_nm) like '%j%team%' then "The J Team" 
when lower(slam_show_gp_nm) like '%inside%nfl%' then "Inside the NFL" 

when (lower(slam_show_gp_nm) like '%kacey%' 
or lower(slam_show_gp_nm) like '%destination%porto%'
or lower(slam_show_gp_nm) like '%race%against%time%'
or lower(slam_show_gp_nm) like '%street%garage%'
) then "Documentaries"
when lower(slam_show_gp_nm) like '%queenpins%' then "Queenpins" 

when lower(slam_show_gp_nm) like '%prodigy%' then "Star Trek: Prodigy" 
when lower(slam_show_gp_nm) like '%guilty%party%' then "Guilty Party" 
when lower(slam_show_gp_nm) like '%madame%x%' then "Madame X" 
when lower(slam_show_gp_nm) like '%paranormal%activity%next%kin' then "Paranormal Activity: Next of Kin" 
when lower(slam_show_gp_nm) like '%seal%team%' then "SEAL Team" 


when lower(slam_show_gp_nm) like '%clifford%red%dog%'   then "Clifford" 
when (slam_show_gp_nm) like 'The Game' then "The Game" 
when lower(slam_show_gp_nm) like '%mayor%kingstown%'   then "Mayor of Kingstown" 
when lower(slam_show_gp_nm) like '%oasis%kneb%'   then "Oasis Knebworth 1996" 
when lower(slam_show_gp_nm) like '%south%park%post%'   then "South Park" 
when lower(slam_show_gp_nm) like '%loud%house%chris%'   then "A Loud House Christmas" 

when lower(slam_show_gp_nm) like '%1883%'   then "1883" 
when lower(slam_show_gp_nm) like "%rumble%"   then "Rumble" 
when lower(slam_show_gp_nm) like "%reno%qanon%"  then "Reno 911" 

when lower(slam_show_gp_nm) like "%the%only%"   then "The Only" 
when lower(slam_show_gp_nm) like "%marfa%tape%"   then "Miranda Lambert Film" 

when lower(slam_show_gp_nm) like "%big%nate%"   then "Big Nate" 
when lower(slam_show_gp_nm) like "%queen%universe%"   then "Queen of the Universe" 
when lower(slam_show_gp_nm) like "%in%between%"   then "The In Between" 
when lower(slam_show_gp_nm) like "%love%tom%"   then "Love, Tom" 
when lower(slam_show_gp_nm) like "%three%months%"   then "Three Months" 
when lower(slam_show_gp_nm) like "wasteland"  then "Wasteland" 

when lower(slam_show_gp_nm) like "%halo%"  then "Halo" 
when lower(slam_show_gp_nm) like "%jackass%forever%"  then "Jackass" 
when lower(slam_show_gp_nm) like "%scream%2022%"  then "Scream" 
when lower(slam_show_gp_nm) like "%fairly%odd%parent%"  then "The Fairly Odd Parents" 


when lower(slam_show_gp_nm) like "%the offer%"  then "The Offer" 


when slam_show_gp_nm is null then 'CORE'
else 'CORE' end as att_level_up, slam_show_gp_nm
from ent_vw.subscription_slam_attribution_fct att   
where att.src_system_id=115
and att.activation_dt between '2021-03-01' and '2022-04-30'
),


show_data_genre as 
(select att.*, genre
from slam_unified att  
left join `i-dss-ent-data.ent_summary.dj_genre_mapping_table_without_local_stations` g on g.show=att.slam_show_gp_nm
)
--conversion
/*
select  
date_trunc(s.activation_dt, month) mn, 
"CBS Platforms" source_cd,
show_clean slam_show_gp_nm,  
count(distinct (case when s.activation_dt is not null then s.subscription_guid else null end)) as Total_Starts,
count(distinct (case when s.trial_start_Dt is not null then s.subscription_guid else null end)) as Trial_Starts,
count(distinct (case when s.trial_start_dt is not null and s.paid_start_dt is not null then s.subscription_guid else null end)) as Trial_TTOP,
count(distinct (case when s.trial_start_Dt is null then s.subscription_guid else null end)) as DTP_Starts,
count(distinct (case when s.paid_start_dt is not null then s.subscription_guid else null end)) Paid_Starts
--from ent_vw.subscription_slam_attribution_fct att   
from ent_vw.subscription_fct s  
  join show_data att  on s.cbs_reg_user_id_cd=att.reg_cookie and att.activation_dt=s.activation_dt 
 where s.src_system_id in (115)
and s.subscription_platform_cd not in ("Apple TV","Apple iOS")
 and att.activation_dt between '2021-01-01' and '2021-12-31' 
group by 1,2,3;
*/



--Retention
select   
"CBS Platform" as platform,
s.slam_show_gp_nm,    
s.category,
s.signup_mn as signup_m,       
max(s.paid_Starts) over (partition by s.signup_mn,s.category,s.slam_show_gp_nm) as paids,     
c.cancel_mn as cancel_m,
c.paid_cancels,     
sum(coalesce(c.paid_cancels,0)) over (partition by c.signup_mn,c.category,s.slam_show_gp_nm order by c.cancel_mn rows unbounded preceding) CUM_cancels,     
(max(s.paid_Starts) over (partition by s.signup_mn,s.category,s.slam_show_gp_nm)-sum(coalesce(c.paid_cancels,0)) over (partition by c.signup_mn,c.category,s.slam_show_gp_nm order by c.cancel_mn rows unbounded preceding)) as retention   
from
(
select 	 
genre slam_show_gp_nm,
"Genre"  category,
--change
 date_trunc(s.activation_dt, month) as signup_mn, 
count(distinct s.subscription_guid) paid_Starts
 from ent_vw.subscription_fct s  
 join show_data_genre att  on s.cbs_reg_user_id_cd=att.reg_cookie and att.activation_dt=s.activation_dt 
 where 
s.activation_dt  between '2021-03-01' and '2022-03-31'  
and s.src_system_id in (115)   
and subscription_platform_cd not in ("TMOBILE","TMOBILE-AMDOCS")
--change
--and s.paid_start_dt between '2021-03-01' and '2022-03-31' 
 group by 1,2,3

)s
join
(
select 	 
genre slam_show_gp_nm,
"Genre"  category,
--change
 date_trunc(s.activation_dt, month) as signup_mn, 
 --change
 DATE_DIFF(s.expiration_dt,s.activation_dt,month)+1 as cancel_mn,
--count(distinct (case when  service in ('Trial to Paid','Direct to Paid') then att.subscription_guid else null end)) as paid_cancels
count(distinct s.subscription_guid) paid_cancels
from ent_vw.subscription_fct s  
 join show_data_genre att  on s.cbs_reg_user_id_cd=att.reg_cookie and att.activation_dt=s.activation_dt 
 where s.activation_dt between '2021-03-01' and '2022-03-31'   
 and s.src_system_id in (115)   
 ---change
-- and s.paid_start_dt between '2021-03-01' and '2022-03-31' 
and subscription_platform_cd not in ("TMOBILE","TMOBILE-AMDOCS")
--change
and s.expiration_dt is not null ---and s.expiration_dt>=s.paid_start_dt
and s.expiration_dt<="2022-04-30" ---End of the last month 
group by 1,2,3,4)c 
on s.category=c.category
and s.signup_mn=c.signup_mn
and s.slam_show_gp_nm=c.slam_show_gp_nm; 
---Paid_Starts
/*
select 	 
genre slam_show_gp_nm,
"Genre"  category,
 date_trunc(s.paid_start_dt, month) as signup_mn, 
count(distinct s.subscription_guid) paid_Starts
 from ent_vw.subscription_fct s  
 join show_data_genre att  on s.cbs_reg_user_id_cd=att.reg_cookie and att.activation_dt=s.activation_dt 
 where 
s.activation_dt  between '2021-03-01' and '2022-03-31'  
and s.src_system_id in (115)   
and subscription_platform_cd not in ("TMOBILE","TMOBILE-AMDOCS")
and s.paid_start_dt between '2021-03-01' and '2022-03-31' 
 group by 1,2,3
*/
