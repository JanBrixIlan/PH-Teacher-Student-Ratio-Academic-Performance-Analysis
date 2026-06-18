-- SQL queries to retrieve data from the DepED database for the 2023-2024 school year
-- Describing the tables needed for the analysis
SELECT *
FROM DepEDdb.dbo.nat_2023_24;

SELECT *
FROM DepEDdb.DBO.ENROLLMENT_2023_24;

SELECT *
FROM DepEDdb.DBO.PERSONNEL_2023_24;

-- Query to combine necessary enrollment, personnel, and NAT data for analysis
-- To be extracted as a spreadsheet "master_school_data_2023_24"
SELECT
    -- School information
    e.school_id,
    e.school_name,
    e.region,
    e.division,
    -- Elementary enrollment by gender
    e.kinder_male,
    e.kinder_female,
    e.g1_male, e.g1_female,
    e.g2_male, e.g2_female,
    e.g3_male, e.g3_female,
    e.g4_male, e.g4_female,
    e.g5_male, e.g5_female,
    e.g6_male, e.g6_female,
    -- JHS enrollment by gender
    e.g7_male, e.g7_female,
    e.g8_male, e.g8_female,
    e.g9_male, e.g9_female,
    e.g10_male, e.g10_female,
    -- Teacher positions
    p.es_master_teacher_iv,
    p.es_master_teacher_iii,
    p.es_master_teacher_ii,
    p.es_master_teacher_i,
    p.es_teacher_iii,
    p.es_teacher_ii,
    p.es_teacher_i,
    -- NAT results
    n.n_test_takers,
    n.filipino_mps,
    n.english_mps,
    n.math_mps,
    n.science_mps,
    n.araling_panlipunan_mps,
    n.overall_mps
FROM depeddb.dbo.enrollment_2023_24 AS e
JOIN depeddb.dbo.personnel_2023_24 AS p
    ON e.school_id = p.school_id
JOIN depeddb.dbo.nat_2023_24 AS n
    ON e.school_id = n.school_id;


-- Aggregations by region
SELECT
    e.region,
    -- Total enrollment
    SUM(e.kinder_male + e.kinder_female) as total_kinder,
    SUM(e.g1_male + e.g1_female) as total_g1,
    
    -- Total teachers
    SUM(
        ISNULL(p.es_teacher_i, 0) + 
        ISNULL(p.es_teacher_ii, 0) + 
        ISNULL(p.es_teacher_iii, 0) +
        ISNULL(p.es_master_teacher_i, 0) + 
        ISNULL(p.es_master_teacher_ii, 0) + 
        ISNULL(p.es_master_teacher_iii, 0) + 
        ISNULL(p.es_master_teacher_iv, 0)
    ) as total_teachers,
    
    -- Average NAT results
    ROUND(AVG(n.math_mps), 2) as avg_math_mps,
    ROUND(AVG(n.overall_mps), 2) as avg_overall_mps
FROM depeddb.dbo.enrollment_2023_24 AS e
JOIN depeddb.dbo.personnel_2023_24 AS p
    ON e.school_id = p.school_id
JOIN depeddb.dbo.nat_2023_24 AS n
    ON e.school_id = n.school_id
GROUP BY e.region
ORDER BY avg_math_mps DESC;


--DEMONSTRATIONS
-- Average NAT scores by region
SELECT
    e.region,
    COUNT(DISTINCT e.school_id) AS total_schools,
    ROUND(AVG(n.overall_mps), 2) AS avg_overall_mps,
    ROUND(AVG(n.math_mps), 2) AS avg_math_mps
FROM depeddb.dbo.enrollment_2023_24 AS e
JOIN depeddb.dbo.nat_2023_24 AS n
    ON e.school_id = n.school_id
GROUP BY e.region
ORDER BY avg_overall_mps DESC;

-- Master Teacher status
SELECT
    e.school_id,
    e.school_name,
    CASE 
        WHEN p.es_master_teacher_i + p.es_master_teacher_ii + 
             p.es_master_teacher_iii + p.es_master_teacher_iv > 0 
        THEN 'Has Master Teacher'
        ELSE 'No Master Teacher'
    END AS master_teacher_status,
    n.overall_mps
FROM depeddb.dbo.enrollment_2023_24 AS e
JOIN depeddb.dbo.personnel_2023_24 AS p ON e.school_id = p.school_id
JOIN depeddb.dbo.nat_2023_24 AS n ON e.school_id = n.school_id;

-- Rank schools by performance within their region
SELECT
    e.region,
    e.school_name,
    n.overall_mps,
    RANK() OVER (PARTITION BY e.region ORDER BY n.overall_mps DESC) AS regional_rank
FROM depeddb.dbo.enrollment_2023_24 AS e
JOIN depeddb.dbo.nat_2023_24 AS n ON e.school_id = n.school_id;

-- Average NAT Scores by region using CTEs
WITH regional_avg AS (
    SELECT n.region, ROUND(AVG(overall_mps), 2) AS avg_mps
    FROM depeddb.dbo.nat_2023_24 n
    JOIN depeddb.dbo.enrollment_2023_24 e ON n.school_id = e.school_id
    GROUP BY n.region
)
SELECT * FROM regional_avg ORDER BY avg_mps DESC;