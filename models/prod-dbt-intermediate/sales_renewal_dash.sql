{{ config( tags=["sales","renewal_dash"], materialized='materialized_view' ) }}

-- Step 1: Select from the `contact` table in the Salesforce schema
WITH salesforce_contact AS (

    SELECT
        *
    FROM
        {{ ref('salesforce_contact_base')}}

),

-- Step 2: Remove unnecessary columns
contact_filtered AS (

    SELECT
        id
        ,reportstoid
        ,name
        ,lastname
        ,department
    FROM
        salesforce_contact

),

-- Step 3: Perform a LEFT JOIN on `reportstoid` and `id` within the same dataset
merged_contacts AS (

    SELECT
        cf.*
        ,rc.name AS rc_name
        ,rc.lastname AS rc_lastname
    FROM
        contact_filtered cf
        LEFT JOIN contact_filtered rc
            ON cf.reportstoid = rc.id

),

-- Step 4: Add a new column with a static value ("Team")
added_custom_column AS (

    SELECT
        *
        ,'Team' AS team_prefix
    FROM
        merged_contacts

),

-- Step 5: Filter rows where `Removed Columns.lastname` is not NULL
filtered_rows AS (

    SELECT
        *
    FROM
        added_custom_column
    WHERE
        rc_lastname IS NOT NULL

),

-- Step 6: Combine the "Team Prefix" and "Removed Columns.lastname" columns into a new column
merged_columns AS (

    SELECT
        *
        ,CONCAT(team_prefix, ' ', rc_lastname) AS "Team"
    FROM
        filtered_rows

),

-- Step 7: Replace specific values in the "Team" column
replaced_value AS (

    SELECT
        *
        ,CASE
           WHEN "Team" = 'Team Leads' THEN 'Website Leads'
           ELSE "Team"
        END AS "Team Updated"
    FROM
        merged_columns

),

-- Step 8: Duplicate the "department" column and rename it
duplicated_column AS (

    SELECT
        *
        ,department AS "Renewals Distinction"
    FROM
        replaced_value

),

-- Step 9: Replace values in the "Renewals Distinction" column
updated_renewals AS (

    SELECT
        *
        ,CASE
           WHEN "Renewals Distinction" = 'Lead Generator'
            THEN 'Inside Sales'
           WHEN "Renewals Distinction" = 'New Sales'
            THEN 'Inside Sales'
           WHEN "Renewals Distinction" = 'Sub Agent'
            THEN 'SubAgent'
           WHEN "Renewals Distinction" = 'Renewals'
            THEN 'Inside Sales'
           WHEN "Renewals Distinction" = 'Sales Director'
            THEN 'Inside Sales'
           WHEN "Renewals Distinction" = 'Retention'
            THEN 'Inside Sales'
           ELSE "Renewals Distinction"
        END AS "Renewals Distinction Updated"
    FROM
        duplicated_column

)

-- Step 10: Select final filtered rows
SELECT
    *
FROM
    updated_renewals