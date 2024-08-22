{{ config( tags=["marketing","bing","hubspot","opportunity","intermediate"] ) }}

with google_ads as (
    select
        activity_date,
        sum(googleads_impressions) as googleads_impressions,
        ROUND((sum(googleads_cost) / 1000000),2) as googleads_cost,
        sum(googleads_clicks) as googleads_clicks
    from {{ source('google_ads_daily_base') }}
    group by activity_date
)

with bing_ads as (
    select
        timeperiod,
        sum(spend) as bing_spend,
        sum(impressions) as bing_impressions,
        sum(clicks) as bing_clicks
    from {{ source('bing_ads_daily_base','bing_ads_daily_base') }}
    group by timeperiod
),

hubspot as (
    select
        converted_date,
        sent_emails as hubspot_sent_emails,
        opened_emails as hubspot_opened_emails,
        clicks as hubspot_clicks,
        bounces as hubspot_bounces,
        spam_reports as hubspot_spam_reports
    from {{ source('hubspot_daily_base','hubspot_daily_base')}}
),

facebook as (
    select
        date_start,
        facebook_impressions,
        facebook_reach,
        facebook_spend, 
        facebook_clicks,
        facebook_unique_clicks
    from {{ source('facebook_daily_base','facebook_daily_base')}}
),

opportunity_sold as (
    SELECT 
    sold_date__c,
    sum(case when iswon = true and status__c <> 'Cancelled' then 1 else 0 end) as total_won_opportunities,
    sum(case when iswon = true and status__c <> 'Cancelled' then points__c else 0 end) as total_won_points,
    sum(case when iswon = true and status__c <> 'Cancelled' and team__c = 'Paid' then 1 else 0 end) as paid_won_opportunities,
    sum(case when iswon = true and status__c <> 'Cancelled' and team__c = 'Paid' then points__c else 0 end) as paid_won_points,
    sum(case when iswon = true and status__c <> 'Cancelled' and team__c = 'Earned' then 1 else 0 end) as earned_won_opportunities,
    sum(case when iswon = true and status__c <> 'Cancelled' and team__c = 'Earned' then points__c else 0 end) as earned_won_points,
    sum(case when iswon = true and status__c <> 'Cancelled' and team__c = 'Owned' then 1 else 0 end) as owned_won_opportunities,
    sum(case when iswon = true and status__c <> 'Cancelled' and team__c = 'Owned' then points__c else 0 end) as owned_won_points,
    sum(case when iswon = true and status__c <> 'Cancelled' and source__c = 'Google' then 1 else 0 end) as google_won_opportunities,
    sum(case when iswon = true and status__c <> 'Cancelled' and source__c = 'Google' then points__c else 0 end) as google_won_points,
    sum(case when iswon = true and status__c <> 'Cancelled' and source__c = 'Microsoft' then 1 else 0 end) as microsoft_won_opportunities,
    sum(case when iswon = true and status__c <> 'Cancelled' and source__c = 'Microsoft' then points__c else 0 end) as microsoft_won_points,
    sum(case when iswon = true and status__c <> 'Cancelled' and source__c = 'Email' then 1 else 0 end) as email_won_opportunities,
    sum(case when iswon = true and status__c <> 'Cancelled' and source__c = 'Email' then points__c else 0 end) as email_won_points,
    sum(case when iswon = true and status__c = 'Cancelled' then 1 else 0 end) as total_cancelled_opportunities,
    sum(case when iswon = true and status__c = 'Cancelled' then cancelled_points__c else 0 end) as total_cancelled_points
from {{ source('salesforce_opportunity_base','salesforce_opportunity_base')}}
where marketing_generator__c = '0035f00000G8KYcAAN'
group by sold_date__c
)

select 
    COALESCE(o.sold_date__c, b.timeperiod, h.converted_date, f.date_start, g.activity_date ) as activity_date,
    g.googleads_cost,
    g.googleads_impressions,
    g.googleads_clicks,
    b.bing_spend,
    b.bing_impressions,
    b.bing_clicks,
    h.hubspot_sent_emails,
    h.hubspot_opened_emails,
    h.hubspot_clicks,
    h.hubspot_bounces,
    h.hubspot_spam_reports,
    f.facebook_impressions,
    f.facebook_reach,
    f.facebook_spend, 
    f.facebook_clicks,
    f.facebook_unique_clicks,
    o.total_won_opportunities,
    o.total_won_points,
    o.paid_won_opportunities,
    o.paid_won_points,
    o.earned_won_opportunities,
    o.earned_won_points,
    o.owned_won_opportunities,
    o.owned_won_points,
    o.google_won_opportunities,
    o.google_won_points,
    o.microsoft_won_opportunities,
    o.microsoft_won_points,
    o.email_won_opportunities,
    o.email_won_points,
    o.total_cancelled_opportunities,
    o.total_cancelled_points
from opportunity_sold as o
left outer join hubspot as h on o.sold_date__c = h.converted_date
left outer join bing_ads as b on b.timeperiod = o.sold_date__c
left outer join facebook as f on f.date_start = o.sold_date__c
left outer join google_ads as g on g.activity_date = o.sold_date__c
