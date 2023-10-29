@echo off

copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_PlayerIntegration.pex" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_PlayerIntegration.psc" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source"

copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_NPCScaler.pex" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_NPCScaler.psc" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source"

copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_Helper.pex" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_Helper.psc" "D:\SteamLibrary\steamapps\common\Starfield\Data\Scripts\Source"

REM Default and Reset Scripts
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles\vpi-ds-reset-vanilla.txt" "D:\SteamLibrary\steamapps\common\Starfield\Data\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles\vpi-ds-reset-defaults.txt" "D:\SteamLibrary\steamapps\common\Starfield\Data\Batchfiles"

REM Optional Config Scripts
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Balanced\Data\Batchfiles\vpi-ds-config-balanced.txt" "D:\SteamLibrary\steamapps\common\Starfield\Data\Batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Hard\Data\Batchfiles\vpi-ds-config-hard.txt" "D:\SteamLibrary\steamapps\common\Starfield\Data\Batchfiles"
REM copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Experimental\Data\Batchfiles\vpi-ds-config-experimental.txt" "D:\SteamLibrary\steamapps\common\Starfield\Data\Batchfiles"

REM DO NOT COPY THE ESM IN FROM THE DIST DIR XEDIT'S VERISON IS THE TRUTH
