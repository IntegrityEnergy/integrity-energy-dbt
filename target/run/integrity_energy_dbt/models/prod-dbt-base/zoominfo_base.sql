

  create view "integrity-db-dev"."prod-dbt-base"."zoominfo_base__dbt_tmp" as (
    select * from zoominfo.zoominfo_upload_09202024
  ) ;
