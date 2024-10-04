CREATE OR REPLACE FORCE EDITIONABLE VIEW "KYUNGAUSER"."HCUSTOMER_ADDRESS_VIEW" ("IDCUSTOMER", "CUSTOMERNAME", "FULLADDRESS", "ADDRESSDURATION") AS 
  SELECT 
    HCustomer.IDCustomer, 
    HCustomer.FirstName || ' ' || HCustomer.LastName AS CustomerName, 
    HAddress.Street || ', ' || HAddress.City || ', ' || HAddress.Province || ', ' || HAddress.Postcode AS FullAddress,
    TO_CHAR(HCustomer_Address.StartDate, 'YYYY-MM-DD') || ' to ' || 
    COALESCE(TO_CHAR(HCustomer_Address.EndDate, 'YYYY-MM-DD'), 'Present') AS AddressDuration
FROM 
    HCustomer
JOIN 
    HCustomer_Address ON HCustomer.IDCustomer = HCustomer_Address.Customer_IDCustomer
JOIN 
    HAddress ON HCustomer_Address.Address_IDAddress = HAddress.IDAddress;

    

-- View for HHotel and HHotel_Room
CREATE OR REPLACE FORCE EDITIONABLE VIEW "KYUNGAUSER"."HOTEL_ROOM_VIEW" ("IDHOTEL", "HOTELROOMINFO", "ROOMDURATION") AS 
SELECT 
    HHotel.IDHotel, 
    HHotel.HotelName || ' - Room ' || HRoom.RoomNumber || ' (' || HRoom.RoomType || ')' AS HotelRoomInfo,
    TO_CHAR(HHotel_Room.StartDate, 'YYYY-MM-DD') || ' to ' || 
    COALESCE(TO_CHAR(HHotel_Room.EndDate, 'YYYY-MM-DD'), 'Present') AS RoomDuration
FROM 
    HHotel
JOIN 
    HHotel_Room ON HHotel.IDHotel = HHotel_Room.Hotel_IDHotel
JOIN 
    HRoom ON HHotel_Room.Room_IDRoom = HRoom.IDRoom;

-- View for HCustomer and HCustomer_Booking
CREATE VIEW Customer_Booking_View AS 
SELECT 
    HCustomer.IDCustomer, 
    HCustomer.FirstName, 
    HCustomer.LastName, 
    HBooking.BookingDate, 
    HBooking.TotalAmount,
    HCustomer_Booking.StartDate, 
    HCustomer_Booking.EndDate, 
FROM 
    HCustomer
JOIN 
    HCustomer_Booking ON HCustomer.IDCustomer = HCustomer_Booking.Customer_IDCustomer
JOIN 
    HBooking ON HCustomer_Booking.Booking_IDBooking = HBooking.IDBooking 
-- WHERE HCustomer_Booking.EndDate IS NULL;