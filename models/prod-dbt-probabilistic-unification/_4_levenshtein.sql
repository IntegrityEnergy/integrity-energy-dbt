{{ config( tags=["levenshtein"] ) }}

-- Levenshtein with Filtering

WITH ratio AS (

    SELECT
        fuzzy_match_key,
        master_key,
        group_key,
        ((length(fuzzy_match_key) + length(master_key)) - fn_levenshtein_distance(fuzzy_match_key, master_key)) / (length(fuzzy_match_key) + length(master_key)) * 100 AS levenshtein_ratio,
        seq_nbr
    FROM
        {{ ref('_3_master_key') }}

)

SELECT
    fuzzy_match_key,
    master_key,
    group_key,
    levenshtein_ratio,
    seq_nbr
FROM
    ratio
WHERE
    levenshtein_ratio >= 75.0
