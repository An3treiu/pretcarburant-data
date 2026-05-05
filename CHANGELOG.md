# Changelog

All notable changes to the dataset and its schema are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). Version numbers map directly to monthly Zenodo releases (`vYYYY.MM` tags).

## [Unreleased]

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
