SELECT fs.product_name,
       fs.product_category,
       fs.total_amount
FROM flourmills_sales AS fs
WHERE fs.total_amount > (
    SELECT AVG(sub.total_amount)
    FROM flourmills_sales AS sub
    WHERE sub.product_category = fs.product_category
);