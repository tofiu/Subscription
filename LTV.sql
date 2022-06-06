select
subscription_platform_cd,
max(median_tenure) as median_tenure 
from
(select 
subscription_platform_cd,subscription_guid, 
percentile_cont(tenure,0.5) OVER (PARTITION BY  subscription_platform_cd) AS median_tenure
from
(
select 
subscription_platform_cd,
s.subscription_guid,
case when (case when s.subscription_platform_cd = 'AMAZON' then s.cancel_dt else s.expiration_dt end) is not null then 
DATE_DIFF(
case when
(case when s.subscription_platform_cd = 'AMAZON' then s.cancel_dt else s.expiration_dt end) >= CURRENT_DATE() then CURRENT_DATE()
else (case when s.subscription_platform_cd = 'AMAZON' then s.cancel_dt else s.expiration_dt end) end ,s.paid_Start_Dt,DAY)
else DATE_DIFF(CURRENT_DATE(),s.paid_Start_Dt,DAY) end tenure
from ent_vw.subscription_fct s   
where src_system_id=115
---and (expiration_dt is  null or  expiration_dt>=current_date())
and (expiration_dt is  null or  expiration_dt>'2021-01-31')
and paid_Start_Dt is not null
and (paid_Start_Dt<='2021-01-31' and activation_Dt <='2021-01-31')
--group by 1   
)
)final 
group by 1
order by 1;
