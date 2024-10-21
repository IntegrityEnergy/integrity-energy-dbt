

  create view "integrity-db-dev"."integrity-dev"."salesforce_meter_number_base__dbt_tmp" as (
    

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
    account__c,
    dl_account__c,
    account_number__c
from "integrity-db"."salesforce"."meter_number__c"
  ) ;
