# Folder-Relocator
A batch script with two bat files, where SetupSiteRelocate calls SetupSite.bat. These scripts are
part of a larger context not present in this repo. The script first copies over and moves certain files into different directories, then grants permissions to special users in other folders. 

To see functionality of just the folders moving, delete step two in SetupSiteRelocate.bat
```
for /l %%n in (0,1,2) do ( 
   icacls "c:\Windows\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files" /grant:r !users[%%n]!:F
   icacls "c:\windows\temp" /grant:r !users[%%n]!:F
   icacls "%newPath%" /grant:r !users[%%n]!:F
)
```

## Getting started

Clone the repo
```bash
  git clone https://github.com/ryan2625/Folder-Relocator.git
```

Run the batch file in the command line
```bash
.\SetupSite.bat
```
Open CMSFrontEnd/ and see the new files located in the subfolders
