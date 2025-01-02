{{ config( tags=["marketing","bing","hubspot","opportunity"], materialized='materialized_view' ) }}

with google_ads as (
    select
        activity_date,
        sum(googleads_impressions) as googleads_impressions,
        ROUND((sum(googleads_cost) / 1000000),2) as googleads_cost,
        sum(googleads_clicks) as googleads_clicks
    from {{ ref('google_ads_daily_base') }}
    group by activity_date
),

bing_ads as (
    select
        timeperiod,
        sum(spend) as bing_spend,
        sum(impressions) as bing_impressions,
        sum(clicks) as bing_clicks
    from {{ ref('bing_ads_daily_base') }}
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
    from {{ ref('hubspot_daily_base')}}
),

facebook as (
    select
        date_start,
        facebook_impressions,
        facebook_reach,
        facebook_spend,
        facebook_clicks,
        facebook_unique_clicks
    from {{ ref('facebook_daily_base')}}
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
    sum(case when iswon = true and status__c <> 'Cancelled' and source__c = 'Email' then points__c else 0 end) as email_won_points
from {{ ref('salesforce_opportunity_base')}}
where marketing_generator__c = '0035f00000G8KYcAAN'
group by sold_date__c
),

opportunity_cancelled as (
SELECT
    cancel_date__c,
    sum(case when iswon = true and status__c = 'Cancelled' then 1 else 0 end) as total_cancelled_opportunities,
    sum(case when iswon = true and cancel_date__c <> NULL then cancelled_points__c else 0 end) as total_cancelled_points
from {{ ref('salesforce_opportunity_base')}}
where marketing_generator__c = '0035f00000G8KYcAAN'
group by cancel_date__c
),

marketing_cost as (
select
    team,
    month,
    hom_cost,
    ipr_cost,
    copywriter,
    dango_costs,
    designer_costs,
    paid_lead_cost,
    data_contractor,
    seo_lead_salary,
    contractor_costs,
    paid_agency_cost,
    paid_support_cost,
    project_management,
    crowd_content_costs,
    email_contractor_costs,
    hubspot_contractor_costs
from {{ ref('marketing_cost_base')}}
),

base_dates as (
    select
        CAST(date as date)
    from {{ source('google_sheets', 'dates') }}
)

select 
    COALESCE(d.date, o.sold_date__c, b.timeperiod, h.converted_date, f.date_start, g.activity_date, c.cancel_date__c, m.month) AS activity_date,
    COALESCE(g.googleads_cost, 0) AS googleads_cost,
    COALESCE(g.googleads_impressions, 0) AS googleads_impressions,
    COALESCE(g.googleads_clicks, 0) AS googleads_clicks,
    COALESCE(b.bing_spend, 0) AS bing_spend,
    COALESCE(b.bing_impressions, 0) AS bing_impressions,
    COALESCE(b.bing_clicks, 0) AS bing_clicks,
    COALESCE(h.hubspot_sent_emails, 0) AS hubspot_sent_emails,
    COALESCE(h.hubspot_opened_emails, 0) AS hubspot_opened_emails,
    COALESCE(h.hubspot_clicks, 0) AS hubspot_clicks,
    COALESCE(h.hubspot_bounces, 0) AS hubspot_bounces,
    COALESCE(h.hubspot_spam_reports, 0) AS hubspot_spam_reports,
    COALESCE(f.facebook_impressions, 0) AS facebook_impressions,
    COALESCE(f.facebook_reach, 0) AS facebook_reach,
    COALESCE(f.facebook_spend, 0) AS facebook_spend, 
    COALESCE(f.facebook_clicks, 0) AS facebook_clicks,
    COALESCE(f.facebook_unique_clicks, 0) AS facebook_unique_clicks,
    COALESCE(o.total_won_opportunities, 0) AS total_won_opportunities,
    COALESCE(o.total_won_points, 0) AS total_won_points,
    COALESCE(o.paid_won_opportunities, 0) AS paid_won_opportunities,
    COALESCE(o.paid_won_points, 0) AS paid_won_points,
    COALESCE(o.earned_won_opportunities, 0) AS earned_won_opportunities,
    COALESCE(o.earned_won_points, 0) AS earned_won_points,
    COALESCE(o.owned_won_opportunities, 0) AS owned_won_opportunities,
    COALESCE(o.owned_won_points, 0) AS owned_won_points,
    COALESCE(o.google_won_opportunities, 0) AS google_won_opportunities,
    COALESCE(o.google_won_points, 0) AS google_won_points,
    COALESCE(o.microsoft_won_opportunities, 0) AS microsoft_won_opportunities,
    COALESCE(o.microsoft_won_points, 0) AS microsoft_won_points,
    COALESCE(o.email_won_opportunities, 0) AS email_won_opportunities,
    COALESCE(o.email_won_points, 0) AS email_won_points,
    COALESCE(c.total_cancelled_opportunities, 0) AS total_cancelled_opportunities,
    COALESCE(c.total_cancelled_points, 0) AS total_cancelled_points,
    m.team AS team,
    m.month AS cost_month,
    COALESCE(m.hom_cost, 0) AS hom_cost,
    COALESCE(m.ipr_cost, 0) AS ipr_cost,
    COALESCE(m.copywriter, 0) AS copywriter,
    COALESCE(m.dango_costs, 0) AS dango_costs,
    COALESCE(m.designer_costs, 0) AS designer_costs,
    COALESCE(m.paid_lead_cost, 0) AS paid_lead_cost,
    COALESCE(m.data_contractor, 0) AS data_contractor,
    COALESCE(m.seo_lead_salary, 0) AS seo_lead_salary,
    COALESCE(m.contractor_costs, 0) AS contractor_costs,
    COALESCE(m.paid_agency_cost, 0) AS paid_agency_cost,
    COALESCE(m.paid_support_cost, 0) AS paid_support_cost,
    COALESCE(m.project_management, 0) AS project_management,
    COALESCE(m.crowd_content_costs, 0) AS crowd_content_costs,
    COALESCE(m.email_contractor_costs, 0) AS email_contractor_costs,
    COALESCE(m.hubspot_contractor_costs, 0) AS hubspot_contractor_costs,
    COALESCE(SUM(COALESCE(m.data_contractor, 0) + COALESCE(m.hubspot_contractor_costs, 0) + COALESCE(m.email_contractor_costs, 0)),0) as total_contractor_costs,
    COALESCE(SUM(COALESCE(m.hom_cost, 0) + COALESCE(m.ipr_cost, 0) + COALESCE(m.copywriter, 0) + COALESCE(m.designer_costs, 0) + COALESCE(m.paid_lead_cost, 0) + COALESCE(m.seo_lead_salary, 0) + COALESCE(m.paid_support_cost, 0) + COALESCE(m.project_management, 0)),0) as operational_costs, 
    COALESCE(SUM(COALESCE(g.googleads_cost,0) + COALESCE(b.bing_spend,0) + COALESCE(f.facebook_spend,0)),0) as total_spend,
    COALESCE(SUM(COALESCE(g.googleads_clicks,0) + COALESCE(b.bing_clicks,0) + COALESCE(f.facebook_clicks,0)),0) as total_clicks,
    COALESCE(SUM(COALESCE(g.googleads_impressions,0) + COALESCE(b.bing_impressions,0) + COALESCE(f.facebook_impressions,0)),0) as total_impressions,
    CASE
        WHEN COALESCE(SUM(COALESCE(g.googleads_clicks,0) + COALESCE(b.bing_clicks,0) + COALESCE(f.facebook_clicks,0)),0) = 0 THEN 0
        ELSE COALESCE(SUM(COALESCE(g.googleads_cost,0) + COALESCE(b.bing_spend,0) + COALESCE(f.facebook_spend,0)),0) / COALESCE(SUM(COALESCE(g.googleads_clicks,0) + COALESCE(b.bing_clicks,0) + COALESCE(f.facebook_clicks,0)),0)
    END AS cost_per_click,
    CASE
        WHEN COALESCE(SUM(COALESCE(g.googleads_impressions,0) + COALESCE(b.bing_impressions,0) + COALESCE(f.facebook_impressions,0)),0) = 0 THEN 0
        ELSE COALESCE(SUM(COALESCE(g.googleads_cost,0) + COALESCE(b.bing_spend,0) + COALESCE(f.facebook_spend,0)),0) / COALESCE(SUM(COALESCE(g.googleads_impressions,0) + COALESCE(b.bing_impressions,0) + COALESCE(f.facebook_impressions,0)),0)
    END AS cost_per_impression,
    CASE
        WHEN COALESCE(SUM(o.total_won_opportunities), 0) = 0 THEN 0
        ELSE COALESCE(SUM(COALESCE(g.googleads_cost,0) + COALESCE(b.bing_spend,0) + COALESCE(f.facebook_spend,0)),0) / COALESCE(SUM(o.total_won_opportunities), 0)
    END AS cost_per_deal,
    CASE
        WHEN COALESCE(SUM(COALESCE(g.googleads_cost,0) + COALESCE(b.bing_spend,0) + COALESCE(f.facebook_spend,0)),0) = 0 THEN 0
        ELSE (((SUM(o.total_won_points) * 100) / COALESCE(SUM(COALESCE(g.googleads_cost,0) + COALESCE(b.bing_spend,0) + COALESCE(f.facebook_spend,0)),0)) / 100)
    END AS return_on_investment
from base_dates as d 
left outer join opportunity_sold as o on d.date = o.sold_date__c
left outer join hubspot as h on d.date = h.converted_date
left outer join bing_ads as b on b.timeperiod = d.date
left outer join facebook as f on f.date_start = d.date
left outer join google_ads as g on g.activity_date = d.date
left outer join opportunity_cancelled as c on c.cancel_date__c = d.date
left outer join marketing_cost as m on d.date = m.month
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50