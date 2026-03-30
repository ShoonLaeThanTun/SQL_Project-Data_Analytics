SELECT
    COUNT(job_id) as job_count,
    Case 
    when job_location = 'Anywhere' THEN 'Remote'
    when job_location = 'New York, NY' THEN 'Local'
    else 'Onsite'
    END as location_category

from job_postings_fact
where job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY job_count ASC;

/* 
I want to categorize the salaries from each job posting.
 To see if it fits in my desired salary range.
• Put salary into different buckets
• Define what's a high, standard, or low salary with our own conditions
• Why? It is easy to determine which job postings are worth looking at
 based on salary.
Bucketing is a common practice in data analysis when viewing categories.
• I only want to look at data analyst roles
• Order from highest to lowest
*/

SELECT 
    count(job_id) as job_count,
    CASE 
    WHEN salary_year_avg >= 150000 THEN 'high'
    WHEN salary_year_avg < 100000 THEN 'low'
    WHEN salary_year_avg Between 100000 and 200000 THEN 'standard'
    else 'no value'
    END as salary_bucket
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    salary_bucket 
ORDER BY
    job_count DESC;