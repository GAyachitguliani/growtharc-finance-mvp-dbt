select
    p.payroll_id,
    p.employee_id,
    emp.employee_name,
    emp.designation,
    p.department_id,
    dept.department_name,
    p.location_id,
    loc.location_name,
    p.payroll_month,
    p.basic_salary,
    p.bonus,
    p.deductions,
    p.tax_deduction,
    p.net_salary,
    p.source_system,
    p.created_at,
    p.updated_at
from {{ ref('stg_fact_payroll') }} p
left join {{ ref('dim_employee') }} emp on emp.employee_id = p.employee_id
left join {{ ref('dim_department') }} dept on dept.department_id = p.department_id
left join {{ ref('dim_location') }} loc on loc.location_id = p.location_id
