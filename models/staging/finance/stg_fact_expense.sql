select * from {{ source('finance_mvp', 'fact_expense') }}
