
SELECT company,
	DATE_PART('year',date_joined) - year_founded AS years_to_unicorn,
	ROUND(funding/1000000,2) as funding_in_millions
FROM companies
	LEFT JOIN dates AS dt
		USING(company_id)
	LEFT JOIN funding AS fnd
		USING(company_id)
	LEFT JOIN industries AS ind
		USING(company_id)
WHERE DATE_PART('year',date_joined) - year_founded >= 10
	AND industry = 'Data management & analytics'
ORDER BY funding_in_millions DESC
LIMIT 10;
