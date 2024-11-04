
  
    

  create  table
    "integrity-db"."prod-dbt-mart"."deal_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."prod-dbt-intermediate"."deal_intermediate"
  );
  