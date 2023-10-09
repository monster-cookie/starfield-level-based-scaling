@echo off

REM Get Caprica from https://github.com/Orvid/Caprica

REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools"

cls
echo ****************************************************************
echo Caprica Starfield Compile
echo.

REM Clear Dist DIR
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\SFSE\plugins\ConsoleCommandRunner"

REM Deploy to Dist DIR
Caprica.exe --game starfield --import "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source\Base" --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_LevelBasedScaling.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_LevelBasedScaling.psc" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\LevelScalingConfig.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\CCR\LevelScalingConfig.toml" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\SFSE\plugins\ConsoleCommandRunner"
