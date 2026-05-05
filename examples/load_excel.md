# Încărcarea datasetului în Excel și Google Sheets

## Google Sheets — celulă unică, auto-refresh

Lipește în celula A1 a unui sheet gol:

```
=IMPORTDATA("https://raw.githubusercontent.com/An3treiu/pretcarburant-data/main/monthly/cumulative-latest.csv")
```

Tot setul de date va fi populat. Google Sheets reîncarcă URL-ul aproximativ o dată pe oră.

## Excel (Microsoft 365 / Excel 2019+) — Power Query

1. **Data → Get Data → From Other Sources → From Web**.
2. Lipește:
   ```
   https://raw.githubusercontent.com/An3treiu/pretcarburant-data/main/monthly/cumulative-latest.csv
   ```
3. Click **Transform Data** pentru a inspecta, sau **Load** ca să-l pui direct într-un worksheet.
4. **Refresh** oricând prin Data → Refresh All. Pentru auto-refresh, setează Data → Properties → Refresh every N minutes.

## LibreOffice Calc

1. **Sheet → Insert Sheet from File**.
2. Lipește același URL raw.
3. Setează separatorul de câmpuri `Comma`, encoding `UTF-8`.

## URL-uri pentru snapshot zilnic (în loc de cumulativ)

Pentru un singur agregat zilnic, folosește folder-ul daily:

```
https://raw.githubusercontent.com/An3treiu/pretcarburant-data/main/daily/YYYY-MM-DD.csv
```

Exemplu pentru 2026-05-05:

```
https://raw.githubusercontent.com/An3treiu/pretcarburant-data/main/daily/2026-05-05.csv
```

## Când folosești cumulativ vs zilnic

- **Cumulativ** (`monthly/cumulative-latest.csv`) — pentru analiză time-series, grafice, dashboard-uri. Un fișier, istoric complet.
- **Zilnic** (`daily/YYYY-MM-DD.csv`) — pentru interogări punctuale sau când te interesează doar numărul de azi.
