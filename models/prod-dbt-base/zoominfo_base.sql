select
    *
from
    {{ source('zoominfo', 'zoominfo_upload_09202024') }}
