@echo off

@REM Get Caprica from https://github.com/Orvid/Caprica currently installed is old manual compile -- v0.3.0 causes a io stream failure

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools"

@REM Clear Dist DIR
@echo "Clearing and scafolding the Dist dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"

@REM Clear Dist-BA2-Main DIR
@echo "Clearing and scafolding the Dist-BA2-Main dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main\Scripts"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main\BatchFiles"

@REM Clear Dist-Optional-Hard DIR
@REM @echo "Clearing and scafolding the Dist-Optional-Hard dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard\Batchfiles"

@REM Clear Dist-Optional-Balanced DIR
@REM @echo "Clearing and scafolding the Dist-Optional-Balanced dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced\Batchfiles"

@REM Clear Dist-Optional-Experimental DIR
@REM @echo "Clearing and scafolding the Dist-Optional-Experimental dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental\Batchfiles"

@REM Clear Dist-Patch-Pilgrimage DIR
@REM @echo "Clearing and scafolding the Dist-Patch-Pilgrimage dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Patch-Pilgrimage\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Patch-Pilgrimage"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Patch-Pilgrimage"

@REM Compile and deploy Scripts to Dist-BA2-Main folder
@echo "Compiling all script in Source/Papyrus to Dist-BA2-Main folder"
"D:\Program Files\PexTools\Caprica-0.3.0.exe" --game starfield --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-venpi-core\Source\Papyrus;C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Papyrus" -R -q && (
  @echo "Compile all scripts has successfully compiled"
  (call )
) || (
  @echo "Error:  Compile all scripts has failed to compile <======================================="
  exit /b 1
)


@REM ESM is purely binary so need to pull from starfield dir where xedit has to have it 
@echo "Copying the ESM from MO2 into the Dist folder"
copy /y "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\DynamicScaling.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
copy /y "D:\MO2Staging\Starfield\mods\DynamicScaling-Pilgrimage-Patch\DynamicScaling-Pilgrimage-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\DynamicScaling-Pilgrimage-Patch\DynamicScaling-Pilgrimage-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Patch-Pilgrimage"

@REM Deploy configuration scripts
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-vanilla.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-defaults.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-reset-gamesettings-default.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2\Batchfiles"

@REM Deploy Optional Config Files
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-balanced.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Balanced\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-hard.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Hard\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Source\Batchfiles\vpi-ds-config-experimental.txt" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-Optional-Experimental\Batchfiles"

@REM Create and copy the BA2 Main Archive to Dist folder
@echo "Creating the BA2 Main Archive"
"D:\Program Files\xEdit\BSArch64.exe" pack "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main" "DynamicScaling - Main.ba2" -sf1 -mt && (
  @echo "Main Archive successfully assembled"
  (call )
) || (
  @echo "ERROR:  Main Archive failed to assemble <======================================="
  exit /b 1
)

@REM Copying the BA2 Main Archive to the Dist folder
@echo "Copying the Main Archive to the Dist folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist-BA2-Main\DynamicScaling - Main.ba2" "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist"
