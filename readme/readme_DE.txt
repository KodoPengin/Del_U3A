Readme für die Del3UA Spywarecleaner Batch - Version 2.74 - von Gameindustry.eu

Inhalt:
1. Beschreibung
2. Installation
3. Gelöschte Dateien
4. Letzte Änderungen
5. Mögliche Probleme
6. Quellenangabe, Hashes



----------------- 1. Beschreibung -----------------

Die Batch durchforstet innerhalb des Steamordners Dateien nach Crashlytics und Logs und löscht dazugehörige Dateien.
Zusätzlich werden die CrashDump und Unity Analytics Ordner (sofern vorhanden) im Nutzerverzeichnis geleert.

Dies beugt einer heimlichen Datenaufnahme und Versand von Crashlytics durch Firmen wie Unity Technologies, ApS, Epic Games, Inc.,
oder der Valve Corporations vor und verstärkt die eigene Privatsphäre während der eigenen Spiele-Sessions.

Das Script wird nach Bedarf erweitert.

Die Batch erstellt eine "steam.cfg" im Verzeichnis, sofern diese nicht vorhanden ist. Die Datei verhindert die automatische Aktualisierung des Steam-Clients.
Dies ist notwendig, da Steam sonst zu jedem Start Dateien neu downloadet und überschreibt.

Anwender die eigene Layoutmodifikationen für den Steam-Client nutzen kennen das Vorgehen wahrscheinlich. 

Um Steam wie gewohnt zu aktualisieren muss die Steam.cfg (temporär) aus dem Installationsverzeichnis entfernt werden.



----------------- 2. Installation -----------------

Die Datei "del_u3a_de.bat" wird in das Hauptverzeichnis von Steam oder des angelegten Bibliothekordners kopiert und kann von dort ausgeführt werden. Zum entfernen, die Datei einfach löschen.



----------------- 3. Dateien -----------------

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
abbey_crash_reporter.exe
UnityCrashHandler32.exe
UnityCrashHandler64.exe

Mehr Info - 5. Mögliche Probleme
UnityEngine.CrashReportingModule.dll
UnityEngine.CrashReportingModule.dll.mdb
UnityEngine.PerformanceReportingModule.dll
Unity.MemoryProfiler.dll
UnityEngine.UnityTestProtocolModule.dll
System.Diagnostics.StackTrace.dll
UnityEngine.SpatialTracking.dll



----------------- 4. Letzte Änderungen -----------------

- Readme Dateien umformatiert und erg„nzt, Unitydateien deaktiviert
- UnityEngine.UnityConnectModule.dll entfernt
- UnrealCEFSubProcess.exe hinzugefügt
- Abbey Games Crashreporter hinzugefügt
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



----------------- 5. Mögliche Probleme -----------------

Die Dateien Unity.MemoryProfiler.dll, UnityEngine.CrashReportingModule.dll, UnityEngine.PerformanceReportingModule.dll, UnityEngine.UnityConnectModule.dll und UnityEngine.UnityTestProtocolModule.dll wurden aus der Liste der zu löschenden Dateien deaktiviert, da es je nach Produkt unterschiedlich ist ob nach dem Entfernen der Dateien das Spiel selbst noch funktioniert oder nicht. Wer will, kann dies weiterhin selbst austesten.

Eine bessere Lösung gibt es derzeit nicht. Die UnityCrashhandler können ohne Bedenken vom eigenen System entfernt werden.



----------------- 6. Quellenangabe, Hashes -----------------

Quelle: https://gameindustry.eu/
Author: Pengin
Version: 2.74
Datum: 30.05.2021

Datei/en:
del_u3a_de.bat
Hash: 18266b36566536e3822ea973ae4bada6456bc247f8ddad5a97ea41458a1f0f9d