select
    vp.payment_id,
    vp.vendor_id,
    v.vendor_name,
    vp.date_id,
    d.full_date,
    d.year,
    vp.department_id,
    dept.department_name,
    vp.invoice_number,
    vp.invoice_amount,
    vp.tax_amount,
    vp.total_paid,
    vp.payment_mode,
    vp.payment_status,
    vp.due_date,
    vp.source_system,
    vp.created_at,
    vp.updated_at
from {{ ref('stg_fact_vendor_payment') }} vp
left join {{ ref('dim_vendor') }} v on v.vendor_id = vp.vendor_id
left join {{ ref('dim_date') }} d on d.date_id = vp.date_id
left join {{ ref('dim_department') }} dept on dept.department_id = vp.department_id
