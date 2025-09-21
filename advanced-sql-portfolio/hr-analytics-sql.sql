-- HR Analytics SQL Portfolio
-- Advanced SQL queries for HR data analysis
-- By Sandeep Karmacharya

-- 1. Employee Demographics Analysis
SELECT 
    department,
    COUNT(*) as employee_count,
    AVG(age) as avg_age,
    ROUND(AVG(salary), 2) as avg_salary,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) * 100.0 / COUNT(*) as female_percentage
FROM employees 
GROUP BY department
ORDER BY employee_count DESC;

-- 2. Retention Analysis with Window Functions
WITH employee_tenure AS (
    SELECT 
        employee_id,
        name,
        department,
        hire_date,
        CASE WHEN termination_date IS NULL THEN CURRENT_DATE ELSE termination_date END as end_date,
        DATEDIFF(CASE WHEN termination_date IS NULL THEN CURRENT_DATE ELSE termination_date END, hire_date) / 365.25 as tenure_years
    FROM employees
),
retention_stats AS (
    SELECT 
        department,
        AVG(tenure_years) as avg_tenure,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY tenure_years) as median_tenure,
        COUNT(CASE WHEN tenure_years < 1 THEN 1 END) * 100.0 / COUNT(*) as turnover_rate_1yr
    FROM employee_tenure
    GROUP BY department
)
SELECT * FROM retention_stats
ORDER BY avg_tenure DESC;

-- 3. Performance and Compensation Analysis
SELECT 
    p.employee_id,
    e.name,
    e.department,
    e.job_title,
    p.performance_rating,
    e.salary,
    LAG(p.performance_rating) OVER (PARTITION BY p.employee_id ORDER BY p.review_year) as prev_rating,
    CASE 
        WHEN LAG(p.performance_rating) OVER (PARTITION BY p.employee_id ORDER BY p.review_year) < p.performance_rating 
        THEN 'Improved'
        WHEN LAG(p.performance_rating) OVER (PARTITION BY p.employee_id ORDER BY p.review_year) > p.performance_rating 
        THEN 'Declined'
        ELSE 'Stable'
    END as performance_trend
FROM performance_reviews p
JOIN employees e ON p.employee_id = e.employee_id
WHERE p.review_year = 2024;

-- 4. Diversity and Inclusion Metrics
WITH diversity_metrics AS (
    SELECT 
        department,
        job_level,
        COUNT(*) as total_employees,
        COUNT(CASE WHEN gender = 'Female' THEN 1 END) as female_count,
        COUNT(CASE WHEN ethnicity != 'White' THEN 1 END) as minority_count
    FROM employees
    WHERE status = 'Active'
    GROUP BY department, job_level
)
SELECT 
    department,
    job_level,
    total_employees,
    ROUND(female_count * 100.0 / total_employees, 2) as female_percentage,
    ROUND(minority_count * 100.0 / total_employees, 2) as minority_percentage
FROM diversity_metrics
ORDER BY department, job_level;

-- 5. Training ROI Analysis
SELECT 
    t.training_program,
    COUNT(DISTINCT t.employee_id) as participants,
    AVG(t.training_cost) as avg_cost_per_employee,
    AVG(pr_before.performance_rating) as avg_performance_before,
    AVG(pr_after.performance_rating) as avg_performance_after,
    AVG(pr_after.performance_rating) - AVG(pr_before.performance_rating) as performance_improvement,
    SUM(t.training_cost) / (AVG(pr_after.performance_rating) - AVG(pr_before.performance_rating)) as cost_per_improvement_point
FROM training t
LEFT JOIN performance_reviews pr_before ON t.employee_id = pr_before.employee_id 
    AND pr_before.review_year = YEAR(t.training_date) - 1
LEFT JOIN performance_reviews pr_after ON t.employee_id = pr_after.employee_id 
    AND pr_after.review_year = YEAR(t.training_date)
GROUP BY t.training_program
HAVING COUNT(DISTINCT t.employee_id) >= 10
ORDER BY performance_improvement DESC;
