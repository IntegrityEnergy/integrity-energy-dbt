{{ config( tags=["enrich"] ) }}

WITH aggregated_customers  AS (

  SELECT
    lead_master_id
    ,MAX(LOWER(TRIM(lead_email))) as lead_email
    ,MAX(LOWER(TRIM(REGEXP_REPLACE(lead_phone, '[- ]', '')))) as lead_phone
    ,MAX(LOWER(TRIM(REGEXP_REPLACE(lead_lastname, '[^a-zA-Z]', '')))) as lead_lastname
    ,MAX(LOWER(TRIM(REGEXP_REPLACE(lead_firstname, '[^a-zA-Z]', '')))) as lead_firstname
  FROM
    {{ ref('lead_prod') }}
  GROUP BY
    lead_master_id

),

add_keys AS (

  SELECT
    lead_master_id
    ,LOWER(TRIM(lead_lastname)) ||
        LOWER(TRIM(lead_firstname)) ||
        LOWER(TRIM(lead_phone)) ||
        LOWER(TRIM(lead_email)) AS fuzzy_match_key
    ,lead_email
    ,lead_phone
    ,lead_lastname
    ,lead_firstname
  FROM
    aggregated_customers

),

add_master_key AS (

  SELECT
    keys.lead_master_id
    ,keys.fuzzy_match_key
    ,unify.master_key
    ,unify.group_key
    ,keys.lead_firstname
    ,keys.lead_lastname
    ,keys.lead_email
    ,keys.lead_phone
  FROM
    add_keys AS keys
    LEFT JOIN {{ ref('_4_levenshtein') }} AS unify
      ON keys.fuzzy_match_key = unify.fuzzy_match_key
        AND unify.levenshtein_ratio = 100

)

SELECT
  lead_master_id
--  ,fuzzy_match_key
  ,master_key
  ,group_key
  ,lead_firstname
  ,lead_lastname
  ,lead_email
  ,lead_phone
FROM
  add_master_key
WHERE
  master_key IS NOT NULL
