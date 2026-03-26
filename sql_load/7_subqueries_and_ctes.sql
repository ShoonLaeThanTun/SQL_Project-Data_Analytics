-- subqueries
SELECT *
FROM(
    SELECT *
    FROM job_postings_fact
    WHERE Extract(Month from job_posted_date) = 1    
) as jan_jobs ;


-- CTE def with 
WITH january_jobs AS(-- CTE starts here
    SELECT *
    FROM job_postings_fact
    WHERE Extract(Month from job_posted_date) = 1 
)-- CTE ends here 

SELECT * FROM january_jobs;

-- Using In 

SELECT name as company_name
FROM company_dim 
WHERE company_id in(
    SELECT company_id
    from job_postings_fact
    where job_no_degree_mention = true);



--Exercise
WITH company_job_count AS(
    SELECT company_id, count(*) as total_jobs
    from job_postings_fact
    GROUP BY company_id
)

select cd.name as company_name,
        cjc.total_jobs
from company_dim cd 
left join company_job_count cjc 
    on cd.company_id = cjc.company_id
ORDER BY total_jobs Desc;

/*
Identify the top 10 skills that are most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the highest counts in 
the skills_job_dim table and then join this result with 
the skills_dim table to get the skill
*/

WITH skill_id_count AS
(
    select skill_id, count(*) as skill_count
    from skills_job_dim 
    GROUP BY skill_id
)
SELECT sd.skills,
        sic.skill_count
FROM skills_dim sd
left join skill_id_count sic
    on sd.skill_id = sic.skill_id
ORDER BY skill_count Desc
LIMIT 10;

/* Determine the size category ('Small', 'Medium', or 'Large') 
for each company by first identifying the number of job postings they have.
 Use a subquery to calculate the total job postings per company.
  A company is considered 'Small' if it has less than 10 job postings, 
  'Medium' if the number of job postings is between 10 and 50, 
  and 'Large' if it has more than 50 job postings.
Implement a subquery to aggregate job counts per company 
before classifying them based on size.
*/

With company_size_category as
(SELECT company_id,
    CASE
    WHEN count(*) <= 10 Then 'Small'
    WHEN count(*) >= 50 Then 'Large'
    WHEN count(*) Between 10 and 50 Then 'Median'
    End as size_category
From job_postings_fact
GROUP BY  company_id
)


select cd.name, 
        csc.size_category as company_size
from
    company_dim cd 
left join company_size_category csc
    on cd.company_id = csc.company_id


/* Find the count of the number of remote job postings per skill
- Display the top 10 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skill
*/

WITH remote_job_skill_count as (
        SELECT
            skill_id,
            count(*) as skill_count
        From 
            skills_job_dim as sjd
        Inner join
            job_postings_fact as jpf
            on sjd.job_id = jpf.job_id
        WHERE 
            
            jpf.job_title_short = 'Data Analyst' And
            jpf.job_work_from_home = true
        Group BY
            skill_id
)

select 
        sd.skills as skill_name,
        rjsc.skill_count
from 
        skills_dim as sd
inner join remote_job_skill_count as rjsc
        on sd.skill_id = rjsc.skill_id
Order by 
        skill_count DESC
LIMIT 10;

