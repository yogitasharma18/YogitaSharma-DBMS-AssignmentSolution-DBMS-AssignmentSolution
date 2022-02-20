-- Project DBMS 

-- Creating Database
	CREATE DATABASE IF NOT EXISTS travel;

-- Using Database
	USE travel;

-- 1) Creating tables in Database travel
	-- PASSENGER table
	CREATE TABLE IF NOT EXISTS `PASSENGER` (
	  `PASSENGER_NAME` VARCHAR(50) NULL DEFAULT NULL,
	  `CATEGORY` VARCHAR(50) NULL DEFAULT NULL,
	  `GENDER` VARCHAR(10) NULL DEFAULT NULL,
	  `BOARDING_CITY` VARCHAR(50) NULL DEFAULT NULL,
	  `DESTINATION_CITY` VARCHAR(50) NULL DEFAULT NULL,
	  `DISTANCE` INT NOT NULL,
	  `BUS_TYPE` VARCHAR(10));
   
-- PRICE table
	CREATE TABLE IF NOT EXISTS `PRICE` (
	  `BUS_TYPE` VARCHAR(10),
	  `DISTANCE` INT NOT NULL,
	  `PRICE` INT NOT NULL);
  
  
-- 2) Inserting values into tables
-- PASSENGER table
	INSERT INTO `PASSENGER` VALUES("Sejal","AC","F","Bengaluru","Chennai",'350',"Sleeper");
	INSERT INTO `PASSENGER` VALUES("Anmol","Non-AC","M","Mumbai","Hyderabad",'700',"Sitting");
	INSERT INTO `PASSENGER` VALUES("Pallavi","AC","F","Panaji","Bengaluru",'600',"Sleeper");
	INSERT INTO `PASSENGER` VALUES("Khusboo","AC","F","Chennai","Mumbai",'1500',"Sleeper");
	INSERT INTO `PASSENGER` VALUES("Udit","Non-AC","M","Trivandrum","Panaji",'1000',"Sleeper");
	INSERT INTO `PASSENGER` VALUES("Ankur","AC","M","Nagpur","Hyderabad",'500',"Sitting");
	INSERT INTO `PASSENGER` VALUES("Hemant","Non-AC","M","Panaji","Mumbai",'700',"Sleeper");
	INSERT INTO `PASSENGER` VALUES("Manish","Non-AC","M","Hyderabad","Bengaluru",'500',"Sitting");
	INSERT INTO `PASSENGER` VALUES("Piyush","AC","M","Pune","Nagpur",'700',"Sitting");

-- PRICE table
	INSERT INTO `PRICE` VALUES("Sleeper",'350','770');
	INSERT INTO `PRICE` VALUES("Sleeper",'500','1100');
	INSERT INTO `PRICE` VALUES("Sleeper",'600','1320');
	INSERT INTO `PRICE` VALUES("Sleeper",'700','1540');
	INSERT INTO `PRICE` VALUES("Sleeper",'1000','2200');
	INSERT INTO `PRICE` VALUES("Sleeper",'1200','2640');
	INSERT INTO `PRICE` VALUES("Sleeper",'1500','2700');
	INSERT INTO `PRICE` VALUES("Sitting",'500','620');
	INSERT INTO `PRICE` VALUES("Sitting",'600','744');
	INSERT INTO `PRICE` VALUES("Sitting",'700','868');
	INSERT INTO `PRICE` VALUES("Sitting",'1000','1240');
	INSERT INTO `PRICE` VALUES("Sitting",'1200','1488');
	INSERT INTO `PRICE` VALUES("Sitting",'1500','1860');

-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?
	SELECT COUNT(CASE WHEN (GENDER) = 'F' THEN 1 END) FEMALE, COUNT(CASE WHEN (GENDER) = 'M' THEN 1 END) MALE 
    FROM PASSENGER 
	WHERE Distance >=600;

-- 4) Find the minimum ticket price for Sleeper Bus
	SELECT MIN(PRICE) AS MINIMUM_PRICE 
    FROM TRAVEL.PRICE 
    WHERE BUS_TYPE ='SLEEPER';

-- 5) Select passenger names whose names start with character 'S'
	SELECT * FROM PASSENGER 
    WHERE PASSENGER_NAME LIKE 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output
	SELECT DISTINCT P1.PASSENGER_NAME, P1.BOARDING_CITY, P1.DESTINATION_CITY, P1.BUS_TYPE, P2.PRICE 
    FROM PASSENGER P1, PRICE P2
	WHERE (P1.DISTANCE = P2.DISTANCE AND P1.BUS_TYPE = P2.BUS_TYPE);

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s
	SELECT P1.PASSENGER_NAME, P2.PRICE 
    FROM PASSENGER P1, PRICE P2 
	WHERE (P1.BUS_TYPE = 'SITTING' AND P1.DISTANCE = 1000);

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
	SELECT PASSENGER.BUS_TYPE, PRICE FROM PRICE INNER JOIN PASSENGER
	ON PRICE.DISTANCE = PASSENGER.DISTANCE 
	WHERE PASSENGER_NAME = "Pallavi";

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
	SELECT DISTINCT DISTANCE 
    FROM PASSENGER 
    ORDER BY DISTANCE desc;

-- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
	SELECT PASSENGER_NAME, DISTANCE * 100.0/ (SELECT SUM(DISTANCE) FROM PASSENGER) AS PERCENTAGE_DIST 
    FROM PASSENGER 
    GROUP BY DISTANCE;

-- 11) Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise
	 SELECT DISTANCE, PRICE,
	 CASE
		WHEN PRICE > 1000 then 'Expensive'
		WHEN (PRICE>500 AND PRICE<1000) then 'Average Cost'
		ELSE 'Cheap'
	END
	AS CATEGORIES FROM PRICE;