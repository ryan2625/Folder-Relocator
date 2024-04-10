REM Author: Ryan Freas
REM Date: 4/10/2024
REM Description: A simple batch script to move files around per Suja's doc (LocalSolutionSetUp1.docx)
REM Make sure SetupSite.bat calls this script (call .\SetupSiteRelocate.bat) and this bat is run as ADMIN

REM Enable the use of for loops
setlocal enabledelayedexpansion 

REM Set current dir to base path then navigate to it
SET mypath=%~dp0
SET newPath=%mypath:~0,-1%
SET users[0]="IUSR"
SET users[1]="NETWORK SERVICE"
SET users[2]="IIS_IUSRS"
ECHO %mypath%
cd /d %mypath%

REM STEP 1: Move folders into appropriate directory
copy "%mypath%\iAppsBase\Working\FrontEnd\CMSFrontEndSite\bin\*" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\DapperExtensions.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\EntityFramework.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\EntityFramework.sqlserver.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\FrontEnd\CMSFrontEndSite\bin\Bridgeline.Unbound.Core.dll" "%mypath%\CMSFrontEnd\Irem.Custom"

REM STEP 2: Grant permissions to local instance, windows temp, and temp ASP.NET files folders
for /l %%n in (0,1,2) do ( 
   icacls "c:\Windows\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files" /grant:r !users[%%n]!:F
   icacls "c:\windows\temp" /grant:r !users[%%n]!:F
   icacls "%newPath%" /grant:r !users[%%n]!:F
)

REM exit