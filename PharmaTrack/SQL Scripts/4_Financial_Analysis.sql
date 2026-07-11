-- ────────────────────────────────────────────
-- SECTION 4: FINANCIAL ANALYSIS
-- ────────────────────────────────────────────

-- Q12: Revenue by Payment Method
SELECT
    PaymentMethod,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(AVG(Revenue), 2)          AS AvgTransactionValue,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS PctOfTotal
FROM sales
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;


-- Q13: Revenue by Customer Type
SELECT
    CustomerType,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(SUM(Profit), 2)           AS TotalProfit,
    ROUND(AVG(Revenue), 2)          AS AvgSpend
FROM sales
GROUP BY CustomerType
ORDER BY TotalRevenue DESC;


-- Q14: Impact of Discount on Revenue
SELECT
    DiscountPct,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(AVG(Profit), 2)           AS AvgProfit
FROM sales
GROUP BY DiscountPct
ORDER BY DiscountPct;

