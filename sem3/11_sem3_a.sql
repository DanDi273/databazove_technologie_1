CREATE OR REPLACE PROCEDURE get_sales_between(
    start_date DATE,
    end_date   DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_sales NUMERIC;
BEGIN
    SELECT COALESCE(SUM(sales), 0)
    INTO v_total_sales
    FROM orders
    WHERE order_date BETWEEN start_date AND end_date;

    RAISE NOTICE 'Začiatok: %, koniec: %, celkový predaj: %',
        start_date, end_date, ROUND(v_total_sales, 2);
END;
$$;

CALL get_sales_between('2024-01-01', '2024-03-31');