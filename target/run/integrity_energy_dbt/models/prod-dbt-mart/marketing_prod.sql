
  
    

  create  table
    "integrity-db"."dbt-mart"."marketing_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."dbt-intermediate"."marketing_intermediate"
where activity_date IS NOT NULL
  );
  