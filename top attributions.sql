with stage1 as (
Select
distinct
v69_registration_id_nbr
from
`dw_vw.aa_video_detail_reporting_day`
where
video_full_episode_ind IS TRUE
and report_suite_id_nm NOT IN ('cbsicbsau', 'cbsicbsca','cbsicbstve')
and day_dt between '2021-03-04' and '2022-08-21'
and lower(reporting_series_nm) LIKE '%star%trek%'
and lower(reporting_series_nm) not like '%woman%motion%'
--and video_season_nbr = '3'
),

slam as (
select 
start_Dt activation_dt,
slam_show_att_gp,
reg_cookie,
subscription_guid
from ent_summary.att_20160201_present att
 left join temp_tm.slam_show_mapping_old s on s.att_gp=att.att_gp 
where start_Dt between '2020-01-01'  and '2021-02-28'
and country='US'

union all

select 
activation_dt,
slam_show_gp_nm, 
reg_cookie,
subscription_guid
from ent_vw.subscription_slam_attribution_fct att  
where att.src_system_id=115
and att.activation_dt between '2021-03-01' and '2022-08-21'
)

select
slam_show_att_gp,
count(distinct reg_cookie) reg
from slam a join stage1 b on a.reg_cookie=b.v69_registration_id_nbr
where activation_dt BETWEEN '2021-03-04' AND '2022-08-21'
group by 1
order by 2 desc
