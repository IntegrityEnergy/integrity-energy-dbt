

select
    *
from "integrity-db"."prod_dbt-intermediate"."marketing_intermediate"
where activity_date IS NOT NULL