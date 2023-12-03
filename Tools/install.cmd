@echo off

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Tools"

REM DO NOT COPY THE ESM IN FROM THE DIST DIR XEDIT'S VERISON IS THE TRUTH

@echo "Deploying Main Archive to MO2 Mod DIR"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\DynamicScaling - Main.ba2" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental
