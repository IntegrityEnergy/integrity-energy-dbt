

select
    *
from "integrity-db"."prod-dbt-intermediate"."marketing_intermediate"
where activity_date IS NOT NULL