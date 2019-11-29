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

SELECT c.region_id, region_name, country_name, city, department_name, name
FROM countries c, regions r, locations l, departments d, employees e
WHERE c.region_id = r.region_id
AND c.country_id = l.country_id
AND l.location_id = d.location_id
AND region_name = 'Europe';

SELECT *
FROM employees;
