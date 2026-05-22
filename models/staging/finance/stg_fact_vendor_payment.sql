select * from {{ source('finance_mvp', 'fact_vendor_payment') }}
