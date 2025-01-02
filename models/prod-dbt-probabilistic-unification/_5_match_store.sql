{{ config( tags=["match_store"] ) }}

--Match Store

SELECT
  group_key,
  LISTAGG(seq_nbr, ',') WITHIN GROUP (ORDER BY seq_nbr) AS groups
FROM
  {{ ref('_4_levenshtein') }}
GROUP BY
  group_key
