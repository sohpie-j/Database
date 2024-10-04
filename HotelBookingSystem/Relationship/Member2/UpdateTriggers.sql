CREATE OR REPLACE TRIGGER Customer_Address_View_Check
INSTEAD OF INSERT OR UPDATE ON Customer_Address_View
FOR EACH ROW
DECLARE
	var_count int;
	var_address_id int;
BEGIN
	-- Check if a row exists for the customer
	SELECT count(*) INTO var_count FROM HCustomer WHERE IDCustomer=:NEW.IDCustomer;
	IF var_count = 1 THEN
		-- If row exists update the customer information
		UPDATE HCustomer SET FirstName=:NEW.FirstName, LastName=:NEW.LastName WHERE IDCustomer=:NEW.IDCustomer;
		-- Expire the current address
		UPDATE HCustomer_Address SET HCustomer_Address.EndDate=SYSDATE WHERE HCustomer_Address.Customer_IDCustomer=:NEW.IDCustomer AND HCustomer_Address.EndDate IS NULL;
	ELSE
		-- Insert the new customer if it does not exist
		INSERT INTO HCustomer VALUES(:NEW.IDCustomer, :NEW.FirstName, :NEW.LastName);
	END IF;
	-- Generate the address sequence number
	SELECT HAddress_Seq.CURRVAL INTO var_address_id FROM dual;
	-- Insert the new address
	INSERT INTO HAddress VALUES(var_address_id,:NEW.Street,:NEW.City,:NEW.Province,:NEW.Postcode);
	-- Relate the new address to the customer and set EndDate to NULL
	INSERT INTO HCustomer_Address VALUES(HCustomer_Address_Seq.CURRVAL,SYSDATE,NULL,:NEW.IDCustomer,var_address_id);
END Customer_Address_View_Check;
/

CREATE OR REPLACE TRIGGER Hotel_Room_View_Check
INSTEAD OF INSERT OR UPDATE ON Hotel_Room_View
FOR EACH ROW
DECLARE
	var_count int;
	var_room_id int;
BEGIN
	-- Check if a row exists for the customer
	SELECT count(*) INTO var_count FROM HHotel WHERE IDHotel=:NEW.IDHotel;
	IF var_count = 1 THEN
		-- If row exists update the customer information
		UPDATE HHotel SET HotelName=:NEW.HotelName WHERE IDHotel=:NEW.IDHotel;
		-- Expire the current address
		UPDATE HHotel_Room SET HHotel_Room.EndDate=SYSDATE WHERE HHotel_Room.Hotel_IDHotel=:NEW.IDHotel AND HHotel_Room.EndDate IS NULL;
	ELSE
		-- Insert the new customer if it does not exist
		INSERT INTO HHotel VALUES(:NEW.IDHotel, :NEW.HotelName);
	END IF;
	-- Generate the address sequence number
	SELECT HRoom_Seq.CURRVAL INTO var_room_id FROM dual;
	-- Insert the new address
	INSERT INTO HRoom VALUES(var_room_id,:NEW.RoomNumber,:NEW.RoomType);
	-- Relate the new address to the customer and set EndDate to NULL
	INSERT INTO HHotel_Room VALUES(HHotel_Room_Seq.CURRVAL,SYSDATE,NULL,:NEW.IDHotel,var_room_id);
END Hotel_Room_View_Check;
/

CREATE OR REPLACE TRIGGER Customer_Booking_View_Check
INSTEAD OF INSERT OR UPDATE ON Customer_Booking_View
FOR EACH ROW
DECLARE
	var_count int;
	var_booking_id int;
BEGIN
	-- Check if a row exists for the customer
	SELECT count(*) INTO var_count FROM HCustomer WHERE IDCustomer=:NEW.IDCustomer;
	IF var_count = 1 THEN
		-- If row exists update the customer information
		UPDATE HCustomer SET FirstName=:NEW.FirstName, LastName=:NEW.LastName WHERE IDCustomer=:NEW.IDCustomer;
		-- Expire the current address
		UPDATE HCustomer_Booking SET HCustomer_Booking.EndDate=SYSDATE WHERE HCustomer_Booking.Customer_IDCustomer=:NEW.IDCustomer AND HCustomer_Booking.EndDate IS NULL;
	ELSE
		-- Insert the new customer if it does not exist
		INSERT INTO HCustomer VALUES(:NEW.IDCustomer, :NEW.FirstName, :NEW.LastName);
	END IF;
	-- Generate the address sequence number
	SELECT HBooking_Seq.CURRVAL INTO var_booking_id FROM dual;
	-- Insert the new address
	INSERT INTO HBooking VALUES(var_booking_id,:NEW.BookingDate,:NEW.TotalAmount);
	-- Relate the new address to the customer and set EndDate to NULL
	INSERT INTO HCustomer_Booking VALUES(HCustomer_Booking_Seq.CURRVAL,SYSDATE,NULL,:NEW.IDCustomer,var_booking_id);
END Customer_Booking_View_Check;
/