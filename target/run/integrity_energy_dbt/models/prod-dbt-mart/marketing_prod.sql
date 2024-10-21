
  
    

  create  table
    "integrity-db-dev"."prod-dbt-mart"."marketing_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."prod-dbt-intermediate"."marketing_intermediate"
where activity_date IS NOT NULL
  );
  