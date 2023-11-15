-- Create the schema
DROP DATABASE IF EXISTS mydb;
CREATE DATABASE IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8;
USE mydb;

-- GET RID OF ALL FOREIGN KEYS EXCEPT BOOKING'S CONFIRMATION_ID
-- Table mydb.Cost
DROP TABLE IF EXISTS mydb.Cost;
CREATE TABLE IF NOT EXISTS mydb.cost(
  Cost_ID INT NOT NULL,
  Amount INT NOT NULL,
  Distance INT NULL,
  Season_Of_Year VARCHAR(45) NULL,
  Day_Of_Week VARCHAR(45) NULL,
  Seat_Number VARCHAR(45) NULL,
  PRIMARY KEY (Cost_ID)
);

-- Table mydb.Passenger
DROP TABLE IF EXISTS mydb.Passenger;
CREATE TABLE IF NOT EXISTS mydb.Passenger (
  Passenger_ID INT NOT NULL,
  Passenger_FName VARCHAR(45) NULL,
  Passenger_LName VARCHAR(45) NULL,
  Passenger_DOB DATETIME NULL,
  Passenger_Address VARCHAR(45) NULL,
  Passenger_Street VARCHAR(45) NULL,
  Passenger_City VARCHAR(45) NULL,
  Passenger_Zip INT NULL,
  Passenger_Phone VARCHAR(45) NULL,
  PRIMARY KEY (Passenger_ID)
); 

-- Table mydb.Booking
DROP TABLE IF EXISTS mydb.Booking;
CREATE TABLE IF NOT EXISTS mydb.Booking (
   Confirmation_ID INT NOT NULL,
  Booking_Date DATETIME NULL,
  Booking_Platform VARCHAR(45) NULL,
  Booking_Type VARCHAR(45) NULL,
  Passenger_ID INT NULL, -- Assuming this is the foreign key reference
  PRIMARY KEY (Confirmation_ID),
  FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID));

DROP TABLE IF EXISTS mydb.Phone;
CREATE TABLE IF NOT EXISTS mydb.Phone (
  Phone_ID VARCHAR(45) NOT NULL,
  Phone_num VARCHAR(15) NULL,
  Passenger_ID INT NOT NULL, 
  FOREIGN KEY (Passenger_ID) REFERENCES Passenger (Passenger_ID),
  PRIMARY KEY (Phone_ID)
);

-- Table mydb.Airline
DROP TABLE IF EXISTS mydb.Airline;
CREATE TABLE IF NOT EXISTS mydb.Airline (
  Airline_ID INT NOT NULL,
  No_Planes INT NULL,
  Plane_ID INT NULL,
  Airport_Gate VARCHAR(45) NULL,
  Num_Employees INT, 
  PRIMARY KEY (Airline_ID)
);

-- Table mydb.Plane
DROP TABLE IF EXISTS mydb.Plane;
CREATE TABLE IF NOT EXISTS mydb.Plane (
  Plane_ID INT NOT NULL,
  Plane_Model VARCHAR(45) NULL,
  Plane_Manufacturer VARCHAR(45) NULL,
  Plane_Size VARCHAR(20),
  Plane_Engine_Power VARCHAR(20),
  PRIMARY KEY (Plane_ID)
  );

-- Table mydb.Pilot
DROP TABLE IF EXISTS mydb.Pilot;
CREATE TABLE IF NOT EXISTS mydb.Pilot (
  Pilot_ID INT NOT NULL,
  Pilot_FName VARCHAR(45) NULL,
  Pilot_LName VARCHAR(45) NULL,
  Pilot_License VARCHAR(45) NULL,
  Hire_Date DATETIME NULL,
  Pilot_DOB DATETIME NULL,
  PRIMARY KEY (Pilot_ID)
);

-- Table mydb.Baggage
DROP TABLE IF EXISTS mydb.Baggage;
CREATE TABLE IF NOT EXISTS mydb.Baggage (
  Baggage_ID VARCHAR(45) NOT NULL,
  Passenger_ID INT NULL,
  Baggage_Weight DECIMAL(2) NULL,
  Baggage_Cost DECIMAL(2) NULL,
  Org_Airport_Loc VARCHAR(45) NULL,
  Org_Departure_Time VARCHAR(45) NULL,
  Flight_ID INT NULL,
  Des_Airport_Loc VARCHAR(45) NULL,
  Des_Departure_Time DATETIME NULL,
  Des_Departure_Gate VARCHAR(45) NULL,
  PRIMARY KEY (Baggage_ID),
  FOREIGN KEY (Passenger_ID) REFERENCES Passenger (Passenger_ID)
);  

-- Table mydb.Des_Airport
DROP TABLE IF EXISTS mydb.Des_Airport;
CREATE TABLE IF NOT EXISTS mydb.Des_Airport (
  Des_Airport_ID VARCHAR(3) NOT NULL,
  Des_Airport_Loc VARCHAR(45) NULL,
  Des_Arrival_Time DATETIME NULL,
  Des_Arrival_Gate VARCHAR(45) NULL,
  Des_Terminal VARCHAR(45) NULL,
  PRIMARY KEY (Des_Airport_ID)
);

-- Table mydb.Org_Airport
DROP TABLE IF EXISTS mydb.Org_Airport;
CREATE TABLE IF NOT EXISTS mydb.Org_Airport (
  Org_Airport_ID VARCHAR(3) NOT NULL,
  Org_Airport_Loc VARCHAR(45) NULL,
  Org_Departure_Time DATETIME NULL,
  Org_Departure_Gate VARCHAR(45) NULL,
  Org_Terminal VARCHAR(45) NULL,
  PRIMARY KEY (Org_Airport_ID)
);

-- Table mydb.Flight Attendant
DROP TABLE IF EXISTS mydb.Flight_Attendant;
CREATE TABLE IF NOT EXISTS mydb.Flight_Attendant (
  Flight_Att_ID VARCHAR(5) NOT NULL,
  Flight_Att_FName VARCHAR(45) NULL,
  Flight_Att_LName VARCHAR(45) NULL,
  Hire_Date DATETIME NULL,
  Flight_Attendant_DOB DATETIME NULL,
  PRIMARY KEY (Flight_Att_ID)
);

-- Table mydb.Flight
DROP TABLE IF EXISTS mydb.Flight;
CREATE TABLE IF NOT EXISTS mydb.Flight (
  Flight_ID INT NOT NULL,
  Org_Departure_Time DATETIME NULL,
  Des_Arrival_Time DATETIME NULL,
  Flight_Time DECIMAL(2) NULL,
  Passenger_ID INT,
  Confirmation_ID INT,
  Org_Airport_ID VARCHAR(3),
  Des_Airport_ID VARCHAR(3),
  Plane_ID INT,
  Pilot_ID INT,
  Flight_Att_ID VARCHAR(5),
  PRIMARY KEY (Flight_ID),
  FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID),
  FOREIGN KEY (Confirmation_ID) REFERENCES Booking(Confirmation_ID),
  FOREIGN KEY (Org_Airport_ID) REFERENCES Org_Airport (Org_Airport_ID),
  FOREIGN KEY (Des_Airport_ID) REFERENCES Des_Airport (Des_Airport_ID),
  FOREIGN KEY (Plane_ID) REFERENCES Plane (Plane_ID),
  FOREIGN KEY (Pilot_ID) REFERENCES Pilot (Pilot_ID),
  FOREIGN KEY (Flight_Att_ID) REFERENCES Flight_Attendant (Flight_Att_ID)
);

-- Table mydb.Flight_Attendant_has_Flight
DROP TABLE IF EXISTS mydb.Flight_Attendant_has_Flight;
CREATE TABLE IF NOT EXISTS mydb.Flight_Attendant_has_Flight (
connection_id int,
  PRIMARY KEY (connection_id),
  Flight_Att_ID VARCHAR(5),
  Flight_ID INT,
  Org_Airport_ID VARCHAR(3),
  Des_Airport_ID VARCHAR(3),
  Pilot_ID INT,
  Plane_ID INT,
  FOREIGN KEY (Flight_Att_ID) REFERENCES Flight_Attendant (Flight_Att_ID),
  FOREIGN KEY (Flight_ID) REFERENCES Flight (Flight_ID),
  FOREIGN KEY (Org_Airport_ID) REFERENCES Org_Airport (Org_Airport_ID),
  FOREIGN KEY (Des_Airport_ID) REFERENCES Des_Airport (Des_Airport_ID),
  FOREIGN KEY (Pilot_ID) REFERENCES Pilot (Pilot_ID),
  FOREIGN KEY (Plane_ID) REFERENCES Plane (Plane_ID)
);


SET FOREIGN_KEY_CHECKS=0;

INSERT INTO mydb.Airline (Airline_ID, No_Planes, Plane_ID, Airport_Gate, Num_Employees)
VALUES
  (1, 30, 201, 'Gate A', 1000),
  (2, 20, 202, 'Gate B', 800),
  (3, 25, 203, 'Gate C', 900),
  (4, 35, 204, 'Gate D', 1100),
  (5, 15, 205, 'Gate E', 700),
  (6, 40, 206, 'Gate F', 1200),
  (7, 28, 207, 'Gate G', 950),
  (8, 22, 208, 'Gate H', 850),
  (9, 33, 209, 'Gate I', 1050),
  (10, 18, 210, 'Gate J', 750);

select * from Airline;

INSERT INTO mydb.Baggage (
  Baggage_ID,
  Passenger_ID,
  Baggage_Weight,
  Baggage_Cost,
  Org_Airport_Loc,
  Org_Departure_Time,
  Flight_ID,
  Des_Airport_Loc,
  Des_Departure_Time,
  Des_Departure_Gate
) VALUES
  ('B001', 1, 15.0, 50.00, 'Airport A', '2023-10-31 08:00:00', 101, 'Airport B', '2023-10-31 10:00:00', 'Gate A'),
  ('B002', 2, 25.5, 75.50, 'Airport C', '2023-10-31 09:30:00', 102, 'Airport D', '2023-10-31 12:30:00', 'Gate B'),
  ('B003', 3, 18.0, 60.00, 'Airport E', '2023-10-31 07:45:00', 103, 'Airport F', '2023-10-31 09:45:00', 'Gate C'),
  ('B004', 4, 22.5, 70.00, 'Airport G', '2023-10-31 10:15:00', 104, 'Airport H', '2023-10-31 13:15:00', 'Gate D'),
  ('B005', 5, 14.0, 45.00, 'Airport I', '2023-10-31 06:30:00', 105, 'Airport J', '2023-10-31 08:30:00', 'Gate E'),
  ('B006', 6, 28.5, 80.00, 'Airport K', '2023-10-31 11:45:00', 106, 'Airport L', '2023-10-31 14:45:00', 'Gate F'),
  ('B007', 7, 19.5, 65.00, 'Airport M', '2023-10-31 09:00:00', 107, 'Airport N', '2023-10-31 11:00:00', 'Gate G'),
  ('B008', 8, 21.0, 68.50, 'Airport O', '2023-10-31 10:45:00', 108, 'Airport P', '2023-10-31 13:45:00', 'Gate H'),
  ('B009', 9, 16.5, 55.00, 'Airport Q', '2023-10-31 08:15:00', 109, 'Airport R', '2023-10-31 10:15:00', 'Gate I'),
  ('B010', 10, 24.0, 72.00, 'Airport S', '2023-10-31 11:00:00', 110, 'Airport T', '2023-10-31 14:00:00', 'Gate J');
  
select * from baggage;

INSERT INTO mydb.Plane (Plane_ID, Plane_Model, Plane_Manufacturer, Plane_Size, Plane_Engine_Power)
VALUES
  (1, 'Boeing 747', 'Boeing', 'Large', 'High'),
  (2, 'Airbus A320', 'Airbus', 'Medium', 'Medium'),
  (3, 'Cessna 172', 'Cessna', 'Small', 'Low'),
  (4, 'Embraer E190', 'Embraer', 'Medium', 'Medium'),
  (5, 'Bombardier CRJ200', 'Bombardier', 'Small', 'Low'),
  (6, 'Airbus A380', 'Airbus', 'Extra-Large', 'Very High'),
  (7, 'Boeing 737', 'Boeing', 'Medium', 'Medium'),
  (8, 'Cessna Citation X', 'Cessna', 'Small', 'Medium'),
  (9, 'Embraer Phenom 100', 'Embraer', 'Small', 'Low'),
  (10, 'Airbus A330', 'Airbus', 'Large', 'High');

select * from plane;

INSERT INTO mydb.Pilot (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_License, Hire_Date, Pilot_DOB)
VALUES
  (1, 'John', 'Smith', 'P12345', '1985-06-15 08:00:00', '1960-02-10 00:00:00'),
  (2, 'Lisa', 'Johnson', 'P54321', '1990-03-20 10:30:00', '1975-09-25 00:00:00'),
  (3, 'Michael', 'Brown', 'P98765', '2000-11-05 14:15:00', '1982-07-12 00:00:00'),
  (4, 'Sarah', 'Williams', 'P23456', '2005-07-10 09:45:00', '1990-12-30 00:00:00'),
  (5, 'David', 'Miller', 'P87654', '2010-12-22 13:20:00', '1988-04-05 00:00:00'),
  (6, 'Emily', 'Davis', 'P65432', '2015-04-17 11:10:00', '1994-10-15 00:00:00'),
  (7, 'James', 'Anderson', 'P34567', '2018-08-28 07:30:00', '1998-06-20 00:00:00'),
  (8, 'Jessica', 'Moore', 'P76543', '2019-09-15 15:45:00', '2000-03-01 00:00:00'),
  (9, 'William', 'Taylor', 'P45678', '2022-02-14 12:25:00', '2002-11-08 00:00:00'),
  (10, 'Olivia', 'Wilson', 'P87654', '2023-05-09 09:00:00', '2004-07-19 00:00:00');

select * from pilot;

-- insert into Cost 
INSERT INTO mydb.Cost (Cost_ID, Amount, Distance, Season_Of_Year, Day_Of_Week, Seat_Number)
VALUES
	(1, 50, 100, 'Summer', 'Monday', 'A1'),
	(2, 60, 150, 'Spring', 'Wednesday', 'B3'),
	(3, 45, 180, 'Fall', 'Friday', 'C7'),
	(4, 55, 75, 'Winter', 'Tuesday', 'D2'),
	(5, 70, 750, 'Summer', 'Thursday', 'E5'),
	(6, 65, 1000, 'Spring', 'Monday', 'F9'),
	(7, 40, 325, 'Fall', 'Sunday', 'G4'),
	(8, 75, 650, 'Winter', 'Saturday', 'H6'),
	(9, 58, 3400, 'Summer', 'Tuesday', 'I8'),
	(10, 68, 140, 'Spring', 'Thursday', 'J10');
    
select * from cost;


-- Booking 
INSERT INTO mydb.Booking (Confirmation_ID, Booking_Date, Booking_Platform, Booking_Type, Passenger_ID)
	VALUES
	(1, '2023-10-31 10:00:00', 'Website', 'One-way', 101),
	(2, '2023-11-01 14:30:00', 'Mobile App', 'Round-trip', 102),
	(3, '2023-11-02 12:45:00', 'Website', 'One-way', 103),
	(4, '2023-11-03 08:15:00', 'Mobile App', 'Round-trip', 104),
	(5, '2023-11-04 16:20:00', 'Website', 'One-way', 105),
	(6, '2023-11-05 11:30:00', 'Mobile App', 'Round-trip', 106),
	(7, '2023-11-06 09:10:00', 'Website', 'One-way', 107),
	(8, '2023-11-07 15:55:00', 'Mobile App', 'Round-trip', 108),
	(9, '2023-11-08 13:25:00', 'Website', 'One-way', 109),
	(10, '2023-11-09 17:40:00', 'Mobile App', 'Round-trip', 110);
select * from booking;

-- Passenger
INSERT INTO mydb.Passenger (Passenger_ID, Passenger_FName, Passenger_LName, Passenger_DOB, Passenger_Address, Passenger_Street, Passenger_City, Passenger_Zip, Passenger_Phone)
	VALUES
	(101, 'John', 'Doe', '1985-05-15', '123 Main St', 'Apt 4B', 'Anytown', 12345, '555-1234'),
	(102, 'Alice', 'Johnson', '1990-08-21', '456 Elm St', 'Unit 7C', 'Otherville', 67890, '555-5678'),
	(103, 'Michael', 'Smith', '1982-03-10', '789 Oak St', 'Suite 12', 'Somewhere', 13579, '555-2468'),
	(104, 'Emily', 'Brown', '1988-12-05', '101 Pine St', 'Apt 3D', 'Nowhere', 24680, '555-1357'),
	(105, 'David', 'Lee', '1995-06-18', '222 Cedar St', 'Unit 5E', 'Anywhere', 86420, '555-9876'),
	(106, 'Sophia', 'Hall', '1989-09-30', '333 Maple St', 'Apt 9A', 'Elsewhere', 97531, '555-5432'),
	(107, 'Oliver', 'Clark', '1992-11-12', '444 Birch St', 'Unit 2F', 'No Place', 25874, '555-6789'),
	(108, 'Emma', 'Johnson', '1987-07-24', '555 Walnut St', 'Suite 8G', 'Here', 74125, '555-1122'),	
	(109, 'Liam', 'Adams', '1993-04-17', '666 Cherry St', 'Apt 6H', 'Everywhere', 96385, '555-3344'),
	(110, 'Ava', 'Miller', '1984-01-09', '777 Spruce St', 'Unit 10I', 'Noway', 15937, '555-5566');
select * from passenger;

-- Phone.
INSERT INTO mydb.Phone (Phone_ID, Phone_num, Passenger_ID)
VALUES
('1', 1234567890, 101),  
('2', 9876543210, 102), 
('3', 5555555555, 103), 
('4', 1231231234, 104),  
('5', 5558887777, 105),  
('6', 9990001111, 106), 
('7', 8889990000, 107), 
('8', 7776665555, 108), 
('9', 4443332222, 109),  
('10', 1112223333, 110); 
select * from phone;

-- Bashir
-- Insert data into mydb.Des_Airport
INSERT INTO mydb.Des_Airport (Des_Airport_ID, Des_Airport_Loc, Des_Arrival_Time, Des_Arrival_Gate, Des_Terminal)
VALUES
  ('LGA', 'New York City', '2023-11-01 10:00:00', 'Gate 1', 'Terminal A'),
  ('JFK', 'New York City', '2023-11-01 11:30:00', 'Gate 2', 'Terminal B'),
  ('ORD', 'Chicago', '2023-11-01 12:15:00', 'Gate 3', 'Terminal C'),
  ('LAX', 'Los Angeles', '2023-11-01 13:45:00', 'Gate 4', 'Terminal D'),
  ('SFO', 'San Francisco', '2023-11-01 15:30:00', 'Gate 5', 'Terminal E'),
  ('DFW', 'Dallas', '2023-11-01 16:20:00', 'Gate 6', 'Terminal F'),
  ('MIA', 'Miami', '2023-11-01 18:00:00', 'Gate 7', 'Terminal G'),
  ('LAS', 'Las Vegas', '2023-11-01 19:45:00', 'Gate 8', 'Terminal H'),
  ('ATL', 'Atlanta', '2023-11-01 21:10:00', 'Gate 9', 'Terminal I'),
  ('DEN', 'Denver', '2023-11-01 22:30:00', 'Gate 10', 'Terminal J');
select * from Des_Airport;

-- Insert data into mydb.Org_Airport
INSERT INTO mydb.Org_Airport (Org_Airport_ID, Org_Airport_Loc, Org_Departure_Time, Org_Departure_Gate, Org_Terminal)
VALUES
  ('JFK', 'New York City', '2023-11-01 08:00:00', 'Gate A', 'Terminal 1'),
  ('ORD', 'Chicago', '2023-11-01 07:30:00', 'Gate B', 'Terminal 2'),
  ('LAX', 'Los Angeles', '2023-11-01 09:15:00', 'Gate C', 'Terminal 3'),
  ('SFO', 'San Francisco', '2023-11-01 06:45:00', 'Gate D', 'Terminal 4'),
  ('DFW', 'Dallas', '2023-11-01 07:20:00', 'Gate E', 'Terminal 5'),
  ('MIA', 'Miami', '2023-11-01 10:30:00', 'Gate F', 'Terminal 6'),
  ('LAS', 'Las Vegas', '2023-11-01 08:50:00', 'Gate G', 'Terminal 7'),
  ('ATL', 'Atlanta', '2023-11-01 06:30:00', 'Gate H', 'Terminal 8'),
  ('DEN', 'Denver', '2023-11-01 07:10:00', 'Gate I', 'Terminal 9'),
  ('SEA', 'Seattle', '2023-11-01 09:45:00', 'Gate J', 'Terminal 10');
select * from Org_Airport;

-- Insert data into mydb.Flight_Attendant
INSERT INTO mydb.Flight_Attendant (Flight_Att_ID, Flight_Att_FName, Flight_Att_LName, Hire_Date, Flight_Attendant_DOB)
VALUES
  ('FA001', 'John', 'Smith', '2021-03-15', '1990-05-12'),
  ('FA002', 'Emily', 'Johnson', '2019-07-22', '1992-08-28'),
  ('FA003', 'Michael', 'Davis', '2020-01-10', '1988-12-03'),
  ('FA004', 'Sophia', 'Wilson', '2022-05-05', '1995-04-17'),
  ('FA005', 'Daniel', 'Miller', '2018-11-30', '1987-09-20'),
  ('FA006', 'Olivia', 'Brown', '2019-09-18', '1993-06-25'),
  ('FA007', 'William', 'Jones', '2021-12-03', '1991-11-08'),
  ('FA008', 'Ava', 'Clark', '2020-08-15', '1994-03-06'),
  ('FA009', 'Ethan', 'Hall', '2022-02-28', '1989-07-14'),
  ('FA010', 'Isabella', 'Moore', '2017-06-12', '1996-10-30');
select * from Flight_Attendant;

-- Insert data into mydb.Flight
INSERT INTO mydb.Flight (Flight_ID, Org_Departure_Time, Des_Arrival_Time, Flight_Time, Passenger_ID, Confirmation_ID, Org_Airport_ID, Des_Airport_ID, Plane_ID, Pilot_ID, Flight_Att_ID)
VALUES
  (1, '2023-11-01 08:00:00', '2023-11-01 10:00:00', 2.00, 1, 101, 'JFK', 'LGA', 1001, 2001, 3001),
  (2, '2023-11-01 09:30:00', '2023-11-01 11:30:00', 2.00, 2, 102, 'ORD', 'JFK', 1002, 2002, 3002),
  (3, '2023-11-01 10:45:00', '2023-11-01 12:15:00', 1.50, 3, 103, 'LAX', 'ORD', 1003, 2003, 3003),
  (4, '2023-11-01 11:15:00', '2023-11-01 13:45:00', 2.50, 4, 104, 'SFO', 'LAX', 1004, 2004, 3004),
  (5, '2023-11-01 12:30:00', '2023-11-01 15:30:00', 3.00, 5, 105, 'DFW', 'SFO', 1005, 2005, 3005),
  (6, '2023-11-01 13:40:00', '2023-11-01 16:20:00', 2.40, 6, 106, 'MIA', 'DFW', 1006, 2006, 3006),
  (7, '2023-11-01 15:15:00', '2023-11-01 18:00:00', 2.75, 7, 107, 'LAS', 'MIA', 1007, 2007, 3007),
  (8, '2023-11-01 16:45:00', '2023-11-01 19:45:00', 3.00, 8, 108, 'ATL', 'LAS', 1008, 2008, 3008),
  (9, '2023-11-01 18:20:00', '2023-11-01 21:10:00', 2.83, 9, 109, 'DEN', 'ATL', 1009, 2009, 3009),
  (10, '2023-11-01 19:45:00', '2023-11-01 22:30:00', 2.75, 10, 110, 'SEA', 'DEN', 1010, 2010, 3010);
select * from Flight;

-- Insert data into mydb.Flight_Attendant_has_Flight
INSERT INTO mydb.Flight_Attendant_has_Flight (connection_id, Flight_Att_ID, Flight_ID, Org_Airport_ID, Des_Airport_ID, Pilot_ID, Plane_ID)
VALUES
  (1, 3001, 1, 'JFK', 'LGA', 2001, 1001),
  (2, 3002, 2, 'ORD', 'JFK', 2002, 1002),
  (3, 3003, 3, 'LAX', 'ORD', 2003, 1003),
  (4, 3004, 4, 'SFO', 'LAX', 2004, 1004),
  (5, 3005, 5, 'DFW', 'SFO', 2005, 1005),
  (6, 3006, 6, 'MIA', 'DFW', 2006, 1006),
  (7, 3007, 7, 'LAS', 'MIA', 2007, 1007),
  (8, 3008, 8, 'ATL', 'LAS', 2008, 1008),
  (9, 3009, 9, 'DEN', 'ATL', 2009, 1009),
  (10, 3010, 10, 'SEA', 'DEN', 2010, 1010);
select * from Flight_Attendant_has_Flight;

SET FOREIGN_KEY_CHECKS=1;
