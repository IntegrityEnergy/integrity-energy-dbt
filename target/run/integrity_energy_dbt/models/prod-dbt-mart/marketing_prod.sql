
  
    

  create  table
    "integrity-db"."prod_dbt-mart"."marketing_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."prod_dbt-intermediate"."marketing_intermediate"
where activity_date IS NOT NULL
  );
  