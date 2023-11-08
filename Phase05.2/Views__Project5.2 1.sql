-- Administrator view  
CREATE VIEW Admin_View AS
SELECT 
    Booking.Confirmation_ID,
    Passenger.Passenger_FName,
    Passenger.Passenger_LName,
    Flight.Org_Departure_Time,
    Flight.Des_Arrival_Time
FROM 
    Booking
JOIN 
    Passenger ON Booking.Passenger_ID = Passenger.Passenger_ID
JOIN 
    Flight ON Booking.Confirmation_ID = Flight.Confirmation_ID;
    
select * from Admin_View;

-- Add Booking view
CREATE VIEW Add_Booking_View AS
SELECT 
    Booking.Confirmation_ID,
    Passenger.Passenger_FName,
    Passenger.Passenger_LName,
    Flight.Org_Departure_Time AS Departure_Time,
    Flight.Des_Arrival_Time AS Arrival_Time,
    Cost.Amount AS Booking_Cost,
    Cost.Distance,
    Cost.Season_Of_Year,
    Cost.Day_Of_Week
FROM 
    Booking
JOIN 
    Passenger ON Booking.Passenger_ID = Passenger.Passenger_ID
JOIN 
    Flight ON Booking.Confirmation_ID = Flight.Confirmation_ID
JOIN 
    Cost ON Booking.Confirmation_ID = Cost.Cost_ID;
    
-- Delete Booking view
CREATE VIEW Delete_Booking_View AS
SELECT 
    Booking.Confirmation_ID,
    Booking.Booking_Date,
    Booking.Booking_Platform,
    Booking.Booking_Type,
    Passenger.Passenger_ID,
    Passenger.Passenger_FName,
    Passenger.Passenger_LName,
    Flight.Flight_ID,
    Flight.Org_Departure_Time,
    Flight.Des_Arrival_Time,
    Cost.Amount AS Booking_Cost
FROM 
    Booking
JOIN 
    Passenger ON Booking.Passenger_ID = Passenger.Passenger_ID
JOIN 
    Flight ON Booking.Confirmation_ID = Flight.Confirmation_ID
JOIN 
    Cost ON Booking.Confirmation_ID = Cost.Cost_ID;
    
    -- Add Flight view
CREATE VIEW Add_Flight_View AS
SELECT 
    Flight.Flight_ID,
    Flight.Org_Departure_Time,
    Flight.Des_Arrival_Time,
    Flight.Flight_Time,
    Pilot.Pilot_ID,
    Pilot.Pilot_FName,
    Pilot.Pilot_LName,
    Plane.Plane_ID,
    Plane.Plane_Model,
    Plane.Plane_Manufacturer,
    Org_Airport.Org_Airport_ID AS Org_Airport_ID,
    Org_Airport.Org_Airport_Loc AS Org_Airport_Location,
    Des_Airport.Des_Airport_ID AS Des_Airport_ID,
    Des_Airport.Des_Airport_Loc AS Des_Airport_Location,
    Flight_Attendent.Flight_Att_ID AS Flight_Attendant_ID,
    Flight_Attendent.Flight_Att_FName AS Flight_Attendant_FName,
    Flight_Attendent.Flight_Att_LName AS Flight_Attendant_LName
FROM 
    Flight
LEFT JOIN 
    Pilot ON Flight.Pilot_ID = Pilot.Pilot_ID
LEFT JOIN 
    Plane ON Flight.Plane_ID = Plane.Plane_ID
LEFT JOIN 
    Org_Airport ON Flight.Org_Airport_ID = Org_Airport.Org_Airport_ID
LEFT JOIN 
    Des_Airport ON Flight.Des_Airport_ID = Des_Airport.Des_Airport_ID
LEFT JOIN 
    Flight_Attendent ON Flight.Flight_Att_ID = Flight_Attendent.Flight_Att_ID;
    
-- Remove Flight view
CREATE VIEW Remove_Flight_View AS
SELECT 
    Flight.Flight_ID,
    Flight.Org_Departure_Time,
    Flight.Des_Arrival_Time,
    Pilot.Pilot_ID,
    Pilot.Pilot_FName,
    Pilot.Pilot_LName,
    Plane.Plane_ID,
    Plane.Plane_Model,
    Org_Airport.Org_Airport_ID AS Org_Airport_ID,
    Org_Airport.Org_Airport_Loc AS Org_Airport_Location,
    Des_Airport.Des_Airport_ID AS Des_Airport_ID,
    Des_Airport.Des_Airport_Loc AS Des_Airport_Location
FROM 
    Flight
LEFT JOIN 
    Pilot ON Flight.Pilot_ID = Pilot.Pilot_ID
LEFT JOIN 
    Plane ON Flight.Plane_ID = Plane.Plane_ID
LEFT JOIN 
    Org_Airport ON Flight.Org_Airport_ID = Org_Airport.Org_Airport_ID
LEFT JOIN 
    Des_Airport ON Flight.Des_Airport_ID = Des_Airport.Des_Airport_ID;
    

    
