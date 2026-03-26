/*Practice Problem 1
? Question:
Write a query to find the average salary both yearly ( salary_year_avg )and 
hourly (salary_hour_avg ) for job postings that were posted after June 1, 2023.
 Group the results by job schedule type.
*/

SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS avg_yearly_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary
FROM job_postings_fact
WHERE job_posted_date::date > '2023-06-01'
GROUP BY job_schedule_type;


/*
Practice Problem 2
? Question:
Write a query to count the number of job postings for each month in 2023,
 adjusting the job_posted_date to be in 'America/New_York' time zone
  before extracting (hint) the month.
Assume the job_posted_date is stored in UTC. Group by and order by the month.
*/

SELECT
    count(job_id),
    Extract(month from job_posted_date at time zone 'UTC' at Time zone 'America/New_York') as job_month
from
    job_postings_fact
where
    extract(year from job_posted_date) = 2023
GROUP BY
    job_month
Order by 
    job_month ASC;

SELECT 
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(*) AS job_count
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY month
ORDER BY month;

/*
Practice Problem 3
? Question:
Write a query to find companies (include company name)
 that have posted jobs offering health insurance,
  where these postings were made in the second quarter of 2023.
   Use date extraction to filter by quarter.

*/ 

select
    c.name as company_name
from company_dim c
join job_postings_fact j
    on c.company_id = j.company_id
where
    j.job_health_insurance 
    and
    extract(year from j.job_posted_date)=2023
    and
    extract(quarter from j.job_posted_date)=2;

SELECT 
    c.name AS company_name
FROM job_postings_fact j
JOIN company_dim c
    ON j.company_id = c.company_id
WHERE j.job_health_insurance = TRUE
  AND EXTRACT(YEAR FROM j.job_posted_date) = 2023
  AND EXTRACT(QUARTER FROM j.job_posted_date) = 2;

