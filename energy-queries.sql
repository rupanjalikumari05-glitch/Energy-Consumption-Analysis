CREATE DATABASE energy_analytics;
USE energy_analytics;

CREATE TABLE energy_consumption (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME,
    department VARCHAR(50),
    electricity_kWh FLOAT,
    water_liters FLOAT,
    electricity_cost FLOAT,
    water_cost FLOAT,
    total_cost FLOAT
);

SELECT * FROM energy_consumption LIMIT 10;
SELECT COUNT(*) FROM energy_consumption;

SELECT department,
       SUM(electricity_kWh) AS total_electricity_kWh,
       SUM(water_liters) AS total_water_liters,
       SUM(total_cost) AS total_cost
FROM energy_consumption
GROUP BY department
ORDER BY total_cost DESC;

SELECT department,
       CASE 
           WHEN HOUR(timestamp) BETWEEN 9 AND 18 THEN 'Peak'
           ELSE 'Non-Peak'
       END AS usage_type,
       SUM(electricity_kWh) AS total_electricity,
       SUM(water_liters) AS total_water,
       SUM(total_cost) AS total_cost
FROM energy_consumption
GROUP BY department, usage_type
ORDER BY department, usage_type;

SELECT department,
       MONTH(timestamp) AS month,
       SUM(electricity_kWh) AS total_electricity,
       SUM(water_liters) AS total_water,
       SUM(total_cost) AS total_cost
FROM energy_consumption
GROUP BY department, month
ORDER BY department, month;

SELECT *
FROM energy_consumption
WHERE electricity_kWh > (SELECT AVG(electricity_kWh) + 2*STDDEV(electricity_kWh) FROM energy_consumption)
ORDER BY electricity_kWh DESC
LIMIT 50;

SELECT DAYNAME(timestamp) AS day_name,
       SUM(total_cost) AS total_cost
FROM energy_consumption
GROUP BY day_name
ORDER BY total_cost DESC;


