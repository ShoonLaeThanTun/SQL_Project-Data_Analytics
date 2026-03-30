SELECT 
    job_title_short, job_location, company_id
From jan_jobs
Union All
SELECT 
    job_title_short, job_location, company_id
From feb_jobs
UNION All
SELECT 
    job_title_short, job_location, company_id
From march_jobs

/*
Find job postings from the first quarter that have a salary greater than $70K
Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT
    job_location, job_via, job_posted_date:: date
From(SELECT 
    *
From jan_jobs
Union All
SELECT 
    *
From feb_jobs
UNION All
SELECT 
    *
From march_jobs)As quarter1_job_posting
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg > 70000
ORDER BY
    salary_hour_avg Desc