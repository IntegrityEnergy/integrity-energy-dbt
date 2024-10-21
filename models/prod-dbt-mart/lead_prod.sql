{{ config(materialized='table', tags=["lead","salesforce","prod"] ) }}

select
    *
from {{ ref('lead_intermediate') }}