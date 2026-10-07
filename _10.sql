SELECT fs.*
FROM flourmills_sales AS fs
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS sub
    WHERE sub.product_name = fs.product_name
    GROUP BY sub.product_name
    HAVING COUNT(DISTINCT EXTRACT(MONTH FROM sub.sale_date)) > 1
);