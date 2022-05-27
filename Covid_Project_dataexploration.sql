--Just checking tables to portray correct information
SELECT *
FROM Covid_deaths_csv
ORDER BY 3,4

SELECT *
FROM Covid_Vaccinations_csv cvc 
ORDER BY 3, 4

--Select data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM Covid_deaths_csv cdc 
ORDER BY 1, 2

-- Looking at total cases vs total deaths
-- Shows likelihood of fying if you contract covid in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM Covid_deaths_csv 
WHERE location like '%states%'
Order By 5 

--Looking at total cases vs total population

SELECT location, date, total_cases, population, (total_cases/population)*100 AS percentpopulation
FROM Covid_deaths_csv cdc 
Order By 1, 2

SELECT location, population, MAX(total_cases) as Highestinfectioncount, Max((total_cases/population))*100 as percentpopulationinfected
FROM Covid_deaths_csv cdc 
-- Where location like '%states%' to hone in united states
GROUP BY location, population 
Order By percentpopulationinfected desc

-- Showing countries with highest death count per population

SELECT location, MAX(cast(total_deaths as int)) as totaldeathcount
FROM Covid_deaths_csv cdc 
-- Where location like '%states%' to hone in united states
Where continent is not null
GROUP BY location 
Order By totaldeathcount desc

-- Breaking data down by continent

SELECT location  , MAX(cast(total_deaths as int)) as totaldeathcount
FROM Covid_deaths_csv cdc 
-- Where location like '%states%' to hone in united states
WHERE continent is not NULL 
GROUP BY location 
Order By totaldeathcount desc

-- Showing continents with highest death count per population

SELECT continent, MAX(cast(total_deaths as int)) as totaldeathcount
FROM Covid_deaths_csv cdc 
-- Where location like '%states%' to hone in united states
Where continent is not null
GROUP BY continent  
Order By totaldeathcount desc

-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int)) / SUM(New_cases)*100 as Deathpercentage
FROM Covid_deaths_csv cdc 
--WHERE location like '%states%'
WHERE continent is not null
--GROUP BY date
ORDER BY 2


-- Looking at total population vs vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingpeopleVaccinated/population)*100
FROM Covid_deaths_csv as dea
Join Covid_Vaccinations_csv as vac
	ON dea.location = vac.location
	AND dea.date = vac.date
ORDER BY 2, 3

--USE CTE

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingpeopleVaccinated/population)*100
FROM Covid_deaths_csv as dea
Join Covid_Vaccinations_csv as vac
	ON dea.location = vac.location
	AND dea.date = vac.date
--ORDER BY 2, 3
)

-- Temp TABLE 

DROP Table if exists PercentPopulationVaccinated
Create Table PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingpeopleVaccinated/population)*100
FROM Covid_deaths_csv as dea
Join Covid_Vaccinations_csv as vac
	ON dea.location = vac.location
	AND dea.date = vac.date
--Where dea.continent is not null
--ORDER BY 2, 3

