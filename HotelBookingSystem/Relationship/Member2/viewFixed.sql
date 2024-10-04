CREATE VIEW Customer_Address_View AS 
SELECT 
    HCustomer.IDCustomer, 
    HCustomer.FirstName, 
    HCustomer.LastName, 
    HAddress.Street, 
    HAddress.City, 
    HAddress.Province, 
    HAddress.Postcode
FROM 
    HCustomer
JOIN 
    HCustomer_Address ON HCustomer.IDCustomer = HCustomer_Address.Customer_IDCustomer
JOIN 
    HAddress ON HCustomer_Address.Address_IDAddress = HAddress.IDAddress;
-- WHERE HCustomer_Address.EndDate IS NULL;
    

-- View for HHotel and HHotel_Room
CREATE VIEW Hotel_Room_View AS 
SELECT 
    HHotel.IDHotel, 
    HHotel.HotelName, 
    -- HHotel_Room.StartDate, 
    -- HHotel_Room.EndDate, 
    HRoom.RoomNumber, 
    HRoom.RoomType
FROM 
    HHotel
JOIN 
    HHotel_Room ON HHotel.IDHotel = HHotel_Room.Hotel_IDHotel
JOIN 
    HRoom ON HHotel_Room.Room_IDRoom = HRoom.IDRoom 
-- WHERE HHotel_Room.EndDate IS NULL;

-- View for HCustomer and HCustomer_Booking
CREATE VIEW Customer_Booking_View AS 
SELECT 
    HCustomer.IDCustomer, 
    HCustomer.FirstName, 
    HCustomer.LastName, 
    -- HCustomer_Booking.StartDate, 
    -- HCustomer_Booking.EndDate, 
    HBooking.BookingDate, 
    HBooking.TotalAmount
FROM 
    HCustomer
JOIN 
    HCustomer_Booking ON HCustomer.IDCustomer = HCustomer_Booking.Customer_IDCustomer
JOIN 
    HBooking ON HCustomer_Booking.Booking_IDBooking = HBooking.IDBooking 
-- WHERE HCustomer_Booking.EndDate IS NULL;