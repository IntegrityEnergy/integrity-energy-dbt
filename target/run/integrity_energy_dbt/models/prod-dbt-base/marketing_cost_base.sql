
        

    

    

    drop materialized view if exists "integrity-db"."prod_dbt-base"."marketing_cost_base";
        create materialized view "integrity-db"."prod_dbt-base"."marketing_cost_base"
        backup yes
        diststyle even
        
        
        auto refresh no
    as (
        select
    team,
    CAST(month as date) as month,
    CAST(REPLACE(hom_cost, ',', '') as decimal(10,2)) as hom_cost,
    CAST(REPLACE(ipr_cost, ',', '')  as decimal(10,2)) as ipr_cost,
    CAST(REPLACE(copywriter, ',', '') as decimal(10,2)) as copywriter,
    CAST(REPLACE(dango_costs, ',', '') as decimal(10,2)) as dango_costs,
    CAST(REPLACE(designer_costs, ',', '') as decimal(10,2)) as designer_costs,
    CAST(REPLACE(paid_lead_cost, ',', '') as decimal(10,2)) as paid_lead_cost,
    CAST(REPLACE(data_contractor, ',', '') as decimal(10,2)) as data_contractor,
    CAST(REPLACE(seo_lead_salary, ',', '') as decimal(10,2)) as seo_lead_salary,
    CAST(REPLACE(contractor_costs, ',', '') as decimal(10,2)) as contractor_costs,
    CAST(REPLACE(paid_agency_cost, ',', '') as decimal(10,2)) as paid_agency_cost,
    CAST(REPLACE(paid_support_cost, ',', '') as decimal(10,2)) as paid_support_cost,
    CAST(REPLACE(project_management, ',', '') as decimal(10,2)) as project_management,
    CAST(REPLACE(crowd_content_costs, ',', '') as decimal(10,2)) as crowd_content_costs,
    CAST(REPLACE(email_contractor_costs, ',', '') as decimal(10,2)) as email_contractor_costs,
    CAST(REPLACE(hubspot_contractor_costs, ',', '') as decimal(10,2)) as hubspot_contractor_costs
from "integrity-db"."google_sheets"."monthly_cost"
    )


    