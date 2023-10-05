@echo off

REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools"

cls
echo ****************************************************************
echo Caprica Starfield Compile
echo.

echo "TOOLSPATH:  %TOOLSPATH%"
echo "IMPORT:     %IMPORT%"
echo "FLAGS:      %FLAGS%"
echo "DIST_DIR:   %DISTDIR%"
echo.


del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
caprica.exe --game starfield --import "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source\Base" --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\VPI_LevelBasedScaling.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_LevelBasedScaling.pex" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\LevelScalingConfig.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\LevelScalingConfig.txt"
