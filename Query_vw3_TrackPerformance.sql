CREATE OR REPLACE VIEW `hallowed-port-454100-h0.access_music_sales.vw_TrackPerformance` AS
SELECT
  td.track_id,
  td.track_name,
  td.genre_name,
  aad.artist_name,
  SUM(sf.quantity) AS total_units_sold,
  SUM(sf.total_amount) AS revenue_generated
FROM `hallowed-port-454100-h0.dw_music_sales.SalesFact` sf
JOIN `hallowed-port-454100-h0.dw_music_sales.TrackDim` td
  ON sf.track_key = td.track_key
JOIN `hallowed-port-454100-h0.dw_music_sales.AlbumArtistDim` aad
  ON sf.album_artist_key = aad.album_artist_key
GROUP BY td.track_id, td.track_name, td.genre_name, aad.artist_name;

