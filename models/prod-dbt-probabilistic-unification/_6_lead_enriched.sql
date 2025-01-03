{{ config( tags=["enrich"] ) }}

--WITH aggregated_customers  AS (
--
--  SELECT
--    lead_master_id
--    ,MAX(lead_company) as lead_company
--    ,MAX(lead_street) as lead_street
--    ,MAX(LOWER(TRIM(lead_email))) as lead_email
--    ,MAX(LOWER(TRIM(REGEXP_REPLACE(lead_phone, '[- ]', '')))) as lead_phone
--    ,MAX(LOWER(TRIM(REGEXP_REPLACE(lead_lastname, '[^a-zA-Z]', '')))) as lead_lastname
--    ,MAX(LOWER(TRIM(REGEXP_REPLACE(lead_firstname, '[^a-zA-Z]', '')))) as lead_firstname
--  FROM
--    {{ ref('lead_prod') }}
--  GROUP BY
--    lead_master_id
--
--),

WITH aggregated_customers  AS (

  SELECT
    lead_master_id
    ,lead_company as lead_company
    ,LOWER(
        TRIM(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        lead_company,
                        '\\b(inc|corp|corporation|ltd|llc|co|company|and)\\b',  -- Remove common suffixes
                        ''
                    ),
                    '[^a-zA-Z]',  -- Remove any non-alphabetic characters (including numbers and special chars)
                    ''
                ),
                '\\s',  -- Remove any spaces
                ''
            )
        )
    ) AS fuzzy_match_company_key
    ,lead_street as lead_street
    ,LOWER(TRIM(lead_email)) as lead_email
    ,TRIM(REGEXP_REPLACE(lead_phone, '[- ]', '')) as lead_phone
    ,LOWER(TRIM(REGEXP_REPLACE(lead_lastname, '[^a-zA-Z]', ''))) as lead_lastname
    ,LOWER(TRIM(REGEXP_REPLACE(lead_firstname, '[^a-zA-Z]', ''))) as lead_firstname
  FROM
    {{ ref('lead_prod') }}
--  GROUP BY
--    lead_master_id

),

add_keys AS (

  SELECT
    lead_master_id
    ,CASE
        WHEN fuzzy_match_company_key IS NULL OR fuzzy_match_company_key = ''
        THEN 'z'
        ELSE fuzzy_match_company_key
    END AS fuzzy_match_key
    ,lead_company
    ,lead_street
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
    ,unify.levenshtein_ratio
    ,keys.lead_company
    ,keys.lead_street
    ,keys.lead_firstname
    ,keys.lead_lastname
    ,keys.lead_email
    ,keys.lead_phone
  FROM
    add_keys AS keys
    INNER JOIN {{ ref('_4_levenshtein') }} AS unify
      ON keys.fuzzy_match_key = unify.fuzzy_match_key

)

SELECT DISTINCT
  lead_master_id
--  ,fuzzy_match_key
  ,master_key
  ,group_key
  ,levenshtein_ratio
  ,lead_company
  ,lead_street
  ,lead_firstname
  ,lead_lastname
  ,lead_email
  ,lead_phone
FROM
  add_master_key
