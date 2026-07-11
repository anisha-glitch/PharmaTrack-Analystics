-- ============================================================
--  PharmaTrack Sales Analytics
--  Script 01: CREATE TABLES
--  Database: PostgreSQL
-- ============================================================

CREATE TABLE categories (
    CategoryID      VARCHAR(10)  PRIMARY KEY,
    CategoryName    VARCHAR(100) NOT NULL,
    Description     VARCHAR(255)
);

CREATE TABLE dosage_forms (
    DosageFormID    VARCHAR(10)  PRIMARY KEY,
    DosageForm      VARCHAR(100) NOT NULL,
    Category        VARCHAR(100)
);

CREATE TABLE suppliers (
    SupplierID      VARCHAR(10)  PRIMARY KEY,
    SupplierName    VARCHAR(150) NOT NULL,
    Country         VARCHAR(50),
    ContactName     VARCHAR(100),
    Email           VARCHAR(150),
    Phone           VARCHAR(20),
    LeadTimeDays    INT,
    Rating          VARCHAR(5),
    ContractSince   DATE
);

CREATE TABLE employees (
    EmployeeID      VARCHAR(10)  PRIMARY KEY,
    FirstName       VARCHAR(50),
    LastName        VARCHAR(50),
    Role            VARCHAR(100),
    Shift           VARCHAR(20),
    Email           VARCHAR(150),
    Phone           VARCHAR(20),
    Salary          NUMERIC(10,2),
    JoinDate        DATE
);

CREATE TABLE medicines (
    MedicineID              VARCHAR(10)  PRIMARY KEY,
    MedicineName            VARCHAR(200) NOT NULL,
    DosageForm              VARCHAR(100),
    Category                VARCHAR(100),
    Type                    VARCHAR(20),
    UnitPrice               NUMERIC(10,2),
    SupplierID              VARCHAR(10)  REFERENCES suppliers(SupplierID),
    RequiresPrescription    VARCHAR(3),
    StorageCondition        VARCHAR(50)
);


CREATE TABLE inventory (
    InventoryID     VARCHAR(10)  PRIMARY KEY,
    MedicineID      VARCHAR(10)  REFERENCES medicines(MedicineID),
    MedicineName    VARCHAR(200),
    CurrentStock    INT,
    ReorderPoint    INT,
    MaxStock        INT,
    StockStatus     VARCHAR(20),
    LastRestockDate DATE,
    ExpiryDate      DATE,
    UnitCost        NUMERIC(10,2)
);


SELECT * FROM categories;
SELECT * FROM dosage_forms;
SELECT * FROM employees;
SELECT * FROM inventory;
SELECT * FROM medicines;
SELECT * FROM sales;
SELECT * FROM suppliers;
DROP TABLE IF EXISTS public.sales;





CREATE TABLE public.sales_data (
    invoiceid      INT,
    medicineid     VARCHAR(20),
    medicinename   VARCHAR(255),
    dosageform     VARCHAR(100),
    category       VARCHAR(100),
    type           VARCHAR(100),
    quantitysold   INT,
    saledate       VARCHAR(50),
    saletime       VARCHAR(50),
    unitprice      NUMERIC(10,2),
    revenue        NUMERIC(12,2),
    costprice      NUMERIC(10,2),
    profit         NUMERIC(12,2),
    discountpct    NUMERIC(5,2),
    paymentmethod  VARCHAR(100),
    customertype   VARCHAR(100),
    employeeid     VARCHAR(50),
    supplierid     VARCHAR(50)
);
ALTER TABLE public.sales_data RENAME TO sales;