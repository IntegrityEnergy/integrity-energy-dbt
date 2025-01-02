{{ config( tags=["fuzzy_data_clean"] ) }}

-- Data Cleaning

SELECT
    LOWER(TRIM(REGEXP_REPLACE(lead_lastname, '[^a-zA-Z]', ''))) AS fuzzy_match_lastname_key,
    LOWER(TRIM(REGEXP_REPLACE(lead_firstname, '[^a-zA-Z]', ''))) AS fuzzy_match_firstname_key,
    LOWER(TRIM(lead_email)) AS fuzzy_match_email_key,
    LOWER(TRIM(REGEXP_REPLACE(lead_phone, '[- ]', ''))) AS fuzzy_match_phone_key,
    LOWER(TRIM(REGEXP_REPLACE(lead_lastname, '[^a-zA-Z]', ''))) ||
        LOWER(TRIM(REGEXP_REPLACE(lead_firstname, '[^a-zA-Z]', ''))) ||
        LOWER(TRIM(REGEXP_REPLACE(lead_phone, '[- ]', ''))) ||
        LOWER(TRIM(lead_email)) AS fuzzy_match_key,
    RANK() OVER (ORDER BY LOWER(TRIM(lead_email)) ASC
        , LOWER(TRIM(REGEXP_REPLACE(lead_phone, '[- ]', ''))) ASC
        , LOWER(TRIM(REGEXP_REPLACE(lead_lastname, '[^a-zA-Z]', ''))) ASC
        , LOWER(TRIM(REGEXP_REPLACE(lead_firstname, '[^a-zA-Z]', ''))) ASC) AS seq_nbr
FROM
    {{ ref('lead_intermediate') }}
