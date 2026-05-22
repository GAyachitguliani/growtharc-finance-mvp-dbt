select
    e.expense_id,
    e.date_id,
    d.full_date,
    d.year,
    d.quarter,
    e.department_id,
    dept.department_name,
    dept.cost_center,
    e.vendor_id,
    v.vendor_name,
    e.expense_category_id,
    ec.expense_category_name,
    ec.expense_type,
    e.location_id,
    loc.location_name,
    loc.country as location_country,
    e.expense_amount,
    e.payment_mode,
    e.approval_status,
    e.source_system,
    e.created_at,
    e.updated_at
from {{ ref('stg_fact_expense') }} e
left join {{ ref('dim_date') }} d on d.date_id = e.date_id
left join {{ ref('dim_department') }} dept on dept.department_id = e.department_id
left join {{ ref('dim_vendor') }} v on v.vendor_id = e.vendor_id
left join {{ ref('dim_expense_category') }} ec on ec.expense_category_id = e.expense_category_id
left join {{ ref('dim_location') }} loc on loc.location_id = e.location_id
