CREATE SCHEMA world_happiness_report_2;
USE world_happiness_report_2;
CREATE TABLE year2019
(Overall_rank INTEGER,
Country_or_region VARCHAR(255),
Score DECIMAL(4,3),
GDP_per_capita DECIMAL(4,3),
Social_support DECIMAL(4,3),
Healthy_life_expectancy DECIMAL(4,3),
Freedom_to_make_life_choices DECIMAL(4,3),
Generosity DECIMAL(4,3),
Perceptions_of_corruption DECIMAL(4,3),PRIMARY KEY(Country_or_region));

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2019.csv'
INTO TABLE year2019
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(Overall_rank, Country_or_region, Score, GDP_per_capita, Social_support, Healthy_life_expectancy, Freedom_to_make_life_choices, Generosity, Perceptions_of_corruption);

select * from year2019;

CREATE TABLE year2018
(Overall_rank INTEGER,
Country_or_region VARCHAR(255),
Score DECIMAL(4,3),
GDP_per_capita DECIMAL(4,3),
Social_support DECIMAL(4,3),
Healthy_life_expectancy DECIMAL(4,3),
Freedom_to_make_life_choices DECIMAL(4,3),
Generosity DECIMAL(4,3),
Perceptions_of_corruption DECIMAL(4,3),PRIMARY KEY(Country_or_region));

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2018.csv'
INTO TABLE year2018
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(Overall_rank, Country_or_region, Score, GDP_per_capita, Social_support, Healthy_life_expectancy, Freedom_to_make_life_choices, Generosity, Perceptions_of_corruption);

select * from year2018;

CREATE TABLE year2017
(Country VARCHAR(255),
Happiness_rank INTEGER,
Happiness_score DECIMAL(20,19),
Whisker_high DECIMAL(20,19),
Whisker_low DECIMAL(20,19),
GDP_per_capita DECIMAL(20,19),
Family DECIMAL(20,19),
Healthy_life_expectancy DECIMAL(20,19),
Freedom DECIMAL(20,19),
Generosity DECIMAL(20,19),
Trust_Government_Corruption DECIMAL(20,19),
Dystopia_Residual DECIMAL(20,19),PRIMARY KEY(Country));

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2017.csv'
INTO TABLE year2017
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(Country, Happiness_rank, Happiness_score, Whisker_high, Whisker_low, GDP_per_capita, Family, Healthy_life_expectancy, Freedom, Generosity, Trust_Government_Corruption, Dystopia_Residual);

select * from year2017;

CREATE TABLE year2016
(Country VARCHAR(255),
Region VARCHAR(255),
Happiness_rank INTEGER,
Happiness_score DECIMAL(20,19),
Lower_Confidence_Interval DECIMAL(20,19),
Upper_Confidence_Interval DECIMAL(20,19),
GDP_per_capita DECIMAL(20,19),
Family DECIMAL(20,19),
Healthy_life_expectancy DECIMAL(20,19),
Freedom DECIMAL(20,19),
Trust_Government_Corruption DECIMAL(20,19),
Generosity DECIMAL(20,19),
Dystopia_Residual DECIMAL(20,19),PRIMARY KEY(Country));

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2016.csv'
INTO TABLE year2016
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(Country, Region, Happiness_rank, Happiness_score, Lower_Confidence_Interval, Upper_Confidence_Interval, GDP_per_capita, Family, Healthy_life_expectancy, Freedom, Trust_Government_Corruption, Generosity, Dystopia_Residual);

select * from year2016;