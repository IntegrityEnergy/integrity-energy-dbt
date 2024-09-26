{{ config( tags=["lead","salesforce","intermediate"] ) }}

with salesforce_leads as (
    select
        id as lead_id,
        city as lead_city,
        name as lead_name,
        email as lead_email,
        phone as lead_phone,
        state as lead_state,
        title as lead_title,
        status as lead_status,
        street as lead_street,
        company as lead_company,
        country as lead_country,
        firstname as lead_firstname,
        lastname as lead_lastname,
        source__c as lead_source,
        channel__c as lead_channel,
        leadsource as lead_leadsource,
        postalcode as lead_postalcode,
        createddate as lead_createddate,
        isconverted as lead_isconverted,
        commodity__c as lead_commodity,
        converteddate as lead_converteddate,
        lastactivitydate as lead_lastactivitydate,
        convertedaccountid as lead_convertedaccountid,
        convertedcontactid as lead_convertedcontactid,
        average_bill_amount__c as lead_average_bill_amount,
        convertedopportunityid as lead_convertedopportunityid,
        marketing_generator__c as lead_marketing_generator,
        new_ready_to_work_date__c as lead_new_ready_to_work_date
    from {{ source('salesforce_lead_base','salesforce_lead_base') }}
),

salesforce_contacts as (
    select
        id as contact_id,
        name as contact_name,
        email as contact_email,
        phone as contact_phone,
        mobilephone as contact_mobilephone,
        main_phone__c as contact_mainphone,
        title as contact_title,
        createddate as contact_createddate,
        mailingcity as contact_mailingcity,
        mailingstate as contact_mailingstate,
        mailingstatecode as contact_mailingstatecode,
        mailingcountry as contact_mailingcountry,
        accountid as contact_accountid,
        rep_last_first__c as contact_rep_last_first,
        customer_account_number__c as contact_customer_account_number,
        contract_signer_phone_email__c as contact_contract_signer_phone_email
    from {{ source('salesforce_contact_base','salesforce_contact_base') }}
),

salesforce_opportunities as (
    select
        contract_signer__c as opp_contract_signer,
        count(distinct(id)) as total_opportunities,
        sum((case when iswon = true then 1 else 0 end)) as won_opportunities,
        sum((case when iswon = true then points__c else 0 end)) as won_points,
        sum((case when iswon = false and isclosed = true then 1 else 0 end)) as lost_opportunities,
        sum((case when isclosed = false then 1 else 0 end)) as open_opportunities,
        sum((case when isclosed = true then 1 else 0 end)) as closed_opportunities
    from {{ source('salesforce_opportunity_base','salesforce_opportunity_base')}}
    group by opp_contract_signer
),

utility_lead as (
    select
        companyname as utility_companyname,
        serviceaddress as utility_serviceaddress,
        servicecity as utility_servicecity,
        servicezip as utility_servicezip,
    from {{ source('utility_lead_base','utility_lead_base')}}
)

select
*
from salesforce_leads as l
left join salesforce_contacts as c on l.lead_convertedcontactid = c.contact_id
left join salesforce_opportunities as o on l.lead_convertedcontactid = o.opp_contract_signer
left join utility_lead as u on l.company = u.companyname
