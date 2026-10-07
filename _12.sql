SELECT DISTINCT fs.product_category
FROM flourmills_sales AS fs
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS sub
    WHERE sub.product_category = fs.product_category
    GROUP BY sub.product_category
    HAVING COUNT(DISTINCT sub.region) > 3
)
ORDER BY fs.product_category;