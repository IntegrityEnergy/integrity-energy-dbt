

  create view "integrity-db"."prod-dbt-mart"."utility_lead_prod__dbt_tmp" as (
    

select
    *
from "integrity-db"."prod-dbt-intermediate"."utility_lead_intermediate"
  ) ;
