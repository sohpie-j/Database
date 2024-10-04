CREATE OR REPLACE PROCEDURE InsertCustomer(
    p_firstname IN VARCHAR2,
    p_lastname IN VARCHAR2,
    p_street IN VARCHAR2,
    p_city IN VARCHAR2,
    p_province IN VARCHAR2,
    p_postcode IN VARCHAR2
) IS
    v_idcustomer NUMBER;
    v_idaddress NUMBER;
BEGIN
    -- -- Insert into HCustomer
    INSERT INTO HCustomer (IDCustomer, FirstName, LastName)
    VALUES (HCustomer_SEQ.NEXTVAL, p_firstname, p_lastname)
    RETURNING IDCustomer INTO v_idcustomer;
    
    -- Insert into HAddress
    INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode)
    VALUES (HCustomer_SEQ.CURRVAL, p_street, p_city, p_province, p_postcode)
    RETURNING IDAddress INTO v_idaddress;
    
    -- Insert into HCustomer_Address
    INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress)
    VALUES (HCustomer_SEQ.NEXTVAL, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), HCustomer_SEQ.CURRVAL, HCustomer_SEQ.CURRVAL);

    -- -- Insert into HCustomer if the record doesn't exist
    -- INSERT INTO HCustomer (IDCustomer, FirstName, LastName)
    -- VALUES (HCustomer_SEQ.NEXTVAL, 'Louse', 'Doftman');

    -- -- Insert into HAddress if the record doesn't exist
    -- INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode)
    -- VALUES (HAddress_SEQ.NEXTVAL, '123 Ellisson St', 'Oregan', 'CA', '12345');

    -- -- testing trigger for insert
    -- INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress)
    -- VALUES (HCustomer_Address_SEQ.NEXTVAL, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-03', 'YYYY-MM-DD'), HAddress_SEQ.CURRVAL, HAddress_SEQ.CURRVAL);
        
    COMMIT;
END InsertCustomer;

----

CREATE OR REPLACE PROCEDURE UpdateCustomer(
    p_idcustomer IN NUMBER,
    p_firstname IN VARCHAR2,
    p_lastname IN VARCHAR2,
    p_street IN VARCHAR2,
    p_city IN VARCHAR2,
    p_province IN VARCHAR2,
    p_postcode IN VARCHAR2
) IS
    v_idaddress NUMBER;
BEGIN
    -- Update the HCustomer table
    UPDATE HCustomer
    SET FirstName = p_firstname,
        LastName = p_lastname
    WHERE IDCustomer = p_idcustomer;
    
    -- Update the HCustomer_Address end date
    UPDATE HCustomer_Address
    SET EndDate = SYSDATE
    WHERE Customer_IDCustomer = p_idcustomer
    AND EndDate IS NULL;
    
    -- Insert the new address into the HAddress table
    INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode)
    VALUES (HAddress_SEQ.NEXTVAL, p_street, p_city, p_province, p_postcode)
    RETURNING IDAddress INTO v_idaddress;
    
    -- Insert a new record into the HCustomer_Address table with the new address
    INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress)
    VALUES (HCustomer_Address_SEQ.NEXTVAL, SYSDATE, NULL, p_idcustomer, v_idaddress);
    
    COMMIT;
END UpdateCustomer;

-----
CREATE OR REPLACE PROCEDURE DeleteCustomer(
    p_idcustomer IN NUMBER
) IS
BEGIN
    -- Delete from HCustomer_Address
    DELETE FROM HCustomer_Address
    WHERE Customer_IDCustomer = p_idcustomer;
    
    -- Delete from HCustomer
    DELETE FROM HCustomer
    WHERE IDCustomer = p_idcustomer;
    
    COMMIT;
END DeleteCustomer;


-----Trigger SQL

CREATE OR REPLACE TRIGGER TRG_CUSTOMER_VIEW_UPDATE 
INSTEAD OF INSERT OR UPDATE ON CUSTOMER_ADDRESS_VIEW 
DECLARE
    v_idaddress NUMBER;
    v_idcustomer_address NUMBER;
BEGIN
    -- Update the existing HCustomer_Address record to set ENDDATE to SYSDATE
    UPDATE "HCUSTOMER_ADDRESS"
    SET EndDate = SYSDATE
    WHERE Customer_IDCustomer = 1  -- Replace with the actual Customer ID
    AND EndDate IS NULL;

    -- Insert a new record into the HAddress table
    INSERT INTO "HADDRESS" (IDAddress, Street, City, Province, Postcode)
    VALUES (HAddress_SEQ.NEXTVAL, '123 Main St', 'Springfield', 'IL', '62704')
    RETURNING IDAddress INTO v_idaddress;

    -- Insert a new record into the HCustomer_Address table
    INSERT INTO "HCUSTOMER_ADDRESS" (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress)
    VALUES (HCustomer_Address_SEQ.NEXTVAL, SYSDATE, NULL, 1, v_idaddress);  -- Replace '1' with the actual Customer ID

END;

-----INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount, IDCustomer)
INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount, IDCustomer)
VALUES (HBooking_SEQ.NEXTVAL, TO_DATE('2024-08-09', 'YYYY-MM-DD'), 250.00, 6);

----Full Examples
-- Step 1: Insert New Customer
INSERT INTO HCustomer (IDCustomer, FirstName, LastName)
VALUES (6, 'Jane', 'Smith');

-- Step 2: Insert New Address and Link to Customer
DECLARE
    v_idaddress NUMBER;
BEGIN
    -- Insert into HAddress
    INSERT INTO HAddress (IDAddress, Street, City, Province, Postcode)
    VALUES (HAddress_SEQ.NEXTVAL, '111 New St', 'New City', 'ww', '22222')
    RETURNING IDAddress INTO v_idaddress;

    -- Insert into HCustomer_Address
    INSERT INTO HCustomer_Address (IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress)
    VALUES (HCustomer_Address_SEQ.NEXTVAL, SYSDATE, NULL, 6, v_idaddress);

    COMMIT;
END;
/

-- Step 3: Insert New Booking
INSERT INTO HBooking (IDBooking, BookingDate, TotalAmount, IDCustomer)
VALUES (HBooking_SEQ.NEXTVAL, TO_DATE('2024-08-09', 'YYYY-MM-DD'), 250.00, 6);
