Name: Crashlytics, Logs und Spyware aus Steam und dazugehörigen (Spiele)verzeichnissen löschen
Quelle: https://gameindustry.eu/
Author: Pengin
Version: 2.72
Datum: 23.01.2021

Datei/en:
del_u3a_de.bat
Hash: 9f36754a33af45f235b066ec9004cd70ca3d5d91fcb4b66b010a5c3ae1388180

--------------------------

Installation:

Kopiere die del_u3a_de.bat in das jeweilige Steam,- oder "Bibliotheks"verzeichnis und starte die Datei.

--------------------------

Beschreibung:

Die Batch durchforstet innerhalb des Steamordners Dateien nach Crashlytics und Logs und löscht dazugehörige Dateien.
Zusätzlich werden die CrashDump und Unity Analytics Ordner (sofern vorhanden) im Nutzerverzeichnis geleert.

Dies beugt einer heimlichen Datenaufnahme und Versand von Crashlytics durch Firmen wie Unity Technologies, ApS, Epic Games, Inc.,
oder der Valve Corporations vor und verstärkt die eigene Privatsphäre während der eigenen Spiele-Sessions.

Das Script wird nach Bedarf erweitert.

Die Batch erstellt eine "steam.cfg". Die Datei verhindert die automatische Aktualisierung des Steam-Clients.
Dies ist notwendig, da Steam sonst zu jedem Start Dateien neu downloadet und überschreibt.
Anwender die eigene Layoutmodifikationen für Steam nutzen kennen das Vorgehen wahrscheinlich. 

Um Steam wie gewohnt zu aktualisieren muss die Steam.cfg (temporär) aus dem Installationsverzeichnis entfernt werden.

--------------------------

Letzte Änderungen:

- Hosts Sektion wurde vorerst wieder entfernt, weiter Unity Analytics Dateien hinzugefügt
- Weitere Dateien zum Säuberungsprozess hinzugefügt
- 2sTimer integriert | Option zum Säubern der friends.css Modifikationen und eine vergessene crashhandler.dll.old hinzugefügt
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
%username%\Appdata\Local\CrashDumps\*.*
%USERPROFILE%\AppData\LocalLow\Unity.
%USERPROFILE%\AppData\LocalLow\*.log

- Steam
bin\cef\cef.win7\*.*
dumps\*.*
bin\cef\cef.win7x64\crash_reporter.cfg
bin\cef\cef.win7x64\debug.log
logs\*.*
.crash
crashhandler.dll
crashhandler64.dll
crashhandler.dll.old
steamerrorreporter.exe
steamerrorreporter64.exe
WriteMiniDump.exe

- Drittanbieter Crashlytics, Dumps, Logs und nicht benötigte Dateien
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
UnityEngine.PerformanceReportingModule.dll
Unity.MemoryProfiler.dll
UnityEngine.UnityConnectModule.dll
UnityEngine.UnityTestProtocolModule.dll
System.Diagnostics.StackTrace.dll
UnityEngine.SpatialTracking.dll