
  
    

  create  table
    "integrity-db"."prod_dbt-mart"."utility_lead_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."prod_dbt-intermediate"."utility_lead_intermediate"
  );
  