SELECT fs.product_category,
       fs.product_name,
       fs.total_amount
FROM flourmills_sales AS fs
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS sub
    WHERE sub.product_category = fs.product_category
      AND sub.total_amount > 200000
);