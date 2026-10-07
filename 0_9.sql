SELECT fs.product_name,
       fs.region,
       fs.total_amount,
       (
           SELECT MIN(sub.total_amount)
           FROM flourmills_sales AS sub
           WHERE sub.region = fs.region
       ) AS region_min_amount
FROM flourmills_sales AS fs;