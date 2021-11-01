SET search_path TO data, public;

SELECT 
	CONCAT_WS(
		' ',
		e.first_name, 
		e.last_name,
		CONCAT('(', e.job_position, ')')
		) AS full_name,
	CONCAT_WS(
		' ',
		co.company,
		CONCAT('(', co.iČo, ')')
		) AS company_ico,
	ad.office_type,
	CONCAT_WS(
		' ',
		ad.street,
		CONCAT(TRIM(TRAILING(ad.descriptive_number)), '/', TRIM(TRAILING(ad.orientation_number)), ','),
		ZIP_code,
		UPPER(city)
		) AS adress
FROM employees e
JOIN adresses ad
ON e.office_id = ad.office_id
JOIN companies co
ON ad.company = co.company