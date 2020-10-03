CREATE SCHEMA world_happiness_report;
USE world_happiness_report;
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






