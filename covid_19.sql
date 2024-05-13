SELECT *
FROM covid_19;

-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
SELECT *
FROM covid_19
WHERE "Province" IS NULL OR "Country/Region" IS NULL OR "Latitude" IS NULL OR "Longitude" IS NULL OR "Date" IS NULL OR "Confirmed" IS NULL OR "Deaths" IS NULL OR "Recovered" IS NULL;

--Q2. If NULL values are present, update them with zeros for all columns.
UPDATE covid_19
SET "Province" = COALESCE("Province", ''),
    "Country/Region" = COALESCE("Country/Region", ''),
    "Latitude" = COALESCE("Latitude", 0.0),
    "Longitude" = COALESCE("Longitude", 0.0),
    "Date" = COALESCE("Date", CURRENT_DATE), -- Replace '' with CURRENT_DATE or NULL
    "Confirmed" = COALESCE("Confirmed", 0),
    "Deaths" = COALESCE("Deaths", 0),
    "Recovered" = COALESCE("Recovered", 0);

-- Q3. check total number of rows
SELECT COUNT(*) AS total_number
FROM covid_19;

-- Q4. Check what is start_date and end_date
SELECT MIN("Date") AS start_date, MAX("Date") AS end_date
FROM covid_19;

-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT(EXTRACT(MONTH From "Date"))) AS Number_month
FROM covid_19;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT EXTRACT(YEAR FROM "Date") AS year, EXTRACT(MONTH FROM "Date") AS month, AVG("Confirmed") AS Avg_Confirmed, AVG("Deaths") AS Avg_Deaths, AVG("Recovered") AS Avg_Recovered
FROM covid_19
GROUP BY EXTRACT(YEAR FROM "Date"), EXTRACT(MONTH FROM "Date")
ORDER BY EXTRACT(YEAR FROM "Date"), EXTRACT(MONTH FROM "Date");

SELECT EXTRACT(MONTH FROM "Date") AS month, AVG("Confirmed") AS Avg_Confirmed, AVG("Deaths") AS Avg_Deaths, AVG("Recovered") AS Avg_Recovered
FROM covid_19
GROUP BY EXTRACT(MONTH FROM "Date")
ORDER BY EXTRACT(MONTH FROM "Date");

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
SELECT 
    EXTRACT(MONTH FROM "Date") AS month,
    mode() WITHIN GROUP (ORDER BY "Confirmed") AS most_frequent_confirmed,
    mode() WITHIN GROUP (ORDER BY "Deaths") AS most_frequent_deaths,
    mode() WITHIN GROUP (ORDER BY "Recovered") AS most_frequent_recovered
FROM 
    covid_19
GROUP BY 
    EXTRACT(MONTH FROM "Date");

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT EXTRACT(YEAR FROM "Date") AS year, MIN("Confirmed") AS min_confirmed, MIN("Deaths") AS min_deaths, MIN("Recovered") AS min_recovered
FROM covid_19
GROUP BY EXTRACT(YEAR FROM "Date");

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT EXTRACT(YEAR FROM "Date") AS year, MAX("Confirmed") AS max_confirmed, MAX("Deaths") AS max_deaths, MAX("Recovered") AS max_recovered
FROM covid_19
GROUP BY EXTRACT(YEAR FROM "Date");

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT EXTRACT(MONTH FROM "Date") AS month, SUM("Confirmed") AS total_confirmed, SUM("Deaths") AS total_deaths, SUM("Recovered") AS total_recovered
FROM covid_19
GROUP BY EXTRACT(MONTH FROM "Date")
ORDER BY EXTRACT(MONTH FROM "Date");

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM("Confirmed") AS total_confirmed, AVG("Confirmed") AS avg_confirmed, 
	VARIANCE("Confirmed") AS var_confirmed, SQRT(VARIANCE("Confirmed")) AS stddev_confirmed
FROM covid_19;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM("Deaths") AS total_deaths, AVG("Deaths") AS avg_deaths, VARIANCE("Deaths") AS var_deaths,
	SQRT(VARIANCE("Deaths")) AS stddev_deaths
FROM covid_19;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM("Recovered") AS total_recovered, AVG("Recovered") AS avg_recovered,
	VARIANCE("Recovered") AS var_recovered, SQRT(VARIANCE("Recovered")) AS stddev_recovered
FROM covid_19;

-- Q14. Find Country having highest number of the Confirmed case
SELECT "Country/Region" AS country, SUM("Confirmed") AS total_confirmed
FROM covid_19
GROUP BY "Country/Region"
ORDER BY total_confirmed DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT "Country/Region" AS country, SUM("Deaths") AS total_deaths
FROM covid_19
GROUP BY "Country/Region"
ORDER BY total_deaths ASC
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT "Country/Region" AS country, SUM("Recovered") as total_recovered
FROM covid_19
GROUP BY "Country/Region"
ORDER BY total_recovered DESC
LIMIT 5;
