{{ config( tags=["base","meter_number","salesforce"] ) }}

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
from salesforce.meter_number__c