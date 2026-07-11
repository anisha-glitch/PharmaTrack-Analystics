-- ────────────────────────────────────────────
-- SECTION 9: WINDOW FUNCTIONS
-- ────────────────────────────────────────────

-- Q23: Running Total Revenue by Date
SELECT
    SaleDate,
    ROUND(SUM(Revenue), 2)              AS DailyRevenue,
    ROUND(SUM(SUM(Revenue)) OVER (
        ORDER BY SaleDate
    ), 2)                               AS RunningTotalRevenue
FROM sales
GROUP BY SaleDate
ORDER BY SaleDate;


-- Q24: Rank Medicines by Revenue within Category
SELECT
    Category,
    MedicineName,
    ROUND(SUM(Revenue), 2)              AS TotalRevenue,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Revenue) DESC
    )                                   AS RankInCategory
FROM sales
GROUP BY Category, MedicineName
ORDER BY Category, RankInCategory;


-- Q25: Top 3 Medicines per Category
WITH RankedMedicines AS (
    SELECT
        Category,
        MedicineName,
        ROUND(SUM(Revenue), 2)          AS TotalRevenue,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY SUM(Revenue) DESC
        )                               AS RankInCategory
    FROM sales
    GROUP BY Category, MedicineName
)
SELECT * FROM RankedMedicines
WHERE RankInCategory <= 3
ORDER BY Category, RankInCategory;
