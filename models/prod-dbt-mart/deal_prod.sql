{{ config( tags=["deal","salesforce","prod"] ) }}

select
    *
from {{ ref('deal_intermediate') }}