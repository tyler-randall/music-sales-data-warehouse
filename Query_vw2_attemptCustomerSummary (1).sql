CREATE OR REPLACE VIEW `hallowed-port-454100-h0.access_music_sales.vw_CustomerSummary` AS
SELECT
  cd.customer_id,
  cd.first_name,
  cd.last_name,
  gd.country,
  ed.employee_id AS support_rep_id,
  ed.first_name AS rep_first_name,
  COUNT(DISTINCT sf.invoice_id) AS num_orders,
  SUM(sf.total_amount) AS total_spent,
  MAX(td.full_date) AS last_purchase_date
FROM `hallowed-port-454100-h0.dw_music_sales.SalesFact` sf
JOIN `hallowed-port-454100-h0.dw_music_sales.CustomerDim` cd
  ON sf.customer_key = cd.customer_key
JOIN `hallowed-port-454100-h0.dw_music_sales.GeographyDim` gd
  ON sf.geography_key = gd.geography_key
JOIN `hallowed-port-454100-h0.dw_music_sales.EmployeeDim` ed
  ON sf.employee_key = ed.employee_key
JOIN `hallowed-port-454100-h0.dw_music_sales.TimeDim` td
  ON sf.date_key = td.date_key
GROUP BY cd.customer_id, cd.first_name, cd.last_name, gd.country,
         ed.employee_id, ed.first_name;
