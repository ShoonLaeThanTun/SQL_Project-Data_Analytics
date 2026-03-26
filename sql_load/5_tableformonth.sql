CREATE TABLE jan_jobs as
    SELECT * FROM
        job_postings_fact
    WHERE
        EXTRACT(month from job_posted_date) = 1;

CREATE TABLE feb_jobs as
    SELECT * FROM
        job_postings_fact
    WHERE
        EXTRACT(month from job_posted_date) = 2;

CREATE TABLE march_jobs as
    SELECT * FROM
        job_postings_fact
    WHERE
        EXTRACT(month from job_posted_date) = 3;
        