{{ config( tags=["base","contact","deal","salesforce"] ) }}

select
    id,
    name,
    email,
    phone,
    mobilephone,
    main_phone__c,
    title,
    createddate,
    mailingcity,
    mailingstate,
    mailingstatecode,
    mailingcountry,
    accountid,
    rep_last_first__c,
    customer_account_number__c,
    contract_signer_phone_email__c
from salesforce.contact