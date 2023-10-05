@echo off

REM The path to your steam starfield game directory 
SET STARFIELD_GAME_DIR="D:\SteamLibrary\steamapps\common\Starfield"

REM The path to your repo base directory
SET REPO_BASE_DIR="C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling"

REM The path to where you used Champollion to decompile the Starfield PEX Scripts
SET IMPORT="%STARFIELD_GAME_DIR%\Data\Scripts\Source\Base"

REM The path to the Data\Scripts dir in you Starfield Game Dir
SET OUTPUT="%STARFIELD_GAME_DIR%\Data\Scripts"

REM The path to the distribution dir
SET DISTDIR="%REPO_BASE_DIR%\Dist"

SET FLAGS="%REPO_BASE_DIR%\Tools\Starfield_Papyrus_Flags.flg"
SET TOOLSPATH="%REPO_BASE_DIR%\Tools"

REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "%TOOLSPATH%"

cls
echo ****************************************************************
echo Caprica Starfield Compile
echo.

echo TOOLSPATH:  "%TOOLSPATH%"
echo IMPORT:     "%IMPORT%"
echo OUTPUT:     "%OUTPUT%"
echo FLAGS:      "%FLAGS%"
echo.

caprica.exe --game starfield --import "%IMPORT%" --flags "%FLAGS%" --output "%OUTPUT%" "%REPO_BASE_DIR%\Source\VPI_LevelBasedScaling.psc"
copy /y "%OUTPUT%\VPI_LevelBasedScaling.pex" "%DISTDIR%\Data\Scripts\VPI_LevelBasedScaling.pex"
copy /y "%REPO_BASE_DIR%\Source\LevelScalingConfig.txt" "%DISTDIR%\LevelScalingConfig.txt"