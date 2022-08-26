SELECT
--start_dt start_dt,
att_gp slam_show_att_gp,
gender_cd,
--Age_group,
COUNT(DISTINCT reg_user_id) Starts,
--avg(t_Age) Avg_age
FROM
(
SELECT
u.reg_user_id,
case
when gender_cd = 'M' then 'Male'
when gender_cd = 'F' then 'Female'
else 'Other' end gender_cd,
(extract(year from current_date()) - safe_cast(birth_year_nbr as int64)) as t_age,
CASE
WHEN (extract(YEAR FROM CURRENT_DATE()) - safe_cast(birth_year_nbr AS int64))
BETWEEN 18 AND 34
THEN '18-34'
WHEN (extract(YEAR FROM CURRENT_DATE()) - safe_cast(birth_year_nbr AS int64))
BETWEEN 35 AND 54
THEN '35-54'
WHEN (extract(YEAR FROM CURRENT_DATE()) - safe_cast(birth_year_nbr AS int64))
BETWEEN 55 AND 100
THEN '55+'
END AS Age_group, start_dt, att_gp
FROM
`i-dss-ent-data.dw_vw.registration_user_dim` u
JOIN
( SELECT DISTINCT reg_cookie AS cbs_reg_user_id_cd, start_dt, att_gp
FROM (
select
--activation_dt start_dt,
date_trunc(activation_dt, quarter) start_dt,
reg_cookie,
subscription_guid,
genre as att_gp
from ent_vw.subscription_slam_attribution_fct att
left join `i-dss-ent-data.ent_summary.dj_genre_mapping_table_without_local_stations` g on g.show=att.slam_show_gp_nm
where src_system_id=115 and
activation_dt between '2022-04-01' and '2022-06-30' and
slam_show_type_nm <> 'live'
)
)ua ON (u.reg_user_id = CAST(ua.cbs_reg_user_id_cd AS string))
)t
--WHERE t_age BETWEEN 18 AND 100
GROUP BY
1,2
