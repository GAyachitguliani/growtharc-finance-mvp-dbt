select * from {{ source('finance_mvp', 'fact_project_cost') }}
