@echo off
set "filename=%~nx0"
SET version="v2.76"
for %%A in (%filename%) do title GameIndustry.eu - Spyware ^& Crashlytics Cleaner for Steam - %version% - %%~zA
SETLOCAL EnableExtensions DisableDelayedExpansion
for /F %%a in ('echo prompt $E ^| cmd') do (
  set "ESC=%%a"
)
:menu
SETLOCAL EnableDelayedExpansion
echo !ESC![92m
echo -------------------------------------------------------------------------
echo # This script deletes crashyltics, logs and spyware from the            #
echo # Steamfolder and from related (game) folders, clean the cache folders  #
echo # and deletes modding leftovers from custom.css files if necessary      #
echo # (c) by GameIndustry.eu - 20 Mar 2023 - %version%                      #
echo -------------------------------------------------------------------------
echo/!ESC![0m

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Request admin rights to remove the files
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

:: Security question
echo !ESC![31mAttention - Active Steaminstances will be closed.!ESC![0m
echo/
echo Do you want to continue? Press [Y]
echo If you want to cancel the process, press [N]. 
echo/
if exist "%SystemRoot%\System32\choice.exe" goto UseChoice

setlocal EnableExtensions EnableDelayedExpansion
:UseSetPrompt
set "UserChoice=N"
set /P "UserChoice=Are you sure [Y/N]? "
set "UserChoice=!UserChoice: =!"
if /I "!UserChoice!" == "N" endlocal & goto :EOF
if /I not "!UserChoice!" == "Y" goto UseSetPrompt
endlocal
goto Continue

:UseChoice
%SystemRoot%\System32\choice.exe /C YN /N /M "Are you sure [Y/N] "
if errorlevel 2 goto :EOF

:Continue

@echo off
:home
cls
echo/
echo Initialization of "%~nx0" for user: %USERNAME%
echo/
echo !ESC![92mSteam-Client: Privacy!ESC![0m
echo 1) Clean CrashHandler, Crashlytics ^& Spyware
echo/
echo !ESC![92mSteam-Client: Maintenance!ESC![0m
echo !ESC![92mSteam-Client: Maintenance (Use the options only when risks are aware.)!ESC![0m
echo 2) Clean Library Cache
echo 3) Clean Picture, Download ^& Shadercache
echo 4) Clean HTML-Cache (Allow Steam to update once after execution)
echo 5) Clean Modding leftovers (Delete Custom css files)
echo/
echo !ESC![92mMain Menu!ESC![0m
echo 6) Version history
echo 7) Close batch
echo/
echo !ESC![92mLinks!ESC![0m
echo 8) About this Script
echo.
set /p navi=Choose:
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
::Close open Steam tasks
echo/
echo Active Steam instances will be closed...
echo !ESC![31mThe process may take some time depending on the size and amount of the folders.!ESC![0m
::If open, close Steam
taskkill /F /T /IM steam.exe >nul 2>&1

::steam.cfg
IF EXIST "steam.cfg" (
echo/
goto :Crash
) ELSE (
echo Eine !ESC![4msteam.cfg!ESC![0m was created...
echo/
@echo off
echo BootStrapperInhibitAll=enable> steam.cfg
echo BootStrapperForceSelfUpdate=disable>> steam.cfg
)

:Crash
echo !ESC![92m1.!ESC![0m Delete Crashlytics, Dumps and Logs related to Valve Corporation....
::Delete files related to logging and tracking
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

echo !ESC![92m2.!ESC![0m Delete (if exist) Crashdumps from system folder....
::Entferne Crashdumps
set "foldersToDelete=%userprofile%\AppData\Local\CrashDumps %userprofile%\AppData\Local\CEF\User Data\Crashpad %userprofile%\AppData\Local\CrashReportClient %userprofile%\AppData\Local\T2GP Launcher\app-1.0.4.2070 %userprofile%\AppData\Local\GameAnalytics %userprofile%\AppData\Local\UnrealEngine %userprofile%\AppData\Local\UniSDK %userprofile%\AppData\Local\BuffPanel"

for %%i in (%foldersToDelete%) do (
    if exist "%%i" (
        rd /s /q "%%i"
    )
)

echo !ESC![92m3.!ESC![0m Delete Crashhandler, CrashHandler, Logs, Dumps, empty folders ^& unnecessary stuff from Third party companies....
::Crashlytics from Third party companies
echo/
setlocal

set "filelist=CrashReport.exe CrashUploader.Base.Azure.dll CrashUploader.Base.dll CrashUploader.Base.UI.dll CrashUploader.Publish.exe CrashUploader.Publish.exe.config crashpad_handler.exe CrashSender1402.exe CrashSender1403.exe crashrpt_lang.ini CrashRpt1403.dll CrashRptProbe1403.dll CrashReporter.dll CrashReporter.exe CrashUploader.Publish.exe.config CrashReporter.exe.config CrashReportClient.exe DLogUploader.exe UnrealCEFSubProcess.exe CrashReportClient.pdb CrashReporter.resources.dll REDEngineErrorReporter.exe abbey_crash_reporter.exe crashmsg.exe output_log.txt telemetry64.dll apex_crash_handler.exe RemoteCrashSender.exe BsSndRpt.exe BugSplatRc.dll BsUnityCrashHandler.exe log.txt steam_autocloud.vdf UnityCrashHandler32.exe UnityCrashHandler64.exe"

for /f "delims=" %%i in ('dir /b /s %filelist% 2^>nul') do (
    echo "%%i" was deleted.
    del "%%i"
)
for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do rd "%%d" >nul 2>nul
echo/
echo !ESC![92mDone:]!ESC![0m
echo/
echo !ESC![92m1.!ESC![0m Back to Menu
echo !ESC![92m2.!ESC![0m Close Batch
echo/
set /p navi=Choose:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:Biblio
@cls
echo Delete Library-Cache (Can take a little while)
echo/
echo !ESC![92m1.!ESC![0m Delete Library-Cache....
echo/
IF EXIST "appcache\httpcache\*.*" del "appcache\httpcache\" /q
IF EXIST "appcache\httpcache\" RMDIR "appcache\httpcache\" /s /q
IF EXIST "appcache\librarycache\*.*" del "appcache\librarycache\" /q
IF EXIST "appcache\librarycache\" RMDIR "appcache\librarycache\" /s /q
IF EXIST "appcache\stats\*.*" del "appcache\stats\" /q
IF EXIST "appcache\stats\" RMDIR "appcache\stats\" /s /q
echo/
echo !ESC![92mDone:]!ESC![0m
echo/
echo !ESC![92m1.!ESC![0m Back to Menu
echo !ESC![92m2.!ESC![0m Close Batch
echo/
set /p navi=Choose:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:DL_Cache
@cls
echo Delete Teaser, Download, Depot ^& Shadercache (Can take a little while)
echo/
echo !ESC![92m1.!ESC![0m Delete Download-Cache....
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
echo !ESC![92mDone:]!ESC![0m
echo/
echo !ESC![92m1.!ESC![0m Back to Menu
echo !ESC![92m2.!ESC![0m Close Batch
echo/
set /p navi=Choose:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:HT_Cache
@cls
echo/
echo Delete HTML-Cache
echo Active Steam instances will be closed...
taskkill /F /T /IM steam.exe >nul 2>&1
echo/
echo !ESC![92m1.!ESC![0m Delete HTML-Cache....
echo/
IF EXIST "%userprofile%\AppData\Local\Steam\htmlcache\Cache\*.*" del "%userprofile%\AppData\Local\Steam\htmlcache\Cache\*.*" /q >nul 2>&1
echo !ESC![92mDone:]!ESC![0m
echo/
echo !ESC![92m1.!ESC![0m Back to Menu
echo !ESC![92m2.!ESC![0m Close Batch
echo/
set /p navi=Choose:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:CF_Del
@cls
echo Modding leftovers will be deleted
echo/
echo !ESC![92m1.!ESC![0m Deleting modifications....
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
echo !ESC![92mDone:]!ESC![0m
echo/
echo !ESC![92m1.!ESC![0m Back to Menu
echo !ESC![92m2.!ESC![0m Close Batch
echo/
set /p navi=Choose:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:Version
cls
echo !ESC![92mVersion history:!ESC![0m 
echo/
echo !ESC![92mDatum:!ESC![0m          !ESC![92mBeschreibung:!ESC![0m
echo 10.03.2023      Optimized deleting of Spyware and unwanted files.
echo 25.02.2023      Added steam_autocloud.vdf, RemoteCrashSender.exe
echo 28.12.2022      Several fixes, delete empty folders, new crashlytics
echo 05.05.2022      Activision DLogUploader.exe
echo 06.12.2021      Mafia 3 telemetry.dll and crashagent64.exe
echo 22.11.2021      Added output_log.txt, Crashdump fix
echo 21.11.2021      Added crashmsg.exe
echo 15.10.2021      Added Amazon GameCrashUploader.exe to list
echo 30.05.2021      Disabled some Unityfiles and rewritten the readmes
echo 20.03.2021      Deleted UnityEngine.UnityConnectModule.dll
echo 18.03.2021      Added UnrealCEFSubProcess.exe 
echo 17.02.2021      Added Abbey Games Crashreporter
echo 17.01.2021      Temporary deleted the hosts section and added more Unity Analytics stuff
echo 15.01.2021      Added more Unity files to cleaning process
echo 13.01.2021      2s Timer added because the Script would be too fast - Option to delete modded friends.css
echo                 files and added crashhandler.dll.old to list
echo 12.01.2021      Added Avalanche Analytics, Epic Games Datarouter, Google Analytics and Tagmananger
echo 07.01.2021      Function to delete several Cache folders, Taskkill optimization
echo                 Several services can be blocked via hosts, see readme
echo 06.01.2021      History function from Thunderfox Script, Menu overhaul,
echo                 Hash, filesize and history added
echo/
echo !ESC![92m1.!ESC![0m Back to Menu
echo !ESC![92m2.!ESC![0m Close Batch
echo/
set /p navi=Choose:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause

:about
cls
echo !ESC![92mAbout this Script!ESC![0m
echo/
echo Donate:   gameindustry.eu/de/donations/
echo Contact:   gameindustry.eu/de/kontakt/
echo Website:  gameindustry.eu/
echo Author:     Pengin
echo/
set "filename=%~nx0"
for %%A in (%filename%) do echo.!ESC![92mDateiname:!ESC![0m %~nx0 - %%~zA bytes
@echo off
echo |set /p ="!ESC![92mSHA256:!ESC![0m "
CertUtil -hashfile "%~nx0" SHA256 | find /i /v "SHA256" | find /i /v "certutil"
echo/
echo !ESC![92m1.!ESC![0m Back to Menu
echo !ESC![92m2.!ESC![0m Close Batch
echo/
set /p navi=Choose:
cls
if "%navi%"=="1" goto home
if "%navi%"=="2" exit
Pause