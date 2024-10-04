-- Testing and Verification
-- 1.	Create the sequences.
-- 2.	Create the historical tables.
-- 3.	Create the triggers for each table.
-- 4.	Perform INSERT, UPDATE, and DELETE operations on the main tables.

-- Verify the historical tables to ensure they capture the changes correctly.
-- These steps and SQL scripts will allow you to maintain a history of changes for the fields in your tables, 
-- ensuring that you have a record of all updates with timestamps indicating when each value was valid.

-- 1. [Create Sequences]
-- Sequence for HCustomer
CREATE SEQUENCE HCustomer_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HAddress
CREATE SEQUENCE HAddress_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HCustomer_Address
CREATE SEQUENCE HCustomer_Address_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HBooking
CREATE SEQUENCE HBooking_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HPAYMENT
CREATE SEQUENCE HPAYMENT_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HBooking_Payment
CREATE SEQUENCE HBooking_Payment_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HHotel
CREATE SEQUENCE HHotel_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HRoom
CREATE SEQUENCE HRoom_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for HHotel_Room
CREATE SEQUENCE HHotel_Room_SEQ
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- [2. Creat Historical Tables]
-- Historical table for HCustomer
CREATE TABLE HCustomer_History (
    HistoryID NUMBER PRIMARY KEY,
    IDCustomer NUMBER,
    FirstName VARCHAR2(150),
    LastName VARCHAR2(150),
    StartTime DATE,
    EndTime DATE
);

-- Historical table for HAddress
CREATE TABLE HAddress_History (
    HistoryID NUMBER PRIMARY KEY,
    IDAddress NUMBER,
    Street VARCHAR2(100),
    City VARCHAR2(100),
    Province VARCHAR2(50),
    Postcode VARCHAR2(10),
    StartTime DATE,
    EndTime DATE
);

-- Historical table for HCustomer_Address
CREATE TABLE HCustomer_Address_History (
    HistoryID NUMBER PRIMARY KEY,
    IDCustomer_Address NUMBER,
    StartDate DATE,
    EndDate DATE,
    Customer_IDCustomer NUMBER,
    Address_IDAddress NUMBER,
    StartTime DATE,
    EndTime DATE
);

-- Historical table for HBooking
CREATE TABLE HBooking_History (
    HistoryID NUMBER PRIMARY KEY,
    IDBooking NUMBER,
    BookingDate DATE,
    TotalAmount DECIMAL(10, 2),
    IDCUSTOMER NUMBER,
    StartTime DATE,
    EndTime DATE
);

-- Historical table for HPAYMENT
CREATE TABLE HPAYMENT_History (
    HistoryID NUMBER PRIMARY KEY,
    IDPayment NUMBER,
    PaymentDate Date,
    PaymentMethod VARCHAR2(20),
    Amount NUMBER(10, 2),
    StartTime DATE,
    EndTime DATE
);

-- Historical table for HBooking_Payment
CREATE TABLE HBooking_Payment_History (
    HistoryID NUMBER PRIMARY KEY,
    IDBooking_Payment NUMBER,
    StartDate DATE,
    EndDate DATE,
    BOOKING_IDBOOKING NUMBER,
    PAYMENT_IDPAYMENT NUMBER,
);

-- Historical table for HHotel
CREATE TABLE HHotel_History (
    HistoryID NUMBER PRIMARY KEY,
    IDHotel NUMBER,
    HotelName VARCHAR2(100),
    BOOKING_IDBOOKING NUMBER,
    StartTime DATE,
    EndTime DATE
);

-- Historical table for HRoom
CREATE TABLE HRoom_History (
    HistoryID NUMBER PRIMARY KEY,
    IDRoom NUMBER,
    RoomNumber NUMBER,
    RoomType VARCHAR2(50),
    Hotel_IDHotel NUMBER,
    StartTime DATE,
    EndTime DATE
);

-- Historical table for HHotel_Room
CREATE TABLE HHotel_Room_History (
    HistoryID NUMBER PRIMARY KEY,
    IDHotel_Room NUMBER,
    StartDate DATE,
    EndDate DATE,
    Hotel_IDHotel NUMBER,
    Room_IDRoom NUMBER,
    StartTime DATE,
    EndTime DATE
);

-- [3. Creating Triggers]
CREATE OR REPLACE TRIGGER trg_HCustomer_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HCustomer
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HCustomer_History (
            HistoryID, IDCustomer, FirstName, LastName, StartTime, EndTime
        ) VALUES (
            HCustomer_SEQ.CURRVAL, :NEW.IDCustomer, :NEW.FirstName, :NEW.LastName, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HCustomer_History
        SET EndTime = SYSDATE
        WHERE IDCustomer = :OLD.IDCustomer
        AND EndTime IS NULL;
        
        INSERT INTO HCustomer_History (
            HistoryID, IDCustomer, FirstName, LastName, StartTime, EndTime
        ) VALUES (
            HCustomer_SEQ.CURRVAL, :NEW.IDCustomer, :NEW.FirstName, :NEW.LastName, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HCustomer_History
        SET EndTime = SYSDATE
        WHERE IDCustomer = :OLD.IDCustomer
        AND EndTime IS NULL;
    END IF;
END;
/

-- [Trigger for HAddress]
CREATE OR REPLACE TRIGGER trg_HAddress_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HAddress
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HAddress_History (
            HistoryID, IDAddress, Street, City, Province, Postcode, StartTime, EndTime
        ) VALUES (
            HAddress_SEQ.CURRVAL, :NEW.IDAddress, :NEW.Street, :NEW.City, :NEW.Province, :NEW.Postcode, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HAddress_History
        SET EndTime = SYSDATE
        WHERE IDAddress = :OLD.IDAddress
        AND EndTime IS NULL;
        
        INSERT INTO HAddress_History (
            HistoryID, IDAddress, Street, City, Province, Postcode, StartTime, EndTime
        ) VALUES (
            HAddress_SEQ.CURRVAL, :NEW.IDAddress, :NEW.Street, :NEW.City, :NEW.Province, :NEW.Postcode, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HAddress_History
        SET EndTime = SYSDATE
        WHERE IDAddress = :OLD.IDAddress
        AND EndTime IS NULL;
    END IF;
END;
/

-- [Trigger for HCustomer_Address]
CREATE OR REPLACE TRIGGER trg_HCustomer_Address_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HCustomer_Address
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HCustomer_Address_History (
            HistoryID, IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress, StartTime, EndTime
        ) VALUES (
            HCustomer_Address_SEQ.CURRVAL, :NEW.IDCustomer_Address, :NEW.StartDate, :NEW.EndDate, :NEW.Customer_IDCustomer, :NEW.Address_IDAddress, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HCustomer_Address_History
        SET EndTime = SYSDATE
        WHERE IDCustomer_Address = :OLD.IDCustomer_Address
        AND EndTime IS NULL;
        
        INSERT INTO HCustomer_Address_History (
            HistoryID, IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress, StartTime, EndTime
        ) VALUES (
            HCustomer_Address_SEQ.CURRVAL, :NEW.IDCustomer_Address, :NEW.StartDate, :NEW.EndDate, :NEW.Customer_IDCustomer, :NEW.Address_IDAddress, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HCustomer_Address_History
        SET EndTime = SYSDATE
        WHERE IDCustomer_Address = :OLD.IDCustomer_Address
        AND EndTime IS NULL;
    END IF;
END;
/

-- [Trigger for HBooking]
CREATE OR REPLACE TRIGGER trg_HBooking_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HBooking
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HBooking_History (
            HistoryID, IDBooking, BookingDate, TotalAmount, IDCUSTOMER, StartTime, EndTime
        ) VALUES (
            HBooking_SEQ.CURRVAL, :NEW.IDBooking, :NEW.BookingDate, :NEW.TotalAmount, :NEW.IDCUSTOMER, SYSDATE, NULL
        );
        
    ELSIF UPDATING THEN
        -- Update EndTime for the existing record before inserting a new history record
        UPDATE HBooking_History
        SET EndTime = SYSDATE
        WHERE IDBooking = :OLD.IDBooking
        AND EndTime IS NULL;
        
        -- Insert new history record
        INSERT INTO HBooking_History (
            HistoryID, IDBooking, BookingDate, TotalAmount, IDCUSTOMER, StartTime, EndTime
        ) VALUES (
            HBooking_SEQ.CURRVAL, :NEW.IDBooking, :NEW.BookingDate, :NEW.TotalAmount, :NEW.IDCUSTOMER, SYSDATE, NULL
        );
        
    ELSIF DELETING THEN
        -- Update EndTime for the record being deleted
        UPDATE HBooking_History
        SET EndTime = SYSDATE
        WHERE IDBooking = :OLD.IDBooking
        AND EndTime IS NULL;
        
    END IF;
END;
/

-- [Trigger for HPAYMENT]
CREATE OR REPLACE TRIGGER trg_HPAYMENT_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HPAYMENT
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HPAYMENT_History (
            HistoryID, IDPayment, PaymentDate, PaymentMethod, Amount, StartTime, EndTime
        ) VALUES (
            HPAYMENT_SEQ.CURRVAL, :NEW.IDPayment, :NEW.PaymentDate, :NEW.PaymentMethod, :NEW.Amount, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HPAYMENT_History
        SET EndTime = SYSDATE
        WHERE IDPayment = :OLD.IDPayment
        AND EndTime IS NULL;
        
        INSERT INTO HPAYMENT_History (
            HistoryID, IDPayment, PaymentDate, PaymentMethod, Amount, StartTime, EndTime
        ) VALUES (
            HPAYMENT_SEQ.CURRVAL, :NEW.IDPayment, :NEW.PaymentDate, :NEW.PaymentMethod, :NEW.Amount, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HPAYMENT_History
        SET EndTime = SYSDATE
        WHERE IDPayment = :OLD.IDPayment
        AND EndTime IS NULL;
    END IF;
END;
/
-- [Trigger for HBooking_Payment]
CREATE OR REPLACE TRIGGER trg_HBooking_Payment_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HBooking_Payment
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HBooking_Payment_History (
            HistoryID, IDBooking_Payment, StartDate, EndDate, BOOKING_IDBOOKING, PAYMENT_IDPAYMENT, StartTime, EndTime
        ) VALUES (
            HBooking_Payment_SEQ.CURRVAL, :NEW.IDBooking_Payment, :NEW.StartDate, :NEW.EndDate, :NEW.BOOKING_IDBOOKING, :NEW.PAYMENT_IDPAYMENT, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HBooking_Payment_History
        SET EndTime = SYSDATE
        WHERE IDBooking_Payment = :OLD.IDBooking_Payment
        AND EndTime IS NULL;
        
        INSERT INTO HBooking_Payment_History (
            HistoryID, IDBooking_Payment, StartDate, EndDate, BOOKING_IDBOOKING, PAYMENT_IDPAYMENT, StartTime, EndTime
        ) VALUES (
            HBooking_Payment_SEQ.CURRVAL, :NEW.IDBooking_Payment, :NEW.StartDate, :NEW.EndDate, :NEW.BOOKING_IDBOOKING, :NEW.PAYMENT_IDPAYMENT, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HBooking_Payment_History
        SET EndTime = SYSDATE
        WHERE IDBooking_Payment = :OLD.IDBooking_Payment
        AND EndTime IS NULL;
    END IF;
END;
/
-- [Trigger for HHotel]
CREATE OR REPLACE TRIGGER trg_HHotel_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HHotel
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HHotel_History (
            HistoryID, IDHotel, HotelName, BOOKING_IDBOOKING, StartTime, EndTime
        ) VALUES (
            HHotel_SEQ.CURRVAL, :NEW.IDHotel, :NEW.HotelName, :NEW.BOOKING_IDBOOKING, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HHotel_History
        SET EndTime = SYSDATE
        WHERE IDHotel = :OLD.IDHotel
        AND EndTime IS NULL;
        
        INSERT INTO HHotel_History (
            HistoryID, IDHotel, HotelName, BOOKING_IDBOOKING, StartTime, EndTime
        ) VALUES (
            HHotel_SEQ.CURRVAL, :NEW.IDHotel, :NEW.HotelName, :NEW.BOOKING_IDBOOKING, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HHotel_History
        SET EndTime = SYSDATE
        WHERE IDHotel = :OLD.IDHotel
        AND EndTime IS NULL;
    END IF;
END;
/

-- [Trigger for HRoom]
CREATE OR REPLACE TRIGGER trg_HRoom_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HRoom
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HRoom_History (
            HistoryID, IDRoom, RoomNumber, RoomType, Hotel_IDHotel, StartTime, EndTime
        ) VALUES (
            HRoom_SEQ.CURRVAL, :NEW.IDRoom, :NEW.RoomNumber, :NEW.RoomType, :NEW.Hotel_IDHotel, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HRoom_History
        SET EndTime = SYSDATE
        WHERE IDRoom = :OLD.IDRoom
        AND EndTime IS NULL;
        
        INSERT INTO HRoom_History (
            HistoryID, IDRoom, RoomNumber, RoomType, Hotel_IDHotel, StartTime, EndTime
        ) VALUES (
            HRoom_SEQ.CURRVAL, :NEW.IDRoom, :NEW.RoomNumber, :NEW.RoomType, :NEW.Hotel_IDHotel, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HRoom_History
        SET EndTime = SYSDATE
        WHERE IDRoom = :OLD.IDRoom
        AND EndTime IS NULL;
    END IF;
END;
/
-- [Trigger for HHotel_Room]
CREATE OR REPLACE TRIGGER trg_HHotel_Room_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HHotel_Room
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HHotel_Room_History (
            HistoryID, IDHotel_Room, StartDate, EndDate, Hotel_IDHotel, Room_IDRoom, StartTime, EndTime
        ) VALUES (
            HHotel_Room_SEQ.CURRVAL, :NEW.IDHotel_Room, :NEW.StartDate, :NEW.EndDate, :NEW.Hotel_IDHotel, :NEW.Room_IDRoom, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HHotel_Room_History
        SET EndTime = SYSDATE
        WHERE IDHotel_Room = :OLD.IDHotel_Room
        AND EndTime IS NULL;
        
        INSERT INTO HHotel_Room_History (
            HistoryID, IDHotel_Room, StartDate, EndDate, Hotel_IDHotel, Room_IDRoom, StartTime, EndTime
        ) VALUES (
            HHotel_Room_SEQ.CURRVAL, :NEW.IDHotel_Room, :NEW.StartDate, :NEW.EndDate, :NEW.Hotel_IDHotel, :NEW.Room_IDRoom, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HHotel_Room_History
        SET EndTime = SYSDATE
        WHERE IDHotel_Room = :OLD.IDHotel_Room
        AND EndTime IS NULL;
    END IF;
END;
/
