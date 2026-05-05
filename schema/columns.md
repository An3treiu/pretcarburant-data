# Schema — column reference

This document describes the canonical CSV schema used in `daily/*.csv` and `monthly/*.csv`.

The schema is **stable and additive** — new columns may be appended in future versions, but existing columns will not be renamed or removed without a major version bump (which corresponds to a new Zenodo concept DOI).

## Columns

| # | Column | Type | Required | Description |
|---|---|---|---|---|
| 1 | `date` | `string (YYYY-MM-DD)` | yes | Reference date in Europe/Bucharest timezone. One row per (date, fuel_type) pair. |
| 2 | `fuel_type` | `enum` | yes | One of: `benzina_standard`, `benzina_premium`, `motorina_standard`, `motorina_premium`, `gpl`. See enum reference below. |
| 3 | `price_min` | `float` (RON/L, 2 decimals) | yes | Minimum observed price across reporting stations on that date. |
| 4 | `price_avg` | `float` (RON/L, 2 decimals) | yes | Arithmetic mean across reporting stations. |
| 5 | `price_max` | `float` (RON/L, 2 decimals) | yes | Maximum observed price across reporting stations. |
| 6 | `station_count` | `int` | yes | Number of stations contributing a valid observation for that (date, fuel_type). |

## Fuel type enum

| Value | English | Romanian | Notes |
|---|---|---|---|
| `benzina_standard` | petrol 95 | benzina 95 octani | Most common; mass market grade |
| `benzina_premium` | petrol 98/100 | benzina premium | Higher octane; brand-specific names |
| `motorina_standard` | diesel | motorina | Most common; mass market grade |
| `motorina_premium` | premium diesel | motorina premium | Brand-specific (V-Power, Efix, etc.) |
| `gpl` | LPG / autogas | GPL auto | Liquefied petroleum gas, automotive |

## Price units and currency

- All prices are in **Romanian Leu per litre (RON/L)**.
- Prices are **gross retail prices** as displayed at the pump — they include VAT (currently 19%), excise duties, and the green stamp where applicable.
- Two decimal places throughout. Half-up rounding from the underlying observations.

## Validation bounds

Outliers are filtered using these absolute bounds before aggregation. Observations outside these bounds are excluded:

| Fuel | Min RON/L | Max RON/L |
|---|---|---|
| benzina_standard, benzina_premium | 5.50 | 12.00 |
| motorina_standard, motorina_premium | 5.50 | 13.00 |
| gpl | 2.50 | 6.00 |

Bounds may be revised over time as the market shifts; revisions are documented in `CHANGELOG.md`.

## Encoding and CSV dialect

- File encoding: **UTF-8**, no BOM.
- Field separator: **comma** (`,`).
- Decimal separator: **dot** (`.`).
- Line terminator: **LF** (`\n`).
- Quoting: minimal (RFC 4180), only fields containing commas or newlines are quoted.
- Header row is always present and matches the column order above.

## Stability promise

- **No breaking changes** to the columns above without a major-version bump and a clear migration note in `CHANGELOG.md`.
- New optional columns may be appended at the right of the table — consumers should index by column name rather than position.
- The `fuel_type` enum may add new values (e.g. CNG, hydrogen) but will not rename existing ones.

For real-time station-level data (which has a richer schema including geographic coordinates and brand), use the live JSON API documented in the README.
