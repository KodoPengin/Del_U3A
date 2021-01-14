@echo off
set "filename=%~nx0"
for %%A in (%filename%) do title GameIndustry.eu - Spyware ^& Crashlytics Cleaner fÅr Steam - v2.71 - %%~zA bytes
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
echo # die Cache-Ordner des Clients und erstellst bei Bedarf hosts EintrÑge  #
echo # (c) by GameIndustry.eu - 14/01/2021 - Version 2.71                     #
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
echo !ESC![92mSteam-Client!ESC![0m
echo 1) Crashlytics ^& Spyware entfernen
echo 2) Bibliothek-Cache leeren
echo 3) Bilder, Download ^& Shadercache leeren
echo 4) HTML-Cache leeren (Nach AusfÅhrung Steam einmal aktualisieren)
echo 5) ModdingrÅckstÑnde (Custom .css Dateien)
echo/
echo !ESC![92mHosts!ESC![0m
echo 6) Analytics ^& Crashlytics via hosts blockieren
echo/
echo !ESC![92mHauptmenÅ!ESC![0m
echo 7) Versionshistorie
echo 8) Beenden
echo.
set /p navi=Eingabe:
if "%navi%"=="1" goto Steam
if "%navi%"=="2" goto Biblio
if "%navi%"=="3" goto DL_Cache
if "%navi%"=="4" goto HT_Cache
if "%navi%"=="5" goto CF_Del
if "%navi%"=="6" goto Hosts_Block
cls
if "%navi%"=="7" goto Version
if "%navi%"=="8" goto exit
goto home

:Steam
cls
::Beende Tasks, sofern diese offen sind
echo/
echo Aktive Steamprozesse werden automatisch geschlossen...
::Wenn offen, beende Steam
taskkill /F /T /IM steam.exe >nul 2>&1

::steam.cfg
IF EXIST "steam.cfg" (
echo/
goto :Crash
) ELSE (
echo Eine !ESC![4msteam.cfg!ESC![0m wird erstellt...
echo/
@echo off
echo BootStrapperInhibitAll=enable> steam.cfg
echo BootStrapperForceSelfUpdate=disable>> steam.cfg
)

:Crash
echo !ESC![92m1.!ESC![0m Entferne Crashlytics, Logs und Dumps von der Valve Corporation....
::Entferne Daten die fÅr Uploads und Logging zustÑndig sind
timeout /t 3 /nobreak>nul
IF EXIST "bin\cef\cef.win7\*.*" del "bin\cef\cef.win7\*.*" /q
IF EXIST "bin\cef\cef.win7\" RMDIR "bin\cef\cef.win7\" /s /q
IF EXIST "dumps\*.*" del "dumps\*.*" /q
IF EXIST "dumps\" RMDIR "dumps\" /s /q
IF EXIST "logs\*.*" del "logs\*.*" /q
IF EXIST "logs\" RMDIR "logs\" /s /q
IF EXIST ".crash" del ".crash" /q
IF EXIST "bin\cef\cef.win7x64\crash_reporter.cfg" del "bin\cef\cef.win7x64\crash_reporter.cfg" /q
IF EXIST "bin\cef\cef.win7x64\debug.log" del "bin\cef\cef.win7x64\debug.log" /q
IF EXIST "crashhandler64.dll" del "crashhandler64.dll" /f /q
IF EXIST "crashhandler.dll" del "crashhandler.dll" /f /q
IF EXIST "crashhandler.dll.old" del "crashhandler.dll.old" /f /q
IF EXIST "steamerrorreporter.exe" del "steamerrorreporter.exe" /f /q
IF EXIST "steamerrorreporter64.exe" del "steamerrorreporter64.exe" /f /q
IF EXIST "WriteMiniDump.exe" del "WriteMiniDump.exe" /f /q

echo !ESC![92m2.!ESC![0m Entferne (sofern vorhanden) Crashdumps im Systemverzeichnis....
::Entferne Crashdumps
IF EXIST "%USERPROFILE%\AppData\Local\CrashDumps\*.*" del "%UserProfile%\AppData\Local\CrashDumps\*.*" /q

echo !ESC![92m3.!ESC![0m Entferne Crashlytics, Logs ^& Dumps von Drittanbietern....
::Crashlytics von Drittanbietern
del /s /f /q CrashUploader.Base.Azure.dll >nul 2>nul
del /s /f /q CrashUploader.Base.dll >nul 2>nul
del /s /f /q CrashUploader.Base.UI.dll >nul 2>nul
del /s /f /q CrashUploader.Publish.exe >nul 2>nul
del /s /f /q CrashUploader.Publish.exe.config >nul 2>nul
del /s /f /q crashpad_handler.exe >nul 2>nul
del /s /f /q CrashSender1403.exe >nul 2>nul
del /s /f /q crashrpt_lang.ini >nul 2>nul
del /s /f /q CrashRpt1403.dll >nul 2>nul
del /s /f /q CrashRptProbe1403.dll >nul 2>nul
del /s /f /q CrashReporter.dll >nul 2>nul
del /s /f /q CrashReporter.exe >nul 2>nul
del /s /f /q CrashUploader.Publish.exe.config >nul 2>nul
del /s /f /q CrashReporter.exe.config >nul 2>nul
del /s /f /q CrashReportClient.exe >nul 2>nul
del /s /f /q CrashReportClient.pdb >nul 2>nul
del /s /f /q CrashReporter.resources.dll >nul 2>nul
del /s /f /q REDEngineErrorReporter.exe >nul 2>nul
del /s /f /q UnityEngine.CrashReportingModule* >nul 2>nul
del /s /f /q *.dmp >nul 2>nul
del /s /f /q *.log >nul 2>nul

::Unity Analytics
set ORIGINAL_DIR=%CD%
set folder="steamapps\common"
for /f %%i in ('dir UnityCrashHandler*.exe /s /b 2^> nul ^| find "" /v /c') do set VAR=%%i
echo !ESC![92m4.!ESC![0m Entferne Unity Spyware und Crashlytics in Spieleverzeichnissen....
echo/
if [%VAR%]==[0] echo Super, es befanden sich keine UnityCrashHandler in den Spiele-Verzeichnissen
if %VAR% gtr 0 echo Es wurden !ESC![92m%VAR%!ESC![0m UnityCrashHandler aus den vorhandenen Spieleverzeichnissen gelîscht
IF EXIST "%folder%" (
    cd /d %folder%
for /f "delims=" %%i in ('dir /a-d /s /b 2^> nul ^ UnityCrashHandler*.exe') do del "%%~i"
)
chdir /d %ORIGINAL_DIR%
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

:Hosts_Block
@cls
echo/
echo Blocke einige BasiseintrÑge zu Tracking, Analytics ^& Spywaredienste mit Hilfe der hosts
echo/
echo !ESC![92m1.!ESC![0m EintrÑge werden in die hosts Datei geschrieben....
echo/
FIND /C /I "remote-config-proxy-prd.uca.cloud.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 remote-config-proxy-prd.uca.cloud.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "thind-gke-euw.prd.data.corp.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 thind-gke-euw.prd.data.corp.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "thind-gke-usc.prd.data.corp.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 thind-gke-usc.prd.data.corp.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "thind-gke-ape.prd.data.corp.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 thind-gke-ape.prd.data.corp.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "53.26.241.35.bc.googleusercontent.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 53.26.241.35.bc.googleusercontent.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "186.194.186.35.bc.googleusercontent.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 186.194.186.35.bc.googleusercontent.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "config.uca.cloud.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 config.uca.cloud.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "cdp.cloud.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 cdp.cloud.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "api.uca.cloud.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 api.uca.cloud.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "perf-events.cloud.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 perf-events.cloud.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "stats.unity3d.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 stats.unity3d.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "crash.steampowered.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 crash.steampowered.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "crashreporter.avalanchestudios.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 crashreporter.avalanchestudios.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "tracking.avalanchestudios.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 tracking.avalanchestudios.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "metrics.avalanchestudios.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 metrics.avalanchestudios.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "tracking2.avalanchestudios.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 tracking2.avalanchestudios.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "oldtracking.avalanchestudios.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 oldtracking.avalanchestudios.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "datarouter.ol.epicgames.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 datarouter.ol.epicgames.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "datarouter-weighted.ol.epicgames.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 datarouter-weighted.ol.epicgames.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "datarouter-prod.ak.epicgames.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 datarouter-prod.ak.epicgames.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "metrics.ol.epicgames.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 metrics.ol.epicgames.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "0.0.0.0 metric-public-service-prod.ol.epicgames.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 metric-public-service-prod.ol.epicgames.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "0.0.0.0 www.google-analytics.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 www.google-analytics.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "0.0.0.0 ssl.google-analytics.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 ssl.google-analytics.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "0.0.0.0 www-google-analytics.l.google.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 www-google-analytics.l.google.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "0.0.0.0 www.googletagmanager.com" %WINDIR%\system32\drivers\etc\hosts >nul 2>&1
IF %ERRORLEVEL% NEQ 0 ECHO 0.0.0.0 www.googletagmanager.com>>%WINDIR%\System32\drivers\etc\hosts
echo !ESC![92mFertig :]!ESC![0m
echo/
echo Weitere BlockeintrÑge fÅr Åber 1500 Spiele und Programme gibt es
echo auf der Webseite !ESC![92mhttps://hosts.gameindustry.eu!ESC![0m zu finden.
echo/
echo 1) ZurÅck zur Auswahl
echo 2) Batch schlie·en
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
::Wenn offen, beende Steam inkl. Unterprozessen
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
@cls
echo !ESC![92mDateiname:!ESC![0m %~nx0
@echo off
echo |set /p ="!ESC![92mHash:!ESC![0m "
CertUtil -hashfile "%~nx0" SHA256 | find /i /v "SHA256" | find /i /v "certutil"
echo/
echo !ESC![92mDatum:!ESC![0m          !ESC![92mBeschreibung:!ESC![0m
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
