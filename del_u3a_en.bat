@echo off
set "filename=%~nx0"
for %%A in (%filename%) do title GameIndustry.eu - Spyware ^& Crashlytics Cleaner for Steam - v2.71 - %%~zA bytes
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
echo # and creates a hosts file if necessary to block some connections       #
echo # (c) by GameIndustry.eu - 15 January 2021 - Version 2.71                #
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
echo !ESC![92mSteam-Client!ESC![0m
echo 1) Clean Crashlytics ^& Spyware
echo 2) Clean Library Cache
echo 3) Clean Picture, Download ^& Shadercache
echo 4) Clean HTML-Cache (Allow Steam to update once after execution)
echo 5) Clean Modding leftovers (Custom css files)
echo/
echo !ESC![92mHosts!ESC![0m
echo 6) Block several Spyware ^& Crashlytics via hosts
echo/
echo !ESC![92mMain Menu!ESC![0m
echo 7) Version history
echo 8) Close batch
echo.
set /p navi=Choose:
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
::Close open Steam tasks
echo/
echo Active Steam instances will be closed...
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

echo !ESC![92m2.!ESC![0m Delete (if exist) Crashdumps from system folder....!ESC![92mOK!ESC![0m
::Entferne Crashdumps
IF EXIST "%USERPROFILE%\AppData\Local\CrashDumps\*.*" del "%UserProfile%\AppData\Local\CrashDumps\*.*" /q

echo !ESC![92m3.!ESC![0m Delete Crashlytics, Logs, Dumps ^& unnecessary stuff from Third party companies....
::Crashlytics from Third party companies
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
del /s /f /q UnityEngine.PerformanceReportingModule.dll >nul 2>nul
del /s /f /q Unity.MemoryProfiler.dll >nul 2>nul
del /s /f /q UnityEngine.UnityConnectModule.dll >nul 2>nul
del /s /f /q UnityEngine.UnityTestProtocolModule.dll >nul 2>nul
del /s /f /q System.Diagnostics.StackTrace.dll >nul 2>nul
del /s /f /q UnityEngine.SpatialTracking.dll >nul 2>nul
del /s /f /q *.dmp >nul 2>nul
del /s /f /q *.log >nul 2>nul

::Unity Analytics
set ORIGINAL_DIR=%CD%
set folder="steamapps\common"
for /f %%i in ('dir UnityCrashHandler*.exe /s /b 2^> nul ^| find "" /v /c') do set VAR=%%i
echo !ESC![92m4.!ESC![0m Delete Unity Spyware and Crashlytics in game folders....
echo/
if [%VAR%]==[0] echo Great. There were no UnityCrashHandler in game folders.
if %VAR% gtr 0 echo !ESC![92m%VAR%!ESC![0m UnityCrashHandler were deleted from game folders
IF EXIST "%folder%" (
    cd /d %folder%
for /f "delims=" %%i in ('dir /a-d /s /b 2^> nul ^ UnityCrashHandler*.exe') do del "%%~i"
)
chdir /d %ORIGINAL_DIR%
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

:Hosts_Block
@cls
echo/
echo Blocking some basic tracker, analytics and spyware services via hosts
echo/
echo !ESC![92m1.!ESC![0m Write entries to hosts....
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
echo !ESC![92mDone:]!ESC![0m
echo/
echo More host entries for over 1500 games and programs
echo can be found on !ESC![92mhttps://hosts.gameindustry.eu!ESC![0m.
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
echo Delete Download-Cache ^& Shadercache (Can take a little while)
echo/
echo !ESC![92m1.!ESC![0m Delete Download-Cache....
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
@cls
echo !ESC![92mFilename:!ESC![0m %~nx0
@echo off
echo |set /p ="!ESC![92mHash:!ESC![0m "
CertUtil -hashfile "%~nx0" SHA256 | find /i /v "SHA256" | find /i /v "certutil"
echo/
echo !ESC![92mDate:!ESC![0m           !ESC![92mDescription:!ESC![0m
echo 15.01.2021      Added more Unity files to cleaning process
echo 13.01.2021      2s Timer added because the Script would be too fast - Option to delete modded friends.css
echo                 files and added crashhandler.dll.old to list
echo 12.01.2021      Added Avalanche Analytics, Epic Games Datarouter, Google Analytics and Tagmananger
echo 07.01.2021      Function to delete several Cache folders, Taskkill optimization
echo                 Several services can be blocked via hosts, see readme
echo 06.01.2021      History function from Thunderfox Script, Menu overhaul,
echo                 Hash, filesize and history added
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