
  
    

  create  table
    "integrity-db"."prod_dbt-mart"."deal_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."prod_dbt-intermediate"."deal_intermediate"
  );
  