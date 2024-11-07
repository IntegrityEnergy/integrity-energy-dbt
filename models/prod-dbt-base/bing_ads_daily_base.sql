{{ config( tags=["base","marketing","bing"] ) }}

select
    spend,
    impressions,
    clicks,
    timeperiod,
    adgroupname,
    campaignname
from {{ source('bing_ads', 'ad_performance_report_daily') }}