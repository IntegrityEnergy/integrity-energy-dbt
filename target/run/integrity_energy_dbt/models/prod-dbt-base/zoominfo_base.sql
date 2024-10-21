

  create view "integrity-db-dev"."integrity-dev"."zoominfo_base__dbt_tmp" as (
    select
    *
from
    "integrity-db"."zoominfo"."zoominfo_upload_09202024"
  ) ;
