{{ config( tags=["base","meter_number","lead","salesforce"] ) }}

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
from {{ source('salesforce', 'meter_number__c') }}