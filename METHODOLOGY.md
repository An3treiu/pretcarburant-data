# Metodologie

Acest document oglindește pagina canonică de metodologie de la
[pretcarburant.ro/metodologie](https://pretcarburant.ro/metodologie) și este
ținut în sincron cu site-ul live.

## Surse de date

Trei feed-uri independente sunt combinate pentru a produce fiecare agregat zilnic.

### 1. Monitorizare oficială ANPC (343 UAT-uri)

Autoritatea Națională pentru Protecția Consumatorilor (ANPC) publică în timp real prețurile la pompă pentru stațiile care operează în 343 de unități administrativ-teritoriale (UAT) din România. PretCarburant.ro colectează acest feed la fiecare două ore și îl folosește ca referință autoritativă pentru orașele acoperite.

### 2. Feed-uri direct de la furnizori (SOCAR, OSCAR)

Două rețele (SOCAR și OSCAR Petrol) publică propriile feed-uri de preț. Acestea sunt folosite ca sursă primară pentru brand-urile respective, având precedență asupra datelor scrapate.

### 3. Monitorizare la nivel de stație (1500+ locații)

Pentru rețelele fără feed direct (Petrom, OMV, Rompetrol, MOL, Lukoil, Gazprom), prețurile sunt colectate la nivel de stație la fiecare două ore.

## Ordinea pipeline-ului

Pipeline-ul rulează la fiecare două ore în această ordine strictă:

1. `peco_v2.py` — strat de bază, datele stațiilor
2. `cron_snapshot.py` — sumar zilnic prețuri
3. `socar_direct.py` — overlay SOCAR autoritativ
4. `monitorul_merge.py` — overlay ANPC cu potrivire geo în mai multe pași (200m → 500m → 800m)
5. `oscar_direct.py` — overlay OSCAR
6. `cron_snapshot_statii.py` — consolidare finală, persistare în SQLite

Ordinea contează: pasul de snapshot trebuie să ruleze ultimul. Mai devreme în 2026, un bug de producție a apărut când snapshot-ul a rulat înainte de merge, colapsând datasetul la un singur preț uniform per brand.

## Reguli de validare

### Praguri pentru outliers

Observațiile în afara acestor praguri sunt excluse:

| Combustibil | Min RON/L | Max RON/L |
|---|---|---|
| benzina_standard, benzina_premium | 5.50 | 12.00 |
| motorina_standard, motorina_premium | 5.50 | 13.00 |
| gpl | 2.50 | 6.00 |

### Normalizare brand-uri

Sursele folosesc casing mixt (Mol, MOL, mol). Toate brand-urile sunt normalizate intern la slug-uri lowercase; valorile afișate provin dintr-un dicționar canonic `RETELE_INFO`.

### Merge geografic

Când ANPC și datele la nivel de stație descriu aceeași stație fizică cu coordonate ușor diferite, o potrivire haversine în mai mulți pași (200m, apoi 500m, apoi 800m) le combină într-o singură înregistrare. Pragul de 800m a fost ales empiric pentru a gestiona cazurile în care o stație ocupă o parcelă mare.

## Cadență de actualizare

- **Date live** — refresh la fiecare 2 ore.
- **Agregat zilnic** — închis la 23:00 EET, publicat scurt după.
- **Snapshot lunar** — publicat pe 1 ale lunii, oglindit pe Zenodo.

## Politică de corecții

Erorile descoperite după publicare sunt corectate în loc în CSV-ul relevant. `CHANGELOG.md` înregistrează fiecare corecție cu data, rândurile afectate și motivul. Corecțiile majore declanșează o nouă versiune Zenodo chiar la mijlocul lunii.

Intenția este **transparență în loc de tăcere**: dacă un număr se schimbă, poți vedea întotdeauna când și de ce.

## Surse de latență

- **Latență live de două ore**: o schimbare de preț la pompă la 14:05 va fi reflectată în date până la aproximativ 16:05 (următorul ciclu de colectare).
- **Latență agregat zilnic**: agregatele naționale de end-of-day sunt disponibile la scurt timp după miezul nopții EET în ziua următoare.
- **Latență Zenodo lunară**: fișierul cumulativ complet al lunii precedente apare pe Zenodo pe 1 ale lunii următoare.

## Reproductibilitate

Codul pipeline-ului este open și rulabil. Repo-ul de la [github.com/An3treiu/pretcarburant-data](https://github.com/An3treiu/pretcarburant-data) conține datele publicate; implementarea live a pipeline-ului este descrisă la [pretcarburant.ro/metodologie](https://pretcarburant.ro/metodologie).

Pentru citare academică, folosește DOI-ul Zenodo `10.5281/zenodo.19560194` (DOI concept, rezolvă întotdeauna la cea mai recentă versiune) sau DOI-ul versiune-specific pentru o anumită release lunară.
