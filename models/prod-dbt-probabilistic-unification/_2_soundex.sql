{{ config( tags=["soundex"] ) }}

--Soundex algortihm

SELECT
  fuzzy_match_key,
  SOUNDEX(fuzzy_match_lastname_key) ||
  SOUNDEX(fuzzy_match_firstname_key) ||
  SOUNDEX(fuzzy_match_phone_key) ||
  SOUNDEX(fuzzy_match_email_key) AS group_key,
  seq_nbr
FROM
  {{ ref('_1_fuzzy_data_clean') }}