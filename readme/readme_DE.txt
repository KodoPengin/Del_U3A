Readme für den GI-Spywarecleaner - Version 2.76 - von Gameindustry.eu

Inhalt:
1. Beschreibung
2. Installation
3. Gelöschte Dateien
4. Letzte Änderungen
5. Mögliche Probleme
6. Quellenangabe, Hashes



----------------- 1. Beschreibung -----------------

Die Windows-Batch-Datei durchforstet innerhalb des Steamordners Dateien nach Crashlytics und Logs und löscht dazugehörige Dateien.
Zusätzlich werden die CrashDump und Unity Analytics Ordner (sofern vorhanden) im Nutzerverzeichnis geleert.

Dies beugt einer heimlichen Datenaufnahme und Versand von Crashlytics durch Firmen wie Unity Technologies, ApS, Epic Games, Inc.,
oder der Valve Corporations vor und verstärkt die eigene Privatsphäre während der eigenen Spiele-Sessions.

Das Script wird nach Bedarf erweitert.

Die Batch erstellt eine "steam.cfg" im Verzeichnis, sofern diese nicht vorhanden ist. Die Datei verhindert die automatische Aktualisierung des Steam-Clients.
Dies ist notwendig, da Steam sonst zu jedem Start Dateien neu downloadet und überschreibt.

Anwender die eigene Layoutmodifikationen für den Steam-Client nutzen kennen das Vorgehen wahrscheinlich. 

Um Steam wie gewohnt zu aktualisieren muss die Steam.cfg (temporär) aus dem Installationsverzeichnis entfernt werden.



----------------- 2. Installation & Ausführung -----------------

Die Datei "del_u3a_de.bat" wird in das Hauptverzeichnis von Steam oder des angelegten Bibliothekordners kopiert und kann von dort ausgeführt werden
 In den Bibliotheksordnern ist keine steam.cfg notwendig und kann gelöscht werden. Die Steam.cfg im Installationsverzeichnis von Steam selbst nur entfernen für Clientupdates.

Werden nach dem Löschen der vorhanden Spywaredateien und Crashlytics neue Spiele mit denselben Diensten installiert, kann die Batch nochmal gestartet werden um auch diese Dateien zu entfernen.


----------------- 3. Dateien -----------------

Folgende Dateien und Ordner werden mit dieser Batch gelöscht:

- System
%username%\Appdata\Local\CrashDumps\*.*
%USERPROFILE%\AppData\LocalLow\Unity.
%USERPROFILE%\AppData\LocalLow\*.log
%USERPROFILE%\AppData\Local\T2GP Launcher\app-1.0.4.2070\crashagent64.exe

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
!! Das Entfernen der Dateien kann eine Weile dauern. Den Prozess nicht abbrechen.

*.dmp
*.log
BsSndRpt.exe
BsUnityCrashHandler.exe
BugSplatRc.dll
CrashReportClient.exe
CrashReportClient.pdb
CrashReporter.dll
CrashReporter.exe
CrashReporter.exe.config
CrashReporter.resources.dll
CrashRpt1403.dll
CrashRptProbe1403.dll
CrashSender1402.exe
CrashSender1403.exe
CrashUploader.Base.Azure.dll
CrashUploader.Base.UI.dll
CrashUploader.Base.dll
CrashUploader.Publish.exe
CrashUploader.Publish.exe.config
DLogUploader.exe
REDEngineErrorReporter.exe
RemoteCrashSender.exe
UnrealCEFSubProcess.exe
abbey_crash_reporter.exe
apex_crash_handler.exe
crashmsg.exe
crashpad_handler.exe
crashrpt_lang.ini
output_log.txt
telemetry64.dll
UnityCrashHandler32.exe
UnityCrashHandler64.exe

Mehr Info - 5. Mögliche Probleme
GameCrashUploader.exe (GameCrashUploader.exe muss manuell gelöscht und anstelle dessen eine Dummy-Datei mit demselben Namen und 0KB Größe erstellt werden)
UnityEngine.CrashReportingModule.dll
UnityEngine.CrashReportingModule.dll.mdb
UnityEngine.PerformanceReportingModule.dll
Unity.MemoryProfiler.dll
UnityEngine.UnityTestProtocolModule.dll
System.Diagnostics.StackTrace.dll
UnityEngine.SpatialTracking.dll



----------------- 4. Letzte Änderungen -----------------
- Entfernen von Spyware und ungewollten Dateien optimiert
- steam_autocloud.vdf, RemoteCrashSender.exe hinzugefügt
- Korrekturen, leere Ordner löschen und neue Crashlytics hinzugefügt
- Activision DLogUploader.exe
- Mafia 3 telemetry.dll und crashagent64.exe
- output_log.txt (übergreifend), Crashdump fix
- Apex Legend crashmsg.exe hinzugefügt
- Amazon's GameCrashUploader unter mögliche Probleme hinzugefügt
- Readme Dateien umformatiert und ergänzt, Unitydateien deaktiviert
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

Für die GameCrashUploader.exe reicht es aus die Datei zu löschen und imselben Verzeichnis eine Textdatei mit dem Namen GameCrashUploader zu erstellen und als Exe zu speichern. Die Datei hat dann 0kb Größe und das Produkt läuft dennoch.
Da die Dateigröße nicht überprüft wird, reicht es somit aus, dem jeweiligem Spiel (New World) etwas vorzugaukeln.

----------------- 6. Quellenangabe, Hashes -----------------

Quelle: https://gameindustry.eu/
Author: Pengin
Version: 2.76
Datum: 11.03.2023

Datei/en:
del_u3a_de.bat
Hash: 09b62735ad7d11c982de92adaa2e1424c07f429b2a12454eeb844ca7c47e03a9
CRC32: 70a02dc4