-- new field based on cost
SELECT aircraft, airline, cost, 
    CASE 
        WHEN cost  = 0
            THEN 'NO COST'
        WHEN  cost >0 AND cost < 100000
            THEN 'MEDIUM COST'
        ELSE 
            'HIGH COST'
    END
    AS cost_category   
FROM  birdstrikes
ORDER BY cost_category;

-- Exercise1: Do the same with speed. If speed is NULL or speed < 100 create a "LOW SPEED" category, otherwise, mark as "HIGH SPEED". Use IF instead of CASE

SELECT aircraft, airline, speed, IF(speed < 100 OR speed is null, "LOW SPEED" , "HIGH SPEED") AS speed_category FROM birdstrikes ORDER BY speed_category;

-- Exercise2: How many distinct 'aircraft' we have in the database?
-- Answer: 3
SELECT COUNT(DISTINCT(aircraft)) FROM birdstrikes;

-- Exercise3: What was the lowest speed of aircrafts starting with 'H'
-- Answer: 9
SELECT MIN(speed) FROM birdstrikes WHERE aircraft LIKE 'H%';

-- Exercise4: Which phase_of_flight has the least of incidents?
-- Answer: Taxi (2)
SELECT phase_of_flight, count(*) AS count FROM birdstrikes group by phase_of_flight ORDER BY count LIMIT 1; 
 
 -- Exercise5: What is the rounded highest average cost by phase_of_flight?
 -- Answer: 54673
 SELECT phase_of_flight, cost, ROUND(AVG(cost)) AS average_cost FROM birdstrikes GROUP BY phase_of_flight ORDER BY average_cost DESC LIMIT 1;
 
 -- Exercise6: What the highest AVG speed of the states with names less than 5 characters?
 -- Answer: 2862.5000
 SELECT AVG(speed) AS avg_speed,state FROM birdstrikes WHERE LENGTH(state)<5 AND state!='' GROUP BY state ORDER BY avg_speed DESC LIMIT 1;
 