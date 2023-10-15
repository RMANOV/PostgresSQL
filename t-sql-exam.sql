--Language:T SQL

-- Tourist Agency
-- Section 1. DDL (30 pts)
-- You have been given the E/R Diagram of the TouristAgency database.
 
-- Create a database called TouristAgency. You need to create 7 tables:
-- •	Countries – contains information about the countries, in which the destinations and hotels are located, each tourist will also has a country;
-- •	Destinations – contains information about the holiday destinations(areas, resorts, etc.);
-- •	Rooms – contains information about the rooms (type of room, count of beds);
-- •	Hotels – contains information about each hotel;
-- •	Tourists – containts information about each tourist, that has booked a room in a hotel;
-- •	Bookings – contains information about each booking;
-- •	HotelsRooms  – mapping table between hotels and rooms;

-- NOTE: Keep in mind that Judge doesn't accept "ALTER" statement and square brackets naming (when the names are not keywords).
-- NOTE: Please keep in mind that in case you have to work with a date, you have to use the exact same data type, described in the models tables. If you don't use the correct type, the Judge system won't accept your submission as correct.

-- You have been tasked to create the tables in the database by the following models:

-- Countries
-- Column Name	Data Type	Constraints
-- Id	Integer from 0 to 2,147,483,647	PK, Unique table identification, Identity
-- Name	String up to 50 symbols, Unicode	Null is not allowed
-- Destinations
-- Column Name	Data Type	Constraints
-- Id	Integer from 0 to 2,147,483,647	PK, Unique table identification, Identity
-- Name	String up to 50 symbols	Null is not allowed
-- CountryId	Integer from 0 to 2,147,483,647	Relationship with table Countries, Null is not allowed
-- Rooms
-- Column Name	Data Type	Constraints
-- Id	Integer from 0 to 2,147,483,647	PK, Unique table identification, Identity
-- Type	String up to 40 symbols	Null is not allowed
-- Price	Decimal, up to 18 digits, 2 of which after the decimal point	Null is not allowed
-- BedCount	Integer from 0 to 2,147,483,647	In range between 0 (exclusive) and 10 (inclusive).
-- Null is not allowed
--  
-- Hotels
-- Column Name	Data Type	Constraints
-- Id	Integer from 0 to 2,147,483,647	PK, Unique table identification, Identity
-- Name	String up to 50 symbols	Null is not allowed
-- DestinationId	Integer from 0 to 2,147,483,647	Relationship with table Destinations, Null is not allowed
-- Tourists
-- Column Name	Data Type	Constraints
-- Id	Integer from 0 to 2,147,483,647	PK, Unique table identification, Identity
-- Name	String up to 80 symbols, Unicode	Null is not allowed
-- PhoneNumber	String up to 20 symbols	Null is not allowed
-- Email	String up to 80 symbols	Null is allowed
-- CountryId	Integer from 0 to 2,147,483,647	Relationship with table Countries, Null is not allowed
-- Bookings
-- Column Name	Data Type	Constraints
-- Id	Integer from 0 to 2,147,483,647	PK, Unique table identification, Identity
-- ArrivalDate	DateTime2	Null is not allowed	
-- DepartureDate	DateTime2	Null is not allowed	
-- AdultsCount	Integer from 0 to 2,147,483,647	In range between 1 (inclusive) and 10 (inclusive).
-- Null is not allowed	
-- ChildrenCount	Integer from 0 to 2,147,483,647	In range between 0 (inclusive) and 9 (inclusive).
-- Null is not allowed	
-- TouristId	Integer from 0 to 2,147,483,647	Relationship with table Tourists, Null is not allowed
-- HotelId	Integer from 0 to 2,147,483,647	Relationship with table Hotels, Null is not allowed
-- RoomId	Integer from 0 to 2,147,483,647	Relationship with table Rooms, Null is not allowed
-- HotelsRooms
-- Column Name	Data Type	Constraints
-- HotelId	Integer from 0 to 2,147,483,647	PK, Unique table identification, Relationship with table Hotels,  Null is not allowed
-- RoomId	Integer from 0 to 2,147,483,647	PK, Unique table identification, Relationship with table Rooms,  Null is not allowed
-- 1.	Database design
-- Submit all of yours CREATE statements to Judge (only the creation of tables).

CREATE TABLE Countries
(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
)

CREATE TABLE Destinations
(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    CountryId INT FOREIGN KEY REFERENCES Countries(Id)
)

CREATE TABLE Rooms
(
    Id INT IDENTITY PRIMARY KEY,
    Type NVARCHAR(40) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    BedCount INT NOT NULL CHECK (BedCount > 0 AND BedCount <= 10)
)

CREATE TABLE Hotels
(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    DestinationId INT FOREIGN KEY REFERENCES Destinations(Id)
)

CREATE TABLE Tourists
(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(80) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    Email NVARCHAR(80),
    CountryId INT FOREIGN KEY REFERENCES Countries(Id)
)

CREATE TABLE Bookings
(
    Id INT IDENTITY PRIMARY KEY,
    ArrivalDate DATETIME2 NOT NULL,
    DepartureDate DATETIME2 NOT NULL,
    AdultsCount INT NOT NULL CHECK (AdultsCount >= 1 AND AdultsCount <= 10),
    ChildrenCount INT NOT NULL CHECK (ChildrenCount >= 0 AND ChildrenCount <= 9),
    TouristId INT FOREIGN KEY REFERENCES Tourists(Id),
    HotelId INT FOREIGN KEY REFERENCES Hotels(Id),
    RoomId INT FOREIGN KEY REFERENCES Rooms(Id)
)

CREATE TABLE HotelsRooms
(
    HotelId INT FOREIGN KEY REFERENCES Hotels(Id),
    RoomId INT FOREIGN KEY REFERENCES Rooms(Id),
    PRIMARY KEY (HotelId, RoomId)
)

-- 2.	Insert
-- Let's insert some sample data into the database. Write a query to add the following records into the corresponding tables. All IDs (Primary Keys) should be auto-generated.
-- Tourists
-- Name	PhoneNumber	Email	CountryId
-- John Rivers	653-551-1555	john.rivers@example.com	6
-- Adeline Aglaé	122-654-8726	adeline.aglae@example.com	2
-- Sergio Ramirez	233-465-2876	s.ramirez@example.com	3
-- Johan Müller	322-876-9826	j.muller@example.com	7
-- Eden Smith	551-874-2234	eden.smith@example.com	6

-- Bookings
-- ArrivalDate	DepartureDate	AdultsCount	ChildrenCount	TouristId	HotelId	RoomId
-- 2024-03-01	2024-03-11	1	0	21	3	5
-- 2023-12-28	2024-01-06	2	1	22	13	3
-- 2023-11-15	2023-11-20	1	2	23	19	7
-- 2023-12-05	2023-12-09	4	0	24	6	4
-- 2024-05-01	2024-05-07	6	0	25	14	6

INSERT INTO Tourists (Name, PhoneNumber, Email, CountryId)
VALUES ('John Rivers', '653-551-1555', 'john.rivers@example.com', 6),
       ('Adeline Aglaé', '122-654-8726', 'adeline.aglae@example.com', 2),
       ('Sergio Ramirez', '233-465-2876', 's.ramirez@example.com', 3),
       ('Johan Müller', '322-876-9826', 'j.muller@example.com', 7),
       ('Eden Smith', '551-874-2234', 'eden.smith@example.com', 6)

INSERT INTO Bookings (ArrivalDate, DepartureDate, AdultsCount, ChildrenCount, TouristId, HotelId, RoomId)
VALUES ('2024-03-01', '2024-03-11', 1, 0, 21, 3, 5),
       ('2023-12-28', '2024-01-06', 2, 1, 22, 13, 3),
       ('2023-11-15', '2023-11-20', 1, 2, 23, 19, 7),
       ('2023-12-05', '2023-12-09', 4, 0, 24, 6, 4),
       ('2024-05-01', '2024-05-07', 6, 0, 25, 14, 6)

-- 3.	Update
-- We've decided to change the departure date of the bookings that are scheduled to arrive in December 2023. 
-- The updated departure date for these bookings should be set to one day later than their original departure date.
-- We need to update the email addresses of tourists, whose names contain "MA". The new value of their email addresses should be set to NULL.

UPDATE Bookings SET DepartureDate = DATEADD(DAY, 1, DepartureDate)
WHERE YEAR(ArrivalDate) = 2023 AND MONTH(ArrivalDate) = 12

UPDATE Tourists SET Email = NULL
WHERE Name LIKE '%MA%'

-- 4.	Delete
-- In table Tourists, delete every tourist, whose Name contains family name "Smith". Keep in mind that there could be foreign key constraint conflicts.

-- UPDATE Bookings SET TouristId = ''
-- WHERE TouristId IN (SELECT Id FROM Tourists WHERE Name LIKE '%Smith%')

-- DELETE FROM Tourists
-- WHERE Name LIKE '%Smith%'

-- ALTER TABLE Bookings DROP CONSTRAINT FK__Bookings__Touris__14B46F20;
-- ALTER TABLE Bookings
-- ADD CONSTRAINT FK__Bookings__Touris__14B46F20 FOREIGN KEY (TouristId)
-- REFERENCES Tourists(Id)
-- ON DELETE CASCADE;

-- DELETE FROM Tourists
-- WHERE Name LIKE '%Smith%'

-- CREATE TABLE Bookings
-- (
--     Id INT IDENTITY PRIMARY KEY,
--     ArrivalDate DATETIME2 NOT NULL,
--     DepartureDate DATETIME2 NOT NULL,
--     AdultsCount INT NOT NULL CHECK (AdultsCount >= 1 AND AdultsCount <= 10),
--     ChildrenCount INT NOT NULL CHECK (ChildrenCount >= 0 AND ChildrenCount <= 9),
--     TouristId INT FOREIGN KEY REFERENCES Tourists(Id),
--     HotelId INT FOREIGN KEY REFERENCES Hotels(Id),
--     RoomId INT FOREIGN KEY REFERENCES Rooms(Id)
-- )

-- SELECT 
--     fk.name AS ForeignKeyName
-- FROM 
--     sys.foreign_keys AS fk
-- INNER JOIN 
--     sys.tables AS t ON fk.parent_object_id = t.object_id
-- WHERE 
--     t.name = 'Bookings' AND 
--     COL_NAME(fk.parent_object_id, 
--              (SELECT fc.parent_column_id 
--               FROM sys.foreign_key_columns AS fc 
--               WHERE fc.constraint_object_id = fk.object_id 
--               AND fc.parent_object_id = t.object_id)) = 'TouristId';

-- ALTER TABLE Bookings DROP CONSTRAINT FK__Bookings__Touris__14B46F20;
-- ALTER TABLE Bookings
-- ADD CONSTRAINT FK__Bookings__Touris__14B46F20 FOREIGN KEY (TouristId)
-- REFERENCES Tourists(Id)
-- ON DELETE CASCADE;

-- DELETE FROM Tourists
-- WHERE Name LIKE '%Smith%'


-- DECLARE @ConstraintName nvarchar(128);
-- SELECT @ConstraintName = fk.name 
-- FROM sys.foreign_keys AS fk
-- INNER JOIN sys.tables AS t ON fk.parent_object_id = t.object_id
-- WHERE t.name = 'Bookings' AND 
-- COL_NAME(fk.parent_object_id, 
--          (SELECT fc.parent_column_id 
--           FROM sys.foreign_key_columns AS fc 
--           WHERE fc.constraint_object_id = fk.object_id 
--           AND fc.parent_object_id = t.object_id)) = 'TouristId';

-- IF @ConstraintName IS NOT NULL
-- BEGIN
--     DECLARE @SQL nvarchar(1000);
--     SET @SQL = 'ALTER TABLE Bookings DROP CONSTRAINT ' + @ConstraintName;
--     EXEC sp_executesql @SQL;
-- END

-- ALTER TABLE Bookings
-- ADD CONSTRAINT FK__Bookings__Touris__14B46F20 FOREIGN KEY (TouristId)
-- REFERENCES Tourists(Id)
-- ON DELETE CASCADE;

-- DELETE FROM Tourists
-- WHERE Name LIKE '%Smith%'

-- UPDATE Bookings
-- SET TouristId = 1
-- WHERE TouristId IN (SELECT Id FROM Tourists WHERE Name LIKE '%Smith%');

-- DELETE FROM Tourists
-- WHERE Name LIKE '%Smith%';

ALTER TABLE Bookings NOCHECK CONSTRAINT ALL

DELETE FROM Tourists
WHERE Name LIKE '%Smith%'

ALTER TABLE Bookings CHECK CONSTRAINT ALL

======

UPDATE Bookings
SET TouristId = 1
WHERE TouristId IN (SELECT Id FROM Tourists WHERE Name LIKE '%Smith%');

DELETE FROM Tourists
WHERE Name LIKE '%Smith%';

-- 5.	Bookings by Price of Room and Arrival Date
-- Select all bookings, ordered by price  of room (descending), then by arrival date (ascending). The arrival date should be formatted in the 'yyyy-MM-dd' format in the query results.
-- Required columns:
-- •	ArrivalDate
-- •	AdultsCount
-- •	ChildrenCount
-- Example
-- ArrivalDate	AdultsCount	ChildrenCount
-- 2023-10-05	3	1
-- 2023-11-19	4	2
-- 2023-12-10	5	1
-- 2023-10-01	2	0

-- Select all bookings, ordered by price  of room (descending), then by arrival date (ascending). 
-- The arrival date should be formatted in the 'yyyy-MM-dd' format in the query results.

-- SELECT FORMAT(ArrivalDate, 'yyyy-MM-dd') AS ArrivalDate, AdultsCount, ChildrenCount
-- FROM Bookings
-- ORDER BY RoomId DESC, ArrivalDate ASC
-- JOIN Rooms ON Bookings.RoomId = Rooms.Id

--1. select from Bookings 
--2. join with Rooms to get the price
--3. order by price descending, then by arrival date ascending
--4. format the arrival date

SELECT FORMAT(ArrivalDate, 'yyyy-MM-dd') AS ArrivalDate, AdultsCount, ChildrenCount
FROM Bookings
JOIN Rooms ON Bookings.RoomId = Rooms.Id
ORDER BY Rooms.Price DESC, ArrivalDate ASC

-- 6.	Hotels by Count of Bookings
-- Select all hotels with "VIP Apartment" available. 
-- Order results by the count of bookings (count of all bookings for the specific hotel, not only for VIP apartment) made for every hotel (descending).
-- Required columns:
-- •	Id
-- •	Name
-- Example
-- Id	Name
-- 5	Saint Ouen Marche Aux Puces
-- 11	Silken Al-Andalaus Palace
-- 20	Kivotos
-- 3	Antica Panada

-- SELECT Hotels.Id, Hotels.Name
-- FROM Hotels
-- JOIN HotelsRooms ON Hotels.Id = HotelsRooms.HotelId
-- JOIN Rooms ON HotelsRooms.RoomId = Rooms.Id
-- JOIN Bookings ON Rooms.Id = Bookings.RoomId
-- WHERE Rooms.Type = 'VIP Apartment'
-- GROUP BY Hotels.Id, Hotels.Name
-- ORDER BY COUNT(Bookings.Id) DESC


--1. select from Hotels
--2. join with HotelsRooms to get the rooms
--3. join with Rooms to get the type
--4. join with Bookings to get the bookings
--5. filter by type
--6. group by hotel id and name
--7. order by count of bookings descending

-- SELECT h.Id, h.Name FROM Hotels h JOIN Rooms r ON h.Id = r.Hotels.Id JOIN Bookings b ON r.Id = b.RoomId WHERE r.Type = 'VIP Apartment' GROUP BY h.Id, h.Name ORDER BY COUNT(b.Id) DESC;

-- SELECT h.Id, h.Name 
-- FROM Hotels h 
-- JOIN HotelsRooms hr ON h.Id = hr.HotelId 
-- JOIN Rooms r ON hr.RoomId = r.Id 
-- JOIN Bookings b ON r.Id = b.RoomId 
-- WHERE r.Type = 'VIP Apartment' 
-- GROUP BY h.Id, h.Name 
-- ORDER BY COUNT(b.Id) DESC;

-- SELECT h.Id, h.Name
-- FROM Hotels h
-- JOIN HotelsRooms hr ON h.Id = hr.Hotels.Id
-- JOIN Rooms r ON hr.RoomId = r.Id
-- JOIN Bookings b ON r.Id = b.RoomId
-- WHERE r.Type = 'VIP Apartment'
-- GROUP BY h.Id, h.Name
-- ORDER BY COUNT(b.Id) DESC

-- Select all hotels with "VIP Apartment" available. 
-- Order results by the count of bookings 

SELECT Hotels.Id, Hotels.Name
FROM Hotels
JOIN HotelsRooms ON Hotels.Id = HotelsRooms.HotelId
JOIN Rooms ON HotelsRooms.RoomId = Rooms.Id
JOIN Bookings ON HotelsRooms.RoomId = Bookings.RoomId
WHERE Rooms.Type = 'VIP Apartment'
GROUP BY Hotels.Id, Hotels.Name
ORDER BY COUNT(Bookings.Id) DESC

--select all hotels and order by the count of bookings
SELECT Hotels.Id, Hotels.Name
FROM Hotels
JOIN HotelsRooms ON Hotels.Id = HotelsRooms.HotelId
JOIN Rooms ON HotelsRooms.RoomId = Rooms.Id
JOIN Bookings ON HotelsRooms.RoomId = Bookings.RoomId
GROUP BY Hotels.Id, Hotels.Name
ORDER BY COUNT(Bookings.Id) DESC
--filter by type
WHERE Rooms.Type = 'VIP Apartment'




****************************************************************************************************************

-- 7.	Tourists without Bookings
-- Select all tourists that haven’t booked a hotel yet. Order them by name (ascending).
-- Required columns:
-- •	Id
-- •	Name
-- •	PhoneNumber
-- Example
-- Id	Name	PhoneNumber
-- 19	Ahmet Yilmaz	777-777-7707
-- 14	Friedrich Weber	434-444-4414

SELECT Id, Name, PhoneNumber
FROM Tourists
WHERE Id NOT IN (SELECT TouristId FROM Bookings)
ORDER BY Name ASC

-- 8.	First 10 Bookings
-- Select the first 10 bookings that will arrive before 2023-12-31. You will need to select the bookings in hotels with odd-numbered IDs. Sort the results in ascending order, first by CountryName, and then by ArrivalDate.
-- Required columns:
-- •	HotelName
-- •	DestinationName
-- •	CountryName
-- Example
-- HotelName	DestinationName	CountryName
-- Royal Promenade des Anglais	Nice	France
-- Saint Ouen Marche Aux Puces	Paris	France
-- Saint Ouen Marche Aux Puces	Paris	France

SELECT TOP 10 Hotels.Name AS HotelName, Destinations.Name AS DestinationName, Countries.Name AS CountryName
FROM Bookings
JOIN Hotels ON Bookings.HotelId = Hotels.Id
JOIN Destinations ON Hotels.DestinationId = Destinations.Id
JOIN Countries ON Destinations.CountryId = Countries.Id
WHERE ArrivalDate < '2023-12-31' AND Hotels.Id % 2 = 1
ORDER BY CountryName ASC, ArrivalDate ASC

-- 9.	Tourists booked in Hotels
-- Select all of the tourists that have a name, not ending in "EZ", and display the names of the hotels, that they have booked a room in. Order by the price of the room (descending).
-- Required columns:
-- •	HotelName
-- •	RoomPrice
-- Example
-- HotelName	RoomPrice
-- Kivotos	600.00
-- Silken Al-Andalaus Palace	280.50
-- Liebesbier Urban Art & Smart Hotel	280.50
-- Anklamer Hof	250.00
-- Silken Al-Andalaus Palace	250.00
-- Silken Al-Andalaus Palace	250.00

SELECT Hotels.Name AS HotelName, Rooms.Price AS RoomPrice
FROM Tourists
JOIN Bookings ON Tourists.Id = Bookings.TouristId
JOIN Hotels ON Bookings.HotelId = Hotels.Id
JOIN Rooms ON Bookings.RoomId = Rooms.Id
WHERE Tourists.Name NOT LIKE '%EZ'
ORDER BY Rooms.Price DESC

-- 10.	Hotels Revenue
-- In this task, you will write an SQL query to calculate the total price of all bookings for each hotel based on the room price and the number of nights guests have stayed. The result should list the hotel names and their corresponding revenue.
-- •	Foreach Booking you should join data for the Hotel and the Room, using the Id references;
-- •	NightsCount – you will need the ArrivalDate and DepartureDate for a DATEDIFF function;
-- •	Calculate the TotalRevenue by summing the price of each booking, using Price of the Room that is referenced to the specific Booking and multiply it by the NightsCount. 
-- •	Group all the bookings by HotelName using the reference to the Hotel. 
-- •	Order the results by TotalRevenue in descending order.
-- Required columns:
-- •	HotelName
-- •	TotalRevenue
-- Example
-- HotelName	HotelRevenue
-- Bonvecchiati	10521.50
-- Kivotos	6530.00
-- Cavo Tagoo	3666.75
-- Silken Al-Andalaus Palace	3507.00

SELECT Hotels.Name AS HotelName, SUM(Rooms.Price * DATEDIFF(DAY, Bookings.ArrivalDate, Bookings.DepartureDate)) AS TotalRevenue
FROM Bookings
JOIN Hotels ON Bookings.HotelId = Hotels.Id
JOIN Rooms ON Bookings.RoomId = Rooms.Id
GROUP BY Hotels.Name
ORDER BY TotalRevenue DESC

-- 11.	Rooms with Tourists
-- Create a user-defined function, named udf_RoomsWithTourists(@name) that receives a room's type.
-- The function should return the total number of tourists that the specific room type has been booked for (adults + children).
-- Hint: A Double Room could be booked for: 2 adults + 0 children, 1 adult + 1 children, 1 adult + 0 children.
-- Example
-- Query
-- SELECT dbo.udf_RoomsWithTourists('Double Room')
-- Output
-- 17

CREATE FUNCTION udf_RoomsWithTourists(@name NVARCHAR(40))
RETURNS INT
AS
BEGIN
    DECLARE @result INT
    SELECT @result = SUM(AdultsCount + ChildrenCount)
    FROM Bookings
    JOIN Rooms ON Bookings.RoomId = Rooms.Id
    WHERE Rooms.Type = @name
    RETURN @result
END

-- 12.	Search for Tourists from a Specific Country
-- Create a stored procedure, named usp_SearchByCountry(@country) that receives a country name. The procedure must print full information about all tourists that have an booked a room and have origin from the given country: Name, PhoneNumber, Email and CountOfBookings (the count of all bookings made). Order them by Name (ascending) and CountOfBookings (decending).
-- Example
-- Query
-- EXEC usp_SearchByCountry 'Greece'
-- Output
-- Name	PhoneNumber	Email	CountOfBookings
-- Maria Papadopoulou	333-303-3333	maria.papadopoulou@example.com	3
-- Nikos Papadopoulos	303-323-3333	nikos.papadopoulos@example.com	3

-- CREATE PROCEDURE usp_SearchByCountry
--     @country NVARCHAR(50)
-- AS
-- BEGIN
--     SELECT Tourists.Name, Tourists.PhoneNumber, Tourists.Email, COUNT(Bookings.Id) AS CountOfBookings
--     FROM Tourists
--     JOIN Bookings ON Tourists.Id = Bookings.TouristId
--     JOIN Hotels ON Bookings.HotelId = Hotels.Id
--     JOIN Destinations ON Hotels.DestinationId = Destinations.Id
--     JOIN Countries ON Destinations.CountryId = Countries.Id
--     WHERE Countries.Name = @country
--     GROUP BY Tourists.Name, Tourists.PhoneNumber, Tourists.Email
--     ORDER BY Tourists.Name ASC, CountOfBookings DESC
-- END

-- ================================================================================================================
-- CREATE PROCEDURE usp_SearchByCountry
--     @country NVARCHAR(50)
-- AS
-- BEGIN
--     SET NOCOUNT ON;
    
--     DECLARE @rowCount INT;

--     CREATE TABLE #TempTable (
--         Name NVARCHAR(100),
--         PhoneNumber NVARCHAR(20),
--         Email NVARCHAR(100),
--         CountOfBookings INT
--     );

--     INSERT INTO #TempTable(Name, PhoneNumber, Email, CountOfBookings)
--     SELECT 
--         Tourists.Name, 
--         Tourists.PhoneNumber, 
--         Tourists.Email, 
--         COUNT(Bookings.Id) AS CountOfBookings
--     FROM 
--         Tourists
--     JOIN 
--         Bookings ON Tourists.Id = Bookings.TouristId
--     JOIN 
--         Countries ON Bookings.CountryId = Countries.Id
--     WHERE 
--         Countries.Name = @country
--     GROUP BY 
--         Tourists.Name, Tourists.PhoneNumber, Tourists.Email
--     ORDER BY 
--         Tourists.Name ASC, CountOfBookings DESC;

--     SET @rowCount = @@ROWCOUNT;

--     IF @rowCount = 0
--     BEGIN
--         PRINT 'No tourists found from the specified country.';
--     END
--     ELSE
--     BEGIN
--         SELECT * FROM #TempTable;
--     END

--     DROP TABLE #TempTable;
    
--     SET NOCOUNT OFF;
-- END

-- 1. select from Tourists only the tourists from the specified country
-- 2. join with Bookings to get the count of bookings
-- 3. join with Hotels to get the destination

-- create procedure usp_SearchByCountry
--     @country nvarchar(50)
-- as
-- BEGIN
--     select Tourists.Name, Tourists.PhoneNumber, Tourists.Email, count(Bookings.Id) as CountOfBookings
--     from Tourists
--     join Bookings on Tourists.Id = Bookings.TouristId
--     join Hotels on Bookings.HotelId = Hotels.Id
--     join Destinations on Hotels.DestinationId = Destinations.Id
--     join Countries on Destinations.CountryId = Countries.Id
--     where Countries.Name = @country
--     group by Tourists.Name, Tourists.PhoneNumber, Tourists.Email
--     order by Tourists.Name asc, CountOfBookings desc
-- END

CREATE PROCEDURE usp_SearchByCountry  
@country nvarchar(50)
AS
BEGIN
  SELECT 
    T.Name,
    T.PhoneNumber,
    T.Email,
    COUNT(B.Id) AS CountOfBookings
  FROM Tourists T
  JOIN Bookings B ON T.Id = B.TouristId
  JOIN Hotels H ON B.HotelId = H.Id
  JOIN Destinations D ON H.DestinationId = D.Id
  JOIN Countries C ON D.CountryId = C.Id
  -- Add this join condition
  WHERE T.CountryId = (SELECT Id FROM Countries WHERE Name = @country)
  GROUP BY T.Name, T.PhoneNumber, T.Email
  ORDER BY T.Name ASC, CountOfBookings DESC;
END


-- 6.	Hotels by Count of Bookings
-- Select all hotels with "VIP Apartment" available. 
-- Order results by the count of bookings (count of all bookings for the specific hotel, not only for VIP apartment) made for every hotel (descending).
-- Required columns:
-- •	Id
-- •	Name
-- Example
-- Id	Name
-- 5	Saint Ouen Marche Aux Puces
-- 11	Silken Al-Andalaus Palace
-- 20	Kivotos
-- 3	Antica Panada

SELECT Hotels.Id, Hotels.Name
FROM Hotels
JOIN HotelsRooms ON Hotels.Id = HotelsRooms.HotelId
JOIN Rooms ON HotelsRooms.RoomId = Rooms.Id
JOIN Bookings ON HotelsRooms.RoomId = Bookings.RoomId
WHERE Rooms.Type = 'VIP Apartment'
GROUP BY Hotels.Id, Hotels.Name
ORDER BY COUNT(Bookings.Id) DESC

SELECT H.Id, H.Name
FROM Hotels H
JOIN HotelsRooms HR ON H.Id = HR.HotelId
JOIN Rooms R ON HR.RoomId = R.Id
WHERE R.Type = 'VIP Apartment'
GROUP BY H.Id, H.Name
ORDER BY COUNT(Bookings.Id) DESC


-- Subquery to calculate total bookings for each hotel
WITH TotalBookings AS (
    SELECT Hotels.Id AS HotelId, COUNT(Bookings.Id) AS TotalBookingCount
    FROM Hotels
    JOIN HotelsRooms ON Hotels.Id = HotelsRooms.HotelId
    JOIN Bookings ON HotelsRooms.RoomId = Bookings.RoomId
    GROUP BY Hotels.Id

-- Main query
SELECT Hotels.Id, Hotels.Name, COUNT(Bookings.Id) AS TotalBookingCount
FROM Hotels
JOIN HotelsRooms ON Hotels.Id = HotelsRooms.HotelId
JOIN Rooms ON HotelsRooms.RoomId = Rooms.Id
JOIN Bookings ON HotelsRooms.RoomId = Bookings.RoomId
WHERE Rooms.Type = 'VIP Apartment'
GROUP BY Hotels.Id, Hotels.Name
ORDER BY COUNT(Bookings.Id) DESC;
