select * from {{ source('finance_mvp', 'dim_date') }}
