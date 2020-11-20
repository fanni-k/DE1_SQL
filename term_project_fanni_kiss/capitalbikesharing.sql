-- DE1 Term Project: Capital Bikesharing by Fanni Kiss
---------------------------------
-- OPERATIONAL DATA LAYER
---------------------------------
-- Creating a new schema and importing the relational dataset

CREATE SCHEMA capitalbikeshare;
USE capitalbikeshare;

SET sql_mode = "";

CREATE TABLE ride_data 
(ride_id VARCHAR(255),
rideable_type VARCHAR(32),
started_at DATETIME NOT NULL,
ended_at DATETIME NOT NULL,
start_station_id INTEGER NOT NULL,
end_station_id INTEGER NOT NULL,
member_casual VARCHAR(32),
member_id INTEGER);

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ride_data.csv'
INTO TABLE ride_data
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES 
(ride_id, rideable_type, started_at, ended_at, start_station_id, end_station_id, member_casual, member_id);

SELECT * FROM ride_data;

CREATE TABLE member_data 
(member_id INTEGER,
member_name VARCHAR(255),
registration_time DATETIME NOT NULL,
email VARCHAR(255),
date_of_birt DATE NOT NULL);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/member_data.csv'
INTO TABLE member_data
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES 
(member_id, member_name, registration_time, email, date_of_birt);

SELECT * FROM member_data;

CREATE TABLE station_data 
(station_id INTEGER,
station_name VARCHAR(255),
lat DECIMAL(30,27),
lng DECIMAL(30,27));

drop table station_data;

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/station_data.csv'
INTO TABLE station_data
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES 
(station_id, station_name, lat, lng);

SELECT * FROM station_data;

---------------------------------
-- ANALYTICAL PLAN
---------------------------------
-- Data source: Capital Bikeshare's, a London-based bikesharing company's ride data downloaded from https://www.capitalbikeshare.com/system-data
-- Time period: September 2020
-- Data tables:
-------- Fact: ride data
-------- Dimension1: member data
-------- Dimension2: station data
-- The aim of the analytics:
-------- 1. Exploring the most frequently used start and end stations
-------- 2. Creating age groups based on members' personal data and explore the most popular end stations by age groups
-------- 3. Exploring the favoured ride type (electric or docked bike) by age groups
-------- 4. Exploring what is the favoured part of the day (forenoon or afternoon) when the bikesharing service is used more

---------------------------------
-- ANALYTICAL DATA STORE
---------------------------------
-- Creating a denormalized table to carry on further analytics

USE capitalbikeshare;

DROP PROCEDURE IF EXISTS CreateRideStationMember;

DELIMITER //
CREATE PROCEDURE CreateRideStationMember()
BEGIN

	DROP TABLE IF EXISTS all_data;
	
    CREATE TABLE all_data AS
   SELECT 
	   ride_data.ride_id AS RideID, 
	   ride_data.rideable_type AS RideableType, 
	   ride_data.started_at AS StartTime,
	   ride_data.member_casual AS MemberCasual,   
       member_data.registration_time AS RegistrationTime,
       member_data.date_of_birt AS DateOfBirth,
       a.station_name AS StartStationName,
       b.station_name AS EndStationName
	FROM
		ride_data
	LEFT JOIN
		member_data USING (member_id)
	LEFT JOIN
		station_data as a ON ride_data.start_station_id = a.station_id
	LEFT JOIN
		station_data as b ON ride_data.end_station_id = b.station_id
	LIMIT 1001;
      -- There are 1000 observations in the fact table
END //
DELIMITER ;

CALL CreateRideStationMember();

SELECT * FROM all_data;

---------------------------------
-- CREATING DATA MARTS
---------------------------------
-- Creating data marts to answer the analytical questions

-- View_01: Which are most popular start stations? 
-- The most commonly used start station is 'New York Ave & Hecht Ave NE'

DROP VIEW IF EXISTS Top_Start_Stations;

CREATE VIEW `Top_Start_Stations` AS
SELECT StartStationName, count(*) AS count FROM all_data GROUP BY StartStationName ORDER BY count DESC LIMIT 11;

-- View_02: Which are the most popular end stations?
-- The most commonly used end station is '10th & U St NW'

DROP VIEW IF EXISTS top_end_stations;

CREATE VIEW `top_end_stations` AS
SELECT EndStationName, count(*) AS count FROM all_data GROUP BY EndStationName ORDER BY count DESC LIMIT 11;

-- View_03: What are the most common end stations by age groups?
-- The '15th & Euclid St  NW' station is popular in the 55+ age group

DROP VIEW IF EXISTS end_stations_by_age_groups;

CREATE VIEW `end_stations_by_age_groups` AS
SELECT EndStationName, COUNT(*),
	CASE 
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 24
			THEN 'under 25'
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) >= 25 AND ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 35
			THEN '25-35'
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) >=35 AND ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 45
			THEN '35-45'
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) >=45 AND ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 55
			THEN '45-55'
		ELSE
			'55+'
	END
	AS AgeGroup
    FROM all_data
	GROUP BY AgeGroup, EndStationName
    ORDER BY COUNT(*) DESC;

-- View_04: Is electric or docked bike more popular in given age groups?
-- Docked bikes are more popular within each age groups

DROP VIEW IF EXISTS rideably_type_by_age_groups;

CREATE VIEW `rideably_type_by_age_groups` AS
SELECT RideableType, COUNT(*),
	CASE 
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 24
			THEN 'under 25'
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) >= 25 AND ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 35
			THEN '25-35'
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) >=35 AND ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 45
			THEN '35-45'
		WHEN ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) >=45 AND ROUND(DATEDIFF(NOW(), DateOfBirth)/365.25) < 55
			THEN '45-55'
		ELSE
			'55+'
	END
    AS AgeGroup
    FROM all_data
	GROUP BY AgeGroup, RideableType
    ORDER BY COUNT(*) DESC;

-- View_05: In which part of the day do members use the service more? (Busy part of the day)
-- The bikesharing service is used more on the afternoon

DROP VIEW IF EXISTS part_of_the_day;

CREATE VIEW `part_of_the_day` AS
SELECT COUNT(RideID), 
	CASE 
		WHEN HOUR(StartTime) > 12 
			THEN 'Afternoon'
		WHEN HOUR(StartTime) < 12
			THEN 'Forenoon'
		ELSE 'Null'
    END
    AS PartOfTheDay
FROM all_data
GROUP BY PartOfTheDay;

