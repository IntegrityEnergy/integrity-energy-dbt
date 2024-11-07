
  
    

  create  table
    "integrity-db"."prod_dbt-mart"."lead_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."prod_dbt-intermediate"."lead_intermediate"
  );
  