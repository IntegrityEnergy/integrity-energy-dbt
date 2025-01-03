{{ config( tags=["lead","salesforce"] ) }}

select
    *
from {{ ref('lead_intermediate') }}