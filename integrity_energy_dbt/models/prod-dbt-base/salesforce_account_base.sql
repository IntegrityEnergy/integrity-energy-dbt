{{ config( tags=["base","account","deal","salesforce"] ) }}

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
    --utility_company__c
from salesforce.account