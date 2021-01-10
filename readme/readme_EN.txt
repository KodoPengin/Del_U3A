Name: Delete Crashlytics, logs and spyware from Steam and related (game) folders
Quelle: https://gameindustry.eu/
Author: Pengin
Version: 2.7
Date: 10.01.2021

File/s:
del_u3a_en.bat
Hash: 0c9f9a9e540d1f93ed626de9fd2730e9373475acbcf0ec35a96575f385df8476

--------------------------

Installation:

Copy the file del_u3a_en.bat into your Steam installation folder and/or additional library folder and run the file

--------------------------

Description:

The batch scans files within the steam folder for crashlytics and logs and deletes associated files.
Additionally the CrashDump folder (if available) in the user directory is emptied.

This prevents a secret data mining and sending of Crashlytics by companies like Unity Technologies, ApS, Epic Games, Inc.
or the Valve Corporations and increases the own privacy during the own game sessions.

The script will be extended as needed.

The batch creates a "steam.cfg". This file prevents the automatic update of the Steam client.
This is necessary, because otherwise Steam downloads and overwrites files every time it is started.
Users who use their own layout modifications for Steam probably know this procedure. 

--------------------------

hosts:

The hosts file is used for our purpose as protection against outbound traffic and sending our data.
The batch (Point 5) in this file is used to block some analytics of the company Unity Technologies
and crashlytics of Valve Corporation and Avalanche Studios.

hosts folder: C:\Windows\System32\drivers\etc

The batch inserts the following entries once (if they do not exist):

0.0.0.0 remote-config-proxy-prd.uca.cloud.unity3d.com
0.0.0.0 thind-gke-euw.prd.data.corp.unity3d.com
0.0.0.0 thind-gke-usc.prd.data.corp.unity3d.com
0.0.0.0 thind-gke-ape.prd.data.corp.unity3d.com
0.0.0.0 53.26.241.35.bc.googleusercontent.com
0.0.0.0 186.194.186.35.bc.googleusercontent.com
0.0.0.0 config.uca.cloud.unity3d.com
0.0.0.0 cdp.cloud.unity3d.com
0.0.0.0 api.uca.cloud.unity3d.com
0.0.0.0 perf-events.cloud.unity3d.com
0.0.0.0 stats.unity3d.com
0.0.0.0 crash.steampowered.com
0.0.0.0 crashreporter.avalanchestudios.com

More host entries for over 1300 games and programs
can be found on https://hosts.gameindustry.eu

--------------------------

Latest changes:

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

- Steam
bin\cef\cef.win7\*.*
dumps\*.*
bin\cef\cef.win7x64\crash_reporter.cfg
bin\cef\cef.win7x64\debug.log
.crash
crashhandler.dll
crashhandler64.dll
steamerrorreporter.exe
steamerrorreporter64.exe
WriteMiniDump.exe

- Third party crashlytics
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