REM Author: Ryan Freas
REM Date: 4/10/2024
REM Description: A simple batch script to move files around per Suja's doc (LocalSolutionSetUp1.docx)
REM Make sure SetupSite.bat in IREMRedesign (root folder) calls this bat file with call .\SetupSiteRelocate.bat

SET mypath=%~dp0
ECHO %mypath%
cd /d %mypath%

REM STEP 1

copy "%mypath%\iAppsBase\Working\FrontEnd\CMSFrontEndSite\bin\*" "%mypath%\CMSFrontEnd\bin"

REM STEP 2

copy "%mypath%\iAppsBase\Working\GACDLLs\DapperExtensions.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\EntityFramework.dll" "%mypath%\CMSFrontEnd\bin"
copy "%mypath%\iAppsBase\Working\GACDLLs\EntityFramework.sqlserver.dll" "%mypath%\CMSFrontEnd\bin"

REM STEP 3

copy "%mypath%\iAppsBase\Working\FrontEnd\CMSFrontEndSite\bin\Bridgeline.Unbound.Core.dll" "%mypath%\CMSFrontEnd\Irem.Custom"

exit