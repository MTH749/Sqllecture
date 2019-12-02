--槛力1
SELECT c.region_id, region_name, country_name
FROM countries c, regions r
WHERE c.region_id = r.region_id
AND region_name = 'Europe';

--槛力 2

SELECT c.region_id, region_name, country_name, city
FROM countries c, regions r, locations l
WHERE c.region_id = r.region_id
AND c.country_id = l.country_id
AND region_name = 'Europe';

--槛力 3

SELECT c.region_id, region_name, country_name, city, department_name
FROM countries c, regions r, locations l, departments d
WHERE c.region_id = r.region_id
AND c.country_id = l.country_id
AND l.location_id = d.location_id
AND region_name = 'Europe';



--槛力4

SELECT c.region_id, region_name, country_name, city, department_name, concat(first_name,last_name) name
FROM countries c, regions r, locations l, departments d, employees e
WHERE c.region_id = r.region_id
AND c.country_id = l.country_id
AND l.location_id = d.location_id
AND d.department_id = e.department_id
AND region_name = 'Europe';

--槛力 5

SELECT employee_id,concat(first_name,last_name) name , e.job_id, job_title
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id;

--槛力 6

SELECT m.manager_id MNG_ID, concat(e.first_name,e.last_name) MGR_NAME, m.employee_id ,concat(m.first_name,m.last_name) NAME, e.job_id, job_title
FROM employees e, jobs j , employees m
WHERE m.job_id = j.job_id
AND m.manager_id =  e.employee_id
ORDER BY  m.manager_id;







select *
FROM employees;
