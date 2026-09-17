# Mini-Test-Log

| Datum | Testfall | Erwartetes Ergebnis | Tatsächliches Ergebnis | Status | Notizen |
|---|---|---|---|---|---|
| 17.09.2026 | `docker compose config` | Gültige Compose-Konfiguration | Erfolgreich | Erledigt | Vorlage unverändert |
| 17.09.2026 | PHP-Syntaxprüfung mit PHP 8.4 | Keine Syntaxfehler | Alle PHP-Dateien ohne Syntaxfehler | Erledigt | Im PHP-8.4-Container ausgeführt |
| 17.09.2026 | Datenbankimport | Tabellen und Seed-Daten vorhanden | 6 Tabellen, 5 Ressourcen, 4 Extras und `START10` vorhanden | Erledigt | MariaDB importiert |
| 17.09.2026 | Registrierung, Login und Logout | Erfolgreiche Session-Weiterleitung | Alle drei Abläufe mit HTTP 302 erfolgreich | Erledigt | Echte Test-HTTP-Session |
| 17.09.2026 | Vollständige Buchung | Buchung wird transaktional gespeichert | Anlage, Slot, Extra und `START10` gespeichert; Datenbankzeile vorhanden | Erledigt | Gesamtbuchung erfolgreich |
| 17.09.2026 | Doppelbuchung | Zweite Buchung desselben Slots wird abgewiesen | MariaDB-Unique-Constraint blockiert Insert | Erledigt | Direkter Constraint-Test |
| 17.09.2026 | Zugriffsschutz | Nicht eingeloggte Nutzer werden umgeleitet | HTTP 302 zu Login | Erledigt | Buchungsstart geschützt |
| 17.09.2026 | CSRF-Schutz | Fehlender Token wird abgewiesen | HTTP 400 | Erledigt | Nach Korrektur erneut getestet |
| 17.09.2026 | Absolute interne Links | Keine verbotenen URLs | Keine Treffer im Anwendungscode | Erledigt | SVG-XML-Namespaces ausgenommen |
| 17.09.2026 | Docker-Start vollständig | Alle drei Services starten | Blockiert: Ports 8000 und 8081 durch `bung6-*` belegt | Offen | Vorlage nicht verändert |
| TODO | Mobile Darstellung | TODO | TODO | Offen | Manuell ergänzen |
| TODO | Ungültiger Gutscheincode im Browser | TODO | TODO | Offen | Manuell ergänzen |