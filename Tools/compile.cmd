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
del /s /q "..\Dist\*.*"
rmdir /s /q "..\Dist"
mkdir "..\Dist"
mkdir "..\Dist\Data\Scripts"
mkdir "..\Dist\Data\Scripts\Source"
mkdir "..\Dist\Data\Batchfiles"
mkdir "..\Dist\Optional\Balanced\Data\Batchfiles"
mkdir "..\Dist\Optional\Hard\Data\Batchfiles"
mkdir "..\Dist\Optional\Experimental\Data\Batchfiles"

REM Deploy to Dist DIR
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "..\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_Helper.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_Helper.psc" "..\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "..\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_InitScript.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_InitScript.psc" "..\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "..\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_PlayerIntegration.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_PlayerIntegration.psc" "..\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "..\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_ConfigTerminal.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_ConfigTerminal.psc" "..\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "..\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPC_LootHandler.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPC_LootHandler.psc" "..\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "..\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPC_ScalingHandler.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPC_ScalingHandler.psc" "..\Dist\Data\Scripts\Source"

Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "..\Dist\Data\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_CloakAbilityApplier.psc"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_CloakAbilityApplier.psc" "..\Dist\Data\Scripts\Source"


REM ESM is purely binary so need to pull from starfield dir where xedit has to have it 
copy /y "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" "..\Source\esm"
copy /y "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" "..\dist\Data"

REM Convert the ESM to YAML and JSON
Spriggit.CLI.exe serialize --InputPath "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" --OutputPath "..\Source\esm\DynamicScaling" --GameRelease Starfield --PackageName Spriggit.Json.Starfield

REM Deploy configuration scripts
copy /y "..\Source\Batchfiles\vpi-ds-reset-vanilla.txt" "..\Dist\Data\Batchfiles"
copy /y "..\Source\Batchfiles\vpi-ds-reset-defaults.txt" "..\Dist\Data\Batchfiles"
copy /y "..\Source\Batchfiles\vpi-ds-reset-gamesettings-default.txt" "..\Dist\Data\Batchfiles"

REM Deploy Options Config Files
copy /y "..\Source\Batchfiles\vpi-ds-config-balanced.txt" "..\Dist\Optional\Balanced\Data\Batchfiles"
copy /y "..\Source\Batchfiles\vpi-ds-config-hard.txt" "..\Dist\Optional\Hard\Data\Batchfiles"
copy /y "..\Source\Batchfiles\vpi-ds-config-experimental.txt" "..\Dist\Optional\Experimental\Data\Batchfiles"