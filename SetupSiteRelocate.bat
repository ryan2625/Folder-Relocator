@echo off
REM Author: Ryan Freas
REM Date: 4/10/2024
REM Description: A simple batch script to move files around, grant permissions, and update files per Suja's doc (LocalSolutionSetUp1.docx)
REM Make sure SetupSite.bat calls this script (call .\SetupSiteRelocate.bat) and this bat is run as ADMIN

REM Enable the use of expanding variables for loops (!string! syntax)
setlocal enabledelayedexpansion 

REM Set current dir to base path then navigate to it 
SET mypath=%~dp0
cd /d %mypath%

REM mypath has a trailing \ that causes icacls to fail, remove it
SET newPath=%mypath:~0,-1%
SET lockedPath="C:\Windows\System32\inetsrv\config\applicationHost.config"

REM Variable names for the string to replace. The syntax seems weird but
REM double quotes are an escape char 
SET original=lockitem=""true"

SET updated=lockitem=""false"

REM Users we need to grant access to
SET users[0]="IUSR"
SET users[1]="NETWORK SERVICE"
SET users[2]="IIS_IUSRS"

REM Path will probably exist due to nature of %~dp0 throw error if not
IF NOT EXIST "%mypath%" GOTO NOPATH

REM STEP 1: Copy folders into appropriate directory
copy "%mypath%\iAppsBase\Working\FrontEnd\CMSFrontEndSite\bin\*" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\DapperExtensions.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\EntityFramework.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\EntityFramework.sqlserver.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\FrontEnd\CMSFrontEndSite\bin\Bridgeline.Unbound.Core.dll" "%mypath%\Irem.Custom"

REM STEP 2: Grant FULL permissions to local instance, windows temp, and temp ASP.NET files folders
REM Where we use %%n to get the value at the index in users arr and the :F flag to grant full control
for /l %%n in (0,1,2) do ( 
   icacls "c:\Windows\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files" /grant:r !users[%%n]!:F
   icacls "c:\windows\temp" /grant:r !users[%%n]!:F
   icacls "%newPath%" /grant:r !users[%%n]!:F
)

IF NOT EXIST "%lockedPath%" GOTO NOCONFIGPATH

REM Display all lines to be corrected
FIND /N /I  "lockitem=""true""" %lockedPath%
FIND /C "lockitem=""false""" %lockedPath%

REM STEP 3: Replace strings in applicationHost.config
REM Get content of applicationHost.config, search for string and replace it with our updated version
REM Save result of this in file applicationHost.config.tmp
powershell "(gc \"%lockedPath%\") -replace '%original%','%updated%'" > "%lockedPath%.tmp"
REM Replace original file with our updated version with the same name
move /Y "%lockedPath%.tmp" "%lockedPath%"

REM Display changes showing we updated the file to lockitem="false". Will not print if file already updated
FIND /N /I "lockitem=""false""" %lockedPath%
FIND /C "lockitem=""true""" %lockedPath%

REM Print Error and stop execution if path not valid
:NOPATH
IF NOT EXIST "%mypath%" (
    ECHO ERR could not find path (%mypath%)
)

REM Print Error and stop execution if config path is not valid - could be related to not having IIS installed
:NOCONFIGPATH
IF NOT EXIST "%lockedPath%" (
    ECHO ERR Do you have IIS installed^? Could not find path (%lockedPath%)
)

REM exit
