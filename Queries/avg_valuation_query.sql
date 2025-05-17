
WITH top_industries AS
	(
	SELECT industry,
	COUNT(DISTINCT ind.company_id) AS num_unicorns
	FROM industries AS ind
	LEFT JOIN dates AS dt
	USING(company_id)
	WHERE DATE_PART('year',date_joined) BETWEEN 2019 AND 2021
	GROUP BY industry
	ORDER BY num_unicorns DESC
	LIMIT 3
	)

SELECT industry,
	DATE_PART('year',date_joined) AS year,
	COUNT(DISTINCT ind.company_id) AS num_unicorns,
	ROUND(AVG(fnd.valuation/1000000000),2) AS average_valuation_billions
FROM industries AS ind
	LEFT JOIN dates as dt
		USING(company_id)
	LEFT JOIN funding AS fnd
		USING(company_id)
WHERE (DATE_PART('year',date_joined) BETWEEN 2019 AND 2021)
	AND industry IN (SELECT industry FROM top_industries)
GROUP BY industry, year
ORDER BY year DESC, num_unicorns DESC;
