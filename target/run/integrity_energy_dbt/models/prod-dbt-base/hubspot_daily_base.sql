
        create materialized view "integrity-db"."prod_dbt-base"."hubspot_daily_base"
        backup yes
        diststyle even
        
        
        auto refresh no
    as (
        with hubspot_daily as (
    SELECT
        (TIMESTAMP 'epoch' + created / 1000 * INTERVAL '1 second')::DATE AS converted_date,
        type
    FROM "integrity-db"."hubspot"."email_events"
)

SELECT
    converted_date,
    sum(case when type = 'SENT' then 1 else 0 end) as sent_emails,
    sum(case when type = 'OPEN' then 1 else 0 end) as opened_emails,
    sum(case when type = 'CLICK' then 1 else 0 end) as clicks,
    sum(case when type = 'BOUNCE' then 1 else 0 end) as bounces,
    sum(case when type = 'SPAMREPORT' then 1 else 0 end) as spam_reports
from hubspot_daily
group by converted_date
    )


    