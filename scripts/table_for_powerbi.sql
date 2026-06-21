-- Table to be used for Power BI
/* Disclaimer: This is the same table in second Jupyter Notebook. Recreated in SQL for better workflow */


-- Creating the table for the data from Python
CREATE TABLE dbo.master_school_data_2023_24 (
    school_id INT PRIMARY KEY,
    school_name NVARCHAR(255),
    region NVARCHAR(100),
    division NVARCHAR(100),

    kinder_male INT,
    kinder_female INT,

    g1_male INT,
    g1_female INT,
    g2_male INT,
    g2_female INT,
    g3_male INT,
    g3_female INT,
    g4_male INT,
    g4_female INT,
    g5_male INT,
    g5_female INT,
    g6_male INT,
    g6_female INT,
    g7_male INT,
    g7_female INT,
    g8_male INT,
    g8_female INT,
    g9_male INT,
    g9_female INT,
    g10_male INT,
    g10_female INT,

    es_master_teacher_iv INT,
    es_master_teacher_iii INT,
    es_master_teacher_ii INT,
    es_master_teacher_i INT,

    es_teacher_iii INT,
    es_teacher_ii INT,
    es_teacher_i INT,

    n_test_takers INT,

    filipino_mps FLOAT,
    english_mps FLOAT,
    math_mps FLOAT,
    science_mps FLOAT,
    araling_panlipunan_mps FLOAT,
    overall_mps FLOAT
);

-- Overview of the table
SELECT * FROM dbo.master_school_data_2023_24;

-- Creating a 'country' column for Power BI
ALTER TABLE dbo.master_school_data_2023_24
ADD country NVARCHAR(100);

-- Setting 'country' column to 'Philippines'
UPDATE dbo.master_school_data_2023_24
SET country = 'Philippines';

-- Setting NULL to 0
UPDATE dbo.master_school_data_2023_24
SET teacher_student_ratio = 0
WHERE teacher_student_ratio IS NULL;

-- Replacing CAR with Cordillera Administrative Region
UPDATE dbo.master_school_data_2023_24
SET region = 'Cordillera Administrative Region'
WHERE region = 'CAR';

UPDATE dbo.ellna_2023_24
SET region = 'Cordillera Administrative Region'
WHERE region = 'CAR';

UPDATE dbo.enrollment_2023_24
SET region = 'Cordillera Administrative Region'
WHERE region = 'CAR';

UPDATE dbo.learners_2023_24
SET region = 'Cordillera Administrative Region'
WHERE region = 'CAR';

UPDATE dbo.nat_2023_24
SET region = 'Cordillera Administrative Region'
WHERE region = 'CAR';

-- Replacing 'division' with 'province'
EXEC sp_rename
    'dbo.master_school_data_2023_24.division',
    'province',
    'COLUMN'