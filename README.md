# Dynamic Scaling (Eventually) for Starfield

A mod for Starfield to add dynamic scaling for Damage, Health, NPC Levels, and Experience.

See https://www.nexusmods.com/starfield/mods/4277


## Global Variables
Use "set XX?????? to YY' to set these values below. XX is the load order on your system use MO2 or LOOT to find the current index. ????? is 
the form ID below. YY is the new value to set. 

| Form ID | Global Varaible                        | Default Value |
| 000856  | BaseNPCHealthBonus                     | 5             |
| 000857  | BasePlayerHealthBonus                  | 5             |
| 000858  | BaseLowLevelNPCHealthAdjustment        | 0.05          |
| 000859  | BaseLowLevelNPCVsPlayerLevelDifference | 5             |
| 00085A  | BaseDamageToPlayerVE                   | 0.5           |
| 00085B  | BaseDamageToPlayerE                    | 0.75          |
| 00085C  | BaseDamageToPlayerN                    | 1.00          |
| 00085D  | BaseDamageToPlayerH                    | 1.50          |
| 00085E  | BaseDamageToPlayerVH                   | 2.00          |
| 00085F  | BaseDamageByPlayerVE                   | 2.00          |
| 000860  | BaseDamageByPlayerE                    | 1.50          |
| 000861  | BaseDamageByPlayerN                    | 1.00          |
| 000862  | BaseDamageByPlayerH                    | 0.75          |
| 000863  | BaseDamageByPlayerVH                   | 0.50          |
| 000864  | BaseResistanceScalingFactor            | 0.0015        |
| 000865  | BasePerkAdjustmentDamageReduction      | 0.25          |
| 000866  | BasePerkAdjustmentDamageAdd            | 0.25          |


## Commands

### Configure Scaling Factor for Damage To Player
Change a scaling factor in the specified level bracket for damage to player 

Execute using: player.cf "SetDamageToPlayerSFForBracket" <bracket> <newSF>
* bracket -> The bracket to change can be 1 to 10 only
* newSF -> The new scale factor to set for the bracket

### Configure Scaling Factor for Damage By Player
Change a scaling factor in the specified level bracket for damage by player 

Execute using: player.cf "SetDamageByPlayerSFForBracket" <bracket> <newSF>
* bracket -> The bracket to change can be 1 to 10 only
* newSF -> The new scale factor to set for the bracket

### Configure Scaling Factor for NPC Bonus Health
Change a scaling factor in the specified level bracket for bonus health given to NPC on level 

Execute using: player.cf "SetNPCBonusHealthSFForBracket" <bracket> <newSF>
* bracket -> The bracket to change can be 1 to 10 only
* newSF -> The new scale factor to set for the bracket

### Configure Scaling Factor for Player Bonus Health
Change a scaling factor in the specified level bracket for bonus health given to the Player on level 

Execute using: player.cf "SetPCBonusHealthSFForBracket" <bracket> <newSF>
* bracket -> The bracket to change can be 1 to 10 only
* newSF -> The new scale factor to set for the bracket

### Configure Scaling Factor for the Low Level NPCs Adjustments
Change a scaling factor in the specified level bracket for adjustment done to a low level NPC to match player's current health and resists 

Execute using: player.cf "SetLowLevelNPCHealthAdjustmentValueForBracket" <bracket> <newSF>
* bracket -> The bracket to change can be 1 to 10 only
* newSF -> The new scale factor to set for the bracket

### Scale Settings
Update Starfield Damage Scaling, NCP Levels, and Experience Game Settings for my current level and the scaling factors for that level. This 
also happens automatically on location change, difficulty change, or NPC kills. 

Execute using: player.cf "ScaleSettings"

### Get Current Scaling Settings for Difficulty and Level
Get the current level scaling settings for your level and difficulty mode

Execute using: player.cf "GetScalingMatrix"

### Dump Level Scaling Config
Get the current level scaling config from the player object and global variables

Execute using: player.cf "DumpLevelScalingConfig"

