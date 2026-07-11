────────────────────────────────────────────
-- SECTION 2: SALES TREND ANALYSIS
-- ────────────────────────────────────────────

-- Q4: Daily Sales Trend
SELECT
    SaleDate,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS DailyRevenue,
    ROUND(SUM(Profit), 2)           AS DailyProfit
FROM sales
GROUP BY SaleDate
ORDER BY SaleDate;


-- Q5: Monthly Sales Trend
SELECT
    TO_CHAR(SaleDate, 'YYYY-MM')    AS YearMonth,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS MonthlyRevenue,
    ROUND(SUM(Profit), 2)           AS MonthlyProfit,
    ROUND(AVG(Revenue), 2)          AS AvgRevenuePerTransaction
FROM sales
GROUP BY TO_CHAR(SaleDate, 'YYYY-MM')
ORDER BY YearMonth;


-- Q6: Weekly Sales Trend
SELECT
    EXTRACT(WEEK FROM SaleDate)     AS WeekNumber,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS WeeklyRevenue,
    ROUND(SUM(Profit), 2)           AS WeeklyProfit
FROM sales
GROUP BY EXTRACT(WEEK FROM SaleDate)
ORDER BY WeekNumber;


-- Q7: Hourly Sales Pattern
SELECT
    EXTRACT(HOUR FROM SaleTime::TIME)   AS HourOfDay,
    COUNT(*)                            AS Transactions,
    ROUND(SUM(Revenue), 2)              AS HourlyRevenue
FROM sales
WHERE SaleTime IS NOT NULL
GROUP BY EXTRACT(HOUR FROM SaleTime::TIME)
ORDER BY HourOfDay;


-- Q8: Day of Week Sales Pattern
SELECT
    TO_CHAR(SaleDate, 'Day')        AS DayOfWeek,
    COUNT(*)                        AS Transactions,
    ROUND(SUM(Revenue), 2)          AS TotalRevenue,
    ROUND(AVG(Revenue), 2)          AS AvgRevenue
FROM sales
GROUP BY TO_CHAR(SaleDate, 'Day')
ORDER BY TotalRevenue DESC;
