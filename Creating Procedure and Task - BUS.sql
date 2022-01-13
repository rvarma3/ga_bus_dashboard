use database EDWH_PROD;
use schema WS_SKYWARDS_PROD;

create or replace procedure ruch_barclays_dash_2022()
RETURNS varchar not null
LANGUAGE javascript
COMMENT = 'Rebuilds all BUS and GA tables for the BUS Dashboard'
EXECUTE AS CALLER
AS
$$
// drop and create tables for the master table 

var trunc_table_1 = `
truncate "EDWH_PROD"."WS_SKYWARDS_PROD".ruchir_CRIS_approved_card_stats
;`

var insert_rows_1 = `
insert into "EDWH_PROD"."WS_SKYWARDS_PROD".ruchir_CRIS_approved_card_stats

select
stat_enh.MEMBER_ID,
decode ( stat_enh.MEMBERSHIP_ENHANCEMENT_REASON_CODE , 'BCHFMC', 'High Fee Card','BCLFMC' ,'Low Fee Card') as card_type,
stat_enh.MEMBERSHIP_ENHANCEMENT_REASON_CODE,
stat_enh.MEMBERSHIP_ENHANCEMENT_REASON_DESCRIPTION,
mem_trans.LOYALTY_PARTNER_BOOKABLE_ACTIVITY_CODE,
mem_trans.ACTIVITY_TYPE_CATEGORY_CODE,
mem_trans.ACTIVITY_TYPE_CATEGORY_NAME,
mem_trans.LOYALTY_PARTNER_CODE,
mem_trans.LOYALTY_PARTNER_NAME,
mem_trans.STATEMENT_DESCRIPTION,
mem_trans.MEMBER_ACTIVITY_TYPE_CODE,
mem_trans.TRANSACTION_DESCRIPTION,
to_date(mem_trans.MEMBER_ACTIVITY_DATE) as MEMBER_ACTIVITY_DATE,
trunc(to_date(mem_trans.MEMBER_ACTIVITY_DATE), 'MM') as activity_month,
trunc(to_date(stat_enh.ACTIVATION_DATE),'MM') as activation_month,
trunc(to_date(mem_trans.TRANSACTION_DATE),'MM') as trans_month,
to_date(mem_trans.TRANSACTION_DATE)  as TRANSACTION_DATE,
stat_enh.age_bucket,
stat_enh.COUNTRY_OF_RESIDENCE_CODE,
stat_enh.COUNTRY_OF_RESIDENCE,
stat_enh.tenure,
to_date(stat_enh.JOIN_DATE) JOIN_DATE,
stat_enh.LOYALTY_TIER_CODE,
stat_enh.NATIONALITY_CODE,
to_date(stat_enh.ACTIVATION_DATE) ACTIVATION_DATE,
stat_enh.gender,
stat_enh.MEMBERSHIP_TENURE_TYPE,
to_date(stat_enh.CARD_EXPIRY) CARD_EXPIRY_date,
sum(mem_trans.TIER_MILES) TIER_MILES ,
sum(mem_trans.exp_miles)  exp_miles,
sum(mem_trans.tot_activities) tot_activities,
sum(mem_trans.sky_miles) sky_miles

from


		(
		 SELECT
		  to_char(SKYWARDS_MEMBER.SKYWARDS_MEMBER_IDENTIFIER) as MEMBER_ID,
		  SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_CODE,
		  SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_DESCRIPTION,
		  to_date(SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT.CARD_EXPIRY_DATE) as CARD_EXPIRY,
		  		CASE
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 1 and 10 THEN  '1-10'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 11 and 20 THEN '11-20'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 21 and 30 THEN '21-30'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 31 and 40 THEN '31-40'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 41 and 50 THEN '41-50'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 51 and 60 THEN '51-60'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 61 and 70 THEN '61-70'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 71 and 80 THEN '71-80'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 81 and 90 THEN '81-90'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 91 and 100 THEN '91-100'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 101 and 110 THEN '101-110'
				 WHEN datediff (years, to_date(CUSTOMER.BIRTH_DATE), sysdate()) between 110 and 150 THEN '>111'
			   END age_bucket,
		  CUSTOMER.COUNTRY_OF_RESIDENCE_CODE,
		  CUSTOMER.COUNTRY_OF_RESIDENCE,
			CASE
				 WHEN datediff (years, to_date(SKYWARDS_MEMBER.MEMBER_JOIN_DATE), sysdate()) between 0 and 2 THEN  '00-02 years'
				 WHEN datediff (years, to_date(SKYWARDS_MEMBER.MEMBER_JOIN_DATE), sysdate()) between 3 and 5 THEN '03-05 years'
				 WHEN datediff (years, to_date(SKYWARDS_MEMBER.MEMBER_JOIN_DATE), sysdate()) between 6 and 10 THEN '06-10 years'
				 WHEN datediff (years, to_date(SKYWARDS_MEMBER.MEMBER_JOIN_DATE), sysdate()) between 11 and 15 THEN '11-15 years'
				 WHEN datediff (years, to_date(SKYWARDS_MEMBER.MEMBER_JOIN_DATE), sysdate()) >= 16  THEN '16+ years'
			   END tenure,
		  to_date(SKYWARDS_MEMBER.MEMBER_JOIN_DATE) JOIN_DATE,
		  SKYWARDS_MEMBER.LOYALTY_TIER_CODE,
		  CUSTOMER_NATIONALITY.NATIONALITY_CODE,
		  DECODE(CUSTOMER.GENDER_CODE,'F','FEMALE','M','MALE',NULL) gender,
		  to_date(SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT.CARD_ACTIVATION_DATE) ACTIVATION_DATE,
		  case
		  when SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT.CARD_ACTIVATION_DATE between (SKYWARDS_MEMBER.MEMBER_JOIN_DATE -5) and (SKYWARDS_MEMBER.MEMBER_JOIN_DATE + 5) then 'NEW_MEMBER'
		  else 'EXISTING_MEMBER' end MEMBERSHIP_TENURE_TYPE
		  
		  
		  
		FROM
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBER"
		  join
		  "EDWH_PROD"."GOLD"."CUSTOMER"
		  on SKYWARDS_MEMBER.SKYWARDS_MEMBER_IDENTIFIER = CUSTOMER.SKYWARDS_MEMBER_IDENTIFIER
		  left join
		  "EDWH_PROD"."GOLD"."CUSTOMER_NATIONALITY" as CUSTOMER_NATIONALITY
		  on  (CUSTOMER.PARTY_SK = CUSTOMER_NATIONALITY.PARTY_SK)
		  JOIN
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT"
		  ON SKYWARDS_MEMBER.SKYWARDS_MEMBER_IDENTIFIER = SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT.SKYWARDS_MEMBER_IDENTIFIER
		  JOIN
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT_REASON"
		  ON SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT.MEMBERSHIP_ENHANCEMENT_REASON_SK = SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_SK
          where 
          SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_CODE  IN  ( 'BCHFMC','BCLFMC'  )
          and
		  SKYWARDS_MEMBER.MEMBER_STATUS_CODE IN ('Active','Pending','INV','SUS') 
		  and
		  to_date(SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT.CARD_EXPIRY_DATE) is null 
		  and
		  SKYWARDS_MEMBER.ENROLLMENT_MEDIA_CODE NOT IN ('FAM','TEST','SDAE','HXGAD')

			) stat_enh
    left join
		  (
		  
		  SELECT
		  to_char(VW_CUSTOMER.SKYWARDS_MEMBER_IDENTIFIER) as member_id,
		  STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_CODE,
		  SKYWARDS_PARTNER_ACTIVITY.LOYALTY_PARTNER_BOOKABLE_ACTIVITY_CODE,
		  SKYWARDS_ACTIVITY_CATEGORY.ACTIVITY_TYPE_CATEGORY_CODE,
		  SKYWARDS_ACTIVITY_CATEGORY.ACTIVITY_TYPE_CATEGORY_NAME,
		  SKYWARDS_PARTNER.LOYALTY_PARTNER_CODE,
		  SKYWARDS_PARTNER.LOYALTY_PARTNER_NAME,
		  SKYWARDS_MEMBERSHIP_ACTIVITY.STATEMENT_DESCRIPTION,
		  SKYWARDS_MEMBER_ACTIVITY_TYPE.MEMBER_ACTIVITY_TYPE_CODE,
		  VW_MEMBER_ACT_TRANSACTIONS.TRANSACTION_DESCRIPTION,
		  to_date(SKYWARDS_MEMBERSHIP_ACTIVITY.MEMBER_ACTIVITY_DATE) MEMBER_ACTIVITY_DATE,
		  to_date(VW_MEMBER_ACT_TRANSACTIONS.TRANSACTION_DATE) TRANSACTION_DATE,
		  
		  sum(VW_MEMBER_ACT_TRANSACTIONS.TIER_MILES_NUMBER) TIER_MILES,
		  sum(nvl(VW_MEMBER_ACT_TRANSACTIONS.SKYWARDS_MILES_NUMBER,0) +nvl( VW_MEMBER_ACT_TRANSACTIONS.GROUP_MILES_NUMBER,0)) as sky_miles,
		  
		  
		  nvl(sum(
				 case 
				   when SKYWARDS_TRANSACTION_TYPE.TRANSACTION_TYPE_CODE in ('SEXP','EXP')
				   then VW_MEMBER_ACT_TRANSACTIONS.SKYWARDS_MILES_NUMBER
					 end),0) exp_miles,

		  count(DISTINCT (CASE WHEN SKYWARDS_MEMBERSHIP_ACTIVITY.MEMBER_ACTIVITY_SEQUENCE_NUMBER=0 THEN NULL ELSE SKYWARDS_MEMBERSHIP_ACTIVITY.MEMBER_ACTIVITY_SEQUENCE_NUMBER END) ) tot_activities
		  
		FROM
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBER" as vw_customer
		  join
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT" as VW_MEMBER_STATUS_ENHANCEMENTS
		  on VW_CUSTOMER.SKYWARDS_MEMBER_IDENTIFIER = VW_MEMBER_STATUS_ENHANCEMENTS.SKYWARDS_MEMBER_IDENTIFIER
		  join
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBERSHIP_STATUS_ENHANCEMENT_REASON" as STATUS_ENHANCEMENT_REASON
		  on VW_MEMBER_STATUS_ENHANCEMENTS.MEMBERSHIP_ENHANCEMENT_REASON_SK = STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_SK
		  join
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBERSHIP_ACTIVITY" as SKYWARDS_MEMBERSHIP_ACTIVITY
		  on VW_CUSTOMER.PARTY_MEMBERSHIP_SK = SKYWARDS_MEMBERSHIP_ACTIVITY.PARTY_MEMBERSHIP_SK
		  join
		  "EDWH_PROD"."GOLD"."SKYWARDS_MEMBER_ACTIVITY_TRANSACTION" as VW_MEMBER_ACT_TRANSACTIONS
		  on SKYWARDS_MEMBERSHIP_ACTIVITY.PARTY_MEMBERSHIP_ACTIVITY_SK = VW_MEMBER_ACT_TRANSACTIONS.PARTY_MEMBERSHIP_ACTIVITY_SK and SKYWARDS_MEMBERSHIP_ACTIVITY.PARTY_SK = VW_MEMBER_ACT_TRANSACTIONS.PARTY_SK
		  join
		  "EDWH_PROD"."GOLD"."SKYWARDS_PARTNER" as SKYWARDS_PARTNER on VW_MEMBER_ACT_TRANSACTIONS.LOYALTY_PARTNER_SK = SKYWARDS_PARTNER.LOYALTY_PARTNER_SK
		  join
		  "EDWH_PROD"."GOLD"."SKYWARDS_PARTNER_ACTIVITY" as SKYWARDS_PARTNER_ACTIVITY on VW_MEMBER_ACT_TRANSACTIONS.LOYALTY_PARTNER_SK = SKYWARDS_PARTNER_ACTIVITY.LOYALTY_PARTNER_SK 
		  and VW_MEMBER_ACT_TRANSACTIONS.LOYALTY_PARTNER_ACTIVITY_SK = SKYWARDS_PARTNER_ACTIVITY.LOYALTY_PARTNER_ACTIVITY_SK
		  join
		"EDWH_PROD"."GOLD"."SKYWARDS_MEMBER_ACTIVITY_TYPE" as SKYWARDS_MEMBER_ACTIVITY_TYPE on SKYWARDS_MEMBERSHIP_ACTIVITY.MEMBER_ACTIVITY_TYPE_SK = SKYWARDS_MEMBER_ACTIVITY_TYPE.MEMBER_ACTIVITY_TYPE_SK 
		and SKYWARDS_MEMBERSHIP_ACTIVITY.MEMBER_ACTIVITY_TYPE_SEQ = SKYWARDS_MEMBER_ACTIVITY_TYPE.MEMBER_ACTIVITY_TYPE_SEQ
		join
		"EDWH_PROD"."GOLD"."SKYWARDS_ACTIVITY_CATEGORY"	as SKYWARDS_ACTIVITY_CATEGORY on (SKYWARDS_MEMBERSHIP_ACTIVITY.ACTIVITY_TYPE_CATEGORY_SK = SKYWARDS_ACTIVITY_CATEGORY.ACTIVITY_TYPE_CATEGORY_SK)
		join
		"EDWH_PROD"."GOLD"."SKYWARDS_TRANSACTION_TYPE" as SKYWARDS_TRANSACTION_TYPE
		on VW_MEMBER_ACT_TRANSACTIONS.TRANSACTION_TYPE_SK = SKYWARDS_TRANSACTION_TYPE.TRANSACTION_TYPE_SK
		  
		  
		  
		WHERE
		   VW_CUSTOMER.MEMBER_STATUS_CODE IN ('Active','Pending','INV','SUS') 
		   AND
		   STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_CODE  IN  ( 'BCHFMC','BCLFMC'  )
           AND
		   to_date(SKYWARDS_MEMBERSHIP_ACTIVITY.MEMBER_ACTIVITY_DATE)  >=  '2020-09-13' 
		   and
		   SKYWARDS_MEMBER_ACTIVITY_TYPE.MEMBER_ACTIVITY_TYPE_CODE NOT IN ('ENR','RCR')
		   and SKYWARDS_MEMBERSHIP_ACTIVITY.ACTIVITY_CANCELLED_FLAG = 'N'

		  
		GROUP BY
		 to_char(VW_CUSTOMER.SKYWARDS_MEMBER_IDENTIFIER) ,
		  STATUS_ENHANCEMENT_REASON.MEMBERSHIP_ENHANCEMENT_REASON_CODE,
		  SKYWARDS_PARTNER_ACTIVITY.LOYALTY_PARTNER_BOOKABLE_ACTIVITY_CODE,
		  SKYWARDS_ACTIVITY_CATEGORY.ACTIVITY_TYPE_CATEGORY_CODE,
		  SKYWARDS_ACTIVITY_CATEGORY.ACTIVITY_TYPE_CATEGORY_NAME,
		  SKYWARDS_PARTNER.LOYALTY_PARTNER_CODE,
		  SKYWARDS_PARTNER.LOYALTY_PARTNER_NAME,
		  SKYWARDS_MEMBERSHIP_ACTIVITY.STATEMENT_DESCRIPTION,
		  SKYWARDS_MEMBER_ACTIVITY_TYPE.MEMBER_ACTIVITY_TYPE_CODE,
		  VW_MEMBER_ACT_TRANSACTIONS.TRANSACTION_DESCRIPTION,
		  to_date(SKYWARDS_MEMBERSHIP_ACTIVITY.MEMBER_ACTIVITY_DATE) ,
		  to_date(VW_MEMBER_ACT_TRANSACTIONS.TRANSACTION_DATE)
         

			) mem_trans on stat_enh.member_id = mem_trans.member_id

group by
stat_enh.MEMBER_ID,
decode ( stat_enh.MEMBERSHIP_ENHANCEMENT_REASON_CODE , 'BCHFMC', 'High Fee Card','BCLFMC' ,'Low Fee Card'),
stat_enh.MEMBERSHIP_ENHANCEMENT_REASON_CODE,
stat_enh.MEMBERSHIP_ENHANCEMENT_REASON_DESCRIPTION,
mem_trans.LOYALTY_PARTNER_BOOKABLE_ACTIVITY_CODE,
mem_trans.ACTIVITY_TYPE_CATEGORY_CODE,
mem_trans.ACTIVITY_TYPE_CATEGORY_NAME,
mem_trans.LOYALTY_PARTNER_CODE,
mem_trans.LOYALTY_PARTNER_NAME,
mem_trans.STATEMENT_DESCRIPTION,
mem_trans.MEMBER_ACTIVITY_TYPE_CODE,
mem_trans.TRANSACTION_DESCRIPTION,
to_date(mem_trans.MEMBER_ACTIVITY_DATE),
trunc(to_date(mem_trans.MEMBER_ACTIVITY_DATE), 'MM'),
trunc(to_date(stat_enh.ACTIVATION_DATE),'MM'),
trunc(to_date(mem_trans.TRANSACTION_DATE),'MM'),
to_date(mem_trans.TRANSACTION_DATE),
stat_enh.age_bucket,
stat_enh.COUNTRY_OF_RESIDENCE_CODE,
stat_enh.COUNTRY_OF_RESIDENCE,
stat_enh.tenure,
to_date(stat_enh.JOIN_DATE),
stat_enh.LOYALTY_TIER_CODE,
stat_enh.NATIONALITY_CODE,
to_date(stat_enh.ACTIVATION_DATE),
stat_enh.gender,
stat_enh.MEMBERSHIP_TENURE_TYPE,
to_date(stat_enh.CARD_EXPIRY)
; `




var insert_rows_2 = `
insert into "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union
select
*
from
"EDWH_PROD"."WS_MDP_PROD"."EXT_GA_RAW_DATA" as a16
where
to_date(date_part) between ((select max(date_part) from "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_master_table_union) +1) and to_date(sysdate()) and
lower(regexp_replace(a16.hits,'[":]', '')) like ('%pagepath/ destinations offers / barclays partnership%') ; `


var trunc_table_2 = ` 
truncate "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_values_table
;`



var insert_rows_3 = `
insert into "EDWH_PROD"."WS_SKYWARDS_PROD".ruch_barclays_values_table
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
cast(ss1.time_on_site *1 as int						   )   as time_on_site         ,
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
regexp_replace( ga_query_param.cd_query_param,'["]', '')   as cd_query_param,


case
when len(CD_QUERY_PARAM) > 19 and CD_QUERY_PARAM like '%referrerid%' then substring(CD_QUERY_PARAM,CHARINDEX('referrerid', CD_QUERY_PARAM)+11 ,  CHARINDEX('&utm_medium', CD_QUERY_PARAM)  -  (CHARINDEX('referrerid', CD_QUERY_PARAM)+11 ) )
when len(CD_QUERY_PARAM) <= 19 and CD_QUERY_PARAM like '%referrerid%' then substring(CD_QUERY_PARAM,CHARINDEX('referrerid', CD_QUERY_PARAM)+11 ) end as referrerid

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
		v2.value:index::string = '159'
		) as ga_query_param on ss1.FULLVISITORID = ga_query_param.FULLVISITORID and ss1.hit_no = ga_query_param.hit_no and ss1.visitid = ga_query_param.visitid

;`


// execute the SQL statements as procedure


// create object to truncate master table
var my_trunc_table1 = snowflake.createStatement({sqlText: trunc_table_1});
var my_trunc_table2 = snowflake.createStatement({sqlText: trunc_table_2});



// create object to insert values into master table
var my_new_table1 = snowflake.createStatement({sqlText: insert_rows_1});
var my_new_table2 = snowflake.createStatement({sqlText: insert_rows_2});
var my_new_table3 = snowflake.createStatement({sqlText: insert_rows_3});




// execute truncate table
// its optional to assign a variable to the execute function
var result14 = my_trunc_table1.execute();
var result15 = my_trunc_table2.execute();



// execute inserting rows
// its optional to assign a variable to the execute function
var result18 = my_new_table1.execute();
var result19 = my_new_table2.execute();
var result20 = my_new_table3.execute();


return 'All Done'
$$;

-- OPTIONAL IF YOU WANT TO CHECK IT THE PROCEDURE WORKS
Call ruch_barclays_dash_2022();






-------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- CREATE THE TASK

DROP TASK IF EXISTS ruch_bus_dashboard_daily_task ;
CREATE TASK ruch_bus_dashboard_daily_task
  WAREHOUSE = SKYWARDS_WH_PROD
  SCHEDULE = 'USING CRON 13 13 * * * Asia/Dubai'
  TIMESTAMP_INPUT_FORMAT = 'YYYY-MM-DD HH24'
  COMMENT = 'refresh all tables for the BUS dashboard'
AS
Call ruch_barclays_dash_2022();


ALTER TASK ruch_bus_dashboard_daily_task RESUME;

SHOW TASKS;




















