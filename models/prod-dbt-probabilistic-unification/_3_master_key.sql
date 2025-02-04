{{ config( tags=["master_key"] ) }}

SELECT
    fuzzy_data.fuzzy_match_key,
    fuzzy_data.group_key,
    temp.lead_company AS master_key,
    fuzzy_data.seq_nbr AS seq_nbr
FROM
    (SELECT
         fuzzy_match_key,
         group_key,
         lead_company
     FROM
        (SELECT
          fuzzy_match_key,
          lead_company,
          group_key,
          ROW_NUMBER() OVER (PARTITION BY group_key ORDER BY group_key DESC) AS rn
         FROM
          {{ ref('_2_soundex') }}) t1
     WHERE
         rn = 1) AS temp,
         {{ ref('_2_soundex') }} AS fuzzy_data
WHERE
    temp.group_key = fuzzy_data.group_key
