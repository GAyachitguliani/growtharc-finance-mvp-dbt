select * from {{ source('finance_mvp', 'dim_expense_category') }}
