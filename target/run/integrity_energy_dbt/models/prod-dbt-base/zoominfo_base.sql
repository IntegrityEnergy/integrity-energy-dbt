

  create view "integrity-db-dev"."integrity-dev"."zoominfo_base__dbt_tmp" as (
    select * from zoominfo.zoominfo_upload_09202024
  ) ;
