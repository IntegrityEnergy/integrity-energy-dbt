

  create view "integrity-db-dev"."integrity-dev"."google_ads_daily_base__dbt_tmp" as (
    

select
    DATE(_data_date) as activity_date, 
    metrics_impressions as googleads_impressions,
    metrics_cost_micros  as googleads_cost, 
    metrics_clicks as googleads_clicks
from google_ads.ads_campaignbasicstats_7446470445
  ) ;
