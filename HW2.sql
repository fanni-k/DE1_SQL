-- Exercise1: What state figures in the 145th line of our database?
-- Answer: Tennessee
SELECT * FROM birdstrikes LIMIT 144,1;

-- Exercise2: What is flight_date of the latest birstrike in this database?
-- Answer: 2000-04-18
SELECT * FROM birdstrikes ORDER BY flight_date DESC;

-- Exercise3: What was the cost of the 50th most expensive damage?
-- Answer: 5345
SELECT DISTINCT cost FROM birdstrikes ORDER BY cost DESC LIMIT 49,1;

-- Exercise4: What state figures in the 2nd record, if you filter out all records which have no state and no bird_size specified?
-- Answer: Alabama
SELECT DISTINCT(state) FROM birdstrikes WHERE state IS NOT NULL AND bird_size IS NOT NULL ORDER BY state;

-- Exercise5: How many days elapsed between the current date and the flights happening in week 52, for incidents from Colorado?
-- Answer: 7582
SELECT * FROM birdstrikes WHERE STATE = 'Colorado'; 
SELECT WEEKOFYEAR ("2000-01-01");
SELECT DATEDIFF( CURDATE(), '2000-01-01');