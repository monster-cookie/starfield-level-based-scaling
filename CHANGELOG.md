# V2.0 Dynamic Scaling ESM Version

## V2.0.8 Changes
* Added Creatures (Doesn't apply to Terrormorphs)
* Special Exception Tough Creatures and Syndicate - I only did every 10 levels and then lean heavily on the autoscaling +/- 5 levels should still preform decently with the middle of level range stats. If this works I'll probably expand the level range out to 500. Looking for feedback like they are still easy to kill vs the other combat factions that get stat boosts every 5 levels. 
* Added a couple of easter egg rando npcs that will drop boss loot but will spawn outside of normal curve. They have 1k DMG resist, 5k health, and the predator dmg add perk
* You will may a Syndicate Experimenter its my dynamic scaling test case so its probably going to be a push over or a nightmare depending on my luck and current experiments. Sorry no real way to disable them when I'm not testing. 
* NOTE: I still need to tune the scale factors for the new high level NPCs. 
* Factions remaining to convert: Varuun, Starborn, Syndicate, Terrormorphs, Elder Terrormorphs, The First

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
