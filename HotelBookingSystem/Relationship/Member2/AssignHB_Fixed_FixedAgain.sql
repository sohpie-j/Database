-- Create Hcustomer table
CREATE TABLE HCustomer (
    IDCustomer NUMBER PRIMARY KEY,
    FirstName VARCHAR2(150),
    LastName VARCHAR2(150)
);
CREATE OR REPLACE SEQUENCE HCustomer_Seq START WITH 50 INCREMENT BY 1;
   
-- Create HAddress table
CREATE TABLE HAddress (
    IDAddress NUMBER PRIMARY KEY,
    Street VARCHAR2(100),
    City VARCHAR2(100),
    Province VARCHAR2(50),
    Postcode VARCHAR2(10)
);
CREATE OR REPLACE SEQUENCE HAddress_Seq START WITH 50 INCREMENT BY 1;
 
-- Create HCustomer_Address table
CREATE TABLE HCustomer_Address (
    IDCustomer_Address NUMBER PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    Customer_IDCustomer NUMBER,
    Address_IDAddress NUMBER,
    CONSTRAINT FK_CUSTOMER FOREIGN KEY (Customer_IDCustomer) REFERENCES HCustomer(IDCustomer),
    CONSTRAINT FK_ADDRESS FOREIGN KEY (Address_IDAddress) REFERENCES HAddress(IDAddress)
);
CREATE OR REPLACE SEQUENCE HCustomer_Address_Seq START WITH 50 INCREMENT BY 1;
 
 -- Create HBooking table
CREATE TABLE HBooking (
    IDBooking NUMBER PRIMARY KEY,
    BookingDate DATE,
    TotalAmount DECIMAL(10, 2),
	IDCUSTOMER NUMBER,
    CONSTRAINT FK_BOOKING_CUSTOMER FOREIGN KEY (IDCUSTOMER) REFERENCES HCUSTOMER (IDCUSTOMER)
);
CREATE OR REPLACE SEQUENCE HBooking_Seq START WITH 50 INCREMENT BY 1;

--Create HPAYMENT table
CREATE TABLE HPAYMENT (
    IDPayment NUMBER PRIMARY KEY,
    PaymentDate Date NOT NULL,
    PaymentMethod VARCHAR2(20),
    Amount NUMBER(10, 2) NOT NULL
);
CREATE OR REPLACE SEQUENCE HPAYMENT_Seq START WITH 50 INCREMENT BY 1;

-- Create HBooking_Payment table
CREATE TABLE HBooking_Payment (
    IDBooking_Payment NUMBER PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    BOOKING_IDBOOKING NUMBER,
    PAYMENT_IDPAYMENT NUMBER,
    CONSTRAINT FK_BOOKING FOREIGN KEY (BOOKING_IDBOOKING) REFERENCES HBOOKING (IDBOOKING),
    CONSTRAINT FK_PAYMENT FOREIGN KEY (PAYMENT_IDPAYMENT) REFERENCES HPAYMENT (IDPAYMENT)
);
CREATE OR REPLACE SEQUENCE HBooking_Payment_Seq START WITH 50 INCREMENT BY 1;

-- Create HHotel table
CREATE TABLE HHotel (
    IDHotel NUMBER PRIMARY KEY,
    HotelName VARCHAR2(100),
    BOOKING_IDBOOKING NUMBER,
    CONSTRAINT FK_HOTEL_BOOKING FOREIGN KEY (BOOKING_IDBOOKING) REFERENCES HBOOKING (IDBOOKING)
);
CREATE OR REPLACE SEQUENCE HHotel_Seq START WITH 50 INCREMENT BY 1;
 
-- Create HRoom table
CREATE TABLE HRoom (
    IDRoom NUMBER PRIMARY KEY,
    RoomNumber NUMBER,
    RoomType VARCHAR2(50),
    Hotel_IDHotel NUMBER,
    CONSTRAINT FK_ROOM_HOTEL FOREIGN KEY (HOTEL_IDHOTEL) REFERENCES HHOTEL (IDHOTEL)
);
CREATE OR REPLACE SEQUENCE HHotel_Seq START WITH 50 INCREMENT BY 1;

 
-- Create HHotel_Room table
CREATE TABLE HHotel_Room (
    IDHotel_Room NUMBER PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    Hotel_IDHotel NUMBER,
    Room_IDRoom NUMBER,
    CONSTRAINT FK_HOTEL FOREIGN KEY (HOTEL_IDHOTEL) REFERENCES HHOTEL (IDHOTEL),
    CONSTRAINT FK_ROOM FOREIGN KEY (ROOM_IDROOM) REFERENCES HROOM (IDROOM)
);
CREATE OR REPLACE SEQUENCE HHotel_Room_Seq START WITH 50 INCREMENT BY 1;

-- Insert values into HCustomerName
INSERT INTO HCustomer (IDCustomer, FirstName, LastName) VALUES (1, 'John', 'Doe');
INSERT INTO HCustomer (IDCustomer, FirstName, LastName) VALUES (2, 'Jane', 'Smith');
INSERT INTO HCustomer (IDCustomer, FirstName, LastName) VALUES (3, 'Michael', 'Johnson');
INSERT INTO HCustomer (IDCustomer, FirstName, LastName) VALUES (4, 'Emily', 'Davis');
INSERT INTO HCustomer (IDCustomer, FirstName, LastName) VALUES (5, 'Chris', 'Brown');
 
-- Insert values into HAddress
INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode) VALUES (1, '123 Main St', 'Springfield', 'IL', '62704');
INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode) VALUES (2, '456 Elm St', 'Springfield', 'IL', '62705');
INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode) VALUES (3, '789 Oak St', 'Springfield', 'IL', '62706');
INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode) VALUES (4, '101 Maple St', 'Springfield', 'IL', '62707');
INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode) VALUES (5, '202 Pine St', 'Springfield', 'IL', '62708');
 --

-- Insert values into HCustomer_Address with TO_DATE function for date conversion
INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress) VALUES
(1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 1, 1);
 
INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress) VALUES
(2, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 2, 2);
 
INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress) VALUES
(3, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 3, 3);
 
INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress) VALUES
(4, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 4, 4);
 
INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress) VALUES
(5, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 5, 5);


-- Insert values into HHotel
INSERT INTO HHotel (IDHotel, HotelName) VALUES (1, 'Grand Hotel');
INSERT INTO HHotel (IDHotel, HotelName) VALUES (2, 'Sunset Inn');
INSERT INTO HHotel (IDHotel, HotelName) VALUES (3, 'Ocean View');
INSERT INTO HHotel (IDHotel, HotelName) VALUES (4, 'Mountain Lodge');
INSERT INTO HHotel (IDHotel, HotelName) VALUES (5, 'City Center Hotel');
 
-- Insert values into HRoom
INSERT INTO HRoom (IDRoom, RoomNumber, RoomType, Hotel_IDHotel) VALUES (1, 101, 'Single', 1);
INSERT INTO HRoom (IDRoom, RoomNumber, RoomType, Hotel_IDHotel) VALUES (2, 102, 'Double', 1);
INSERT INTO HRoom (IDRoom, RoomNumber, RoomType, Hotel_IDHotel) VALUES (3, 201, 'Suite', 2);
INSERT INTO HRoom (IDRoom, RoomNumber, RoomType, Hotel_IDHotel) VALUES (4, 301, 'Single', 3);
INSERT INTO HRoom (IDRoom, RoomNumber, RoomType, Hotel_IDHotel) VALUES (5, 302, 'Double', 3);
 
-- Insert values into HHotel_Room with TO_DATE function for date conversion
INSERT INTO HHotel_Room (IDHotel_Room, StartDate, EndDate, Hotel_IDHotel, Room_IDRoom) VALUES
(1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 1, 1);
INSERT INTO HHotel_Room (IDHotel_Room, StartDate, EndDate, Hotel_IDHotel, Room_IDRoom) VALUES
(2, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 1, 2);
INSERT INTO HHotel_Room (IDHotel_Room, StartDate, EndDate, Hotel_IDHotel, Room_IDRoom) VALUES
(3, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 2, 3);
INSERT INTO HHotel_Room (IDHotel_Room, StartDate, EndDate, Hotel_IDHotel, Room_IDRoom) VALUES
(4, TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'), 3, 4);
INSERT INTO HHotel_Room (IDHotel_Room, StartDate, EndDate, Hotel_IDHotel, Room_IDRoom) VALUES
(5, TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-10-31', 'YYYY-MM-DD'), 3, 5);
 
 -- Insert values into HPAYMENT table
INSERT INTO HPAYMENT (IDPayment, PaymentDate, PaymentMethod, Amount)
VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Cash', 150.00);
 
INSERT INTO HPAYMENT (IDPayment, PaymentDate, PaymentMethod, Amount)
VALUES (2, TO_DATE('2024-01-02', 'YYYY-MM-DD'), 'Credit Card', 200.00);
 
INSERT INTO HPAYMENT (IDPayment, PaymentDate, PaymentMethod, Amount)
VALUES (3, TO_DATE('2024-01-03', 'YYYY-MM-DD'), 'Debit', 250.00);
 
INSERT INTO HPAYMENT (IDPayment, PaymentDate, PaymentMethod, Amount)
VALUES (4, TO_DATE('2024-01-04', 'YYYY-MM-DD'), 'Cash', 300.00);
 
INSERT INTO HPAYMENT (IDPayment, PaymentDate, PaymentMethod, Amount)
VALUES (5, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'Credit Card', 350.00);

-- Insert values into HBooking table
INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount, IDCustomer)
VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 150.00, 1);
 
INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount,  IDCustomer)
VALUES (2, TO_DATE('2024-01-02', 'YYYY-MM-DD'), 200.00, 2);
 
INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount,  IDCustomer)
VALUES (3, TO_DATE('2024-01-03', 'YYYY-MM-DD'), 250.00, 3);
 
INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount,  IDCustomer)
VALUES (4, TO_DATE('2024-01-04', 'YYYY-MM-DD'), 300.00, 4);
 
INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount,  IDCustomer)
VALUES (5, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 350.00, 5);

-- Insert values into HBooking_Payment table
INSERT INTO HBooking_Payment (IDBooking_Payment, StartDate, EndDate, Booking_IDBooking, Payment_IDPayment)
VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), NULL, 1, 1);
 
INSERT INTO HBooking_Payment (IDBooking_Payment, StartDate, EndDate, Booking_IDBooking, Payment_IDPayment)
VALUES (2, TO_DATE('2024-01-02', 'YYYY-MM-DD'), NULL, 2, 2);
 
INSERT INTO HBooking_Payment (IDBooking_Payment, StartDate, EndDate, Booking_IDBooking, Payment_IDPayment)
VALUES (3, TO_DATE('2024-01-03', 'YYYY-MM-DD'), NULL, 3, 3);
 
INSERT INTO HBooking_Payment (IDBooking_Payment, StartDate, EndDate, Booking_IDBooking, Payment_IDPayment)
VALUES (4, TO_DATE('2024-01-04', 'YYYY-MM-DD'), NULL, 4, 4);
 
INSERT INTO HBooking_Payment (IDBooking_Payment, StartDate, EndDate, Booking_IDBooking, Payment_IDPayment)
VALUES (5, TO_DATE('2024-01-05', 'YYYY-MM-DD'), NULL, 5, 5);
 