
-- master table
-- master table
drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_1;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_1 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a1
where
to_date(date_part) between '2020-09-16' and '2020-09-30' and
lower(regexp_replace(a1.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_2;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_2 as
select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a2
where 
to_date(date_part) between '2020-10-01' and '2020-10-31' and
lower(regexp_replace(a2.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_3;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_3 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a3
where 
to_date(date_part) between '2020-11-01' and '2020-11-30' and
lower(regexp_replace(a3.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_4;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_4 as
select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a4
where
to_date(date_part) between '2020-12-01' and '2020-12-31' and
lower(regexp_replace(a4.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_5;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_5 as
select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a5
where
to_date(date_part) between '2021-01-01' and '2021-01-31' and
lower(regexp_replace(a5.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;


drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_6;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_6 as
select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a6
where
to_date(date_part) between '2021-02-01' and '2021-02-28' and
lower(regexp_replace(a6.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_7;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_7 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a7
where
to_date(date_part) between '2021-03-01' and '2021-03-31' and
lower(regexp_replace(a7.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_8;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_8 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a8
where
to_date(date_part) between '2021-04-01' and '2021-04-30' and
lower(regexp_replace(a8.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_9;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_9 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a9
where
to_date(date_part) between '2021-05-01' and '2021-05-31' and
lower(regexp_replace(a9.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_10;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_10 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a10
where
to_date(date_part) between '2021-06-01' and '2021-06-30' and
lower(regexp_replace(a10.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;


drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_11;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_11 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a11
where
to_date(date_part) between '2021-07-01' and '2021-07-31' and
lower(regexp_replace(a11.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_12;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_12 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a12
where
to_date(date_part) between '2021-08-01' and '2021-08-31' and
lower(regexp_replace(a12.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_13;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_13 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a13
where
to_date(date_part) between '2021-09-01' and '2021-09-30' and
lower(regexp_replace(a13.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_14;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_14 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a14
where
to_date(date_part) between '2021-10-01' and '2021-10-31' and
lower(regexp_replace(a14.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_15;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_15 as

select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a15
where
to_date(date_part) between '2021-11-01' and '2021-11-30' and
lower(regexp_replace(a15.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 

;

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_16;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_16 as
select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a16
where
to_date(date_part) between '2021-12-01' and '2021-12-31' and
lower(regexp_replace(a16.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') 



---------------------------------------------------------------------------------


-- union all the tables

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union as

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_1
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_2
union all
select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_3
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_4
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_5
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_6
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_7
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_8
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_9
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_10
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_11
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_12
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_13
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_14
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_15
union all

select
*
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_16
;



--------------------------------------------------------------------------------------


-- validation check for overlaps

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_1'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_1
union all

select
min(date_part),
max(date_part),
,
'ruch_barclays_master_table_2'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_2
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_3'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_3
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_4'

from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_4
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_5'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_5
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_6'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_6
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_7'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_7
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_8'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_8
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_9'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_9
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_10'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_10
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_11'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_11
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_12'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_12
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_13'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_13
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_14'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_14
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_15'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_15
union all

select
min(date_part),
max(date_part),
'ruch_barclays_master_table_16'
from
"EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_16
;








-----------------------------------------------------------------------------------


-- create the final table from the union table

drop table if exists "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_values_table;
create table "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_values_table as


select
ss1.date_part,
ss1.visitid,
ss1.CHANNELGROUPING,
ss1.FULLVISITORID,
ss1.CLIENTID,
ss1.hits,
ss1.TOTALS,
ss1.TRAFFICSOURCE,
ss1.CUSTOMDIMENSIONS,
regexp_replace( ss1.hit_no                   ,'["]', '')   as hit_no				,
regexp_replace( ss1.entry_page               ,'["]', '')   as entry_page           ,
regexp_replace( ss1.exit_page                ,'["]', '')   as exit_page            ,
regexp_replace( ss1.current_page_path        ,'["]', '')   as current_page_path    ,
regexp_replace( ss1.current_page_title       ,'["]', '')   as current_page_title   ,
regexp_replace( ss1.event_action             ,'["]', '')   as event_action         ,
regexp_replace( ss1.event_category           ,'["]', '')   as event_category       ,
regexp_replace( ss1.event_label              ,'["]', '')   as event_label          ,
regexp_replace( ss1.event_value              ,'["]', '')   as event_value          ,
regexp_replace( ss1.hit_type                 ,'["]', '')   as hit_type             ,
regexp_replace( ss1.hit_time                 ,'["]', '')   as hit_time             ,
regexp_replace( ss1.bounced                  ,'["]', '')   as bounced              ,
regexp_replace( ss1.visits                   ,'["]', '')   as visits               ,
regexp_replace( ss1.visitor_type             ,'["]', '')   as visitor_type         ,
regexp_replace( ss1.time_on_site             ,'["]', '')   as time_on_site         ,
regexp_replace( ss1.sess_person_id           ,'["]', '')   as sess_person_id       ,
regexp_replace( ss1.user_person_id           ,'["]', '')   as user_person_id       ,
regexp_replace( ss1.skywards_tier_ga         ,'["]', '')   as skywards_tier_ga     ,
regexp_replace( ss1.browser_used             ,'["]', '')   as browser_used         ,
regexp_replace( ss1.platform_type            ,'["]', '')   as platform_type        ,
regexp_replace( ss1.country_ga               ,'["]', '')   as country_ga           ,
regexp_replace( ss1.state_region_ga          ,'["]', '')   as state_region_ga      ,
regexp_replace( ss1.utm_source               ,'["]', '')   as utm_source           ,
regexp_replace( ss1.utm_medium               ,'["]', '')   as utm_medium           ,
regexp_replace( ss1.utm_campaign             ,'["]', '')   as utm_campaign         ,
regexp_replace( ss1.utm_ad_content           ,'["]', '')   as utm_ad_content       ,
regexp_replace( ga_hit_id.cd_GA_Hit_ID       ,'["]', '')   as cd_GA_Hit_ID         ,
regexp_replace( ga_prev_page.cd_previous_page,'["]', '')   as cd_previous_page     ,
regexp_replace( ga_query_param.cd_query_param,'["]', '')   as cd_query_param

from
	(

	select
	a1.date_part,
    a1.visitid,
	a1.CHANNELGROUPING,
	a1.FULLVISITORID,
	a1.CLIENTID,
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
	parse_json(TRAFFICSOURCE):campaign as utm_campaign,
	parse_json(TRAFFICSOURCE):adContent as utm_ad_content,

	  

	'hello' as something
	from
	 "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union as a1,
	 lateral flatten (input =>  parse_json(a1.hits)  ) as vr,
	 lateral flatten( input => parse_json(a1.CUSTOMDIMENSIONS) ) as sess_cd,
	 lateral flatten( input => parse_json(a1.CUSTOMDIMENSIONS) ) as sess_cd_1,
	 lateral flatten( input => parse_json(a1.CUSTOMDIMENSIONS) ) as sess_cd_2
	where
	-- FULLVISITORID in ('6897951228314575162', '415906969382633187') and
	sess_cd.value:index::string = '53' and
	sess_cd_1.value:index::string = '54' and
	sess_cd_2.value:index::string = '33'
	) as ss1

left join
		(
		select 
		a2.FULLVISITORID,
        a2.date_part,
        a2.visitid,
		v1.value:hitNumber  as hit_no,
		v2.value:value::string as cd_GA_Hit_ID
		from
		 "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union as a2
		,lateral flatten( input => parse_json(a2.hits) ) as v1
		,lateral flatten( input => v1.value:customDimensions ) as v2
		where
		-- FULLVISITORID in ('6897951228314575162', '415906969382633187') and
		v2.value:index::string = '114'
		) as ga_hit_id on ss1.FULLVISITORID = ga_hit_id.FULLVISITORID and ss1.hit_no = ga_hit_id.hit_no and ss1.visitid = ga_hit_id.visitid
left join
		(
		select 
		a2.FULLVISITORID,
        a2.date_part,
        a2.visitid,
		v1.value:hitNumber  as hit_no,
		v2.value:value::string as cd_previous_page
		from
		 "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union as a2
		,lateral flatten( input => parse_json(a2.hits) ) as v1
		,lateral flatten( input => v1.value:customDimensions ) as v2
		where
		-- FULLVISITORID in ('6897951228314575162', '415906969382633187') and
		v2.value:index::string = '109'
		) as ga_prev_page on ss1.FULLVISITORID = ga_prev_page.FULLVISITORID and ss1.hit_no = ga_prev_page.hit_no and ss1.visitid = ga_prev_page.visitid
left join

		(
		select 
		a2.FULLVISITORID,
        a2.date_part,
        a2.visitid,
		v1.value:hitNumber  as hit_no,
		v2.value:value::string as cd_query_param
		from
		 "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union as a2
		,lateral flatten( input => parse_json(a2.hits) ) as v1
		,lateral flatten( input => v1.value:customDimensions ) as v2
		where
		-- FULLVISITORID in ('6897951228314575162', '415906969382633187') and
		v2.value:index::string = '159'
		) as ga_query_param on ss1.FULLVISITORID = ga_query_param.FULLVISITORID and ss1.hit_no = ga_query_param.hit_no and ss1.visitid = ga_query_param.visitid

;