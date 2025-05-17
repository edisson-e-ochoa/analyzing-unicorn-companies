
WITH top_companies_by_country AS
	(
	SELECT country,
		company,
		ROUND(valuation/1000000000,2) AS valuation_in_billions, 
		RANK() OVER(
		PARTITION BY country
		ORDER BY valuation DESC, funding DESC
		) AS rank
	FROM companies
		LEFT JOIN funding
			USING(company_id)
	GROUP BY country, company, valuation, funding
	ORDER BY country
	)

SELECT country, company, valuation_in_billions
FROM top_companies_by_country
WHERE rank = 1
ORDER BY valuation_in_billions DESC;
