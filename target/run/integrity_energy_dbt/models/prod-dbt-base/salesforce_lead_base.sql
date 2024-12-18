
        create materialized view "integrity-db"."prod_dbt-base"."salesforce_lead_base"
        backup yes
        diststyle even
        
        
        auto refresh no
    as (
        select
    id,
    city,
    name,
    email,
    phone,
    state,
    title,
    status,
    street,
    company,
    country,
    firstname,
    lastname,
    source__c,
    channel__c,
    leadsource,
    postalcode,
    createddate,
    CAST(createddate as DATE) as createdday,
    isconverted,
    commodity__c,
    converteddate,
    lastactivitydate,
    convertedaccountid,
    convertedcontactid,
    lead_id_for_opp__c,
    average_bill_amount__c,
    convertedopportunityid,
    converted_from_lead__c,
    marketing_generator__c,
    new_ready_to_work_date__c,
    last_activity_note_date__c
from "integrity-db"."salesforce"."lead"
    )


    