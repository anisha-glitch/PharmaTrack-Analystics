-- ────────────────────────────────────────────
-- SECTION 5: SUPPLIER ANALYSIS
-- ────────────────────────────────────────────

-- Q15: Supplier Performance
SELECT
    s.SupplierName,
    s.Country,
    s.Rating,
    s.LeadTimeDays,
    COUNT(sl.InvoiceID)             AS TotalSales,
    ROUND(SUM(sl.Revenue), 2)       AS TotalRevenue,
    COUNT(DISTINCT sl.MedicineID)   AS MedicinesSupplied
FROM sales sl
JOIN suppliers s ON sl.SupplierID = s.SupplierID
GROUP BY s.SupplierName, s.Country, s.Rating, s.LeadTimeDays
ORDER BY TotalRevenue DESC;


-- ────────────────────────────────────────────
-- SECTION 6: EMPLOYEE PERFORMANCE
-- ────────────────────────────────────────────

-- Q16: Employee Sales Performance
SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName    AS EmployeeName,
    e.Role,
    e.Shift,
    COUNT(s.InvoiceID)                  AS TransactionsHandled,
    ROUND(SUM(s.Revenue), 2)            AS TotalRevenue,
    ROUND(AVG(s.Revenue), 2)            AS AvgRevenuePerTransaction
FROM sales s
JOIN employees e ON s.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Role, e.Shift
ORDER BY TotalRevenue DESC;


-- Q17: Revenue by Employee Shift
SELECT
    e.Shift,
    COUNT(s.InvoiceID)              AS Transactions,
    ROUND(SUM(s.Revenue), 2)        AS TotalRevenue,
    ROUND(AVG(s.Revenue), 2)        AS AvgRevenue
FROM sales s
JOIN employees e ON s.EmployeeID = e.EmployeeID
GROUP BY e.Shift
ORDER BY TotalRevenue DESC;
