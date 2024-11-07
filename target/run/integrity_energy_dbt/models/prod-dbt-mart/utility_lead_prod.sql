
  
    

  create  table
    "integrity-db"."dbt-mart"."utility_lead_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."dbt-intermediate"."utility_lead_intermediate"
  );
  