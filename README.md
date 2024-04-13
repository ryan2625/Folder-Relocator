# Folder-Relocator
A batch script with three bat files, where SetupSiteRelocate calls SetupSite.bat. These scripts are
part of a larger context not present in this repo. The script first copies over and moves certain files into different directories, then grants permissions to special users in other folders. Aftter that, it searches for a specified file and updates certain strings based on patterns you feed it. 

To see functionality of just the folders moving, delete step two and three in SetupSiteRelocate.bat
```
REM STEP 2
for /l %%n in (0,1,2) do ( 
   icacls "c:\Windows\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files" /grant:r !users[%%n]!:F
   icacls "c:\windows\temp" /grant:r !users[%%n]!:F
   icacls "%newPath%" /grant:r !users[%%n]!:F
)
REM STEP 3
powershell "(gc \"%lockedPath%\") -replace '%original%','%updated%'" > "%lockedPath%.tmp"
move /Y "%lockedPath%.tmp" "%lockedPath%"
```

## Getting started

Clone the repo
```bash
  git clone https://github.com/ryan2625/Folder-Relocator.git
```

Run the batch file in the command line
```bash
.\SetupSiteRelocate.bat
```
Open CMSFrontEnd/ and see the new files located in the subfolders
