
  
    

  create  table
    "integrity-db"."dbt-mart"."deal_prod__dbt_tmp"
    
    
    
  as (
    

select
    *
from "integrity-db"."dbt-intermediate"."deal_intermediate"
  );
  