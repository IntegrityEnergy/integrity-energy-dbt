{{ config(materialized='table', tags=["lead","salesforce","prod"] ) }}

select
    *
from {{source('lead_intermediate','lead_intermediate')}}