
        

    

    

    drop materialized view if exists "integrity-db"."prod_dbt-base"."google_ads_daily_base";
        create materialized view "integrity-db"."prod_dbt-base"."google_ads_daily_base"
        backup yes
        diststyle even
        
        
        auto refresh no
    as (
        select
    DATE(_data_date) as activity_date, 
    metrics_impressions as googleads_impressions,
    metrics_cost_micros  as googleads_cost, 
    metrics_clicks as googleads_clicks
from "integrity-db"."google_ads"."ads_campaignbasicstats_7446470445"
    )


    