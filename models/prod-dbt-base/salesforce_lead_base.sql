{{ config( tags=["lead","deal","salesforce"] ) }}

WITH base AS (

    SELECT
        id,
        city,
        name,
        LOWER(TRIM(email)) AS email,
        REGEXP_REPLACE(phone, '[- ', '') AS phone,
        state,
        title,
        status,
        street,
        company,
        country,
        LOWER(TRIM(REGEXP_REPLACE(firstname, '[^a-zA-Z]', ''))) AS firstname,
        LOWER(TRIM(REGEXP_REPLACE(lastname, '[^a-zA-Z]', ''))) AS lastname,
        source__c,
        channel__c,
        leadsource,
        postalcode,
        createddate,
        CAST(createddate AS DATE) AS createdday,
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
        last_activity_note_date__c,
        ROW_NUMBER() OVER (
          PARTITION BY
            REGEXP_REPLACE(phone, '[- ]', ''), -- Remove spaces and hyphens from phone numbers
            LOWER(TRIM(email)), -- Normalize email by converting to lowercase
            LOWER(TRIM(REGEXP_REPLACE(firstname, '[^a-zA-Z]', ''))),
            LOWER(TRIM(REGEXP_REPLACE(lastname, '[^a-zA-Z]', ''))),
          ORDER BY
            COALESCE(lastactivitydate, createddate) DESC -- Order by last activity date or created date
        ) AS rn
    FROM
        {{ source('salesforce', 'lead') }}

)

SELECT
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
    createdday,
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
FROM
    base
WHERE
    rn = 1
