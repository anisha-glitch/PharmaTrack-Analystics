-- ────────────────────────────────────────────
-- SECTION 8: CTEs
-- ────────────────────────────────────────────

-- Q21: CTE — Medicine Revenue Tier Classification
WITH MedicineRevenue AS (
    SELECT
        MedicineName,
        Category,
        ROUND(SUM(Revenue), 2)      AS TotalRevenue,
        SUM(QuantitySold)           AS TotalUnitsSold
    FROM sales
    GROUP BY MedicineName, Category
),
MedicineTiers AS (
    SELECT *,
        CASE
            WHEN TotalRevenue >= 1000   THEN 'Platinum'
            WHEN TotalRevenue >= 500    THEN 'Gold'
            WHEN TotalRevenue >= 200    THEN 'Silver'
            ELSE 'Bronze'
        END AS RevenueTier
    FROM MedicineRevenue
)
SELECT RevenueTier, COUNT(*) AS MedicineCount,
       ROUND(AVG(TotalRevenue), 2) AS AvgRevenue,
       SUM(TotalUnitsSold) AS TotalUnitsSold
FROM MedicineTiers
GROUP BY RevenueTier
ORDER BY AvgRevenue DESC;


-- Q22: CTE — Month over Month Revenue Growth
WITH MonthlyRev AS (
    SELECT
        TO_CHAR(SaleDate, 'YYYY-MM')    AS YearMonth,
        ROUND(SUM(Revenue), 2)          AS MonthlyRevenue
    FROM sales
    GROUP BY TO_CHAR(SaleDate, 'YYYY-MM')
)
SELECT
    YearMonth,
    MonthlyRevenue,
    LAG(MonthlyRevenue) OVER (ORDER BY YearMonth)   AS PrevMonthRevenue,
    ROUND((MonthlyRevenue - LAG(MonthlyRevenue) OVER (ORDER BY YearMonth))
          / NULLIF(LAG(MonthlyRevenue) OVER (ORDER BY YearMonth), 0) * 100, 2) AS MoMGrowthPct
FROM MonthlyRev
ORDER BY YearMonth;
