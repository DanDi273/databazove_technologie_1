SELECT fs.*
FROM flourmills_sales AS fs
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS sub
    WHERE sub.region = fs.region
      AND EXTRACT(YEAR FROM sub.sale_date) = 2024
);