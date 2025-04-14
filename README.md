# Music Sales Data Warehouse (BigQuery)

This project implements a dimensional data warehouse for a music store. The pipeline is built in layers — staging, storage, and access — using SQL in Google BigQuery.

## Layers

- **Stage Layer:** Loads raw, normalized data from RhythmCloud into BigQuery.
- **Storage Layer:** Transforms and builds dimension and fact tables (star schema).
- **Access Layer:** Creates SQL views for clean, ML/analytics-ready queries.

## Views

- `vw_DailySalesMetrics`: Daily revenue and quantity sold
- `vw_CustomerSummary`: Aggregated customer activity and rep info
- `vw_TrackPerformance`: Revenue and units sold by track + artist

---
