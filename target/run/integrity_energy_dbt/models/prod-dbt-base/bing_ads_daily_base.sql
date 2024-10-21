
        create materialized view "integrity-db-prod"."dbt-base"."bing_ads_daily_base"
        backup yes
        diststyle even
        
        
        auto refresh no
    as (
        select
    spend,
    impressions,
    clicks,
    timeperiod,
    adgroupname,
    campaignname
from "integrity-db"."bing_ads"."ad_performance_report_daily"
    )


    