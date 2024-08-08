{{ config(materialized='table', tags=["marketing","prod"] ) }}

select
    *
from {{source('marketing_intermediate','marketing_intermediate')}}
where activity_date IS NOT NULL
