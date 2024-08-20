{{ config( tags=["lead","salesforce","prod"] ) }}

with utility_leads as (SELECT
u.companyname as utility_companyname,
u.servicestate,
u.utility,
u.serviceaddress,
left(u.servicezip,5) as servicezip,
MIN(e.companyname) as companyname,
MIN(u.accountnumber) as accountnumber,
MIN(u.ratecode) as ratecode,
MIN(right(TRIM(u.accountnumber,''),4)) as "last4",
regexp_replace(MIN(e."be telephone number10"), '[^0-9]', '') as phone,
SUM(u.annualusage) as total_annual_usage,
MIN(e."eru titledesc") as title,
MIN(e."eru firstname") as firstname,
MIN(e."eru lastname") as lastname,
MIN(e."bee email addr80") as email
FROM "integrity-db"."utility_leads"."utilitylead" as u
left join "integrity-db"."utility_leads"."enriched" as e on u.companyname = e.companyname AND u.servicestate = e.servicestate AND u.utility = e.utility AND u.serviceaddress = e.serviceaddress
where e."be telephone number10" IS NOT NULL AND e."be telephone number10" > 1 AND e."be telephone number10" <> ' '
group by 1,2,3,4,5
order by total_annual_usage desc),

salesforce_leads as (
    select
        id as lead_id,
        regexp_replace(phone, '[^0-9]', '') as lead_phone
    from salesforce.lead
)

SELECT
    u.utility_companyname as Company,
    u.servicestate,
    u.utility,
    u.serviceaddress,
    u.servicezip,
    u.accountnumber as accountnumber,
    MIN(u.last4) as last4,
    MIN(u.phone) as phone,
    MIN(l.lead_phone) as lead_phone,
    MIN(u.total_annual_usage) as total_annual_usage,
    case when MIN(u.title) = '' then NULL else MIN(u.title) END as title,
    case when MIN(u.firstname) = '' then NULL else MIN(u.firstname) END as firstname,
    case when MIN(u.lastname) = '' then NULL else MIN(u.lastname) END as lastname,
    case when MIN(u.email) = '' then NULL else MIN(u.email) END as email,
    '0055f000009HAOGAA4' as OwnerId
from utility_leads as u
left join salesforce_leads as l on u.phone = l.lead_phone
where total_annual_usage > 5000000 and l.lead_phone IS NULL
group by 1,2,3,4,5,6
order by MIN(u.total_annual_usage) desc