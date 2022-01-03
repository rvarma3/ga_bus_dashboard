
-- master table
drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table as
select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA"
where
date_part >= '2020-09-16' and
lower(regexp_replace(a1.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 
-----------------------------------------------------------------------------------




select
a1.date_part,
a1.CHANNELGROUPING,
a1.FULLVISITORID,
a1.CLIENTID,
a1.CHANNELGROUPING,
a1.hits,
a1.TOTALS,
a1.TRAFFICSOURCE,
a1.CUSTOMDIMENSIONS,
vr.value:hitNumber as hit_no,
vr.value:appInfo.landingScreenName as entry_page,
vr.value:appInfo.exitScreenName as exit_page,
vr.value:page.pagePath as current_page_path,
vr.value:page.pageTitle as current_page_title,
vr.value:eventInfo.eventAction as event_action,
vr.value:eventInfo.eventCategory as event_category,
vr.value:eventInfo.eventLabel as event_label,
vr.value:eventInfo.eventValue as event_value,
vr.value:type as hit_type,
(vr.value:time::integer)/1000 as hit_time,
case when parse_json(totals):bounces::string != 'null' then 'Yes' else 'No' end as bounced,
parse_json(totals):visits as visits,
case when parse_json(totals):newVisits::string is not null then 'new_visitor' else 'returning_visitor' end as visitor_type,
parse_json(totals):timeOnSite::integer as time_on_site,
sess_cd.value:value::string as sess_person_id,
sess_cd_1.value:value::string as user_person_id,
sess_cd_2.value:value::string as skywards_tier_ga,
parse_json(device):browser as browser_used,
parse_json(device):deviceCategory as platform_type,
parse_json(GEONETWORK):country as country_ga,
parse_json(GEONETWORK):region as state_region_ga,
parse_json(TRAFFICSOURCE):source as utm_source,
parse_json(TRAFFICSOURCE):medium as utm_medium,

'hello' as something
from
 "EDWH_PROD"."WS_SKYWARDS_PROD".tesing_ruchir_ga_to_drop as a1,
 lateral flatten (input =>  parse_json(a1.hits)  ) as vr,
 lateral flatten( input => parse_json(a1.CUSTOMDIMENSIONS) ) as sess_cd,
 lateral flatten( input => parse_json(a1.CUSTOMDIMENSIONS) ) as sess_cd_1,
 lateral flatten( input => parse_json(a1.CUSTOMDIMENSIONS) ) as sess_cd_2
 
 
where

sess_cd.value:index::string = '53' and
sess_cd_1.value:index::string = '54' and
sess_cd_2.value:index::string = '33'
;


-- custom dimensions - hit id
(
select 
a2.FULLVISITORID,
v1.value:hitNumber  as hit_no,
v2.value:value::string as cd_GA_Hit_ID
from
 "EDWH_PROD"."WS_SKYWARDS_PROD".tesing_ruchir_ga_to_drop as a2
,lateral flatten( input => parse_json(a2.hits) ) as v1
,lateral flatten( input => v1.value:customDimensions ) as v2
where

v2.value:index::string = '114'
) as ga_hit_id on ss1.FULLVISITORID = ga_hit_id.FULLVISITORID and ss1.hit_no = ga_hit_id.hit_no

;
-- custom dimensions - previous page name
(
select 
a2.FULLVISITORID,
v1.value:hitNumber  as hit_no,
v2.value:value::string as cd_previous_page
from
 "EDWH_PROD"."WS_SKYWARDS_PROD".tesing_ruchir_ga_to_drop as a2
,lateral flatten( input => parse_json(a2.hits) ) as v1
,lateral flatten( input => v1.value:customDimensions ) as v2
where
v2.value:index::string = '109'
) as ga_prev_page on ss1.FULLVISITORID = ga_prev_page.FULLVISITORID and ss1.hit_no = ga_prev_page.hit_no


;

-- custom dimensions - query parameter
(
select 
a2.FULLVISITORID,
v1.value:hitNumber  as hit_no,
v2.value:value::string as cd_query_param
from
 "EDWH_PROD"."WS_SKYWARDS_PROD".tesing_ruchir_ga_to_drop as a2
,lateral flatten( input => parse_json(a2.hits) ) as v1
,lateral flatten( input => v1.value:customDimensions ) as v2
where
v2.value:index::string = '159'
) as ga_query_param on ss1.FULLVISITORID = ga_query_param.FULLVISITORID and ss1.hit_no = ga_query_param.hit_no




