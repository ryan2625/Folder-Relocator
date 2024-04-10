@setlocal enableextensions
@cd /d "%~dp0"

call .\iAppsBase\SetupSite.bat IREMRedesign
%APPCMD% add vdir /app.name:"IREMRedesign/" /path:"/Configuration" /physicalPath:"%CD%\Libraries\Configuration"
call .\SetupSiteRelocate.bat