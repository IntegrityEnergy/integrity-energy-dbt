{{ config(materialized='table', tags=["deal","salesforce","prod"] ) }}

select
    *
from {{source('deal_intermediate','deal_intermediate')}}