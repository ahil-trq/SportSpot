# SportSpot

SportSpot ist ein deutschsprachiges Buchungssystem für Sportanlagen an der Hauptstraße 1 in Friedberg. Nutzer können Anlagen filtern, feste Zeitslots buchen, Extras auswählen, Buchungen Stornieren, Rabattcode verwenden und ihre eigenen Buchungen einsehen.

## Voraussetzungen

- Docker Desktop mit Docker Compose
- Git oder ein lokaler Projektordner
- Browser

## Start mit der Docker-Vorlage

Im Projektordner ausführen:

```bash
docker compose up -d
```

Die Anwendung ist entsprechend der unveränderten Compose-Vorlage unter `http://localhost:8001/src/index.php` erreichbar. phpMyAdmin läuft unter `http://localhost:8001`.

## Datenbankimport

Nach dem ersten Start den Dump importieren:

```bash
docker compose exec -T db mariadb -u root -prootpasswort meine_db < sql-dump/sportspot.sql
```

Die Anwendung verwendet die unveränderten Vorlagenwerte: Datenbank `meine_db`, Benutzer `benutzer`, Passwort `benutzerpasswort`, Host `db`.

## Architektur

- Frontend: HTML5, Bootstrap 5 lokal unter `src/assets/vendor/`, eigenes CSS und Vanilla JavaScript
- Backend: PHP 8.4 ohne Framework
- Datenbank: MariaDB mit PDO und vorbereiteten Statements
- `src/includes/`: gemeinsame Datenbank-, Session-, Auth-, CSRF-, Validierungs- und Buchungslogik
- `sql-dump/sportspot.sql`: Schema und Seed-Daten

Der Buchungsassistent besteht aus vier getrennten PHP-Seiten. Der Zwischenzustand liegt in der Session. Die finale Speicherung erfolgt in einer Transaktion; `UNIQUE(resource_id, booking_date, start_time)` verhindert Doppelbuchungen auf Datenbankebene.

## Demo-Ablauf

1. Konto registrieren und anmelden.
2. Sportanlage und Filter auswählen.
3. Zukünftiges Datum und verfügbaren Slot auswählen.
4. Extras und optional `START10` eingeben.
5. Zusammenfassung prüfen und `Jetzt verbindlich buchen` ausführen.
6. Buchung unter „Meine Buchungen“ kontrollieren.

## Tests

Die vorgesehenen Tests wurden durchgeführt und sind im [Mini-Test-Log.md](Mini-Test-Log.md) dokumentiert.
