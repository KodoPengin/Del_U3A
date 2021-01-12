Name: Crashlytics, Logs und Spyware aus Steam und dazugehörigen (Spiele)verzeichnissen löschen
Quelle: https://gameindustry.eu/
Author: Pengin
Version: 2.7
Datum: 12.01.2021

Datei/en:
del_u3a_de.bat
Hash: 5a86715aa507ddc4379b5359fdce3516715730ecf5fbcda37c1a5b5ad74878ac

--------------------------

Installation:

Kopiere die del_u3a_de.bat in das jeweilige Steam,- oder "Bibliotheks"verzeichnis und starte die Datei.

--------------------------

Beschreibung:

Die Batch durchforstet innerhalb des Steamordners Dateien nach Crashlytics und Logs und löscht dazugehörige Dateien.
Zusätzlich wird der CrashDump Ordner (sofern vorhanden) im Nutzerverzeichnis geleert.

Dies beugt einer heimlichen Datenaufnahme und Versand von Crashlytics durch Firmen wie Unity Technologies, ApS, Epic Games, Inc.,
oder der Valve Corporations vor und verstärkt die eigene Privatsphäre während der eigenen Spiele-Sessions.

Das Script wird nach Bedarf erweitert.

Die Batch erstellt eine "steam.cfg". Die Datei verhindert die automatische Aktualisierung des Steam-Clients.
Dies ist notwendig, da Steam sonst zu jedem Start Dateien neu downloadet und überschreibt.
Anwender die eigene Layoutmodifikationen für Steam nutzen kennen das Vorgehen wahrscheinlich. 

Um Steam wie gewohnt zu aktualisieren muss die Steam.cfg (temporär) aus dem Installationsverzeichnis entfernt werden.

--------------------------

hosts:

Die hosts Datei dient für unseren Zweck als Schutz vor ausgehendem Verkehr und dem Versand unserer Daten. Die Batch tätigt
unter Punkt 5 einige Einträge in dieser Datei und blockiert Analytics der Firma Unity Technologies, sowie Crashsender der
Firmen Valve Corporation und Avalanche Studios.

hosts-Ordner: C:\Windows\System32\drivers\etc

Die Batch fügt (sofern diese nicht existieren) einmalig folgende Einträge ein:

0.0.0.0 remote-config-proxy-prd.uca.cloud.unity3d.com
0.0.0.0 thind-gke-euw.prd.data.corp.unity3d.com
0.0.0.0 thind-gke-usc.prd.data.corp.unity3d.com
0.0.0.0 thind-gke-ape.prd.data.corp.unity3d.com
0.0.0.0 53.26.241.35.bc.googleusercontent.com
0.0.0.0 186.194.186.35.bc.googleusercontent.com
0.0.0.0 config.uca.cloud.unity3d.com
0.0.0.0 cdp.cloud.unity3d.com
0.0.0.0 api.uca.cloud.unity3d.com
0.0.0.0 perf-events.cloud.unity3d.com
0.0.0.0 stats.unity3d.com
0.0.0.0 crash.steampowered.com
0.0.0.0 crashreporter.avalanchestudios.com
0.0.0.0 tracking.avalanchestudios.com
0.0.0.0 metrics.avalanchestudios.com
0.0.0.0 tracking2.avalanchestudios.com
0.0.0.0 oldtracking.avalanchestudios.com
0.0.0.0 datarouter.ol.epicgames.com
0.0.0.0 datarouter-weighted.ol.epicgames.com
0.0.0.0 datarouter-prod.ak.epicgames.com
0.0.0.0 metrics.ol.epicgames.com
0.0.0.0 metric-public-service-prod.ol.epicgames.com
0.0.0.0 www.google-analytics.com
0.0.0.0 ssl.google-analytics.com
0.0.0.0 www-google-analytics.l.google.com
0.0.0.0 www.googletagmanager.com

Weitere Blockeinträge für über 1500 Spiele und Programme gibt es
auf der Webseite https://hosts.gameindustry.eu

--------------------------

Letzte Änderungen:

- Unity Analytics und Valve Crashlytics können via hosts zu blockiert werden
- Funktionen zum Leeren verschiedener Cacheordner von Steam hinzugefügt
- Menü überarbeitet, Hash, Dateigröße und Historie hinzugefügt
- UnityEngine.CrashReportingModules hinzugefügt
- CD Projekt RED Crashlytics hinzugefügt
- Es wird nun überprüft ob eine Steam.cfg vorhanden ist
- Bessere Ausgabe der Unity Analytics
- CrashDump Ordner hinzugefügt
- Beschreibungen während des Löschvorgangs ergänzt
- Dateiliste hinzugefügt
- Eine steam.cfg wird ins Installationsverzeichnis geschrieben
- Weitere Crashlytics von Drittanbieterfirmen und Steam hinzugefügt
- Bugfix der verhinderte dass Dateien wirklich gelöscht wurden
- Fehlerausgabe bei 0 Ergebnissen unterdrückt
- Es wird angezeigt wieviele Dateien gelöscht wurden

--------------------------

Folgende Dateien und Ordner werden mit dieser Batch gelöscht:

- System
%Nutzername%\Appdata\Local\CrashDumps\*.*

- Steam
bin\cef\cef.win7\*.*
dumps\*.*
bin\cef\cef.win7x64\crash_reporter.cfg
bin\cef\cef.win7x64\debug.log
.crash
crashhandler.dll
crashhandler64.dll
steamerrorreporter.exe
steamerrorreporter64.exe
WriteMiniDump.exe

- Drittanbieter Crashlytics
*.log
*.dmp
CrashUploader.Base.Azure.dll
CrashUploader.Base.dll
CrashUploader.Base.UI.dll
CrashUploader.Publish.exe
CrashUploader.Publish.exe.config
crashpad_handler.exe
CrashSender1403.exe
crashrpt_lang.ini
CrashRpt1403.dll
CrashRptProbe1403.dll
CrashReporter.dll
CrashReporter.exe
CrashUploader.Publish.exe.config
CrashReporter.exe.config
CrashReportClient.exe
CrashReportClient.pdb
CrashReporter.resources.dll
REDEngineErrorReporter.exe
UnityCrashHandler32.exe
UnityCrashHandler64.exe
UnityEngine.CrashReportingModule.dll
UnityEngine.CrashReportingModule.dll.mdb