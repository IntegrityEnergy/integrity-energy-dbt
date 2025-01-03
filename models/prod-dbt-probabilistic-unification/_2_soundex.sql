{{ config( tags=["soundex"] ) }}

--Soundex algortihm

SELECT
  fuzzy_match_key
  ,lead_company
  ,SOUNDEX(fuzzy_match_key) AS group_key
  ,seq_nbr
FROM
  {{ ref('_1_fuzzy_data_clean') }}