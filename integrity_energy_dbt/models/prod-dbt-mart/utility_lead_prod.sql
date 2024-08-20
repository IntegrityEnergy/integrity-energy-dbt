{{ config( tags=["utility_lead","prod"] ) }}

select
    *
from {{source('utility_lead_intermediate','utility_lead_intermediate')}}