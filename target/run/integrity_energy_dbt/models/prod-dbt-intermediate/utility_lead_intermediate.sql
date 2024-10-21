

  create view "integrity-db-prod"."dbt-intermediate"."utility_lead_intermediate__dbt_tmp" as (
    

with meter_number as (
    select
        id,
        name,
        city__c,
        state__c,
        street__c,
        zip_code__c,
        mils__c,
        commodity__c,
        createddate,
        service_address__c,
        status__c,
        account__c
    from "integrity-db-prod"."dbt-base"."salesforce_meter_number_base"
),

account as (
    select
        id,
        name,
        type,
        phone,
        industry,
        billingcity,
        billingcountry,
        billingcountrycode,
        billingpostalcode,
        billingstreet,
        main_phone__c
    from "integrity-db-prod"."dbt-base"."salesforce_account_base"
),

utility_leads as (
    select
        companyname,
        serviceaddress,
        servicecity,
        servicestate,
        servicezip,
        utility,
        accountnumber,
        annualusage,
        ratecode,
        lastname,
        firstname,
        title,
        phone,
        email
    from "integrity-db-prod"."dbt-base"."utility_lead_base"
)

select
    m.id as meter_number_id,
    MIN(m.name) as meter_number_name,
    MIN(m.city__c) as meter_number_city,
    MIN(m.state__c) as meter_number_state,
    MIN(m.street__c) as meter_number_street,
    MIN(m.zip_code__c) as meter_number_zip_code,
    MIN(m.mils__c) as meter_number_mils,
    MIN(m.commodity__c) as meter_number_commodity,
    MIN(m.createddate) as meter_number_createddate,
    MIN(m.service_address__c) as meter_number_service_address,
    MIN(m.status__c) as meter_number_status,
    MIN(m.account__c) as meter_number_account_id,
    MIN(a.id) as account_id,
    MIN(a.name) as account_name,
    MIN(a.type) as account_type,
    MIN(a.phone) as account_phone,
    MIN(a.industry) as account_industry,
    MIN(a.billingcity) as account_billingcity,
    MIN(a.billingcountry) as account_billingcountry,
    MIN(a.billingcountrycode) as account_billingcountrycode,
    MIN(a.billingpostalcode) as account_billingpostalcode,
    MIN(a.billingstreet) as account_billingstreet,
    MIN(a.main_phone__c) as account_main_phone,
    MIN(u.companyname) as utility_companyname,
    MIN(u.serviceaddress) as utility_serviceaddress,
    MIN(u.servicecity) as utility_servicecity,
    MIN(u.servicestate) as utility_servicestate,
    MIN(u.servicezip) as utility_servicezip,
    MIN(u.utility) as utility_utility,
    MIN(u.accountnumber) as utility_accountnumber,
    MIN(u.annualusage) as utility_annualusage,
    MIN(u.ratecode) as utility_ratecode,
    MIN(u.firstname) as utility_firstname,
    MIN(u.lastname) as utility_lastname,
    MIN(u.title) as utility_title,
    MIN(u.phone) as utility_phone,
    MIN(u.email) as utility_email
from meter_number as m
left join account as a on m.account__c = a.id
left join utility_leads as u 
on 
    (trim(lower(a.name)) = trim(lower(u.companyname)) AND
    trim(m.zip_code__c) = trim(u.servicezip) AND
    trim(lower(m.city__c)) = trim(lower(u.servicecity)) AND
    regexp_substr(m.street__c, '^[0-9]+') = regexp_substr(u.serviceaddress, '^[0-9]+'))
    --OR (trim(lower(m.street__c)) = trim(lower(u.serviceaddress)))
group by m.id
  ) ;
