-- ────────────────────────────────────────────
-- SECTION 3: MEDICINE PERFORMANCE
-- ────────────────────────────────────────────

-- Q9: Top 10 Best Selling Medicines by Revenue
SELECT
    MedicineName,
    Category,
    COUNT(*)                        AS TimesSold,
    SUM(QuantitySold)               AS TotalUnitsSold,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(SUM(Profit), 2)           AS TotalProfit,
    ROUND(AVG(UnitPrice), 2)        AS AvgPrice
FROM sales
GROUP BY MedicineName, Category
ORDER BY TotalRevenue DESC
LIMIT 10;


-- Q10: Top 10 Best Selling Medicines by Quantity
SELECT
    MedicineName,
    Category,
    DosageForm,
    SUM(QuantitySold)               AS TotalUnitsSold,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue
FROM sales
GROUP BY MedicineName, Category, DosageForm
ORDER BY TotalUnitsSold DESC
LIMIT 10;


-- Q11: Revenue by Dosage Form
SELECT
    DosageForm,
    COUNT(*)                        AS Transactions,
    SUM(QuantitySold)               AS TotalUnitsSold,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(AVG(UnitPrice), 2)        AS AvgPrice
FROM sales
GROUP BY DosageForm
ORDER BY TotalRevenue DESC
LIMIT 15;
