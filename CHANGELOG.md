# V2.0 Dynamic Scaling ESM Version

## V2.0.19
* Injecting MK5 Boss Loot using Keywords and hidden perk
* Fixed tons of enc -> lchar -> lvl NPC chaining errors that were messing up earlier dynamic script tests

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
