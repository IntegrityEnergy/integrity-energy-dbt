{{ config( tags=["sales","renewal_dash"], materialized='materialized_view' ) }}

-- Step 1: Select from the `meter` table in the Salesforce schema
WITH salesforce_meter AS (
    SELECT * 
    FROM {{ ref('salesforce_meter_number_base')}}
        WHERE status__c != 'unbooked' 

)

-- Step 2: Select final filtered rows
SELECT
    *
FROM
    salesforce_meter