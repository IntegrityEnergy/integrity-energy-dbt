

  create view "integrity-db-dev"."integrity-dev"."bing_ads_daily_base__dbt_tmp" as (
    

select
    spend,
    impressions,
    clicks,
    timeperiod,
    adgroupname,
    campaignname
from bing_ads.ad_performance_report_daily
  ) ;
