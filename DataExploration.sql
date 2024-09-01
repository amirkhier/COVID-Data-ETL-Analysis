-- SELECT data that we're going to be using
-- EXPLORATION IN coronadeaths table
SELECT location,formatted_date,total_cases,new_cases,total_deaths,population
FROM coronadeaths c
ORDER BY location ,formatted_date; 


-- Looking At Total Cases vs Total Deaths
SELECT location,formatted_date,total_cases,total_deaths,(total_deaths /total_cases )*100 AS DeathPercentage
FROM coronadeaths c
ORDER BY location ,formatted_date; 
-- Looking At The top countries have the most  DeathPercentage Rate (Max Total Cases vs Max Total Deaths) in 2024
SELECT location,MAX(formatted_date) AS UpdatedDate,MAX(total_cases) AS TotalCases,MAX(total_deaths) AS TotalDeaths,(MAX(total_deaths) /MAX(total_cases) )*100 AS DeathPercentage
FROM coronadeaths c
GROUP BY location
HAVING location NOT IN(SELECT DISTINCT(continent) FROM coronadeaths c2)
ORDER BY DeathPercentage DESC;

-- Looking At Total Cases vs Total Deaths in United States
-- Shows likelihood of dying if you contract covid in USA
SELECT location,formatted_date,total_cases,total_deaths,(total_deaths /total_cases )*100 AS DeathPercentage
FROM coronadeaths c
WHERE location ='United States'
ORDER BY DeathPercentage DESC; 

-- Looking At Total Cases vs Total Deaths in Israel
-- Shows likelihood of dying if you contract covid in Israel
SELECT location,formatted_date,total_cases,total_deaths,(total_deaths /total_cases )*100 AS DeathPercentage
FROM coronadeaths c
WHERE location LIKE '%israel%'
ORDER BY formatted_date;



-- Looking At Total Cases vs Population Around the World
-- Shows what percentage of popultation got Covid
SELECT location,formatted_date,total_cases,population ,((total_cases / population)*100)AS InfectedPopulationPercentage
FROM coronadeaths c
ORDER BY location ,formatted_date ; 

-- Looking At Total Cases vs Population In United States
SELECT location,formatted_date,total_cases,population ,((total_cases / population)*100)AS InfectedPopulationPercentage
FROM coronadeaths c
WHERE location = 'United States'
ORDER BY formatted_date ;

-- Looking At The top countries have the most population who are  infected in covid according to (Total Cases vs Population) in 2024
-- Looking At countries with highest infection Rate compared to population
SELECT location,MAX(YEAR(formatted_date)) AS CurrentYear,MAX(total_cases) AS HighestInfectionCount,population ,((MAX(total_cases) / population)*100)AS InfectedPopulationPercentage
FROM coronadeaths c
GROUP BY location
HAVING location NOT IN(SELECT DISTINCT(continent) FROM coronadeaths c2)
ORDER BY InfectedPopulationPercentage DESC;


-- Looking At Total Cases vs Population In Israel
SELECT location,formatted_date,total_cases,population ,((total_cases / population)*100)AS InfectedPopulationPercentage
FROM coronadeaths c
WHERE location LIKE '%israel%'
ORDER BY formatted_date;


-- Showing Countries With Highest Death Count per Population from 2020 to 2024
SELECT location,MAX(total_deaths) AS HighestDeathCount,population ,((MAX(total_deaths) / population)*100)AS DeathPopulationPercentage
FROM coronadeaths c
GROUP BY location
HAVING location NOT IN(SELECT DISTINCT(continent) FROM coronadeaths c2)
ORDER BY DeathPopulationPercentage DESC;


-- Showing Continent With Highest Death Count per Population from 2020 to 2024 ,Include All the world
SELECT location ,MAX(total_deaths) AS HighestDeathCount,population ,((MAX(total_deaths) / population)*100)AS DeathPopulationPercentage
FROM coronadeaths c
WHERE location IN(SELECT DISTINCT(continent) FROM coronadeaths c2)
GROUP BY location
UNION ALL 
-- Query That Calculate ALL the world population who infected
SELECT 'All' AS location , SUM(HighestDeathCount) AS SumDeathCount , SUM(population) AS worldPopulation 
,SUM(HighestDeathCount)/SUM(population) AS DeathPopulationPercentage FROM (SELECT location ,MAX(total_deaths) AS HighestDeathCount,population ,((MAX(total_deaths) / population)*100)AS DeathPopulationPercentage
FROM coronadeaths c
WHERE location IN(SELECT DISTINCT(continent) FROM coronadeaths c2)
GROUP BY location) AS TABLE2
ORDER BY DeathPopulationPercentage DESC;

-- GLOBAL
SELECT formatted_date,SUM(new_cases) AS total_cases ,SUM(new_deaths) AS total_deaths ,(SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM coronadeaths c;





-- EXPLORATION IN coronavacination table
SELECT * FROM coronavacination c ;
-- Joining between Two Tables:

SELECT * 
FROM coronavacination c JOIN coronadeaths c2 ON c.location = c2.location  AND c.formatted_date = c2.formatted_date ;

-- Looking at Total Population vs Vaccinations:
-- ALERT we need to create more 2 temporary tables ,because if we don't do that , the retrieval of data responds slowly...


CREATE TABLE table1 AS 
SELECT continent,location, formatted_date, population 
FROM coronadeaths c
WHERE location NOT IN(SELECT DISTINCT(continent) FROM coronadeaths c2)
ORDER BY location, formatted_date;

CREATE TABLE table2 AS
SELECT continent,location, formatted_date,new_vaccinations,
SUM(new_vaccinations) over(PARTITION BY location ORDER BY location,formatted_date) AS RollingPeopleVaccinated
FROM coronavacination c
WHERE location NOT IN(SELECT DISTINCT(continent) FROM coronadeaths c2)
ORDER BY location, formatted_date;

SELECT t.continent,t.location,t.formatted_date,t.population,t2.new_vaccinations,t2.RollingPeopleVaccinated
FROM table1 t JOIN table2 t2 ON t.location = t2.location AND t.formatted_date = t2.formatted_date;

-- USING CTE 

WITH PopVSVac (Continent , Location ,Date , Population , New_Vaccinations , RollingPeopleVaccinated)
AS(SELECT t.continent,t.location,t.formatted_date,t.population,t2.new_vaccinations,t2.RollingPeopleVaccinated
FROM table1 t JOIN table2 t2 ON t.location = t2.location AND t.formatted_date = t2.formatted_date)
SELECT *,(RollingPeopleVaccinated/Population)*100 FROM PopVSVac;




-- Creating Views to store data for later visualisations

CREATE VIEW PercentPopulationVaccinated AS(SELECT t.continent,t.location,t.formatted_date,t.population,t2.new_vaccinations,t2.RollingPeopleVaccinated
FROM table1 t JOIN table2 t2 ON t.location = t2.location AND t.formatted_date = t2.formatted_date);

SELECT * FROM percentpopulationvaccinated p ;
