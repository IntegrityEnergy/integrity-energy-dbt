
  
    

  create  table
    "integrity-db-dev"."prod-dbt-mart"."lead_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."prod-dbt-intermediate"."lead_intermediate"
  );
  