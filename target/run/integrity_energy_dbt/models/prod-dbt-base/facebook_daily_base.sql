

  create view "integrity-db-dev"."prod-dbt-base"."facebook_daily_base__dbt_tmp" as (
    

select
    date_start, 
    sum(impressions) as facebook_impressions,
    sum(reach) as facebook_reach,
    sum(spend) as facebook_spend, 
    sum(clicks) as facebook_clicks,
    sum(unique_clicks) as facebook_unique_clicks
from facebook.ads_insights
group by date_start
  ) ;
