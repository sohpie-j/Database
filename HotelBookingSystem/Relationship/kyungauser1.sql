CREATE OR REPLACE TRIGGER trg_HCustomer_Address_HISTORY
BEFORE INSERT OR UPDATE OR DELETE ON HCustomer_Address
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HCustomer_Address_History (
            HistoryID, IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress, StartTime, EndTime
        ) VALUES (
            HCustomer_Address_SEQ.NEXTVAL, :NEW.IDCustomer_Address, :NEW.StartDate, :NEW.EndDate, :NEW.Customer_IDCustomer, :NEW.Address_IDAddress, SYSDATE, NULL
        );
    ELSIF UPDATING THEN
        UPDATE HCustomer_Address_History
        SET EndTime = SYSDATE
        WHERE IDCustomer_Address = :OLD.IDCustomer_Address
        AND EndTime IS NULL;
        
        INSERT INTO HCustomer_Address_History (
            HistoryID, IDCustomer_Address, StartDate, EndDate, Customer_IDCustomer, Address_IDAddress, StartTime, EndTime
        ) VALUES (
            HCustomer_Address_SEQ.NEXTVAL, :NEW.IDCustomer_Address, :NEW.StartDate, :NEW.EndDate, :NEW.Customer_IDCustomer, :NEW.Address_IDAddress, SYSDATE, NULL
        );
    ELSIF DELETING THEN
        UPDATE HCustomer_Address_History
        SET EndTime = SYSDATE
        WHERE IDCustomer_Address = :OLD.IDCustomer_Address
        AND EndTime IS NULL;
    END IF;
END;
/
