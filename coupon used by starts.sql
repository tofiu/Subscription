with slam_starts as (
select distinct reg_cookie
from 
ent_vw.subscription_slam_attribution_fct 
where src_system_id=115
and activation_dt between '2022-02-24' and '2022-04-24'
and lower(slam_show_gp_nm) like '%waste%land%'
),

coupon_starts as (
select distinct f.cbs_reg_user_id_cd, c.coupon_cd, activation_dt,  from 
`ent_vw.subscription_fct` f 
join
ent_vw.recurly_coupon_redemptn_fct c
on f.subscription_guid = c.subscription_guid 
and f.src_system_id = c.src_system_id 
where
activation_dt between '2022-02-24' and '2022-04-24'
and f.src_system_id=115
and f.cbs_reg_user_id_cd in (select reg_cookie from slam_starts)
group by 1,2,3)

select 
activation_dt,
coupon_cd, 
count(distinct cbs_reg_user_id_cd)
from coupon_starts

group by 1,2
order by 3 desc
