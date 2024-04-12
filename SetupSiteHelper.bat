REM Didn't quite use this code that I had to write because I found a powershell workaround. 
REM Apparently, dealing with the literal equals "=" is outside of the scope of 
REM batch variable substring substitutions :(

REM Convert equals sign HEX into ASCII where char is "="
set hex=0x3D
set /a num=%hex%
call cmd /c exit /b %num%
set char=%=exitCodeASCII%
SET lockedPath="C:\Windows\System32\inetsrv\config\applicationHost.config"

SET "new=lockitemASD^%char%^"false^""
SET "old=lockitem^%char%^"true^""
REM STEP 3: In inetsrv\config, set lockItem="true" to false TODO create temp file and overwrite original
 for /f "usebackq delims=" %%x in (%lockedPath%) do (
   SET t=%%x
   ECHO !t:%old%=%new%!
 ) 

REM Display all corrected lines with new pattern
FIND /N /I /C %original% %lockedPath%
FIND /N /I %updated% %lockedPath%