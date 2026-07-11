-- ────────────────────────────────────────────
-- SECTION 7: INVENTORY ANALYSIS
-- ────────────────────────────────────────────

-- Q18: Low Stock Medicines (Below Reorder Point)
SELECT
    i.MedicineName,
    m.Category,
    i.CurrentStock,
    i.ReorderPoint,
    i.StockStatus,
    i.ExpiryDate,
    i.UnitCost
FROM inventory i
JOIN medicines m ON i.MedicineID = m.MedicineID
WHERE i.CurrentStock <= i.ReorderPoint
ORDER BY i.CurrentStock ASC;


-- Q19: Medicines Expiring Within 90 Days
SELECT
    i.MedicineName,
    m.Category,
    i.CurrentStock,
    i.ExpiryDate,
    CURRENT_DATE - i.ExpiryDate        AS DaysUntilExpiry,
    ROUND(i.CurrentStock * i.UnitCost, 2) AS StockValue
FROM inventory i
JOIN medicines m ON i.MedicineID = m.MedicineID
WHERE i.ExpiryDate <= CURRENT_DATE + INTERVAL '90 days'
ORDER BY i.ExpiryDate ASC;


-- Q20: Inventory Value by Category
SELECT
    m.Category,
    COUNT(i.MedicineID)                     AS TotalMedicines,
    SUM(i.CurrentStock)                     AS TotalUnitsInStock,
    ROUND(SUM(i.CurrentStock * i.UnitCost), 2) AS TotalInventoryValue
FROM inventory i
JOIN medicines m ON i.MedicineID = m.MedicineID
GROUP BY m.Category
ORDER BY TotalInventoryValue DESC;
