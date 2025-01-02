{{ config( tags=["marketing"] ) }}

select
    *
from {{ ref('marketing_intermediate') }}
where activity_date IS NOT NULL