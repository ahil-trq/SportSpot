# Prompt-Log

## 17.09.2026 · Masterpromt ChatGPT

**Prompt:** Im Anhang findest du eine Beschreibung von einem Uniprojekt, welches wir erarbeiten müssen. Generiere uns einen passenden Promt für Visiual Studio Code: Microsoft Copilot. Unsere Idee ist eine Sport Buchungswebseite namens SportSpot. Es befindet sich auf der Hauptstraße 1 in Friedberg. Mache auch ein cooles Logo rein. Beachte auch Dateien für die Dokumentation etc. Für die KI Nutzung kann bereits dieser Promt und ChatGPT und Microsoft Copilot angegeben werden.

**Gekürzte Antwort:** Vorgehen, genutze Technologien, Beschreibung von Webseite, Dateienstruktur und Funktionen als Prompt für Copilot.

**Entscheidung des Teams:** Entscheidung übernommen für MS Copilot

**Reflexion:** War gut, aber schon vielleicht zu sehr detailliert.




## 17.09.2026 · Masterpromt MS Copilot

**Prompt:** Du arbeitest als Full-Stack-Entwickler an einer benoteten Hochschul-Projektarbeit. Entwickle eine verständliche, wartbare und vollständig dokumentierte Webanwendung namens **SportSpot**.

### Ziel
SportSpot ist ein Buchungssystem für Sportanlagen am Standort:

**Hauptstraße 1, Friedberg**

Die Anwendung soll Sportplätze und Sportbereiche visuell darstellen und deren Buchung ermöglichen. Die Oberfläche und Dokumentation sind auf Deutsch.

### Vorgehen

1. Analysiere zuerst den gesamten vorhandenen Workspace.
2. Prüfe insbesondere die bereitgestellte Docker-Vorlage und deren Datenbankkonfiguration.
3. Verändere die Docker-Vorlage und die vorgegebenen Datenbank-Passwörter nicht.
4. Falls die offizielle Docker-Vorlage fehlt, melde dies und erfinde keinen Ersatz.
5. Erstelle zunächst nur:

- einen Umsetzungsplan,
- den geplanten Dateibaum,
- das Datenbankschema,
- den Buchungsablauf,
- offene Fragen oder Risiken.
6. Warte anschließend auf die Nachricht: **„Plan freigegeben“**.
7. Implementiere danach schrittweise. Erkläre nach jedem Abschnitt kurz die geänderten Dateien und führe passende Tests aus.
8. Erfinde keine erfolgreichen Testergebnisse. Dokumentiere nur tatsächlich ausgeführte Tests.
Die Architektur soll für Studierende verständlich und während einer Live-Coding-Prüfung leicht erweiterbar sein. Vermeide unnötige Abstraktionen und übermäßig komplexe Entwurfsmuster.

### Vorgeschriebene Technologien

- Frontend: HTML5, CSS, Bootstrap 5 und Vanilla JavaScript
- Backend: PHP ohne Framework
- Datenbank: die relationale Datenbank aus der vorhandenen Docker-Vorlage, beispielsweise MariaDB oder MySQL
- Datenbankzugriff ausschließlich mit PDO und vorbereiteten Statements
- Keine zusätzlichen Frontend-Frameworks wie React, Vue, Angular oder Tailwind
- Bootstrap lokal unter `src/assets/vendor/` einbinden, nicht über ein CDN
- Alle internen Links, Form-Actions, Bilder, Skripte, Stylesheets und Fetch-URLs müssen relativ sein
- Keine Links mit `localhost`, IP-Adressen oder führendem `/`

### Funktionen

### Landingpage
Erstelle eine moderne, responsive Landingpage mit:

- kurzer Beschreibung von SportSpot in ein bis zwei Sätzen,
- Standort „Hauptstraße 1, Friedberg“,
- lokal gespeicherten SVG-Illustrationen,
- Übersicht der angebotenen Sportarten,
- klarer Schaltfläche zum Buchungsprozess.

### Logo und Gestaltung
Erstelle ein eigenes SVG-Logo unter `src/assets/img/sportspot-logo.svg`.

Gestaltungsidee:

- Kombination aus Standort-Pin, Ball und stilisiertem „S“,
- moderner sportlicher Look,
- Farben Dunkelblau, Türkis und Limettengrün,
- Wortmarke „SportSpot“,
- zusätzlich eine kompakte Favicon-Version,
- keine fremden Marken, Stockbilder oder urheberrechtlich problematischen Grafiken.
Nutze das Logo im Header, auf der Landingpage und im Favicon. Erstelle außerdem eigene lokale SVG-Grafiken für die Sportangebote.

### Registrierung und Login
Die Registrierung enthält mindestens:

- Vorname,
- Nachname,
- Straße und Hausnummer,
- Postleitzahl,
- Ort,
- E-Mail-Adresse,
- Passwort und Passwortbestätigung.
Umsetzen:

- eindeutige E-Mail-Adressen,
- `password_hash()` und `password_verify()`,
- PHP-Sessions,
- `session_regenerate_id()` nach dem Login,
- serverseitige Validierung,
- sichere Fehlermeldungen,
- CSRF-Schutz für verändernde Formulare,
- korrektes HTML-Escaping,
- Logout.

### Buchung in getrennten Seiten
Der Buchungsvorgang besteht aus mindestens diesen vier Seiten:

1. **Sportanlage auswählen**

- visuell anklickbarer, schematischer Lageplan,
- beispielsweise Tennisplatz A und B, Multifunktionshalle, Beachvolleyballfeld und Kleinfeld,
- belegte und verfügbare Anlagen farblich kennzeichnen,
- zusätzlich barrierefreie Auswahl über Karten oder Radiobuttons.
2. **Datum und Zeitslot auswählen**

- nur zukünftige Termine,
- übersichtliche Anzeige verfügbarer und belegter Slots,
- Verfügbarkeit serverseitig erneut prüfen.
3. **Extras auswählen**

- Leihschläger,
- Ballset,
- Umkleideschrank,
- optional Trainerstunde,
- dynamische Preisvorschau.
4. **Zusammenfassung**

- Anlage, Datum, Uhrzeit, Extras, Einzelpreise, Rabatt und Gesamtpreis,
- Schaltfläche mit der exakten Beschriftung **„Jetzt verbindlich buchen“**,
- kein Zahlungsprozess erforderlich.
Der Zustand des Buchungsassistenten kann sicher in der Session gespeichert werden. Jeder Schritt muss serverseitig validiert werden.

### Doppelbuchungen verhindern
Verwende feste, nicht überlappende Zeitslots. Sichere eine Buchung sowohl in PHP als auch durch eine Datenbank-Constraint ab, beispielsweise mit einem eindeutigen Index auf Anlage und Startzeit.

Die finale Buchung muss innerhalb einer Datenbanktransaktion erfolgen. Wenn ein Slot zwischenzeitlich vergeben wurde, soll eine verständliche Meldung erscheinen und keine unvollständige Buchung gespeichert werden.

### Eigene Buchungen
Eingeloggte Benutzer können ausschließlich ihre eigenen Buchungen ansehen. Zeige Status, Sportanlage, Datum, Uhrzeit, Extras und Gesamtpreis an.

### Zwei zusätzliche Funktionen
Implementiere mindestens:

1. Suche und Filterung nach Sportart, Innen-/Außenbereich und Preis.
2. Gutscheincode mit serverseitiger Prüfung und Preisberechnung, beispielsweise `START10`.
Optional kann zusätzlich das Stornieren einer zukünftigen eigenen Buchung umgesetzt werden.

### Datenbank
Plane mindestens folgende Tabellen:

- `users`
- `resources`
- `bookings`
- `extras`
- `booking_extras`
- `coupons`
Nutze Fremdschlüssel, sinnvolle Indizes, Zeitstempel und Seed-Daten. Lege einen vollständigen SQL-Dump unter folgendem Pfad ab:

`sql-dump/sportspot.sql`

Der Dump muss zur Datenbank der vorhandenen Docker-Vorlage passen.

### Dateistruktur
Alle Dateien der Webanwendung müssen im Ordner `src` liegen. Eine mögliche Struktur ist:

- `src/index.php`
- `src/register.php`
- `src/login.php`
- `src/logout.php`
- `src/booking-step-1.php`
- `src/booking-step-2.php`
- `src/booking-step-3.php`
- `src/booking-summary.php`
- `src/my-bookings.php`
- `src/includes/`
- `src/assets/css/`
- `src/assets/js/`
- `src/assets/img/`
- `src/assets/vendor/`
- `sql-dump/sportspot.sql`
Gemeinsame Navigation, Footer, Datenbankverbindung, Authentifizierung, CSRF-Funktionen und Hilfsfunktionen sollen in nachvollziehbaren Includes liegen.

### Pflichtdokumentation im Repository-Root
Erstelle und pflege:

- `AI-Usage.md`
- `Prompts.md`
- `Planning-Mode.md`
- `Mini-Test-Log.md`
- `Relexion.md`
- `README.md`
- `Abgabe.md`
Verwende exakt den Dateinamen `Relexion.md`, da er so in der Pflichtübersicht der Aufgabenstellung genannt wird.

### Inhalt der Dokumentation
`AI-Usage.md`:

- ChatGPT: Analyse der Aufgabenstellung, Ideenfindung und Erstellung dieses Master-Prompts
- GitHub Copilot in Visual Studio Code: Planung, Codevorschläge, Refactoring, Fehlersuche und Testunterstützung
- Grenzen der KI-Nutzung und menschliche Prüfung
`Prompts.md`:

- Datum und verwendetes KI-Werkzeug
- wichtiger Prompt
- gekürzte Antwort
- Entscheidung des Teams
- kurze Reflexion
- diesen Master-Prompt als ersten Eintrag dokumentieren
`Planning-Mode.md`:

- Copilot-Vorschläge zur Architektur
- tatsächlich gewählte Lösung
- verworfene Alternativen
- Begründungen des Teams
`Mini-Test-Log.md`:

- Datum
- Testfall
- erwartetes Ergebnis
- tatsächliches Ergebnis
- Status
- Notizen
`Relexion.md`:

- was gut funktioniert hat,
- wo KI unzuverlässig war,
- welche Vorschläge verändert oder verworfen wurden,
- welche menschlichen Kompetenzen notwendig waren.
Erfinde keine Entscheidungen oder persönlichen Reflexionen des Teams. Verwende dafür klar gekennzeichnete TODO-Stellen, die das Team später ehrlich ergänzt.

`README.md`:

- Projektbeschreibung,
- Voraussetzungen,
- Start mit der vorhandenen Docker-Vorlage,
- Datenbankimport,
- Architekturübersicht,
- Demo-Ablauf,
- bekannte Einschränkungen.
`Abgabe.md`:

- Projektname SportSpot,
- Platzhalter für Namen und Matrikelnummern,
- Platzhalter für den Link zum privaten THM-GitLab-Repository,
- Hinweis, dass diese Informationen für die Moodle-Abgabe als PDF exportiert werden müssen.

### Qualität und Sicherheit

- responsives Bootstrap-Layout,
- semantisches HTML,
- Tastaturbedienbarkeit und sichtbare Fokuszustände,
- Alt-Texte und beschriftete Formulare,
- serverseitige Validierung aller Daten,
- keine SQL-Injection oder XSS,
- keine Passwörter im Klartext,
- keine hartcodierten absoluten URLs,
- klare Kommentare nur an erklärungsbedürftigen Stellen,
- konsistente deutsche Benutzeroberfläche.

### Abschlussprüfungen
Führe nach der Implementierung mindestens folgende Prüfungen aus und dokumentiere sie:

- PHP-Syntaxprüfung aller PHP-Dateien,
- Docker-Start,
- Datenbankimport,
- Registrierung, Login und Logout,
- vollständige Buchung,
- Verhinderung einer Doppelbuchung,
- Zugriffsschutz für eigene Buchungen,
- Filterung,
- gültiger und ungültiger Gutscheincode,
- Formularvalidierung und CSRF-Schutz,
- mobile Darstellung,
- Suche nach absoluten oder mit `/` beginnenden internen Links.
Behebe gefundene Fehler und aktualisiere danach SQL-Dump und Dokumentation. Gib zum Abschluss eine kompakte Übersicht über Architektur, Startanleitung, Teststand und noch offene TODOs aus.

Beginne jetzt ausschließlich mit Analyse und Planungsphase. Verändere noch keine Dateien.

**Gekürzte Antwort:** Nach Freigabe zum Docker, begann er nach unserer Aufforderung die Dateien zu erstellen. Das Ergebnis ist ein gutes Grundgerüst unserer Webeite.

**Entscheidung des Teams:** Entscheidung übernommen.

**Reflexion:** Man hätte es vielleicht Stück für Stück angehen sollen. Die Skripte sind zwar nicht all zu schwer zu verstehen, dennoch ist es viel auf einmal.


## 18.09.2026 · Tabelle umformatieren

**Prompt:** Änder die Tabelle so um und leere alle Zeilen

**Antwort:** Die Tabelle in Mini-Test-Log.md wurde auf das gewünschte Format geändert und alle bisherigen Zeilen wurden geleert. Es sind jetzt drei leere Testfall-Zeilen vorhanden.

**Entscheidung des Teams:** Entscheidung übernommen.

**Reflexion:** War gut.


## 18.09.2026 · Registrierung fehlgeschlagen

**Prompt:** Ich habe versucht mich zu regestrieren aber ist kommt folgende fehler: "Registrierung konnte nicht gepsichert werden"

**Antwort:** Die Ursache war die Datenbank: Die Tabelle users existierte noch nicht. Deshalb erschien die allgemeine Fehlermeldung in register.php.
Ich habe das SQL-Schema importiert und eine Testregistrierung erfolgreich durchgeführt. Die Testdaten wurden anschließend wieder gelöscht.
Für eine neue Einrichtung musst du einmal aus dem Projektordner ausführen:
 
 
docker compose exec -T db mariadb -u root -prootpasswort meine_db < sql-dump/sportspot.sql
 
 
Danach sollte die Registrierung unter http://localhost:8001/src/register.php funktionieren.
 

**Entscheidung des Teams:** Entscheidung übernommen.

**Reflexion:** War gut.


## 18.09.2026 · Mehrere Slots wählbar machen

**Prompt:** Man sollte mehrere Slots aufeinmal buchen können
 
**Antwort:** Mehrere Slots können jetzt gleichzeitig gebucht werden.
Geändert wurden:
Mehrfachauswahl per Checkbox in booking-step-2.php
Preisberechnung für mehrere Slots
Prüfung, ob einer der ausgewählten Slots inzwischen belegt ist
Speicherung aller Slots innerhalb einer Transaktion
Anzeige aller ausgewählten Zeiten in booking-summary.php
Die Syntaxprüfung war erfolgreich. Beispiel: 3 Slots à 18 EUR ergeben 54 EUR.

**Entscheidung des Teams:** Entscheidung übernommen, während man Überblick auf mehrere Dateien noch haben muss. 

**Reflexion:** Hat gut geklappt.



## 18.09.2026 · Berechnung von Extras klappt nicht

**Prompt:** da wir jetzt mehrere slots auf einmal buchen können haben wir jetzt das problem das die extras nur auf ein slot gebucht werden die sollte man für jeden slot seperat wählen können
 
 
**Antwort:** Das Problem ist behoben. Extras können jetzt für jeden Slot separat ausgewählt werden.
Beispiel:
09:00–10:00: Leihschläger
10:00–11:00: keine Extras
11:00–12:00: Getränke
Die Extras werden korrekt jedem einzelnen Slot zugeordnet und separat in der Datenbank gespeichert. Die Zusammenfassung zeigt die Extras ebenfalls pro Slot an.

**Entscheidung des Teams:** Entscheidung übernommen.

**Reflexion:** Hat gut geklappt.



## 18.09.2026 · Stoniermöglichkeit schaffen

**Prompt:** Wir brauchen noch ein stornier möglichkeit
 
 
**Antwort:** Eigene zukünftige Buchungen können storniert werden.
Bereits gestartete oder stornierte Buchungen können nicht erneut storniert werden.
Jede Buchung wird per CSRF-geschütztem POST verarbeitet.
Stornierte Buchungen erhalten den Status „Storniert“.
Bei mehreren Slots kann jeder Slot einzeln storniert werden.
Die PHP-Syntaxprüfung war erfolgreic

**Entscheidung des Teams:** Entscheidung übernommen.

**Reflexion:** Hat gut geklappt.

