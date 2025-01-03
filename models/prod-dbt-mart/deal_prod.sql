{{ config( tags=["deal","salesforce"] ) }}

select
    *
from {{ ref('deal_intermediate') }}