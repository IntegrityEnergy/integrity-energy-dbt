

  create view "integrity-db-dev"."integrity-dev"."salesforce_account_base__dbt_tmp" as (
    

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
  ) ;
