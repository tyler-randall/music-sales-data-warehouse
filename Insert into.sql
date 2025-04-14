-- CustomerDim
INSERT INTO `hallowed-port-454100-h0.dw_music_sales.CustomerDim`
(customer_key, customer_id, first_name, last_name, email, country, support_rep_id, last_update)
SELECT 
  CustomerId, CustomerId, FirstName, LastName, Email, Country, SupportRepId,
  CURRENT_TIMESTAMP()
FROM `hallowed-port-454100-h0.stg_music_sales.Customer`;

-- TrackDim
INSERT INTO `hallowed-port-454100-h0.dw_music_sales.TrackDim`
(track_key, track_id, track_name, composer, genre_name, media_type_name, unit_price, last_update)
SELECT 
  t.TrackId, t.TrackId, t.Name, t.Composer, g.Name, NULL, t.UnitPrice,
  CURRENT_TIMESTAMP()
FROM `hallowed-port-454100-h0.stg_music_sales.Track` t
LEFT JOIN `hallowed-port-454100-h0.stg_music_sales.Genre` g ON t.GenreId = g.GenreId;

-- AlbumArtistDim
INSERT INTO `hallowed-port-454100-h0.dw_music_sales.AlbumArtistDim`
(album_artist_key, album_id, artist_id, album_title, artist_name, last_update)
SELECT 
  ROW_NUMBER() OVER(), al.AlbumId, al.ArtistId, al.Title, a.Name,
  CURRENT_TIMESTAMP()
FROM `hallowed-port-454100-h0.stg_music_sales.Album` al
JOIN `hallowed-port-454100-h0.stg_music_sales.Artist` a ON al.ArtistId = a.ArtistId;

--EmployeeDim
INSERT INTO `hallowed-port-454100-h0.dw_music_sales.EmployeeDim`
(employee_key, employee_id, first_name, last_name, title, reports_to, hire_date, last_update)
SELECT 
  EmployeeId, EmployeeId, FirstName, LastName, Title, ReportsTo, HireDate,
  CURRENT_TIMESTAMP()
FROM `hallowed-port-454100-h0.stg_music_sales.Employee`;

--TimeDim
INSERT INTO `hallowed-port-454100-h0.dw_music_sales.TimeDim`
(date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, last_update)
SELECT 
  ROW_NUMBER() OVER (ORDER BY InvoiceDate),
  InvoiceDate,
  FORMAT_DATE('%A', InvoiceDate),
  EXTRACT(DAY FROM InvoiceDate),
  EXTRACT(MONTH FROM InvoiceDate),
  FORMAT_DATE('%B', InvoiceDate),
  EXTRACT(QUARTER FROM InvoiceDate),
  EXTRACT(YEAR FROM InvoiceDate),
  CURRENT_TIMESTAMP()
FROM `hallowed-port-454100-h0.stg_music_sales.Invoice`
GROUP BY InvoiceDate;

--GeographyDim
INSERT INTO `hallowed-port-454100-h0.dw_music_sales.GeographyDim`
(geography_key, country, state, city, postal_code, last_update)
SELECT 
  ROW_NUMBER() OVER() AS geography_key,
  BillingCountry AS country,
  CAST(NULL AS STRING) AS state,
  CAST(NULL AS STRING) AS city,
  CAST(NULL AS STRING) AS postal_code,
  CURRENT_TIMESTAMP() AS last_update
FROM `hallowed-port-454100-h0.stg_music_sales.Invoice`
GROUP BY BillingCountry;

--SalesFact
INSERT INTO `hallowed-port-454100-h0.dw_music_sales.SalesFact`
(sale_id, invoice_id, customer_key, track_key, album_artist_key, employee_key, date_key, geography_key, quantity, unit_price, total_amount, last_update)
WITH invoice_dates AS (
  SELECT InvoiceId, td.date_key
  FROM `hallowed-port-454100-h0.stg_music_sales.Invoice` i
  JOIN `hallowed-port-454100-h0.dw_music_sales.TimeDim` td ON i.InvoiceDate = td.full_date
), geo_mapping AS (
  SELECT InvoiceId, g.geography_key
  FROM `hallowed-port-454100-h0.stg_music_sales.Invoice` i
  JOIN `hallowed-port-454100-h0.dw_music_sales.GeographyDim` g ON i.BillingCountry = g.country
)
SELECT 
  il.InvoiceLineId,
  il.InvoiceId,
  i.CustomerId,
  il.TrackId,
  aa.album_artist_key,
  c.SupportRepId,
  id.date_key,
  gm.geography_key,
  il.Quantity,
  t.UnitPrice,
  il.Quantity * t.UnitPrice,
  CURRENT_TIMESTAMP()
FROM `hallowed-port-454100-h0.stg_music_sales.InvoiceLine` il
JOIN `hallowed-port-454100-h0.stg_music_sales.Invoice` i USING (InvoiceId)
JOIN `hallowed-port-454100-h0.stg_music_sales.Track` t ON il.TrackId = t.TrackId
JOIN `hallowed-port-454100-h0.stg_music_sales.Album` alb ON t.AlbumId = alb.AlbumId
JOIN `hallowed-port-454100-h0.dw_music_sales.AlbumArtistDim` aa ON alb.AlbumId = aa.album_id
JOIN `hallowed-port-454100-h0.stg_music_sales.Customer` c ON i.CustomerId = c.CustomerId
JOIN invoice_dates id USING (InvoiceId)
JOIN geo_mapping gm USING (InvoiceId);


