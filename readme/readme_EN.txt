Readme für die Del3UA Spywarecleaner Batch - Version 2.74 - von Gameindustry.eu

Inhalt:
1. Description
2. Installation
3. Deleted files
4. Latest changes
5. Problems
6. Source, Hashes



----------------- 1. Description -----------------

The batch scans files within the steam folder for crashlytics and logs and deletes associated files.
Additionally the CrashDump and Unity Analytics folder (if available) in the user directory are emptied.

This prevents a secret data mining and sending of Crashlytics by companies like Unity Technologies, ApS, Epic Games, Inc.
or the Valve Corporations and increases the own privacy during the own game sessions.

The script will be extended as needed.

The batch creates a "steam.cfg". This file prevents the automatic update of the Steam client.
This is necessary, because otherwise Steam downloads and overwrites files every time it is started.
Users who use their own layout modifications for Steam probably know this procedure. 



----------------- 2. Installation -----------------

Copy the file del_u3a_en.bat into your Steam installation folder and/or additional library folder and run the file. To uninstall, simply delete the batch.



----------------- 3. Deleted files -----------------

Following files and folders will be deleted:

- System
%username%\Appdata\Local\CrashDumps\*.*
%USERPROFILE%\AppData\LocalLow\Unity.
%USERPROFILE%\AppData\LocalLow\*.log

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

See section - 5. Problems
UnityEngine.CrashReportingModule.dll
UnityEngine.CrashReportingModule.dll.mdb
UnityEngine.PerformanceReportingModule.dll
Unity.MemoryProfiler.dll
UnityEngine.UnityTestProtocolModule.dll
System.Diagnostics.StackTrace.dll
UnityEngine.SpatialTracking.dll



----------------- 4. Latest changes -----------------

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



----------------- 6. Source, Hashes -----------------


Source: https://gameindustry.eu/
Author: Pengin
Version: 2.74
Date: 30.05.2021

File/s:
del_u3a_en.bat
Hash: 9194063f4c5bdb3da8d96f7f41ac223cdab693d8d009959b3838c6478c46a8b5