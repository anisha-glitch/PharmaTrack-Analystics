-- ────────────────────────────────────────────
-- SECTION 1: BUSINESS KPIs
-- ────────────────────────────────────────────

-- Q1: Overall Business KPIs
SELECT
    COUNT(*)                                            AS TotalTransactions,
    COUNT(DISTINCT InvoiceID)                           AS TotalInvoices,
    ROUND(SUM(Revenue), 2)                              AS TotalRevenue,
    ROUND(SUM(CostPrice), 2)                            AS TotalCost,
    ROUND(SUM(Profit), 2)                               AS TotalProfit,
    ROUND(AVG(Profit / NULLIF(Revenue, 0)) * 100, 2)   AS ProfitMarginPct,
    ROUND(AVG(UnitPrice), 2)                            AS AvgUnitPrice,
    ROUND(AVG(QuantitySold), 2)                         AS AvgQuantityPerSale
FROM sales;


-- Q2: Revenue by Medicine Type (Drug vs Supply)
SELECT
    Type,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(SUM(Profit), 2)           AS TotalProfit,
    ROUND(AVG(UnitPrice), 2)        AS AvgUnitPrice,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS PctOfTotal
FROM sales
GROUP BY Type
ORDER BY TotalRevenue DESC;


-- Q3: Revenue by Category
SELECT
    Category,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(SUM(Profit), 2)           AS TotalProfit,
    ROUND(AVG(Profit / NULLIF(Revenue,0)) * 100, 2) AS ProfitMarginPct
FROM sales
GROUP BY Category
ORDER BY TotalRevenue DESC;
