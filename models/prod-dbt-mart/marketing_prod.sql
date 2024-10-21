{{ config(materialized='table', tags=["marketing","prod"] ) }}

select
    *
from {{ ref('marketing_intermediate') }}
where activity_date IS NOT NULL
