select * from {{ source('finance_mvp', 'dim_vendor') }}
