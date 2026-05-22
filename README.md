# GrowthArc Finance MVP — dbt on Snowflake

**Repository:** [github.com/GAyachitguliani/growtharc-finance-mvp-dbt](https://github.com/GAyachitguliani/growtharc-finance-mvp-dbt)  
**Stack:** dbt Cloud · Snowflake · GitHub · Cursor (remote dbt MCP)

Medallion analytics project for the Finance MVP capstone: dimensions and facts in `CAPSTONE_PROJECT.FINANCE_MVP`, transformed through dbt (silver/gold) with Semantic Layer metrics for governed reporting and AI assistants.

---

## Overview

| Item | Detail |
|------|--------|
| **Purpose** | Finance analytics MVP — revenue, expense, payroll, project cost, vendor payments |
| **Source system** | Snowflake tables created via capstone DDL (`DIM_*`, `FACT_*`) |
| **Transform engine** | dbt (dbt Cloud jobs / IDE) |
| **Compute** | Snowflake warehouse |
| **Consumption** | Gold marts + dbt Semantic Layer; optional Cursor via remote MCP |

---

## Architecture (medallion)

| Layer | Location | Description |
|-------|----------|-------------|
| **Bronze** | `CAPSTONE_PROJECT.FINANCE_MVP` | Raw dims/facts (Snowflake DDL — outside dbt) |
| **Silver** | `models/staging/finance/` | Cleansed views (`stg_*`) over sources |
| **Gold** | `models/marts/finance/` | Business-ready `dim_*` and enriched `fct_*` |
| **Semantic** | `_finance__semantic.yml` | Metrics: net revenue, total expenses |

```
Snowflake (bronze) → dbt staging (silver) → dbt marts (gold) → Semantic Layer / BI / MCP
```

---

## Prerequisites

1. Snowflake: run capstone DDL; grant `SELECT` on `FINANCE_MVP` and `CREATE` on dev schema (e.g. `FINANCE_MVP_DBT`).
2. dbt Cloud: project linked to this GitHub repo; Snowflake connection to `CAPSTONE_PROJECT`.
3. Profile name in dbt Cloud: **`capstone_finance`** (matches `dbt_project.yml`).

---

## dbt Cloud setup

1. **GitHub** → connect repository [GAyachitguliani/growtharc-finance-mvp-dbt](https://github.com/GAyachitguliani/growtharc-finance-mvp-dbt).
2. **Connection** → Snowflake: account, role, warehouse, database `CAPSTONE_PROJECT`.
3. **Development environment** → default/custom schema: `FINANCE_MVP_DBT` (recommended — do not overwrite bronze tables).
4. Run: `dbt deps` then `dbt build`.
5. Enable **Semantic Layer** and **Copilot** (plan-dependent) for metrics and MCP.

---

## Cursor — remote dbt MCP

Copy `.cursor/mcp.json.example` to `.cursor/mcp.json` and set:

- dbt host URL  
- Personal access token  
- Production / development environment IDs  
- User ID  

See [dbt remote MCP quickstart](https://docs.getdbt.com/docs/dbt-ai/mcp-quickstart-remote). **Never commit real tokens.**

---

## Project structure

```
models/
  staging/finance/          # Silver — sources + stg_*
    _finance__sources.yml
    stg_dim_*.sql
    stg_fact_*.sql
  marts/finance/            # Gold — dim_*, fct_*
    _finance__models.yml
    _finance__semantic.yml
```

---

## Commands

```bash
dbt deps
dbt build
dbt test
```

---

## Data domains

- **Dimensions:** date, client, project, employee, department, vendor, expense category, location  
- **Facts:** revenue, expense, payroll, project cost, vendor payment  

---

## Maintainers

GrowthArc data engineering — capstone / finance MVP initiative.
