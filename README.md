# Philippine Teacher-Student Ratio and Academic Performance Analysis

## Overview
A clear observation we have today is that students graduate elementary school but could hardly read, write, and do basic arithmetic. This project would try to answer if the ratio of teachers to students and the presence of master teachers to guide the pedagogy affects the Grade 6 NAT scores as a measurable indicator of foundational learning outcomes across Philippine public schools.

## Central Questions
- Does teacher count correlate with Grade 6 NAT performance across schools?
- Does Master Teacher presence correlate with higher NAT scores?

## Dataset
- Source: Department of Education (DepEd) Official Open Data
- Coverage: SY 2023-24
- Scope: 5 regions — Region I, III, VIII, IX, and CAR
- NAT scores reflect Grade 6 performance only

## Limitations
- NAT data limited to SY 2023-24 — no longitudinal analysis possible
- Teacher position data contains significant null values — treated as zero
- Teacher assignments by grade level not specified in source data
- Dataset covers 5 regions only — findings not generalizable nationwide

## Tools Used
- SQL Server — data storage and querying
- Python — data cleaning, feature engineering, statistical analysis
- Power BI — dashboard and visualization
- GitHub — version control

## Repository Structure

```
PH-Teacher-Student-Ratio-Academic-Performance-Analysis/
├── data/
│   ├── raw/
│   ├── processed/
│   └── outputs/
├── notebooks/
├── dashboards/
├── scripts/
├── findings/
├── .gitattributes
├── .gitignore
└── README.md
```

## Setup
1. Run scripts/create_database.py to load data into SQL Server
2. Open notebooks/analysis.ipynb to run the analysis

## Current Status
✅ Data Cleaning
✅ Exploratory Analysis
✅ SQL Data Extraction & Transformation
🟡 Dashboard (In Progress)
⬜ Final Insights Page