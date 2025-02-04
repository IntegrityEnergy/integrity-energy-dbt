{{ config(tags=["fuzzy_data_clean"]) }}

WITH clean_data AS (
    SELECT
        LOWER(
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
        ,LOWER(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(lead_company, '[^a-zA-Z]', ''), '\\s', ''))) AS lead_company
    FROM
        {{ ref('lead_intermediate') }}

)

SELECT
    fuzzy_match_company_key
    ,lead_company
    ,CASE
        WHEN fuzzy_match_company_key IS NULL OR fuzzy_match_company_key = ''
        THEN 'z'
        ELSE fuzzy_match_company_key
    END AS fuzzy_match_key
    ,RANK() OVER (
        ORDER BY
            fuzzy_match_company_key ASC
    ) AS seq_nbr
FROM
    clean_data
