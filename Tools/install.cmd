@echo off

@echo "Deploying the VPI_Helper script"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_Helper.pex" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_Helper.psc" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts\source"

@echo "Deploying the VPI_DS_InitScript script"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_InitScript.pex" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_InitScript.psc" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts\source"

@echo "Deploying the VPI_DS_PlayerIntegration script"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_PlayerIntegration.pex" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_PlayerIntegration.psc" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts\source"

@echo "Deploying the VPI_DS_ConfigTerminal script"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_ConfigTerminal.pex" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_ConfigTerminal.psc" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts\source"

@echo "Deploying the VPI_DS_NPC_LootHandler script"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_NPC_LootHandler.pex" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_NPC_LootHandler.psc" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts\source"

@echo "Deploying the VPI_DS_NPC_ScalingHandler script"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_NPC_ScalingHandler.pex" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_NPC_ScalingHandler.psc" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts\source"

@echo "Deploying the VPI_DS_CloakAbilityApplier script"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\VPI_DS_CloakAbilityApplier.pex" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Scripts\Source\VPI_DS_CloakAbilityApplier.psc" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\scripts\source"


REM Default and Reset Scripts
@echo "Deploying the configuration batch files"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles\vpi-ds-reset-vanilla.txt" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles\vpi-ds-reset-defaults.txt" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Data\Batchfiles\vpi-ds-reset-gamesettings-default.txt" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\batchfiles"

REM Optional Config Scripts
@echo "Deploying the optional configuration batch files"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Balanced\Data\Batchfiles\vpi-ds-config-balanced.txt" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\batchfiles"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Hard\Data\Batchfiles\vpi-ds-config-hard.txt" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\batchfiles"
REM copy /y "C:\Repositories\Public\Starfield Mods\starfield-level-based-scaling\Dist\Optional\Experimental\Data\Batchfiles\vpi-ds-config-experimental.txt" "D:\MO2Staging\Starfield\mods\DynamicScalingExperimental\batchfiles"

REM DO NOT COPY THE ESM IN FROM THE DIST DIR XEDIT'S VERISON IS THE TRUTH
