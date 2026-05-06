-- SQL queries to retrieve data from the DepED database for the 2023-2024 school year
-- Describing the tables needed for the analysis
SELECT *
FROM DepEDdb.dbo.nat_2023_24;

SELECT *
FROM DepEDdb.DBO.ENROLLMENT_2023_24;

SELECT *
FROM DepEDdb.DBO.PERSONNEL_2023_24;

-- Query to combine necessary enrollment, personnel, and NAT data for analysis
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