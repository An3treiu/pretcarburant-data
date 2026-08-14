# Changelog

All notable changes to the dataset and its schema are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). Version numbers map directly to monthly Zenodo releases (`vYYYY.MM` tags).

## [Unreleased]

### Fixed
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

### Added
- Initial repository layout with daily and monthly snapshots.

## [v2026.05] — 2026-05-05

### Added
- First public release of the dataset on GitHub.
- Backfilled historical aggregates from 2015-01-15 through 2026-05-05.
- Schema documentation in `schema/columns.md`.
- Methodology documentation in `METHODOLOGY.md` mirroring [pretcarburant.ro/metodologie](https://pretcarburant.ro/metodologie).
- Code examples for Python (pandas), R and Excel/Sheets.
- CC-BY 4.0 licence and `CITATION.cff` for academic citation.

### Notes
- Concept DOI `10.5281/zenodo.19560194` was created in April 2026 with an early extract; this monthly release supersedes it as the canonical version source while keeping the concept DOI stable.
- Historical aggregates before 2026 are sparse (typically 1–2 observations per month) because pre-2026 data was reconstructed from public reporting; aggregates from 2026 onwards are dense (daily).
