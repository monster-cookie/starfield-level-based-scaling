# V2.1 Full Dynamic Scaling

## V2.1.7
* Removed the NPC Scaler/Loot stuff
* Added configuration for enable/disable debug mode

## V2.1.6
* NPC REsize functions have been removed and moved to the new NPC Resizer Mod

## V2.1.5
* Full usage and compatibility with VenpiCore
* Pilgrimage Patch has updates for the latest version

## V2.1.4
* All combat factions now are using the same logic for both scaling and group spawning. 
* Maybe hopefully fixed the loot explosion issues
* I still need to implement the First's and Starborn's MK versioned NPCs

## V2.1.3
* Added a new global for legendary spawn chance which is the change dynamic scaling will make a legendary from a normal. Fixing dynamic scaling effectively removing the legendary buffs for the legendary NPCs, I noticed it was making legendary mobs way too much. The chance is now 25% instead of 50%. The new variable is DSLegendaryChangeNotToSpawn and its default values is 75%. It is configurable in the terminal. 

## V2.1.2
* Added new feature flag for random groups of NPCs instead of 1 NP you will get 2-4 based on chance. MK5 will be capped at 2 and only 10% chance, the other types will have 4 (10%), 3 (20%), or 2 (40%). 
* Random group sizes only enabled on Crimson Fleet/Pirate faction for feedback on spawn rates. 
* Legendary's are no longer scaled, scaling was making them way weaker stats wise but not visually. They will hit hard and be hard to kill again. 
* Changed the default for the NPC resize easter egg to off it was fun for a while but it cause weird engine scaling glitches on death. 

## V2.1.1
* No more loose files everything is one BA2 now which should make manual installs way easier. Please remove the vpi* scripts and batch files from data\scripts, data\scripts\source, and data\batchfiles. Hopefully your organizer will remove them but with how new the plugin for Starfield is they probably will not. Vortex user please us Starfield plugin 0.5.6 or newer. 

## V2.1.0
* Full dynamic scaling via the cloak effect is functional and working. There is still some intentional random variance and MK1 (--) will hit way less and take more damage then MK5 (++) NPCs. 
* MK5 now have a 50% chance to force into T3 legendary versions with even high stats then a legendary normally would have. 
* I still need to implement the First's and Starborn's MK versioned NPCs I will get them this weekend its just cut and paste work :) 
* Loot is actual fixed with a MAJOR caveat, you need a new NGP session or game. Apparent the engine pre makes some stuff on universe creation and the only way to reset it is a new NGP session and universe. 

## V2.0.24
* Trying a different way to tone down the loot explosions. The loots lists will only ever return exactly 1 item then the script side ill inject 1-4 items depending on NPC type (MK1-5).
* Also fixed papyrus error about a missing property in the loot handler

## V2.0.23
* A repackage to readd fixed ESM that has the enable/disable for the new feature properly working. 

## V2.0.22
* New feature flag to disable custom loot injection, find in the config terminal
* Using a custom look list for the 3 combat faction classes Pirate (Spacer/CrimsonFleet/Pirate), Generic (Ecliptic), Va'ruun so you should get way less injected loot. I have no control over what Legendary Recycler is doing. If people aren't happy with the new drop rate I'll probably have to over ride the real NPC loot lists and make a bun fo patches for the conflicts.
* Where I was using Utility.Random() I'm not using the quests die calculation it has a lot of guard in it to ensure a fairly random number is generated.  

## V2.0.21
* Fix for the low level NPC menu not launching

## V2.0.20
* Added feature flags for the NPC resize easter egg and NPC Stat Scaling. Control via the Configuration Terminal.
* Stat scaling is highly alpha and the current iteration only works on Va'ruun and only in papyrus logs. It calculates but doesn't apply yet. I'm still trying to track down all the key stats like reflect, critical change, damage modifiers. The ones in AV vars skyrim used are 0 in starfield so I don't think that is the real values cause I crit a lot. :) 

## V2.0.19
* Injecting MK5 Boss Loot using cloak spell it is the only sucky but viable way around the encounter system. Minor bosses (have ++ in their name) will have a legendary. All pirate factions will have random contraband on them bosses will have a lot more. 
* Put in for debugging the initial feasibility of this system for true dynamic scale, all combat factions with -- or ++ in their name will randomly scale up (++) or down (--)
* Init Quest will add the Configuration Terminal into your inventory if you don't already have one
* Removed the Syndicate and Creature factions for now while I fully implement dynamic scaling. Also they never worked right and some of them had a lot of extra whitespace and a newline in their names (Thank you Excel)

## V2.0.18
* Experimenter's min level set to 100 and they have all the increased aggression settings I could find. 
* Currently the NPC level pool for a rank name has 4 normal one then the boosted ++ variant. These now rotate available combat styles.

## V2.0.17
* Fixed the missing keyword/flag on the low level configuration menu that stopped it from loading
* Added remaining default/baseline configuration screens to the configuration terminal
* All menus have descriptions and titles now to help out

## V2.0.16
* Created a configuration tables (Dynamic Scaling Configuration Table uses 1 lead) craft at the work bench can configure and of the global variables in game. Might have a nasty way to deal with the bracket data too but will be longer term. 

## V2.0.15
* Reimplemented Crimson Fleet/Pirate Faction from level 1 to 500 every 5 levels, have structure for going to 990. Enabled PC Level Multiplier and Auto Calc Stats.
* Reimplemented Spacer Faction from level 1 to 500 every 5 levels, have structure for going to 990. Enabled PC Level Multiplier and Auto Calc Stats.
* Reimplemented Ecliptic Faction from level 1 to 500 every 5 levels, have structure for going to 990. Enabled PC Level Multiplier and Auto Calc Stats.
* Removed combat music from Crimson Fleet to match other factions. Added combat music to all bosses(++) to make them more standout. 
* Basically I think true dynamic scaling to player will have to wait for the starfield creation kit. For now the PC Level Multiplier and Auto Calc stats seems to be the only way around the weird stat recalculation that happens on a new NGP session. Testing 4 NGPs sessions with Pirates I got consistent combat in all 4 sessions. 

## V2.0.14
* Reverted to v2.0.10
* Reimplemented Crimson Fleet/Pirate from level 1 to 500 every 10 levels, have structure for going to 990 but need better testing first. 
* NOTE: Need feed back on Ecliptic using every 5 levels vs Pirates using every 10 levels. My gut says Ecliptic is better without being able to use any of the PC level mult/Auto-Calc stuff which appears broken on the Engine side. 
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Varuun, Starborn, Terrormorphs, Elder Terrormorphs, The First

## V2.0.13
* Having to scale damage resists too now. I think I see why BS disabled the auto scaler it doesn't seem to be reliable. I will also need to explore how to scale damage via scripting that isn't stored in Actor Values. If this doesn't work I'll probably need to go back to static leveled lists with npc defined every 10 levels up to level 990. 
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Terrormorphs, Elder Terrormorphs


## V2.0.12
* Turned out leaving the Pirates/Crimson Fleet on the old system as a backup was a mistake it stopped scaling for that faction

## V2.0.11
* Adding The First, Starborn, and Va'ruun factions to dynamic backend scaling system but this time reusing the base leveled chars instead of making my own.
* Converted the Spacers, Crimson Fleet/Pirates, and Ecliptic to dynamic backend again reusing and extending the base encounter chars. 
* Made the Experimenter harder will eventually be bosses like the Legend/Serpent Caller/Commanders. Experimenting with hidden perk buffs. 
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Terrormorphs, Elder Terrormorphs

## V2.0.10
* Restoring script to reset game settings to default

## V2.0.9 Changes
* Turns out finding rando Syndicate spawns is hard so now all factions have an Experimenter testing truly dynamic spawning
* Initial version of fully dynamic scaling applied to all the Experimenters and the Pirate faction. It uses fLowLevelNPCBaseHealthMult to handle health scaling. Please give me feedback.
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Varuun, Starborn, Terrormorphs, Elder Terrormorphs, The First

## V2.0.8 Changes
* Added Creatures (Doesn't apply to Terrormorphs)
* Special Exception Tough Creatures and Syndicate - I only did every 10 levels and then lean heavily on the autoscaling +/- 5 levels should still preform decently with the middle of level range stats. If this works I'll probably expand the level range out to 500. Looking for feedback like they are still easy to kill vs the other combat factions that get stat boosts every 5 levels. 
* Added a couple of easter egg rando npcs that will drop boss loot but will spawn outside of normal curve. They have 1k DMG resist, 5k health, and the predator dmg add perk
* You will may a Syndicate Experimenter its my dynamic scaling test case so its probably going to be a push over or a nightmare depending on my luck and current experiments. Sorry no real way to disable them when I'm not testing. 
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Varuun, Starborn, Terrormorphs, Elder Terrormorphs, The First

## V2.0.7 Changes
* Added Pirate/Crimson Fleet Combat Faction (Does not apply to the crimson fleet quest zones)
* Added a new global variables to disable Damage, Health, and XP (Coming Soon) scaling it does not apply to iCalcLevelAdjustUp/iCalcLevelAdjustDown or Low Level NPC they are required for NPC level scaling.
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Varuun, Starborn, Syndicate, Creatures, Tough Creatures, Terrormorphs, Elder Terrormorphs, The First

## V2.0.6 Changes
* Dropped the recruit/apprentice tags they were just for testing. Keeping the Master tag as that starts a boost to health/resists
* Added ecliptic faction
* The infinite scaling NPCs (last in tree) have unique names for example spaces is Spacer Legend and Ecliptic is Ecliptic Commander
* The syndicate faction will be VERY VERY experimental I'm going to use it to try to fix the level scaling backend BGS disabled
* Fixed a typo in the math formula that adjusts damage for armor resistance making it 3 times stronger then it should have been 
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Pirate, Varuun, Starborn, Syndicate, Creatures, Tough Creatures, Terrormorphs, Elder Terrormorphs, The First
