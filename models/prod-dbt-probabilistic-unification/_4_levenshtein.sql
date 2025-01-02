{{ config( tags=["levenshtein"] ) }}

-- Levenshtein with Filtering

SELECT
    fuzzy_match_key,
    master_key,
    group_key,
    CASE
        WHEN fuzzy_match_key = master_key THEN 100
        ELSE 100 - ABS(LENGTH(fuzzy_match_key) - LENGTH(master_key))
    END AS levenshtein_ratio,
    seq_nbr
FROM
    {{ ref('_3_master_key') }}
WHERE
    CASE
        WHEN fuzzy_match_key = master_key THEN 100
        ELSE 100 - ABS(LENGTH(fuzzy_match_key) - LENGTH(master_key))
    END >= 80.0
