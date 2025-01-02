{{ config( tags=["utility_lead"] ) }}

select
    *
from {{ ref('utility_lead_intermediate') }}