--1
CREATE TABLE countries
(
    country_id INT,
    country_name VARCHAR[40],
    region_id INT
);

--2
DROP TABLE countries;
CREATE TABLE countries ();

--3
select * Into dup_countries From countries Where 1 = 2;

--4
drop table dup_countries;
select * into dup_countries from countries;

--5
CREATE TABLE IF NOT EXISTS countries
(
    country_id INT,
    country_name VARCHAR[40],
    region_id INT
);

--6
CREATE TABLE jobs
(
    job_id INT,
    job_title varchar(35),
    min_salary decimal(6,0),
    max_salary decimal(6,0) CHECK (max_salary <= 25000)
);

--7
drop table countries;
CREATE TABLE countries
(
    country_id INT,
    country_name TEXT CHECK (country_name IN ('Italy', 'India', 'China')),
    region_id INT
);

--8
drop table countries;
CREATE TABLE countries
(
    country_id INT UNIQUE,
    country_name VARCHAR[40],
    region_id INT
);

--9
drop table jobs;
CREATE TABLE jobs
(
    job_id INT PRIMARY KEY NOT NULL,
    job_title varchar(35) NOT NULL DEFAULT ' ',
    min_salary decimal(6,0) DEFAULT 8000,
    max_salary decimal(6,0) DEFAULT NULL
);

--10
drop table countries;
CREATE TABLE countries
(
    country_id INT UNIQUE PRIMARY KEY,
    country_name VARCHAR[40],
    region_id INT
);

--11
drop table countries;
CREATE TABLE countries
(
    country_id INT PRIMARY KEY,
    country_name VARCHAR[40],
    region_id INT
);

--12
drop table countries;
CREATE TABLE countries
(
    country_id INT,
    country_name VARCHAR[40],
    region_id INT,
    UNIQUE (country_id, region_id)
);

--13
CREATE TABLE job_history
(
    employee_id INT UNIQUE,
    start_date date,
    end_date date,
    job_id INT PRIMARY KEY,
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

--14
CREATE TABLE departments
(
    department_id numeric(4, 0) UNIQUE,
    department_name VARCHAR[30] NOT NULL,
    manager_id numeric(6, 0) NOT NULL DEFAULT NULL::numeric,
    location_id numeric(4, 0) DEFAULT NULL::numeric,
    PRIMARY KEY (department_id, manager_id)
);
CREATE TABLE employees
(
    employee_id numeric(6, 0) UNIQUE,
    first_name VARCHAR[40] NOT NULL,
    last_name VARCHAR[50] NOT NULL,
    email VARCHAR[50],
    phone_number VARCHAR[20] NOT NULL,
    hire_date date NOT NULL,
    job_id numeric(6, 0) NOT NULL,
    salary numeric(6, 2) NOT NULL,
    commission numeric(6, 2) NOT NULL,
    manager_id numeric(6, 0) NOT NULL DEFAULT NULL::numeric,
    department_id numeric(4, 0) NOT NULL,
FOREIGN KEY (department_id, manager_id) REFERENCES departments (department_id, manager_id)
);

--15
drop table employees;
CREATE TABLE employees
(
    employee_id numeric(6, 0) UNIQUE,
    first_name VARCHAR[40] NOT NULL,
    last_name VARCHAR[50] NOT NULL,
    email VARCHAR[50] NOT NULL,
    phone_number VARCHAR[20] NOT NULL,
    hire_date date NOT NULL,
    job_id INT NOT NULL,
    salary numeric(6, 2) NOT NULL,
    commission numeric(6, 2) NOT NULL,
    manager_id numeric(6, 0) NOT NULL,
    department_id numeric(4, 0) NOT NULL,
FOREIGN KEY (department_id) REFERENCES  departments (department_id),
FOREIGN KEY(job_id) REFERENCES jobs (job_id)
);

--16
drop table employees;
CREATE TABLE employees
(
    employee_id numeric(6, 0) UNIQUE,
    first_name  VARCHAR[40]   NOT NULL,
    last_name   VARCHAR[50]   NOT NULL,
    job_id      INT           NOT NULL,
    salary      numeric(6, 2) NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

--17
drop table employees;
CREATE TABLE employees
(
    employee_id numeric(6, 0) UNIQUE,
    first_name  VARCHAR[40]   NOT NULL,
    last_name   VARCHAR[50]   NOT NULL,
    job_id      INT           NOT NULL,
    salary      numeric(6, 2) NOT NULL,
FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON DELETE CASCADE ON UPDATE RESTRICT
);

--18
drop table employees;
CREATE TABLE employees
(
    employee_id numeric(6, 0) UNIQUE,
    first_name  VARCHAR[40]   NOT NULL,
    last_name   VARCHAR[50]   NOT NULL,
    job_id      INT           NOT NULL,
    salary      numeric(6, 2) NOT NULL,
FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON DELETE SET NULL ON UPDATE SET NULL
);

--19
drop table employees;
CREATE TABLE employees
(
    employee_id numeric(6, 0) UNIQUE,
    first_name  VARCHAR[40]   NOT NULL,
    last_name   VARCHAR[50]   NOT NULL,
    job_id      INT           NOT NULL,
    salary      numeric(6, 2) NOT NULL,
FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--20
ALTER TABLE countries RENAME TO country_new;

--21
CREATE TABLE locations
(
    location_id    numeric(4, 0) NOT NULL,
    street_address VARCHAR[40]   NOT NULL,
    postal_code    VARCHAR[12]   NOT NULL,
    city           VARCHAR[30]   NOT NULL,
    state_province VARCHAR[25]   NOT NULL,
    country_id     VARCHAR[2]    NOT NULL
);
ALTER TABLE locations ADD region_id INT;

--22
ALTER TABLE locations ALTER region_id TYPE text;

--23
ALTER TABLE locations DROP city;

--24
ALTER TABLE locations RENAME state_province TO state;

--25
ALTER TABLE locations ADD PRIMARY KEY(location_id);

--26
ALTER TABLE locations DROP CONSTRAINT locations_pkey;
ALTER TABLE locations ADD PRIMARY KEY(location_id,region_id);

--27
ALTER TABLE locations DROP CONSTRAINT locations_pkey;

--28
ALTER TABLE job_history ADD CONSTRAINT fk_jobs_id
FOREIGN KEY (job_id) REFERENCES jobs(job_id);

--29
ALTER TABLE job_history DROP CONSTRAINT fk_jobs_id;
ALTER TABLE job_history ADD CONSTRAINT fk_jobs_id
FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON UPDATE RESTRICT ON DELETE CASCADE;

--30
ALTER TABLE job_history DROP CONSTRAINT fk_jobs_id;

--31
CREATE UNIQUE INDEX CONCURRENTLY index_job_id ON job_history(job_id);

--32
DROP INDEX index_job_id;

--33
ALTER TABLE employees ADD COLUMN email VARCHAR[50];
UPDATE employees SET email[50] = 'not available';

--34
ALTER TABLE employees ADD COLUMN commission_pct numeric(6, 2);
ALTER TABLE employees ADD COLUMN department_id numeric(4, 0);
UPDATE employees SET email[50] = 'not available',commission_pct = 0.10;

--35
UPDATE employees SET email[50] = 'not available', commission_pct = 0.10 WHERE department_id = 110;

--36
UPDATE employees SET email[50] = 'not available' WHERE department_id = 80 AND commission_pct<.20;

--37
UPDATE employees SET email[50] = 'not available' WHERE department_id=(SELECT department_id FROM departments WHERE department_name[40]='Accounting');

--38
UPDATE employees SET salary = 8000 WHERE employee_id = 105 AND salary < 5000;

--39
UPDATE employees SET job_id = 'SH_CLERK' WHERE employee_id = 118 AND department_id = 30 AND NOT job_id LIKE 'SH%';

--40
UPDATE employees
SET salary = CASE
    WHEN department_id = 40 THEN salary*0.25
    WHEN department_id = 90 THEN salary*0.15
    WHEN department_id = 110 THEN salary*0.10
    ELSE salary END;
