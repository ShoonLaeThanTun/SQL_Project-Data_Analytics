/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs 
demand certain skills, helping job seekers understand 
which skills to develop that align with top salaries
*/

with top_paying_jobs as (SELECT
    job_id, 
    job_title,
    salary_year_avg,
    name as company_name
FROM job_postings_fact
LEFT JOIN company_dim
    on job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10)

Select
    top_paying_jobs.*,
    skills as skill_name
From top_paying_jobs
inner join skills_job_dim
    on skills_job_dim.job_id = top_paying_jobs.job_id
inner join skills_dim
    on skills_dim.skill_id = skills_job_dim.skill_id
order by salary_year_avg desc;


