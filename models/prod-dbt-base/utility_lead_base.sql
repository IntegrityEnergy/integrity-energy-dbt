{{ config( tags=["base","lead","utility_lead"] ) }}

select
        u.companyname,
        u.serviceaddress,
        u.servicecity,
        u.servicestate,
        u.servicezip,
        u.utility,
        u.accountnumber,
        u.annualusage,
        u.ratecode,
        e."eru lastname" as lastname,
        e."eru firstname" as firstname,
        e."eru titledesc" as title,
        e."be telephone number10" as phone,
        e."bee email addr80" as email
from {{ source('utility_leads', 'utilitylead') }} as u
left join utility_leads.enriched as e 
on u.companyname = e.companyname 
AND u.serviceaddress = e.serviceaddress
AND u.utility = e.utility
AND u.servicecity = e.servicecity
AND u.servicestate = e.servicestate
AND u.ratecode = e.ratecode
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14