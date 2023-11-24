@echo off

REM Get latest 7zip cli from https://www.7-zip.org/download.html (Want x64 7Zip Extras package) see https://documentation.help/7-Zip/syntax.htm for online docs

REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools"

REM Clear Dist DIR
del /q "C:\Users\degre\Downloads\DynamicScaling.zip"
del /q "C:\Users\degre\Downloads\DynamicScaling-Config-Balanced.zip"
del /q "C:\Users\degre\Downloads\DynamicScaling-Config-Hard.zip"
del /q "C:\Users\degre\Downloads\DynamicScaling-Config-Experimental.zip"
del /q "C:\Users\degre\Downloads\DynamicScaling-Pilgrimage-Patch.zip"

REM Archive Dist Dir
.\7za.exe a -tzip "C:\Users\degre\Downloads\DynamicScaling.zip" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\*.*"
.\7za.exe a -tzip "C:\Users\degre\Downloads\DynamicScaling-Config-Balanced.zip" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced\Batchfiles"
.\7za.exe a -tzip "C:\Users\degre\Downloads\DynamicScaling-Config-Hard.zip" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard\Batchfiles"
.\7za.exe a -tzip "C:\Users\degre\Downloads\DynamicScaling-Config-Experimental.zip" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental\Batchfiles"
.\7za.exe a -tzip "C:\Users\degre\Downloads\DynamicScaling-Pilgrimage-Patch.zip" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Patch-Pilgrimage\*.*"
