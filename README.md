# SportSpot

SportSpot ist ein deutschsprachiges Buchungssystem für Sportanlagen an der Hauptstraße 1 in Friedberg. Nutzer können Anlagen filtern, feste Zeitslots buchen, Extras auswählen und ihre eigenen Buchungen einsehen.

## Voraussetzungen

- Docker Desktop mit Docker Compose
- Git oder ein lokaler Projektordner
- Browser

## Start mit der Docker-Vorlage

Im Projektordner ausführen:

```bash
docker compose up -d
```

Die Anwendung ist entsprechend der unveränderten Compose-Vorlage unter `http://localhost:8000/src/index.php` erreichbar. phpMyAdmin läuft unter `http://localhost:8081`.

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

## Bisher ausgeführte Tests

- `docker compose config`: erfolgreich
- PHP-Syntaxprüfung aller PHP-Dateien mit PHP 8.4: erfolgreich
- Bootstrap-Dateien lokal geladen: erfolgreich

Weitere geforderte End-to-End-Tests werden nach dem Datenbankimport durchgeführt und im [Mini-Test-Log.md](Mini-Test-Log.md) dokumentiert.

## Bekannte Einschränkungen

- Die vorhandene Docker-Vorlage mountet den Projektroot und definiert keinen separaten Apache-DocumentRoot für `src`; daher enthält die lokale Browseradresse `src/index.php`.
- Stornieren zukünftiger Buchungen ist derzeit nicht umgesetzt.
- Teamdaten, Entscheidungen und persönliche Reflexionen sind in der Dokumentation als TODO markiert.