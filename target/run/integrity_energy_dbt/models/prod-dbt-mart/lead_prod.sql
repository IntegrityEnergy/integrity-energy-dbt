
  
    

  create  table
    "integrity-db"."dbt-mart"."lead_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."dbt-intermediate"."lead_intermediate"
  );
  