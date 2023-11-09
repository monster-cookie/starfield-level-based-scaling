@echo off

REM Get Caprica from https://github.com/Orvid/Caprica currently installed is old manual compile -- v0.3.0 causes a io stream failure
REM Get Spriggit from https://github.com/Mutagen-Modding/Spriggit currently installed is 0.10

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
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Balanced\Data\Batchfiles"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Hard\Data\Batchfiles"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Experimental\Data\Batchfiles"

REM Deploy to Dist DIR
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source\Base;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_PlayerIntegration.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_PlayerIntegration.psc" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source\Base;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPCScaler.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPCScaler.psc" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source\Base;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_ConfigTerminal.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_ConfigTerminal.psc" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source\Base;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_Helper.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_Helper.psc" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source"


REM ESM can't is purly binary so need to pull from starfield dir where xedit has to have it 
copy /y "D:\SteamLibrary\steamapps\common\Starfield\Data\DynamicScaling.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\esm"
copy /y "D:\SteamLibrary\steamapps\common\Starfield\Data\DynamicScaling.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\dist\Data"


REM Convert the ESM to YAML and JSON
Spriggit.CLI.exe serialize --InputPath "D:\SteamLibrary\steamapps\common\Starfield\Data\DynamicScaling.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\esm\DynamicScaling" --GameRelease Starfield --PackageName Spriggit.Json.Starfield

copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-vanilla.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-defaults.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-gamesettings-default.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles"

REM Deploy Options Config Files
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-balanced.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Balanced\Data\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-hard.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Hard\Data\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-experimental.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Experimental\Data\Batchfiles"
