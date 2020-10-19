-- HOMEWORK 5

CREATE TABLE areaCodes (
city VARCHAR(50),
AreaCode VARCHAR(50)
);

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HW5_area-codes.csv'
INTO TABLE areaCodes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

DROP PROCEDURE IF EXISTS FixUSPhones; 

DELIMITER $$

CREATE PROCEDURE FixUSPhones ()
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE phone varchar(50) DEFAULT "x";
	DECLARE customerNumber INT DEFAULT 0;
    	DECLARE country varchar(50) DEFAULT "";
        DECLARE areacode varchar(50) DEFAULT 0;

	-- declare cursor for customer
	DECLARE curPhone
		CURSOR FOR 
            		SELECT customers.customerNumber, customers.phone, customers.country  
				FROM classicmodels.customers;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curPhone;
    
    	-- create a copy of the customer table 
DROP TABLE IF EXISTS classicmodels.fixed_customers;
	CREATE TABLE classicmodels.fixed_customers LIKE classicmodels.customers;
	INSERT fixed_customers SELECT * FROM classicmodels.customers;
    
  -- insert area codes into 'fixed_customers' table with LEFT JOIN
    
    SELECT * FROM classicmodels.fixed_customers
    LEFT JOIN areaCodes
    USING (city);
    
	fixPhone: LOOP
		FETCH curPhone INTO customerNumber, phone, country;
		IF finished = 1 THEN 
			LEAVE fixPhone;
		END IF;
		 
		-- insert into messages select concat('country is: ', country, ' and phone is: ', phone);
         
		IF country = 'USA'  THEN
			IF phone NOT LIKE '+%' THEN
				IF LENGTH(phone) = 10 THEN 
					SET  phone = CONCAT('+1',phone);
                    UPDATE classicmodels.fixed_customers
                    SET fixed_customers.phone=phone 
							WHERE fixed_customers.customerNumber = customerNumber;
                    ELSE IF LENGTH(phone) = 7 THEN
                    SET  phone = CONCAT('+1',phone);
					UPDATE classicmodels.fixed_customers 
						SET fixed_customers.phone=phone 
							WHERE fixed_customers.customerNumber = customerNumber;
                		END IF;    
			END IF;
       		 END IF;
             END IF;

	END LOOP fixPhone;
	CLOSE curPhone;

END$$
DELIMITER ;

CALL FixUSPhones;

SELECT * FROM fixed_customers where country = 'USA';