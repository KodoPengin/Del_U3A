Readme for GI-Spywarecleaner - Version 2.76 - by Gameindustry.eu

Inhalt:
1. Description
2. Installation
3. Deleted files
4. Latest changes
5. Problems
6. Source, Hashes



----------------- 1. Description -----------------

The windows-batch-file scans files within the steam folder for crashlytics and logs and deletes associated files.
Additionally the CrashDump and Unity Analytics folder (if available) in the user directory are emptied.

This prevents a secret data mining and sending of Crashlytics by companies like Unity Technologies, ApS, Epic Games, Inc.
or the Valve Corporations and increases the own privacy during the own game sessions.

The script will be extended as needed.

The batch creates a "steam.cfg". This file prevents the automatic update of the Steam client.
This is necessary, because otherwise Steam downloads and overwrites files every time it is started.
Users who use their own layout modifications for Steam probably know this procedure. 



----------------- 2. Installation & execution -----------------

Copy the file del_u3a_en.bat into your Steam installation folder and/or additional library folder and run the file. In the library folders, steam.cfg is not necessary and can be deleted.
Remove the Steam.cfg in the installation directory of Steam itself only for client updates.

If new games with the same services are installed after deleting the existing spyware files and crashlytics, the batch can be run again to remove these files as well.


----------------- 3. Deleted files -----------------

Following files and folders will be deleted:

- System
%username%\Appdata\Local\CrashDumps\*.*
%USERPROFILE%\AppData\LocalLow\Unity.
%USERPROFILE%\AppData\LocalLow\*.log
%USERPROFILE%\AppData\Local\T2GP Launcher\app-1.0.4.2070\crashagent64.exe

- Steam
bin\cef\cef.win7\*.*
dumps\*.*
logs\*.*
bin\cef\cef.win7x64\crash_reporter.cfg
bin\cef\cef.win7x64\debug.log
.crash
crashhandler.dll
crashhandler64.dll
crashhandler.dll.old
steamerrorreporter.exe
steamerrorreporter64.exe
WriteMiniDump.exe

- Third party crashlytics, dumps, logs and unnecessary files
!! The deletion of files may take a while. Do not skip the progress

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

See section - 5. Problems
GameCrashUploader.exe (Manually delete GameCrashUploader.exe and instead create a dummy file with the same name and 0kb size)
UnityEngine.CrashReportingModule.dll
UnityEngine.CrashReportingModule.dll.mdb
UnityEngine.PerformanceReportingModule.dll
Unity.MemoryProfiler.dll
UnityEngine.UnityTestProtocolModule.dll
System.Diagnostics.StackTrace.dll
UnityEngine.SpatialTracking.dll



----------------- 4. Latest changes -----------------
- Code optimization
- Optimized deleting of spyware and unwanted files
- steam_autocloud.vdf, RemoteCrashSender.exe
- Several fixes, delete empty folders, new crashlytics
- Activision DLogUploader.exe
- Mafia 3 telemetry.dll and crashagent64.exe
- Added output_log.txt (crossover), Crashdump fix
- Added Apex Legend crashmsg.exe
- Added Amazon GameCrashUploader workaround, see Problems
- Disabled some Unityfiles and rewritten the readmes
- Deleted UnityEngine.UnityConnectModule.dll
- Added UnrealCEFSubProcess.exe
- Added Abbey Games Crashreporter
- Temporary deleted the hosts section and added more Unity Analytics stuff
- More Unity Analytics added to deletion list
- Added more files to the cleaning process
- 2s Timer added because the Script would be too fast - Option to delete modded friends.css files and added crashhandler.dll.old to list
- Several analytics and crashlytics can be blocked now
- Function added to delete the Cache folders
- Changed Menu structure, added Hash, filesize and history
- UnityEngine.CrashReportingModules added
- CD Projekt RED Crashlytics added
- Additional check if steam.cfg exist
- Better output for Unity Analytics
- CrashDump folder added
- More detailed info during the deleting process
- File-List attached
- A steam.cfg is written to the installation directory
- More Crashlytics from third party companies and Steam added
- Added more crashlytics from third party companies and Steam itself
- Fixed: Since last changes, there was an error which prevented the deletion of related files
- Surpressed error output with zero results
- Counter added for deleted files



----------------- 5. Problems -----------------

The files Unity.MemoryProfiler.dll, UnityEngine.CrashReportingModule.dll, UnityEngine.PerformanceReportingModule.dll, UnityEngine.UnityConnectModule.dll and UnityEngine.UnityTestProtocolModule.dll have been deactivated from the list of deleted files, because it differs depending on the product whether after removing the files the game itself still works or not. If you want, you can still test this out yourself.

There is currently no better solution. UnityCrashhandler can be removed from your system without hesitation.

For GameCrashUploader.exe it is sufficient to delete the file and create a text file named GameCrashUploader in the same directory and save it as exe. The file then has 0kb size and the product still runs.
Since the file size is not checked, it is thus sufficient to fool the respective game (New World).

----------------- 6. Source, Hashes -----------------


Source: https://gameindustry.eu/
Author: Pengin
Version: 2.76
Date: 20.03.2023

File/s:
del_u3a_en.bat
Hash: dfbb41a798dd7def15fc66bd1f003665e9b416dba03a0268491fb1731987c365
CRC32: f2754ccc