<div align="center">

# Prețuri Carburanți România — Date Deschise

**Set de date public, citabil academic. Seria măsurată începe la 18 martie 2026.**

[![License: CC BY 4.0](https://img.shields.io/badge/Licen%C8%9B%C4%83-CC_BY_4.0-blue.svg?style=flat-square)](https://creativecommons.org/licenses/by/4.0/)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.19560194-orange.svg?style=flat-square)](https://doi.org/10.5281/zenodo.19560194)
[![Actualizat zilnic](https://img.shields.io/badge/Actualizat-zilnic-success.svg?style=flat-square)](https://github.com/An3treiu/pretcarburant-data/commits/main)
[![Stații monitorizate](https://img.shields.io/badge/Sta%C8%9Bii-1500%2B-brightgreen.svg?style=flat-square)](https://pretcarburant.ro)

*Întreținut de [PretCarburant.ro](https://pretcarburant.ro). Date oficiale ANPC + monitorizare directă la pompă. Disponibil pentru reutilizare comercială.*

</div>

---

## De ce există acest set de date

În România, prețurile la pompă se schimbă des, depind puternic de regiune și brand, iar referințele publice oficiale (ANRE, ANPC) sunt fie cu zile-ntârziere, fie greu de prelucrat. Acest repo rezolvă problema:

- **Date proaspete**, agregate la nivel național, livrate zilnic.
- **Sursă deschisă și citabilă** — fiecare versiune lunară primește un DOI Zenodo propriu, ideal pentru cercetare, jurnalism, analize de politici publice și auditul indexilor de combustibil ai operatorilor logistici.
- **Metodologie publică** și verificabilă — fără cutie neagră.

---

## Ce găsești aici

| Folder | Conținut | Cadență |
|---|---|---|
| **** | Istoric complet, un singur fișier | actualizat zilnic |
|  | Snapshot lunar (artefact Zenodo release) | lunar, pe 1 ale lunii |
|  | Snapshot zilnic la nivel național | zilnic, ~23:00 EET |
|  | Documentație coloane CSV | versionat |
|  | Cod gata de copiat (Python, R, Excel) | versionat |
|  | Detalii pipeline + reguli validare | versionat |
|  | Metadate citare academică | versionat |

---

## Pornire rapidă

### Python (pandas)



### R



### Excel / Google Sheets



Mai multe exemple: [](examples/).

---

## Schemă

CSV-ul are 6 coloane stabile:

| # | Coloană | Tip | Exemplu | Descriere |
|---|---|---|---|---|
| 1 | Wed May  6 08:31:04 GTBDT 2026 |  |  | Data de referință (Europe/Bucharest) |
| 2 |  | enum |  | Vezi enumerarea de mai jos |
| 3 |  | float, RON/L |  | Minim observat în acea zi |
| 4 |  | float, RON/L |  | Medie pe stațiile raportoare |
| 5 |  | float, RON/L |  | Maxim observat |
| 6 |  | int |  | Stații care au contribuit |

**Tipuri de combustibil:** , , , , .

Prețurile sunt brute, includ TVA, accize și toate taxele — așa cum apar pe panoul de la pompă.

Pentru detalii complete (validare, encoding, stabilitate), vezi [](schema/columns.md).

---

## Cum se construiesc datele

Trei surse independente, combinate la fiecare 2 ore:

1. **ANPC oficial** — raportările publice de la 343 de UAT-uri din România.
2. **Feed direct furnizori** — SOCAR și OSCAR publică ele însele prețurile.
3. **Monitorizare la nivel de stație** — 1500+ stații Petrom, OMV, Rompetrol, MOL, Lukoil, Gazprom.

Cele trei feed-uri sunt unificate cu potrivire geo în mai mulți pași (200m → 500m → 800m), filtrate pentru outlieri (praguri explicit documentate), apoi agregate.

Detalii complete: [](METHODOLOGY.md) și [pretcarburant.ro/metodologie](https://pretcarburant.ro/metodologie).

---

## Cadență

| Evenimet | Când | Format |
|---|---|---|
| Commit zilnic în  | ~23:00 EET, automat | un CSV nou pe zi |
| Refresh  | la fiecare commit zilnic | suprascris |
| Release tagged  pe GitHub | pe 1 ale lunii | tag + release notes |
| Versiune nouă pe Zenodo | la fiecare release tag | DOI versiune nouă, automat |

DOI-ul concept  rămâne stabil și pointează întotdeauna la cea mai recentă versiune.

---

## Citare

Dacă folosești acest set de date într-o lucrare, articol sau raport, folosește citarea de mai jos. Pentru metadate procesabile automat, vezi [](CITATION.cff).



---

## Cazuri de utilizare reale

- **Logistică & transport** — indexarea taxelor de combustibil (fuel surcharge) împotriva unei referințe publice defensabile, citabile cu DOI. Fără scraping intern.
- **Cercetare academică** — analiză longitudinală a prețurilor cu amănuntul în România, dispersii regionale, comportamentul rețelelor de retail.
- **Jurnalism economic** — investigații despre marje, transmisia șocurilor de preț la consumator, efectele măsurilor fiscale (OUG-uri, accize).
- **Politici publice** — monitorizarea răspunsului pieței la măsurile de plafonare (ex: OUG 19/2026).
- **Finanțe personale** — bugetare și calcul cost călătorie.

Pentru integrări B2B custom (rezoluție regională, granularitate per rețea, formate dedicate), contactează autorul.

---

## Licență

Publicat sub [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) — folosește, partajează și adaptează liber, inclusiv comercial. Singura condiție: atribuire (link la repo sau DOI) și marcarea modificărilor dacă există.

---

## Contribuții și contact

| Tip de contact | Canal |
|---|---|
| Probleme cu datele, bug-uri, întrebări de schemă | [GitHub Issues](https://github.com/An3treiu/pretcarburant-data/issues) |
| Pull requests pentru exemple, documentație | direct pe repo |
| Parteneriate, integrări custom B2B | an3treiu@gmail.com |
| Pagina principală PretCarburant.ro | [pretcarburant.ro](https://pretcarburant.ro) |

---

<div align="center">

**Dacă acest set de date îți este util în muncă sau cercetare, un star pe repo ajută la vizibilitate.**

[![Star pe GitHub](https://img.shields.io/github/stars/An3treiu/pretcarburant-data?style=social)](https://github.com/An3treiu/pretcarburant-data)

*Construit și întreținut de [Stoian Andrei-Șerban](https://github.com/An3treiu) pentru [PretCarburant.ro](https://pretcarburant.ro).*

</div>
