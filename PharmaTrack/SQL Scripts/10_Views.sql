-- ────────────────────────────────────────────
-- SECTION 10: VIEWS
-- ────────────────────────────────────────────

-- V1: Executive Summary View
CREATE OR REPLACE VIEW vw_executive_summary AS
SELECT
    COUNT(*)                                            AS TotalTransactions,
    COUNT(DISTINCT InvoiceID)                           AS TotalInvoices,
    ROUND(SUM(Revenue), 2)                              AS TotalRevenue,
    ROUND(SUM(Profit), 2)                               AS TotalProfit,
    ROUND(AVG(Profit / NULLIF(Revenue,0)) * 100, 2)    AS ProfitMarginPct,
    COUNT(DISTINCT MedicineID)                          AS UniqueMedicines,
    ROUND(AVG(UnitPrice), 2)                            AS AvgUnitPrice
FROM sales;


-- V2: Full Sales Detail View
CREATE OR REPLACE VIEW vw_sales_details AS
SELECT
    s.InvoiceID,
    s.SaleDate,
    s.SaleTime,
    s.MedicineName,
    s.DosageForm,
    s.Category,
    s.Type,
    s.QuantitySold,
    s.UnitPrice,
    s.Revenue,
    s.CostPrice,
    s.Profit,
    s.DiscountPct,
    s.PaymentMethod,
    s.CustomerType,
    e.FirstName || ' ' || e.LastName    AS EmployeeName,
    e.Role                              AS EmployeeRole,
    e.Shift,
    sup.SupplierName,
    sup.Country                         AS SupplierCountry
FROM sales s
JOIN employees e    ON s.EmployeeID  = e.EmployeeID
JOIN suppliers sup  ON s.SupplierID  = sup.SupplierID;


-- V3: Inventory Alert View
CREATE OR REPLACE VIEW vw_inventory_alerts AS
SELECT
    i.MedicineName,
    m.Category,
    m.DosageForm,
    i.CurrentStock,
    i.ReorderPoint,
    i.StockStatus,
    i.ExpiryDate,
    CASE
        WHEN i.ExpiryDate <= CURRENT_DATE + INTERVAL '30 days'  THEN 'Critical Expiry'
        WHEN i.ExpiryDate <= CURRENT_DATE + INTERVAL '90 days'  THEN 'Expiring Soon'
        ELSE 'OK'
    END AS ExpiryAlert,
    ROUND(i.CurrentStock * i.UnitCost, 2) AS StockValue
FROM inventory i
JOIN medicines m ON i.MedicineID = m.MedicineID
WHERE i.StockStatus = 'Low'
   OR i.ExpiryDate <= CURRENT_DATE + INTERVAL '90 days';
   -- -----------------------------THE SECTION ABOVE WAS REPLACED BY THE SECTION BELOW DUE TO ERRORS------------------------------------------

-- V1: Executive Summary View
CREATE OR REPLACE VIEW vw_executive_summary AS
SELECT
    COUNT(*)                                            AS TotalTransactions,
    COUNT(DISTINCT InvoiceID)                           AS TotalInvoices,
    COUNT(DISTINCT MedicineID)                          AS UniqueMedicines,
    ROUND(SUM(Revenue), 2)                              AS TotalRevenue,
    ROUND(SUM(Profit), 2)                               AS TotalProfit,
    ROUND(AVG(Profit / NULLIF(Revenue,0)) * 100, 2)    AS ProfitMarginPct,
    ROUND(AVG(UnitPrice), 2)                            AS AvgUnitPrice,
    ROUND(SUM(QuantitySold), 0)                         AS TotalUnitsSold
FROM sales;

-- V2: Full Sales Detail View
CREATE OR REPLACE VIEW vw_sales_details AS
SELECT
    s.InvoiceID, s.SaleDate, s.SaleTime,
    s.MedicineName, s.DosageForm, s.Category, s.Type,
    s.QuantitySold, s.UnitPrice, s.Revenue, s.CostPrice,
    s.Profit, s.DiscountPct, s.PaymentMethod, s.CustomerType,
    e.FirstName || ' ' || e.LastName AS EmployeeName,
    e.Role, e.Shift,
    sup.SupplierName, sup.Country, sup.Rating
FROM sales s
JOIN employees e ON s.EmployeeID = e.EmployeeID
JOIN suppliers sup ON s.SupplierID = sup.SupplierID;

-- V3: Inventory Alert View
CREATE OR REPLACE VIEW vw_inventory_alerts AS
SELECT
    i.MedicineName, m.Category, m.DosageForm, m.Type,
    i.CurrentStock, i.ReorderPoint, i.StockStatus, i.ExpiryDate,
    i.ExpiryDate - CURRENT_DATE AS DaysUntilExpiry,
    CASE
        WHEN i.ExpiryDate <= CURRENT_DATE + INTERVAL '30 days' THEN 'Critical'
        WHEN i.ExpiryDate <= CURRENT_DATE + INTERVAL '90 days' THEN 'Warning'
        ELSE 'OK'
    END AS ExpiryAlert,
    ROUND(i.CurrentStock * i.UnitCost, 2) AS StockValue
FROM inventory i
JOIN medicines m ON i.MedicineID = m.MedicineID;

-- V4: Category Performance View
CREATE OR REPLACE VIEW vw_category_performance AS
SELECT
    s.Category, s.Type,
    COUNT(*) AS TotalTransactions,
    SUM(s.QuantitySold) AS TotalUnitsSold,
    ROUND(SUM(s.Revenue), 2) AS TotalRevenue,
    ROUND(SUM(s.Profit), 2) AS TotalProfit,
    ROUND(AVG(s.Profit / NULLIF(s.Revenue,0)) * 100, 2) AS ProfitMarginPct,
    COUNT(DISTINCT s.MedicineID) AS UniqueMedicines
FROM sales s
GROUP BY s.Category, s.Type;
