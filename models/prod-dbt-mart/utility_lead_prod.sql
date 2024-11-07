{{ config( tags=["utility_lead","prod"] ) }}

select
    *
from {{ ref('utility_lead_intermediate') }}