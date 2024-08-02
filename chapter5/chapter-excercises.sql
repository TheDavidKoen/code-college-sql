SELECT 3.14159265*(5^2);

/* American Indian and Alaska Native alone - Data dictionary reference "P0010005" */

SELECT geo_name AS "county", state_us_abbreviation AS "state",
	ROUND((CAST (p0010005 AS numeric(8,1)) / p0010001) * 100,2) AS "pct_native" 
FROM us_counties_2010
WHERE state_us_abbreviation ILIKE '%NY%'
ORDER BY "pct_native" DESC
;

-- answer:  "Franklin County", which has 7.36% of its population identified as
-- 			American Indian / Alaska Native alone (p0010005).
--	The Bronx had a larger number of p0010005, but was only 1.32% 

SELECT state_us_abbreviation AS "State", percentile_cont(.5)
	WITHIN GROUP ( ORDER BY p0010001) AS "County Median"
FROM us_counties_2010
GROUP BY state_us_abbreviation
HAVING state_us_abbreviation = 'NY' OR state_us_abbreviation = 'CA' 
;