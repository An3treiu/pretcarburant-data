# Changelog

All notable changes to the dataset and its schema are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). Version numbers map directly to monthly Zenodo releases (`vYYYY.MM` tags).

## [Unreleased]

### Fixed
- **Erratum — 264 files containing synthetic values have been removed from the
  repository.** Every daily file before `daily/2026-03-18.csv` and every monthly
  file before `monthly/2026-03-cumulative.csv` (132 of each) was produced by a
  seeding routine that generated plausible-looking numbers from annual averages, not by
  measurement. They were written at the first public release and never removed, because
  the daily export only ever writes files — it does not delete stale ones.

  The signature is visible in the data itself: every synthetic row reports
  `station_count = 500`, a constant that never occurs in measured data.

  The daily export was already restricted to measured data on an earlier date, so
  `monthly/cumulative-latest.csv` and every file from 2026-03-18 onward were
  never affected and are unchanged. Nothing that was measured has been removed.

  **The measured series begins on 2026-03-18.** Any analysis that used files dated before
  that should be re-run without them. The README previously described the dataset as
  covering "2015 to today"; that claim has been corrected.

- **Erratum — daily minima recomputed for 2026-06-25 to 2026-09-22.** Stale prices had
  set the reported national minimum on 258 fuel-days; maxima, averages and station counts
  are unchanged:
  * a station the official ANPC feed had stopped reporting kept its last price: standard
    diesel 10.18 RON/l on 2026-09-09 to 2026-09-22 (14 days), now 10.19 to 10.79 (error up
    to 0.61 RON/l); premium diesel 10.52 on 2026-09-16 to 2026-09-22 (7 days), now 10.55 to
    10.91;
  * a driver-submitted price older than 72 hours: standard petrol 9.65 on 2026-09-11 to
    2026-09-20 (10 days), now 9.82 to 9.91 (up to 0.26 RON/l);
  * prices unchanged for 14 days or more while at least 90% of the same brand's network
    changed price, or below 90% of the day's median: LPG 3.61 (64 days, 2026-06-25 to
    2026-09-07), now 4.23 to 4.45, and 4.28 (22 days between 2026-08-12 and 2026-09-22,
    including the three August days corrected in the previous erratum), now 4.33 to 4.59;
    premium petrol 9.84 and 9.99 (38 days, 2026-08-15 to 2026-09-22), now 9.89 to 10.41;
    premium diesel 9.55 (7 days between 2026-08-03 and 2026-08-14), now 10.41 to 11.13;
    standard diesel 8.04 on 2026-06-28, now 8.95;
  * premium minima below the plausible range: petrol 7.32 and 7.54 (51 days between
    2026-06-25 and 2026-08-14), now 9.10 to 9.99; diesel 7.66 (44 days, 2026-06-25 to
    2026-08-11), now 9.32 to 10.90.

  Corrected values were recomputed from the per-station daily archive, which currently
  starts on 2026-06-25 (90-day retention). A published value was changed only when every
  archived price at that value was stale, and it was replaced by the next valid price in
  the same direction.

  Before 2026-06-25 there is nothing to recompute from. These published minima are outside
  the plausible range and should be treated as unreliable; they are left as published
  because `price_min` is a required column: standard petrol and standard diesel 6.74
  (2026-04-05 to 2026-06-18, 63 days each), LPG 2.57 and 3.24 (81 days between 2026-03-18
  and 2026-06-18), premium petrol 7.32 and premium diesel 7.03 to 7.66 (2026-03-20 to
  2026-06-24, 88 days each).

  Upstream, one rule now selects the published minimum and maximum for the site, the
  mobile app, the press digest, social posts and this dataset: a plausible range per fuel
  (standard petrol 7.90–12.00, standard diesel 8.00–13.00, LPG 3.30–6.00, premium petrol
  8.50–12.50, premium diesel 8.00–13.00 RON/l), no price the source no longer reports, no
  price unchanged for 14 days while at least 90% of the brand's network moved (a price at
  the network's own ceiling is not treated as stale), no price below 90% of the national
  median, and no extreme without another station's price within 0.15 RON/l. From
  2026-09-22 the daily average also uses only prices within the plausible range.

- **Erratum — daily aggregates for 2026-08-12, 2026-08-13 and 2026-08-14 have been
  recomputed and corrected.** One of the upstream sources feeding the pipeline stopped
  responding on 2026-08-11 (HTTP 403). Because the shared data file is written by several
  independent scrapers, the staleness guard measured the file's modification time and never
  fired — so the ~128 stations covered only by that source kept contributing their last
  known prices as if they were current. Those frozen values were low enough to set the
  reported national minimum on the affected days.

  The published minima were wrong by up to 0.16 RON/l for standard petrol
  (9.26 -> 9.42 on 2026-08-13), 0.18 RON/l for standard diesel, and 0.67 RON/l for LPG
  (3.61 -> 4.28). Averages moved by at most 0.01 RON/l. The observation count drops on
  these days (e.g. 1424 -> 1296 for standard petrol), which correctly reflects that fewer
  stations had live prices than previously reported.

  Corrected values were recomputed from the per-station daily archive, excluding stations
  whose only source had been silent for more than 24 hours — the same rule the site now
  applies at read time. **2026-08-11 was checked and is unaffected:** its reported minimum
  also occurred at a station with a live price that day, so it is left as published.

  Days before 2026-08-12 are unchanged. Upstream, the staleness guard now tracks each
  source separately rather than relying on the shared file's timestamp, so prices from a
  source that has gone quiet are excluded automatically.

### Changed
- **Validation bounds tightened** (`schema/columns.md`, `METHODOLOGY.md`): from 2026-09-22
  observations outside standard petrol 7.90–12.00, standard diesel 8.00–13.00, LPG
  3.30–6.00, premium petrol 8.50–12.50, premium diesel 8.00–13.00 RON/l are excluded before
  aggregation (previously documented as 5.50–12.00 / 5.50–13.00 / 2.50–6.00; in practice
  only values above 100 were filtered). Rows before 2026-06-25 were not re-filtered; see
  the erratum under Fixed.
- **VAT rate corrected in the schema notes:** 21% since 1 August 2025 (Law 141/2025), not
  19%.

### Added
- Initial repository layout with daily and monthly snapshots.

## [v2026.05] — 2026-05-05

### Added
- First public release of the dataset on GitHub.
- Backfilled historical aggregates from 2015-01-15 through 2026-05-05.
  **Withdrawn on 2026-08-31 — these values were synthetic. See the erratum under [Unreleased].**
- Schema documentation in `schema/columns.md`.
- Methodology documentation in `METHODOLOGY.md` mirroring [pretcarburant.ro/metodologie](https://pretcarburant.ro/metodologie).
- Code examples for Python (pandas), R and Excel/Sheets.
- CC-BY 4.0 licence and `CITATION.cff` for academic citation.

### Notes
- Concept DOI `10.5281/zenodo.19560194` was created in April 2026 with an early extract; this monthly release supersedes it as the canonical version source while keeping the concept DOI stable.
- Historical aggregates before 2026 are sparse (typically 1–2 observations per month) because pre-2026 data was reconstructed from public reporting; aggregates from 2026 onwards are dense (daily).
