select
    pc.project_cost_id,
    pc.project_id,
    pr.project_name,
    pr.client_id,
    cl.client_name,
    pc.employee_id,
    emp.employee_name,
    pc.date_id,
    d.full_date,
    pc.infrastructure_cost,
    pc.material_cost,
    pc.travel_cost,
    pc.total_project_cost,
    pc.source_system,
    pc.created_at,
    pc.updated_at
from {{ ref('stg_fact_project_cost') }} pc
left join {{ ref('dim_project') }} pr on pr.project_id = pc.project_id
left join {{ ref('dim_client') }} cl on cl.client_id = pr.client_id
left join {{ ref('dim_employee') }} emp on emp.employee_id = pc.employee_id
left join {{ ref('dim_date') }} d on d.date_id = pc.date_id
