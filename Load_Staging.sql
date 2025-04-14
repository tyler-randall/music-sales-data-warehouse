-- Invoice
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Invoice`
AS 
SELECT InvoiceId, CustomerId, InvoiceDate, BillingCountry, Total
FROM `anly-6250-70r-f22.RhythmCloud.Invoice`;

-- InvoiceLine
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.InvoiceLine`
AS 
SELECT InvoiceLineId, InvoiceId, TrackId, Quantity
FROM `anly-6250-70r-f22.RhythmCloud.InvoiceLine`;  

-- Customer
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Customer`
AS 
SELECT CustomerId, FirstName, LastName, Country, Email, SupportRepId
FROM `anly-6250-70r-f22.RhythmCloud.Customer`;

-- Employee
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Employee`
AS 
SELECT EmployeeId, FirstName, LastName, Title, ReportsTo, HireDate
FROM `anly-6250-70r-f22.RhythmCloud.Employee`;

-- Track
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Track`
AS 
SELECT TrackId, Name, AlbumId, GenreId, Composer, UnitPrice
FROM `anly-6250-70r-f22.RhythmCloud.Track`;

-- Album
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Album`
AS 
SELECT AlbumId, Title, ArtistId
FROM `anly-6250-70r-f22.RhythmCloud.Album`;

-- Artist
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Artist`
AS 
SELECT ArtistId, Name
FROM `anly-6250-70r-f22.RhythmCloud.Artist`;

-- Genre
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Genre`
AS 
SELECT GenreId, Name
FROM `anly-6250-70r-f22.RhythmCloud.Genre`;

-- MediaType
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.MediaType`
AS 
SELECT MediaTypeId, Name
FROM `anly-6250-70r-f22.RhythmCloud.MediaType`;

-- Playlist
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.Playlist`
AS 
SELECT PlaylistId, Name
FROM `anly-6250-70r-f22.RhythmCloud.Playlist`;

-- PlaylistTrack
CREATE OR REPLACE TABLE `hallowed-port-454100-h0.stg_music_sales.PlaylistTrack`
AS 
SELECT PlaylistId, TrackId
FROM `anly-6250-70r-f22.RhythmCloud.PlaylistTrack`;