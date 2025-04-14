-- Views 
CREATE SCHEMA IF NOT EXISTS `hallowed-port-454100-h0.access_music_sales`
OPTIONS(location="US");

CREATE OR REPLACE VIEW `hallowed-port-454100-h0.access_music_sales.vw_DailySalesMetrics` AS
SELECT
  td.full_date AS sales_date,
  COUNT(DISTINCT sf.invoice_id) AS num_orders,
  SUM(sf.total_amount) AS total_sales,
  AVG(sf.total_amount) AS avg_order_value,
  SUM(sf.quantity) AS total_items_sold
FROM `hallowed-port-454100-h0.dw_music_sales.SalesFact` sf
JOIN `hallowed-port-454100-h0.dw_music_sales.TimeDim` td
  ON sf.date_key = td.date_key
GROUP BY sales_date
ORDER BY sales_date;
