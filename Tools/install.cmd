@echo off

REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools"

copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_LevelBasedScaling.pex" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\LevelScalingConfig.txt" "D:\SteamLibrary\steamapps\common\Starfield"
