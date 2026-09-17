# Planning Mode

## Frage zum Fehler -> Kein Inhalt auf Index Page
Hey irgendwie zeigt unsere index Datei nur den Header an. Woran leigt das vielleciht? Wenn man auf buchen klickt, kommt zwar die Login Seite, aber auch ohne Inhalt

Die Ursache ist gefunden: In header.php wird current_user() verwendet, aber auth.php nicht eingebunden. PHP bricht deshalb nach dem bereits ausgegebenen Header ab. Daher erscheint nur die Navigation, auch auf der Login-Seite.

Ergänze in header.php oben:


Also:


Danach sollten Landingpage, Login und Navigation vollständig angezeigt werden. Die Datei Prompts.md habe ich dabei nicht verändert.

## Entscheidung

"Start Implementation wurde genutzt.