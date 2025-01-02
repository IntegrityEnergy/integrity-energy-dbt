{{ config( tags=["fuzzy_data_clean"] ) }}

-- Data Cleaning

SELECT
  LOWER(REGEXP_REPLACE(lead_lastname, '[^a-zA-Z]', '')) AS fuzzy_match_lastname_key,
  LOWER(REGEXP_REPLACE(lead_firstname, '[^a-zA-Z]', '')) AS fuzzy_match_firstname_key,
  LOWER(REGEXP_REPLACE(lead_email, '[^a-zA-Z]', '')) AS fuzzy_match_email_key,
  LOWER(REGEXP_REPLACE(lead_phone, '[^a-zA-Z]', '')) AS fuzzy_match_phone_key,
  LOWER(REGEXP_REPLACE(lead_master_id, '[^a-zA-Z]', '')) AS fuzzy_match_key,
  RANK() OVER (ORDER BY lead_email ASC, lead_phone ASC, lead_lastname ASC, lead_firstname ASC) AS seq_nbr
FROM
  {{ ref('lead_intermediate') }}
