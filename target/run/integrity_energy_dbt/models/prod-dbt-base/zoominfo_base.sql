
        create materialized view "integrity-db-prod"."dbt-base"."zoominfo_base"
        backup yes
        diststyle even
        
        
        auto refresh no
    as (
        select
    *
from
    "integrity-db"."zoominfo"."zoominfo_upload_09202024"
    )


    