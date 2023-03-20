@echo off
set "filename=%~nx0"
SET version="v2.76"
for %%A in (%filename%) do title GameIndustry.eu - Spyware ^& Crashlytics Cleaner fÅr Steam - %version% - %%~zA
SETLOCAL EnableExtensions DisableDelayedExpansion
for /F %%a in ('echo prompt $E ^| cmd') do (
  set "ESC=%%a"
)
:menu
SETLOCAL EnableDelayedExpansion
echo !ESC![92m
echo -------------------------------------------------------------------------
echo # Das Script entfernt Crashlytics, Logs und Analyticsdienste aus dem    #
echo # Steam-Verzeichnis und dazugehîrigen (Spiele)verzeichnissen , leert    #
echo # die Cache-Ordner und entfernt Modding RÅckstÑnde der custom.css       #
echo # (c) by GameIndustry.eu - 20/03/2023 - %version%                       #
echo -------------------------------------------------------------------------
echo/!ESC![0m

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Fordere Adminrechte zum Entfernen der Dateien an
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:: Sicherheitsabfrage
echo !ESC![31mAchtung - Aktive Steaminstanzen werden geschlossen.!ESC![0m
echo/
echo Mîchten Sie fortfahren? DrÅcken Sie auf [Y]
echo Wenn Sie den Vorgang abbrechen mîchten, drÅcken sie auf [N]. 
echo/
if exist "%SystemRoot%\System32\choice.exe" goto UseChoice

setlocal EnableExtensions EnableDelayedExpansion
:UseSetPrompt
set "UserChoice=N"
set /P "UserChoice=Sind Sie sicher [Y/N]? "
set "UserChoice=!UserChoice: =!"
if /I "!UserChoice!" == "N" endlocal & goto :EOF
if /I not "!UserChoice!" == "Y" goto UseSetPrompt
endlocal
goto Continue

:UseChoice
%SystemRoot%\System32\choice.exe /C YN /N /M "Sind Sie sicher [Y/N] "
if errorlevel 2 goto :EOF

:Continue

@echo off
:home
cls
echo/
echo Initialisierung der "%~nx0" fÅr Anwender: %USERNAME%
echo/
echo !ESC![92mSteam-Client: Datenschutz!ESC![0m
echo 1) Crashhandler, Crashlytics ^& Spyware entfernen
echo/
echo !ESC![92mSteam-Client: Wartung (Verwenden Sie die Optionen nur, wenn Risiken bewusst sind.)!ESC![0m
echo 2) Bibliothek-Cache leeren
echo 3) Bilder, Download ^& Shadercache leeren
echo 4) HTML-Cache leeren (Nach AusfÅhrung Steam einmal aktualisieren)
echo 5) ModdingrÅckstÑnde (Lîsche Custom .css Dateien)
echo/
echo !ESC![92mHauptmenÅ!ESC![0m
echo 6) Versionshistorie
echo 7) Beenden
echo/
echo !ESC![92mLinks!ESC![0m
echo 8) öber das Script
echo.
set /p navi=Eingabe:
if "%navi%"=="1" goto Steam
if "%navi%"=="2" goto Biblio
if "%navi%"=="3" goto DL_Cache
if "%navi%"=="4" goto HT_Cache
if "%navi%"=="5" goto CF_Del
cls
if "%navi%"=="6" goto Version
if "%navi%"=="7" goto exit
if "%navi%"=="8" goto about
goto home

:Steam
cls
::Beende Tasks, sofern diese offen sind
echo/
echo Aktive Steamprozesse werden automatisch geschlossen...
echo !ESC![31mDer Vorgang kann je nach Grî·e und Menge der gefundenen Ordner etwas dauern.!ESC![0m
::Wenn offen, beende Steam
taskkill /F /T /IM steam.exe >nul 2>&1

::steam.cfg
IF NOT EXIST "steam.cfg" (
    echo Eine !ESC![4msteam.cfg!ESC![0m wird erstellt...
    echo/
    echo BootStrapperInhibitAll=enable> steam.cfg
    echo BootStrapperForceSelfUpdate=disable>> steam.cfg
)

:Crash
echo !ESC![92m1.!ESC![0m Entferne Crashlytics, Logs und Dumps von der Valve Corporation....
::Entferne Daten die fÅr Uploads und Logging zustÑndig sind
timeout /t 3 /nobreak>nul
@echo off
IF EXIST "bin\cef\cef.win7\*.*" (
    del "bin\cef\cef.win7\*.*" /q
    RMDIR "bin\cef\cef.win7\" /s /q
)
IF EXIST "dumps\*.*" (
    del "dumps\*.*" /q
    RMDIR "dumps\" /s /q
)
IF EXIST "logs\*.*" (
    del "logs\*.*" /q
    RMDIR "logs\" /s /q
)
del ".crash" /q >nul 2>nul
del "bin\cef\cef.win7x64\crash_reporter.cfg" /q >nul 2>nul
del "bin\cef\cef.win7x64\debug.log" /q >nul 2>nul
del "bin\secure_desktop_capture.exe" /f /q >nul 2>nul
del "bin\secure_desktop_capture.zip" /f /q >nul 2>nul
del "bin\steam_monitor.exe" /f /q >nul 2>nul
del "package\steam_client_metrics.bin" /f /q >nul 2>nul
del "crashhandler64.dll" /f /q >nul 2>nul
del "crashhandler.dll" /f /q >nul 2>nul
del "crashhandler.dll.old" /f /q >nul 2>nul
del "steamerrorreporter.exe" /f /q >nul 2>nul
del "steamerrorreporter64.exe" /f /q >nul 2>nul
del "WriteMiniDump.exe" /f /q >nul 2>nul

echo !ESC![92m2.!ESC![0m Entferne (sofern vorhanden) Crashdumps ^& Crashlytics im Systemverzeichnis....
::Entferne Crashdumps
set "foldersToDelete=%userprofile%\AppData\Local\CrashDumps %userprofile%\AppData\Local\CEF\User Data\Crashpad %userprofile%\AppData\Local\CrashReportClient %userprofile%\AppData\Local\T2GP Launcher\app-1.0.4.2070 %userprofile%\AppData\Local\GameAnalytics %userprofile%\AppData\Local\UnrealEngine %userprofile%\AppData\Local\UniSDK %userprofile%\AppData\Local\BuffPanel"

for %%i in (%foldersToDelete%) do (
    if exist "%%i" (
        rd /s /q "%%i"
    )
)

echo !ESC![92m3.!ESC![0m Entferne Crashhandler, Crashlytics, Logs, Dumps, leere Ordner ^& nicht benîtigte Dateien von Drittanbietern....
::Crashlytics von Drittanbietern
echo/
setlocal

set "filelist=CrashReport.exe CrashUploader.Base.Azure.dll CrashUploader.Base.dll CrashUploader.Base.UI.dll CrashUploader.Publish.exe CrashUploader.Publish.exe.config crashpad_handler.exe CrashSender1402.exe CrashSender1403.exe crashrpt_lang.ini CrashRpt1403.dll CrashRptProbe1403.dll CrashReporter.dll CrashReporter.exe CrashUploader.Publish.exe.config CrashReporter.exe.config CrashReportClient.exe DLogUploader.exe UnrealCEFSubProcess.exe CrashReportClient.pdb CrashReporter.resources.dll REDEngineErrorReporter.exe abbey_crash_reporter.exe crashmsg.exe output_log.txt telemetry64.dll apex_crash_handler.exe RemoteCrashSender.exe BsSndRpt.exe BugSplatRc.dll BsUnityCrashHandler.exe log.txt steam_autocloud.vdf UnityCrashHandler32.exe UnityCrashHandler64.exe"

for /f "delims=" %%i in ('dir /b /s %filelist% 2^>nul') do (
    echo "%%i" wurde entfernt.
    del "%%i"
)
for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do rd "%%d" >nul 2>nul
echo/
echo !ESC![92mFertig :]!ESC![0m
echo/
echo !ESC![92m1.!ESC![0m ZurÅck zur Auswahl
echo !ESC![92m2.!ESC![0m Batch schlie·en
echo/
set /p navi=Eingabe: 
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:Biblio
@cls
echo Bibliothek-Cache leeren (Dies kann je nach Grî·e des Ordners etwas dauern)
echo/
echo !ESC![92m1.!ESC![0m Bibliothek-Cache wird geleert....
echo/
IF EXIST "appcache\httpcache\*.*" del "appcache\httpcache\" /q
IF EXIST "appcache\httpcache\" RMDIR "appcache\httpcache\" /s /q
IF EXIST "appcache\librarycache\*.*" del "appcache\librarycache\" /q
IF EXIST "appcache\librarycache\" RMDIR "appcache\librarycache\" /s /q
IF EXIST "appcache\stats\*.*" del "appcache\stats\" /q
IF EXIST "appcache\stats\" RMDIR "appcache\stats\" /s /q
echo/
echo !ESC![92mFertig :]!ESC![0m
echo/
echo 1) ZurÅck zur Auswahl
echo 2) Batch schlie·en
echo/
set /p navi=Eingabe:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:DL_Cache
@cls
echo Bilder, Download-Cache ^& Shadercache leeren (Dies kann je nach Grî·e des Ordners etwas dauern)
echo/
echo !ESC![92m1.!ESC![0m Download-Cache wird geleert....
echo/
IF EXIST "steamapps\downloading\*.*" del "steamapps\downloading\" /q
IF EXIST "steamapps\downloading" RMDIR "steamapps\downloading" /s /q
IF EXIST "deopotcache\*.*" del "steamapps\depotcache\" /q
IF EXIST "depotcache\" RMDIR "depotcache\" /s /q
IF EXIST "steamapps\shadercache\*.*" del "steamapps\shadercache\" /q
IF EXIST "steamapps\shadercache\" RMDIR "steamapps\shadercache\" /s /q
IF EXIST "steamapps\temp\*.*" del "steamapps\temp\" /q
IF EXIST "steamapps\temp\" RMDIR "steamapps\temp\" /s /q
IF EXIST "steamapps\workshop\downloads\*.*" del "steamapps\workshop\downloads\" /q
IF EXIST "steamapps\workshop\downloads\" RMDIR "steamapps\workshop\downloads\" /s /q
IF EXIST "steamapps\workshop\temp\*.*" del "steamapps\workshop\temp\" /q
IF EXIST "steamapps\workshop\temp\" RMDIR "steamapps\workshop\temp\" /s /q
IF EXIST "steam\games\*.*" del "steam\games\*.*" /q
echo/
echo !ESC![92mFertig :]!ESC![0m
echo/
echo 1) ZurÅck zur Auswahl
echo 2) Batch schlie·en
echo/
set /p navi=Eingabe:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:HT_Cache
@cls
echo/
echo HTML-Cache leeren
echo Aktive Steamprozesse werden automatisch geschlossen...
taskkill /F /T /IM steam.exe >nul 2>&1
echo/
echo !ESC![92m1.!ESC![0m HTML-Cache wird geleert....
echo/
IF EXIST "%userprofile%\AppData\Local\Steam\htmlcache\Cache\*.*" del "%userprofile%\AppData\Local\Steam\htmlcache\Cache\*.*" /q >nul 2>&1
echo !ESC![92mFertig :]!ESC![0m
echo/
echo 1) ZurÅck zur Auswahl
echo 2) Batch schlie·en
echo/
set /p navi=Eingabe:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:CF_Del
@cls
echo ModdingrÅckstÑnde im werden entfernt
echo/
echo !ESC![92m1.!ESC![0m Anpassungen entfernen....
echo/
IF EXIST "clientui\css\friends.custom.css" del "clientui\css\friends.custom.css" /q >nul 2>&1
IF EXIST "clientui\friends.custom.css" del "clientui\friends.custom.css" /s /q >nul 2>&1
IF EXIST "clientui\friends.original.css" del "clientui\friends.original.css" /s /q >nul 2>&1
IF EXIST "clientui\ofriends.custom.css" del "clientui\ofriends.custom.css" /s /q >nul 2>&1
IF EXIST "clientui\ofriends.original.css" del "clientui\ofriends.original.css" /s /q >nul 2>&1
IF EXIST "steamui\libraryroot.custom.css" del "steamui\libraryroot.custom.css" /s /q >nul 2>&1
IF EXIST "steamui\libraryroot.original.css" del "steamui\libraryroot.original.css" /s /q >nul 2>&1
IF EXIST "steamui\main.custom.css" del "steamui\main.custom.css" /s /q >nul 2>&1
IF EXIST "steamui\main.original.css" del "steamui\main.original.css" /s /q >nul 2>&1
echo !ESC![92mFertig :]!ESC![0m
echo/
echo 1) ZurÅck zur Auswahl
echo 2) Batch schlie·en
echo/
set /p navi=Eingabe:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:Version
cls
echo !ESC![92mVersionshistorie:!ESC![0m 
echo/
echo !ESC![92mDatum:!ESC![0m          !ESC![92mBeschreibung:!ESC![0m
echo 10.03.2023      Entfernen von Spyware und ungewollten Dateien optimiert.
echo 25.02.2023      steam_autocloud.vdf, RemoteCrashSender.exe hinzugefÅgt
echo 28.12.2022      Korrekturen, leere Ordner lîschen und neue Crashlytics hinzugefÅgt
echo 05.05.2022      Activision DLogUploader.exe
echo 06.12.2021      Mafia 3 telemetry.dll und crashagent64.exe
echo 22.11.2021      output_log.txt hinzugefÅgt, Crashdump fix
echo 21.11.2021      crashmsg.exe hinzugefÅgt
echo 15.10.2021      Amazon GameCrashUploader.exe hinzugefÅgt
echo 30.05.2021      Readme Dateien umformatiert und ergÑnzt, Unitydateien deaktiviert
echo 20.03.2021      UnityEngine.UnityConnectModule.dll gelîscht
echo 18.03.2021      UnrealCEFSubProcess.exe hinzugefÅgt
echo 17.02.2021      Abbey Games Crashreporter hinzugefÅgt
echo 17.01.2021      Hosts Sektion wurde vorerst wieder entfernt, weiter Unity Analytics Dateien hinzugefÅgt
echo 15.01.2021      Weitere Unity Dateien zum SÑuberungsprozess hinzugefÅgt
echo 13.01.2021      Timer von 2 Sekunden integriert, da sonst das Script zu schnell ist - Option zum sÑubern
echo                 von friends.css Modifikationen und eine vergessene crashhandler.dll.old hinzugefÅgt
echo 12.01.2021      Avalanche Analytics erweitert, Epic Games Datarouter, Google Analytics und Tagmananger hinzugefÅgt
echo 07.01.2021      Verschiedene Cacheordner des Steam-Clients kînnen nun geleert werden, Taskkill Optimierung
echo                 Verschiedene Dienste kînnen nun per hosts blockiert werden. Siehe Readme
echo 06.01.2021      Historie aus dem Thunderfox Script Åbernommen, MenÅ Åberarbeitet, Hash und
echo                 Dateigrî·e hinzugefÅgt, Funktionen zum Leeren des Steam-Cache's hinzugefÅgt
echo/
echo 1) ZurÅck zur Auswahl
echo 2) Batch schlie·en
echo/
set /p navi=Eingabe:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:about
cls
echo !ESC![92möber das Script!ESC![0m
echo/
echo Spenden:   gameindustry.eu/de/donations/
echo Kontakt:   gameindustry.eu/de/kontakt/
echo Webseite:  gameindustry.eu/
echo Autor:     Pengin
echo/
set "filename=%~nx0"
for %%A in (%filename%) do echo.!ESC![92mDateiname:!ESC![0m %~nx0 - %%~zA bytes
@echo off
echo |set /p ="!ESC![92mSHA256:!ESC![0m "
CertUtil -hashfile "%~nx0" SHA256 | find /i /v "SHA256" | find /i /v "certutil"
echo/
echo 1) ZurÅck zur Auswahl
echo 2) Batch schlie·en
echo/
set /p navi=Eingabe:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause