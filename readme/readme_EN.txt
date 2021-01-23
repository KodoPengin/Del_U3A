Name: Delete Crashlytics, logs and spyware from Steam and related (game) folders
Quelle: https://gameindustry.eu/
Author: Pengin
Version: 2.72
Date: 23.01.2021

File/s:
del_u3a_en.bat
Hash: a3f7d910ee94c9b681c6df6fb16323873b00a5bbd661e4f5280c8fa093066414

--------------------------

Installation:

Copy the file del_u3a_en.bat into your Steam installation folder and/or additional library folder and run the file

--------------------------

Description:

The batch scans files within the steam folder for crashlytics and logs and deletes associated files.
Additionally the CrashDump and Unity Analytics folder (if available) in the user directory are emptied.

This prevents a secret data mining and sending of Crashlytics by companies like Unity Technologies, ApS, Epic Games, Inc.
or the Valve Corporations and increases the own privacy during the own game sessions.

The script will be extended as needed.

The batch creates a "steam.cfg". This file prevents the automatic update of the Steam client.
This is necessary, because otherwise Steam downloads and overwrites files every time it is started.
Users who use their own layout modifications for Steam probably know this procedure. 

--------------------------

Latest changes:

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

--------------------------

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