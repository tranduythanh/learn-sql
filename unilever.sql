USE master;
GO

-- Set the database to single-user mode
ALTER DATABASE UNILEVER_ABC
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Drop the database
DROP DATABASE UNILEVER_ABC;
GO

CREATE DATABASE UNILEVER_ABC

GO
--lenh su dung CSDL
USE UNILEVER_ABC

GO

DROP TABLE IF EXISTS PRODUCT_CATEGORY;
CREATE TABLE PRODUCT_CATEGORY (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
GO
SELECT * FROM PRODUCT_CATEGORY;
GO

DROP TABLE IF EXISTS PACKAGING_SPEC;
CREATE TABLE PACKAGING_SPEC (
    id INT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    level1_quantity INT NOT NULL CHECK (level1_quantity >= 0),
    level2_quantity INT NOT NULL CHECK (level2_quantity >= 0),
    level3_quantity INT NOT NULL CHECK (level3_quantity >= 0),
    level4_quantity INT NOT NULL CHECK (level4_quantity >= 0)
);
SELECT * FROM PACKAGING_SPEC;
GO

DROP TABLE IF EXISTS MANUFACTURER;
CREATE TABLE MANUFACTURER (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
SELECT * FROM MANUFACTURER;
GO

DROP TABLE IF EXISTS PRODUCT;
CREATE TABLE PRODUCT (
    id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_weight INT NOT NULL CHECK (product_weight >= 0),
    product_category_id INT,
    packaging_spec_id INT,
    manufacturer_id INT,
    FOREIGN KEY (product_category_id) REFERENCES PRODUCT_CATEGORY(id),
    FOREIGN KEY (packaging_spec_id) REFERENCES PACKAGING_SPEC(id),
    FOREIGN KEY (manufacturer_id) REFERENCES MANUFACTURER(id)
);
SELECT * FROM PRODUCT;
GO

DROP TABLE IF EXISTS TEAM;
CREATE TABLE TEAM (
    id INT PRIMARY KEY,
    manufacturer_id INT,
    FOREIGN KEY (manufacturer_id) REFERENCES MANUFACTURER(id)
);
SELECT * FROM TEAM;
GO

DROP TABLE IF EXISTS STAFF;
CREATE TABLE STAFF (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    team_role VARCHAR(255) NOT NULL,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES TEAM(id)
);
SELECT * FROM STAFF;
GO


DROP TABLE IF EXISTS UNILEVER_INVOICE;
CREATE TABLE UNILEVER_INVOICE (
    id INT PRIMARY KEY,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    source VARCHAR(255) NOT NULL,
    spec_level INT NOT NULL CHECK (spec_level >= 1 AND spec_level <= 4),
    invoice_date DATETIME NOT NULL,
    currency VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES PRODUCT(id)
);
SELECT * FROM UNILEVER_INVOICE;
GO

DROP TABLE IF EXISTS RECEIPT;
CREATE TABLE RECEIPT (
    id INT PRIMARY KEY,
    unilever_invoice_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    receipt_date DATETIME NOT NULL,
    condition VARCHAR(255) NOT NULL,
    FOREIGN KEY (unilever_invoice_id) REFERENCES UNILEVER_INVOICE(id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(id)
);
SELECT * FROM RECEIPT;
GO

DROP TABLE IF EXISTS "RETURN";
CREATE TABLE "RETURN" (
    id INT PRIMARY KEY,
    receipt_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    reason VARCHAR(255) NOT NULL,
    FOREIGN KEY (receipt_id) REFERENCES RECEIPT(id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(id)
);
SELECT * FROM "RETURN";
GO

DROP TABLE IF EXISTS REGION;
CREATE TABLE REGION (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
SELECT * FROM REGION;
GO

DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region_id INT,
    client_type VARCHAR(255) NOT NULL,
    FOREIGN KEY (region_id) REFERENCES REGION(id)
);
SELECT * FROM CUSTOMER;
GO

DROP TABLE IF EXISTS "ORDER";
CREATE TABLE "ORDER" (
    id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    date DATETIME NOT NULL,
    status VARCHAR(255) NOT NULL,
    delivery_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(id)
);
SELECT * FROM "ORDER";

GO

DROP TABLE IF EXISTS "USER";
CREATE TABLE "USER" (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL
);
SELECT * FROM "USER";

GO

DROP TABLE IF EXISTS PAYMENT;
CREATE TABLE PAYMENT (
    id INT PRIMARY KEY,
    unilever_invoice_id INT,
    amount INT NOT NULL CHECK (amount >= 0),
    payment_date DATETIME NOT NULL,
    penalty_percentage FLOAT CHECK (penalty_percentage >= 0),
    FOREIGN KEY (unilever_invoice_id) REFERENCES UNILEVER_INVOICE(id)
);
SELECT * FROM PAYMENT;

GO

DROP TABLE IF EXISTS TEMPORARY_SLIP;
CREATE TABLE TEMPORARY_SLIP (
    id INT PRIMARY KEY,
    staff_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    date DATETIME NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES STAFF(id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(id)
);
SELECT * FROM TEMPORARY_SLIP;

GO

DROP TABLE IF EXISTS DISPATCH_SLIP;
CREATE TABLE DISPATCH_SLIP (
    id INT PRIMARY KEY,
    temporary_slip_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    date DATETIME NOT NULL,
    FOREIGN KEY (temporary_slip_id) REFERENCES TEMPORARY_SLIP(id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(id)
);
SELECT * FROM DISPATCH_SLIP;

GO



DROP TABLE IF EXISTS ORDER_ITEM;
CREATE TABLE ORDER_ITEM (
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    unit_price INT NOT NULL CHECK (unit_price >= 0),
    spec_level INT NOT NULL CHECK (spec_level >= 1 AND spec_level <= 4),
    dispatch_slip_id INT,
    FOREIGN KEY (order_id) REFERENCES "ORDER"(id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(id),
    FOREIGN KEY (dispatch_slip_id) REFERENCES DISPATCH_SLIP(id)
);
SELECT * FROM ORDER_ITEM;

GO

DROP TABLE IF EXISTS INVENTORY_IN_OUT;
CREATE TABLE INVENTORY_IN_OUT (
    id INT PRIMARY KEY,
    staff_id INT,
    product_id INT,
    transaction_type VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    date DATETIME NOT NULL,
    spec_level INT NOT NULL CHECK (spec_level >= 1 AND spec_level <= 4),
    dispatch_slip_id INT,
    FOREIGN KEY (staff_id) REFERENCES STAFF(id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(id),
    FOREIGN KEY (dispatch_slip_id) REFERENCES DISPATCH_SLIP(id)
);
SELECT * FROM INVENTORY_IN_OUT;

GO



DROP TABLE IF EXISTS REPORT;
CREATE TABLE REPORT (
    id INT PRIMARY KEY,
    user_id INT,
    report_type VARCHAR(255) NOT NULL,
    generated_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "USER"(id)
);
SELECT * FROM REPORT;

GO

DROP TABLE IF EXISTS STATISTIC;
CREATE TABLE STATISTIC (
    id INT PRIMARY KEY,
    user_id INT,
    statistic_type VARCHAR(255) NOT NULL,
    generated_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "USER"(id)
);
SELECT * FROM STATISTIC;



GO 

-- Trigger for RECEIPT and UNILEVER_INVOICE constraint
CREATE TRIGGER check_receipt_quantity
BEFORE INSERT ON RECEIPT
FOR EACH ROW
BEGIN
    DECLARE total_received INT;
    SELECT SUM(quantity) INTO total_received
    FROM RECEIPT
    WHERE unilever_invoice_id = NEW.unilever_invoice_id;

    IF total_received + NEW.quantity > (SELECT quantity FROM UNILEVER_INVOICE WHERE id = NEW.unilever_invoice_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Total receipt quantity cannot exceed the invoice quantity';
    END IF;
END;

GO 

-- Trigger for RETURN and RECEIPT constraint
CREATE TRIGGER check_return_quantity
BEFORE INSERT ON RETURN
FOR EACH ROW
BEGIN
    DECLARE total_returned INT;
    SELECT SUM(quantity) INTO total_returned
    FROM RETURN
    WHERE receipt_id = NEW.receipt_id;

    IF total_returned + NEW.quantity > (SELECT quantity FROM RECEIPT WHERE id = NEW.receipt_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Total return quantity cannot exceed the receipt quantity';
    END IF;
END;

DELIMITER ;

-- Trigger for ORDER_ITEM and ORDER constraint
DELIMITER //
CREATE TRIGGER check_order_item_quantity
BEFORE INSERT ON ORDER_ITEM
FOR EACH ROW
BEGIN
    DECLARE available_quantity INT;
    SELECT SUM(quantity) INTO available_quantity
    FROM INVENTORY_IN_OUT
    WHERE product_id = NEW.product_id;

    IF available_quantity - NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order item quantity cannot exceed the available product quantity';
    END IF;
END;