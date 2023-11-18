@echo off

@REM Get Caprica from https://github.com/Orvid/Caprica currently installed is old manual compile -- v0.3.0 causes a io stream failure
@REM Get Spriggit from https://github.com/Mutagen-Modding/Spriggit currently installed is 0.10

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools"

@REM Clear Dist DIR
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"

REM Clear Dist-BA2 DIR
@echo "Clearing and scafolding the Dist-BA2 dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\BatchFiles"

@REM Clear Dist-Optional-Hard DIR
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard\Batchfiles"

@REM Clear Dist-Optional-Balanced DIR
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced\Batchfiles"

@REM Clear Dist-Optional-Experimental DIR
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental\Batchfiles"


REM Deploy Scripts to Dist-BA2 folder
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_Helper.psc"
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_InitScript.psc"
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_PlayerIntegration.psc"
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_ConfigTerminal.psc"
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPC_LootHandler.psc"
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_NPC_ScalingHandler.psc"
Caprica-Experimental.exe --game starfield --flags "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools\Starfield_Papyrus_Flags.flg" --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus\VPI_DS_CloakAbilityApplier.psc"


REM ESM is purely binary so need to pull from starfield dir where xedit has to have it 
copy /y "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"

REM Convert the ESM to YAML and JSON
Spriggit.CLI.exe serialize --InputPath "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\ESM\DynamicScaling" --GameRelease Starfield --PackageName Spriggit.Json.Starfield

REM Deploy configuration scripts
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-vanilla.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-defaults.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-gamesettings-default.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Batchfiles"

@REM Deploy Optional Config Files
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-balanced.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-hard.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-experimental.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental\Batchfiles"

@REM Create and copy the BA2 to Dist folder
@echo "Creating the BA2 Archive"
.\BSArch64.exe pack "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2" "DynamicScaling - Main.ba2" -sf1 -mt
@echo "Copying the BA2 Archive to the Dist folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\DynamicScaling - Main.ba2" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
