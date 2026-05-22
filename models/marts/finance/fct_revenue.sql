select
    r.revenue_id,
    r.date_id,
    d.full_date,
    d.year,
    d.quarter,
    d.month_name,
    r.client_id,
    c.client_name,
    c.client_segment,
    c.region as client_region,
    r.project_id,
    p.project_name,
    p.project_type,
    r.revenue_type,
    r.invoice_number,
    r.gross_revenue,
    r.discount_amount,
    r.tax_amount,
    r.net_revenue,
    r.payment_status,
    r.source_system,
    r.created_at,
    r.updated_at
from {{ ref('stg_fact_revenue') }} r
left join {{ ref('dim_date') }} d on d.date_id = r.date_id
left join {{ ref('dim_client') }} c on c.client_id = r.client_id
left join {{ ref('dim_project') }} p on p.project_id = r.project_id
