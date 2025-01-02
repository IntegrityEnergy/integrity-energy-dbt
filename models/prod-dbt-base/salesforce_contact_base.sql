{{ config( tags=["contact","deal","lead","salesforce"] ) }}

WITH base AS (

    SELECT
        id,
        name,
        LOWER(TRIM(email)) AS email,
        REGEXP_REPLACE(phone, '[- ]', '') AS phone,
        REGEXP_REPLACE(mobilephone, '[- ', '') AS mobilephone,
        REGEXP_REPLACE(main_phone__c, '[- ]', '') AS main_phone__c,
        title,
        createddate,
        mailingcity,
        mailingstate,
        mailingstatecode,
        mailingcountry,
        accountid,
        rep_last_first__c,
        customer_account_number__c,
        contract_signer_phone_email__c,
        ROW_NUMBER() OVER (
          PARTITION BY
            REGEXP_REPLACE(phone, '[- ]', ''), -- Remove spaces and hyphens from phone numbers
            LOWER(TRIM(REGEXP_REPLACE(email, '[- ]', ''))), -- Normalize email by converting to lowercase
            LOWER(TRIM(name)) -- Normalize name by converting to lowercase
          ORDER BY
            COALESCE(lastactivitydate, createddate) DESC -- Order by last activity date or created date
        ) AS rn
    FROM
        {{ source('salesforce', 'contact') }}

)

SELECT
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
FROM
    base
WHERE
    rn = 1
