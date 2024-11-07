
        create materialized view "integrity-db"."dbt-base"."salesforce_account_base"
        backup yes
        diststyle even
        
        
        auto refresh no
    as (
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
from "integrity-db"."salesforce"."account"
    )


    