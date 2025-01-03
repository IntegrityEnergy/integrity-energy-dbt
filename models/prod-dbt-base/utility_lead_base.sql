{{ config( tags=["lead","utility_lead"] ) }}

WITH utilitylead_base AS (

    SELECT
        companyname,
        serviceaddress,
        servicecity,
        servicestate,
        servicezip,
        utility,
        accountnumber,
        annualusage,
        ratecode,
        ROW_NUMBER() OVER (
          PARTITION BY
            companyname, serviceaddress, utility, servicecity, servicestate, ratecode
          ORDER BY
            _airbyte_extracted_at DESC
        ) AS rn
    FROM
        {{ source('utility_leads', 'utilitylead') }}

),

enriched_base AS (

    SELECT
        "eru lastname" as lastname,
        "eru firstname" as firstname,
        "eru titledesc" as title,
        "be telephone number10" as phone,
        "bee email addr80" as email,
        companyname,
        serviceaddress,
        utility,
        servicecity,
        servicestate,
        ratecode
    FROM
        {{ source('utility_leads', 'enriched') }}

)


select
        u.companyname,
        u.serviceaddress,
        u.servicecity,
        u.servicestate,
        u.servicezip,
        u.utility,
        u.accountnumber,
        u.annualusage,
        u.ratecode,
        REGEXP_REPLACE(e.lastname, '[^a-zA-Z]', '') AS lastname,
        REGEXP_REPLACE(e.firstname, '[^a-zA-Z]', '') AS firstname,
        e.title,
        REGEXP_REPLACE(e.phone, '[- ]', '') AS phone,
        LOWER(TRIM(e.email)) AS email,
FROM
    utilitylead_base AS u
    LEFT JOIN enriched_base AS e
        ON u.companyname = e.companyname
            AND u.serviceaddress = e.serviceaddress
            AND u.utility = e.utility
            AND u.servicecity = e.servicecity
            AND u.servicestate = e.servicestate
            AND u.ratecode = e.ratecode
WHERE
    u.rn = 1
GROUP BY
    1,2,3,4,5,6,7,8,9,10,11,12,13,14
