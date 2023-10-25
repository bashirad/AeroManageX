-- Create the schema
DROP DATABASE IF EXISTS mydb;
CREATE DATABASE IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8;
USE mydb;

-- GET RID OF ALL FOREIGN KEYS EXCEPT BOOKING'S CONFIRMATION_ID
-- Table mydb.Cost
DROP TABLE IF EXISTS mydb.Cost;
CREATE TABLE IF NOT EXISTS mydb.Cost (
  Cost_ID INT NOT NULL,
  Amount INT NOT NULL,
  Distance VARCHAR(45) NULL,
  Season_Of_Year VARCHAR(45) NULL,
  Day_Of_Week VARCHAR(45) NULL,
  Seat_Number VARCHAR(45) NULL,
  PRIMARY KEY (Cost_ID)
);


-- Table mydb.Airline
DROP TABLE IF EXISTS mydb.Airline;
CREATE TABLE IF NOT EXISTS mydb.Airline (
  Airline_ID INT NOT NULL,
  No_Planes INT NULL,
  Plane_ID INT NULL,
  Airport_Gate VARCHAR(45) NULL,
  Num_Employees INT, 
  PRIMARY KEY (Airline_ID),
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


-- Table mydb.Des_Airport
DROP TABLE IF EXISTS mydb.Des_Airport;
CREATE TABLE IF NOT EXISTS mydb.Des_Airport (
  Des_Airport_ID INT NOT NULL,
  Des_Airport_Loc VARCHAR(45) NULL,
  Des_Arrival_Time DATETIME NULL,
  Des_Arrival_Gate VARCHAR(45) NULL,
  Des_Terminal VARCHAR(45) NULL,
  PRIMARY KEY (Des_Airport_ID)
);

-- Table mydb.Org_Airport
DROP TABLE IF EXISTS mydb.Org_Airport;
CREATE TABLE IF NOT EXISTS mydb.Org_Airport (
  Org_Airport_ID INT NOT NULL,
  Org_Airport_Loc VARCHAR(45) NULL,
  Org_Departure_Time DATETIME NULL,
  Org_Departure_Gate VARCHAR(45) NULL,
  Org_Terminal VARCHAR(45) NULL,
  PRIMARY KEY (Org_Airport_ID)
);

-- Table mydb.Flight Attendent
DROP TABLE IF EXISTS mydb.Flight_Attendent;
CREATE TABLE IF NOT EXISTS mydb.Flight_Attendent (
  Flight_Att_ID INT NOT NULL,
  Flight_Att_FName VARCHAR(45) NULL,
  Flight_Att_LName VARCHAR(45) NULL,
  Hire_Date DATETIME NULL,
  Flight_Attendent_DOB DATETIME NULL,
  PRIMARY KEY (Flight_Att_ID)
);

-- Table mydb.Plane
DROP TABLE IF EXISTS mydb.Plane;
CREATE TABLE IF NOT EXISTS mydb.Plane (
  Plane_ID INT NOT NULL,
  Plane_Model VARCHAR(45) NULL,
  Plane_Manufacturer VARCHAR(45) NULL,
  Plane_Size VARCHAR(20),
  Plane_Engine_Power VARCHAR(20),
  PRIMARY KEY (Plane_ID),
);


-- Table mydb.Booking
DROP TABLE IF EXISTS mydb.Booking;
CREATE TABLE IF NOT EXISTS mydb.Booking (
  Confirmation_ID INT NOT NULL,
  Booking_Date DATETIME NULL,
  Booking_Platform VARCHAR(45) NULL,
  Booking_Type VARCHAR(45) NULL,
  PRIMARY KEY (Confirmation_ID),
  FOREIGN KEY (Passenger_ID) REFERENCES Passenger (Passenger_ID),
  );

-- Table mydb.Baggage
DROP TABLE IF EXISTS mydb.Baggage;
CREATE TABLE IF NOT EXISTS mydb.Baggage (
  Baggage_ID VARCHAR(45) NOT NULL,
  Passenger_ID INT NULL,
  Baggage_Weight DECIMAL(2) NULL,
  Baggage_Cost DECIMAL(2) NULL,
  Org_Airport_Loc DATETIME NULL,
  Org_Departure_Time VARCHAR(45) NULL,
  Flight_ID INT NULL,
  Des_Airport_Loc VARCHAR(45) NULL,
  Des_Departure_Time DATETIME NULL,
  Des_Departure_Gate VARCHAR(45) NULL,
  PRIMARY KEY (Baggage_ID),
  FOREIGN KEY (Passenger_ID) REFERENCES Passenger (Passenger_ID)
);

-- Table mydb.Flight
DROP TABLE IF EXISTS mydb.Flight;
CREATE TABLE IF NOT EXISTS mydb.Flight (
  Flight_ID INT NOT NULL,
  Org_Departure_Time DATETIME NULL,
  Des_Arrival_Time DATETIME NULL,
  Flight_Time DECIMAL(2) NULL,
  PRIMARY KEY (Flight_ID),
  FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID),
  FOREIGN KEY (Confirmation_ID) REFERENCES Booking(Confirmation_ID),
  FOREIGN KEY (Org_Airport_ID) REFERENCES Org_Airport (Org_Airport_ID),
  FOREIGN KEY (Des_Airport_ID) REFERENCES Des_Airport (Des_Airport_ID),
  FOREIGN KEY (Plane_ID) REFERENCES Plane (Plane_ID),
  FOREIGN KEY (Pilot_ID) REFERENCES Pilot (Pilot_ID),
  FOREIGN KEY (Flight_Att_ID) REFERENCES Flight_Attendent (Flight_Att_ID)
);

-- Table mydb.Flight_Attendent_has_Flight
DROP TABLE IF EXISTS mydb.Flight_Attendent_has_Flight;
CREATE TABLE IF NOT EXISTS mydb.Flight_Attendent_has_Flight (
  PRIMARY KEY (Flight_Att_ID, Flight_ID, Org_Airport_ID, Des_Airport_ID, Pilot_ID, Plane_ID),
  FOREIGN KEY (Flight_Att_ID) REFERENCES Flight_Attendent (Flight_Att_ID),
  FOREIGN KEY (Flight_ID) REFERENCES Flight (Flight_ID),
  FOREIGN KEY (Org_Airport_ID) REFERENCES Org_Airport (Org_Airport_ID),
  FOREIGN KEY (Des_Airport_ID) REFERENCES Des_Airport (Des_Airport_ID),
  FOREIGN KEY (Pilot_ID) REFERENCES Pilot (Pilot_ID),
  FOREIGN KEY (Plane_ID) REFERENCES Plane (Plane_ID)
);

