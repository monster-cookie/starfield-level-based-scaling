;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; This script will scale your damage settings based on your current 
;;; level. You need to link this to your player actor using the command
;;; below:
;;;
;;; player.aps VPI_LevelBasedScaling
;;;
ScriptName VPI_LevelBasedScaling Extends ReferenceAlias


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;

String Property Version="1.1.6" Auto

Actor Property PlayerRef Auto

Perk Property Skill_Wellness Auto
Perk Property Skill_EnergyWeaponDissipation Auto
Perk Property Skill_PainTolerance Auto
Perk Property Skill_Rejuvenation Auto

Perk Property Skill_Ballistics Auto 
Perk Property Skill_Lasers Auto
Perk Property Skill_ParticleBeams Auto
Perk Property Skill_Marksmanship Auto

Perk Property Skill_PistolCertification Auto
Perk Property Skill_ShotgunCertification Auto
Perk Property Skill_HeavyWeaponsCertification Auto
Perk Property Skill_RifleCertification Auto

Perk Property Skill_ArmorPenetration Auto
Perk Property Skill_Crippling Auto

Float Property DefaultNPCHealthBonus=0.00 Auto
Float Property DefaultPlayerHealthBonus=0.00 Auto

Float Property DefaultDamageToPlayerVE=0.50 Auto
Float Property DefaultDamageToPlayerE=0.75 Auto
Float Property DefaultDamageToPlayerN=1.00 Auto
Float Property DefaultDamageToPlayerH=1.50 Auto
Float Property DefaultDamageToPlayerVH=2.00 Auto

Float Property DefaultDamageByPlayerVE=2.00 Auto
Float Property DefaultDamageByPlayerE=1.50 Auto
Float Property DefaultDamageByPlayerN=1.00 Auto
Float Property DefaultDamageByPlayerH=0.75 Auto
Float Property DefaultDamageByPlayerVH=0.50 Auto

Float[] Property SF_PCHealthBoost Auto
Float[] Property SF_NPCHealthBoost Auto
Float[] Property SF_DamageToPlayer Auto
Float[] Property SF_DamageByPlayer Auto

Float Property PerkADJ_DamageReduction=0.25 Auto
Float Property PerkADJ_DamageAdd=0.25 Auto
Float Property PerkADJ_SpecialArmorPen=0.002 Auto
Float Property PerkADJ_SpecialCrippling=0.01 Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

;; This event will run once, when the script is initialized and is a member of any and all scripts 
;; per docs. In the terms of ReferenceAlias is called when the script is bound to something. 
Event OnInit() 
  Debug.Trace("EVENT: OnInit triggered populating Properties and Regenerating Scaling Values", 0)
  Debug.Notification("Level Based Scaling " + version + " is currently running.")

  UpdateBindings()
  CreateBracketArrays()

  ScaleForMyLevel()
EndEvent

;; Event called when the player loads a save game. This event is only sent to the player actor. If 
;; this is the first save game load where the event is being listened to, and the event is on an 
;; alias, and the alias didn't exist at the time the save was made, then the player won't be in the 
;; alias by the time the event is sent, and the alias script will not receive the event. It should 
;; then receive later events.
Event OnPlayerLoadGame()
  Utility.Wait(1.0)
  Debug.Trace("EVENT: OnPlayerLoadGame triggered populating Properties and Regenerating Scaling Values", 0)
  Debug.Notification("Level Based Scaling " + version + " is currently running.")

  UpdateBindings()
  CreateBracketArrays()

  ScaleForMyLevel()
EndEvent

Event OnDifficultyChanged(Int aOldDifficulty, Int aNewDifficulty)
  Debug.Trace("EVENT: OnDifficultyChanged triggered Regenerating Scaling Values", 0)
  ScaleForMyLevel()
EndEvent

; Using ReferenceAlias (vs Actor) this is now actually triggered so don't think I need OnEnterShipInterior/OnExitShipInterior
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  Debug.Trace("EVENT: OnLocationChange triggered Regenerating Scaling Values", 0)
  ScaleForMyLevel()
EndEvent

;; Called on ever thinkg you kill player or beast -- probably a good tracking point as you gain XP from the kill
Event OnKill(ObjectReference akVictim)
  Debug.Trace("EVENT: OnKill triggered Regenerating Scaling Values", 1)
  ScaleForMyLevel()
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;

;; ****************************************************************************
;; Update property bindings that can't automatically be bound without CK 
;;
Function UpdateBindings()
  if (PlayerRef == None) 
    PlayerRef = Game.GetPlayer()
  EndIf
  if (Skill_Wellness == None)
    Skill_Wellness =  Game.GetForm(0x002CE2E1) as Perk
  EndIf
  if (Skill_EnergyWeaponDissipation == None)
    Skill_EnergyWeaponDissipation =  Game.GetForm(0x002C59E2) as Perk
  EndIf
  if (Skill_PainTolerance == None)
    Skill_PainTolerance =  Game.GetForm(0x002CFCAE) as Perk
  EndIf
  if (Skill_Rejuvenation == None)
    Skill_Rejuvenation =  Game.GetForm(0x0028AE13) as Perk
  EndIf
  if (Skill_Ballistics == None)
    Skill_Ballistics =  Game.GetForm(0x002CFCAB) as Perk
  EndIf
  if (Skill_Lasers == None)
    Skill_Lasers =  Game.GetForm(0x002C59DD) as Perk
  EndIf
  if (Skill_ParticleBeams == None)
    Skill_ParticleBeams =  Game.GetForm(0x0027BAFD) as Perk
  EndIf
  if (Skill_Marksmanship == None)
    Skill_Marksmanship =  Game.GetForm(0x002C890B) as Perk
  EndIf
  if (Skill_PistolCertification == None)
    Skill_PistolCertification =  Game.GetForm(0x002080FF) as Perk
  EndIf
  if (Skill_ShotgunCertification == None)
    Skill_ShotgunCertification =  Game.GetForm(0x0027DF97) as Perk
  EndIf
  if (Skill_HeavyWeaponsCertification == None)
    Skill_HeavyWeaponsCertification =  Game.GetForm(0x00147E38) as Perk
  EndIf
  if (Skill_RifleCertification == None)
    Skill_RifleCertification =  Game.GetForm(0x002CE2E0) as Perk
  EndIf
  if (Skill_ArmorPenetration == None)
    Skill_ArmorPenetration =  Game.GetForm(0x0027DF94) as Perk
  EndIf
  if (Skill_Crippling == None)
    Skill_Crippling =  Game.GetForm(0x0027CBBA) as Perk
  EndIf
EndFunction

Function CreateBracketArrays() 
  If (SF_PCHealthBoost == None)
    SF_PCHealthBoost = new Float[11]
    SF_PCHealthBoost[1] = 0.00
    SF_PCHealthBoost[2] = 0.00
    SF_PCHealthBoost[3] = 0.00
    SF_PCHealthBoost[4] = 0.00
    SF_PCHealthBoost[5] = 0.00
    SF_PCHealthBoost[6] = 0.00
    SF_PCHealthBoost[7] = 0.00
    SF_PCHealthBoost[8] = 0.00
    SF_PCHealthBoost[9] = 0.00
    SF_PCHealthBoost[10] = 0.00
  EndIf
  If (SF_NPCHealthBoost == None)
    SF_NPCHealthBoost = new Float[11]
    SF_NPCHealthBoost[1] = 0.00
    SF_NPCHealthBoost[2] = 0.00
    SF_NPCHealthBoost[3] = 0.00
    SF_NPCHealthBoost[4] = 0.00
    SF_NPCHealthBoost[5] = 0.00
    SF_NPCHealthBoost[6] = 0.00
    SF_NPCHealthBoost[7] = 0.00
    SF_NPCHealthBoost[8] = 0.00
    SF_NPCHealthBoost[9] = 0.00
    SF_NPCHealthBoost[10] = 0.00
  EndIf
  If (SF_DamageToPlayer == None)
    SF_DamageToPlayer = new Float[11]
    SF_DamageToPlayer[1] = 0.80
    SF_DamageToPlayer[2] = 0.90
    SF_DamageToPlayer[3] = 1.10
    SF_DamageToPlayer[4] = 1.40
    SF_DamageToPlayer[5] = 1.60
    SF_DamageToPlayer[6] = 1.80
    SF_DamageToPlayer[7] = 2.00
    SF_DamageToPlayer[8] = 2.25
    SF_DamageToPlayer[9] = 2.50
    SF_DamageToPlayer[10] = 3.00
  EndIf
  If (SF_DamageByPlayer == None)
    SF_DamageByPlayer = new Float[11]
    SF_DamageByPlayer[1] = 1.10
    SF_DamageByPlayer[2] = 1.00
    SF_DamageByPlayer[3] = 0.90
    SF_DamageByPlayer[4] = 0.80
    SF_DamageByPlayer[5] = 0.70
    SF_DamageByPlayer[6] = 0.60
    SF_DamageByPlayer[7] = 0.50
    SF_DamageByPlayer[8] = 0.40
    SF_DamageByPlayer[9] = 0.30
    SF_DamageByPlayer[10] = 0.15
  EndIf
EndFunction

;; ****************************************************************************
;; Convert the difficulty int value to the string value
;;
String Function GetDifficulty(int iDifficulty)
  if (iDifficulty == 0)
    return "Very Easy"
  ElseIf (iDifficulty == 1)
    return "Easy"
  ElseIf (iDifficulty == 2)
    return "Normal"
  ElseIf (iDifficulty == 3)
    return "Hard"
  ElseIf (iDifficulty == 4)
    return "Very Hard"
  Else
    return "Unknown(" + iDifficulty +")"
  EndIf
EndFunction

;; ****************************************************************************
;; Get the bracket that applies to the player's current level
;;
Int Function GetBracketForPlayerLevel()
  Int playerLevel = PlayerRef.GetLevel()

  If (1 <= playerLevel && playerLevel <= 25)
    return 1
  ElseIf (26 <= playerLevel && playerLevel <= 50)
    return 2
  ElseIf (51 <= playerLevel && playerLevel <= 75)
    return 3
  ElseIf (76 <= playerLevel && playerLevel <= 100)
    return 4
  ElseIf (101 <= playerLevel && playerLevel <= 125)
    return 5
  ElseIf (126 <= playerLevel && playerLevel <= 150)
    return 6
  ElseIf (151 <= playerLevel && playerLevel <= 200)
    return 7
  ElseIf (201 <= playerLevel && playerLevel <= 250)
    return 8
  ElseIf (251 <= playerLevel && playerLevel <= 300)
    return 9
  Else
    return 10
  EndIf
EndFunction

;; ****************************************************************************
;; Get the scaling factor for damage done to the player by NPCs at the 
;; player's current level
;;
Float Function GetDamageToPlayerScalingFactor() 
  Int playerLevel = PlayerRef.GetLevel()
  Int playerBracket = GetBracketForPlayerLevel()
  Float scaleFactor = SF_DamageToPlayer[playerBracket];

  Debug.Trace("Damage To Player scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  If (playerRef.HasPerk(Skill_Wellness) || playerRef.HasPerk(Skill_EnergyWeaponDissipation) || playerRef.HasPerk(Skill_PainTolerance) || playerRef.HasPerk(Skill_Rejuvenation))
    Float adjustment = PerkADJ_DamageReduction * (playerBracket/6)
    scaleFactor += adjustment
    Debug.Trace("SF adjusted for damage reduction perks increased by " + adjustment + ".", 0)
  EndIf

  If scaleFactor < 0 
    Debug.Trace("SF is less than 0 so adjusting to minimum of 0.001.", 0)
    Return 0.001
  Else 
    Return scaleFactor
  EndIf

  Debug.Trace("RESULT: Final Damage To Player scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + ".", 1)
EndFunction

;; ****************************************************************************
;; Get the scaling factor for damage done by the player to NPCs at the 
;; player's current level
;;
Float Function GetDamageByPlayerScalingFactor()
  Int playerLevel = PlayerRef.GetLevel()
  Int playerBracket = GetBracketForPlayerLevel()
  Float scaleFactor = SF_DamageByPlayer[playerBracket];

  Debug.Trace("Damage By Player scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  If ((playerRef.HasPerk(Skill_PistolCertification) || playerRef.HasPerk(Skill_ShotgunCertification) || playerRef.HasPerk(Skill_HeavyWeaponsCertification) || playerRef.HasPerk(Skill_RifleCertification)) && (playerRef.HasPerk(Skill_Ballistics) || playerRef.HasPerk(Skill_Lasers) || playerRef.HasPerk(Skill_ParticleBeams) || playerRef.HasPerk(Skill_Marksmanship))) 
    Float adjustment = PerkADJ_DamageAdd * (playerBracket/6)
    scaleFactor -= adjustment
    Debug.Trace("SF adjusted for damage add perks decreased by " + adjustment + ".", 0)
  EndIf

  If (playerRef.HasPerk(Skill_ArmorPenetration))
    scaleFactor -= PerkADJ_SpecialArmorPen
    Debug.Trace("SF adjusted for Armor Penetration perk decreased by " + PerkADJ_SpecialArmorPen + ".", 0)
  EndIf
  
  If (playerRef.HasPerk(Skill_Crippling))
    scaleFactor -= PerkADJ_SpecialCrippling
    Debug.Trace("SF adjusted for Crippling perk perk decreased by " + PerkADJ_SpecialCrippling + ".", 0)
  EndIf

  If scaleFactor < 0 
    Debug.Trace("SF is less than 0 so adjusting to minimum of 0.001.", 0)
    Return 0.001
  Else 
    Return scaleFactor
  EndIf

  Debug.Trace("RESULT: Final Damage By Player scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + ".", 1)
EndFunction

;; ****************************************************************************
;; Get the scaling factor for NPC sponginess at the player's current level
;;
Float Function SponginessNPCScalingFactor()
  Int playerLevel = PlayerRef.GetLevel()
  Int playerBracket = GetBracketForPlayerLevel()
  Float scaleFactor = SF_NPCHealthBoost[playerBracket];

  Debug.Trace("NPC Bonus Health scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  If scaleFactor < 0 
    Debug.Trace("SF is less than 0 so adjusting to minimum of 0.001.", 0)
    Return 0.001
  Else 
    Return scaleFactor
  EndIf

  Debug.Trace("RESULT: Final NPC Bonus Health scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + ".", 1)
EndFunction

;; ****************************************************************************
;; Get the scaling factor for Player sponginess at the player's current level
;;
Float Function SponginessPlayerScalingFactor()
  Int playerLevel = PlayerRef.GetLevel()
  Int playerBracket = GetBracketForPlayerLevel()
  Float scaleFactor = SF_PCHealthBoost[playerBracket];

  Debug.Trace("Player Bonus Health scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  If scaleFactor < 0 
    Debug.Trace("SF is less than 0 so adjusting to minimum of 0.001.", 0)
    Return 0.001
  Else 
    Return scaleFactor
  EndIf

  Debug.Trace("RESULT: Final Player Bonus Health scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + ".", 1)
EndFunction

;; ****************************************************************************
;; Get, scale, and update a float based game setting 
;;
Function ScaleFloatGameSetting (String gameSetting, Float defaultValue, Float scaleFactor)
  Float scaledValue = defaultValue * scaleFactor
  Debug.ExecuteConsole("setgs " + gameSetting + " " + scaledValue)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;

;; ****************************************************************************
;; Change a default damage to player values
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultDamageToPlayerValue" <difficulty> <newValue>
;;   difficulty -> 0=Very Easy, 1=Easy, 2=Normal, 3=Hard, 4=Very Hard
;;   newValue -> The new float value to set
;;
Function SetDefaultDamageToPlayerValue(int difficulty, Float value)
  If (difficulty == 0)
    DefaultDamageToPlayerVE = value
  ElseIf (difficulty == 1)
    DefaultDamageToPlayerE = value
  ElseIf (difficulty == 2)
    DefaultDamageToPlayerN = value
  ElseIf (difficulty == 3)
    DefaultDamageToPlayerH = value
  ElseIf (difficulty == 4)
    DefaultDamageToPlayerVH = value
  EndIf
EndFunction

;; ****************************************************************************
;; Change a default damage by player values
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultDamageByPlayerValue" <difficulty> <newValue>
;;   difficulty -> 0=Very Easy, 1=Easy, 2=Normal, 3=Hard, 4=Very Hard
;;   newValue -> The new float value to set
;;
Function SetDefaultDamageByPlayerValue(int difficulty, Float value)
  If (difficulty == 0)
    DefaultDamageByPlayerVE = value
  ElseIf (difficulty == 1)
    DefaultDamageByPlayerE = value
  ElseIf (difficulty == 2)
    DefaultDamageByPlayerN = value
  ElseIf (difficulty == 3)
    DefaultDamageByPlayerH = value
  ElseIf (difficulty == 4)
    DefaultDamageByPlayerVH = value
  EndIf
EndFunction

;; ****************************************************************************
;; Change the default NPC health boost
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultNPCHealthBoost" <newValue>
;;   newValue -> The new float value to set
;;
Function SetDefaultNPCHealthBoost(Float value)
  DefaultNPCHealthBonus = value
EndFunction

;; ****************************************************************************
;; Change the default Player health boost
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultPlayerHealthBoost" <newValue>
;;   newValue -> The new float value to set
;;
Function SetDefaultPlayerHealthBoost(Float value)
  DefaultPlayerHealthBonus = value
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for damage to player 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDamageToPlayerSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetDamageToPlayerSFForBracket(int bracket, Float newSF)
  SF_DamageToPlayer[bracket] = newSF
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for damage by player 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDamageByPlayerSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetDamageByPlayerSFForBracket(int bracket, Float newSF)
  SF_DamageByPlayer[bracket]=newSF
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for NPC Bonus Health 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetNPCBonusHealthSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetNPCBonusHealthSFForBracket(int bracket, Float newSF)
  SF_NPCHealthBoost[bracket]=newSF
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for Player Bonus Health 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetPCBonusHealthSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetPCBonusHealthSFForBracket(int bracket, Float newSF)
  SF_PCHealthBoost[bracket] = newSF
EndFunction

;; ****************************************************************************
;; Update Starfield Damage Scaling Game Setting for my current level and 
;; scaling factor for that level
;;
;; Use: player.cf "VPI_LevelBasedScaling.ScaleForMyLevel"
;;
Function ScaleForMyLevel()
  Float sfDamageByPlayer = GetDamageByPlayerScalingFactor()
  Float sfDamageToPlayer = GetDamageToPlayerScalingFactor()
  Float sfSponginessNPC = SponginessNPCScalingFactor()
  Float sfSponginessPlayer = SponginessPlayerScalingFactor()

  ScaleFloatGameSetting("fNPCHealthLevelBonus", DefaultNPCHealthBonus, sfSponginessNPC)
  ScaleFloatGameSetting("fHealthEnduranceOffset", DefaultPlayerHealthBonus, sfSponginessPlayer)

  ScaleFloatGameSetting("fDiffMultHPByPCVE", DefaultDamageByPlayerVE, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCE", DefaultDamageByPlayerE, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCN", DefaultDamageByPlayerN, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCH", DefaultDamageByPlayerH, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCVH", DefaultDamageByPlayerVH, sfDamageByPlayer)

  ScaleFloatGameSetting("fDiffMultHPToPCVE", DefaultDamageToPlayerVE, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCE", DefaultDamageToPlayerE, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCN", DefaultDamageToPlayerN, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCH", DefaultDamageToPlayerH, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCVH", DefaultDamageToPlayerVH, sfDamageToPlayer)    
EndFunction

;; ****************************************************************************
;; Get current scaling settings for your level and difficulty mode
;;
;; Use: player.cf "VPI_LevelBasedScaling.GetScalingMatrix"
;;
Function GetScalingMatrix()
  Int iPlayerLevel = PlayerRef.GetLevel()
  Int iPlayerBracket = GetBracketForPlayerLevel()
  Int iDifficulty = Game.GetDifficulty()
  string sDifficulty = GetDifficulty(iDifficulty)

  Float sfDamageByPlayer = GetDamageByPlayerScalingFactor()
  Float sfDamageToPlayer = GetDamageToPlayerScalingFactor()
  Float sfSponginessNPC = SponginessNPCScalingFactor()
  Float sfSponginessPlayer = SponginessPlayerScalingFactor()

  Float scaledDamageByPlayerVE = Game.GetGameSettingFloat("fDiffMultHPByPCVE")
  Float scaledDamageByPlayerE = Game.GetGameSettingFloat("fDiffMultHPByPCE")
  Float scaledDamageByPlayerN = Game.GetGameSettingFloat("fDiffMultHPByPCN")
  Float scaledDamageByPlayerH = Game.GetGameSettingFloat("fDiffMultHPByPCH")
  Float scaledDamageByPlayerVH = Game.GetGameSettingFloat("fDiffMultHPByPCVH")

  Float scaledDamageToPlayerVE = Game.GetGameSettingFloat("fDiffMultHPToPCVE")
  Float scaledDamageToPlayerE = Game.GetGameSettingFloat("fDiffMultHPToPCE")
  Float scaledDamageToPlayerN = Game.GetGameSettingFloat("fDiffMultHPToPCN")
  Float scaledDamageToPlayerH = Game.GetGameSettingFloat("fDiffMultHPToPCH")
  Float scaledDamageToPlayerVH = Game.GetGameSettingFloat("fDiffMultHPToPCVH")

  Float scaledSponginessNPC = Game.GetGameSettingFloat("fNPCHealthLevelBonus")
  Float scaledSponginessPlayer = Game.GetGameSettingFloat("fHealthEnduranceOffset")

  String message = "Scaling for a player level of " + iPlayerLevel + " using scaling data from the level " + iPlayerBracket + " bracket.\n"

  message += "NPC Health Boost is " + scaledSponginessNPC + " (Default:" + DefaultNPCHealthBonus + " X SF:" + sfSponginessNPC + ").\n"
  message += "Player Health Boost is " + scaledSponginessPlayer + " (Default:" + DefaultPlayerHealthBonus + " X SF:" + sfSponginessPlayer + ").\n"

  if (iDifficulty == 0)
    ;; Very Easy Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerVE + " (Default:" + DefaultDamageToPlayerVE + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerVE + " (Default:" + DefaultDamageByPlayerVE + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerE + " (Default:" + DefaultDamageToPlayerE + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerE + " (Default:" + DefaultDamageByPlayerE + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerN + " (Default:" + DefaultDamageToPlayerN + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerN + " (Default:" + DefaultDamageByPlayerN + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerH + " (Default:" + DefaultDamageToPlayerH + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerH + " (Default:" + DefaultDamageByPlayerH + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerVH + " (Default:" + DefaultDamageToPlayerVH + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerVH + " (Default:" + DefaultDamageByPlayerVH + " X SF:" + sfDamageByPlayer + ").\n"
  EndIf

  Debug.Trace(message, 2)
  Debug.Messagebox(message)
EndFunction

;; ****************************************************************************
;; Get the current level scaling config from the player object
;;
;; Use: player.cf "VPI_LevelBasedScaling.DumpLevelScalingConfig"
;;
Function DumpLevelScalingConfig() 
  string message = "*** Defaults ***\n\n"
  message += "NPC Health " + DefaultNPCHealthBonus + ".\nPlayer Health " + DefaultPlayerHealthBonus + ".\n"
  message += "Damage To Player: |VE " + DefaultDamageToPlayerVE + "|E " + DefaultDamageToPlayerE + "|N " + DefaultDamageToPlayerN + "|H " + DefaultDamageToPlayerH + "|VH " + DefaultDamageToPlayerVH + "|\n"
  message += "Damage By Player: |VE " + DefaultDamageByPlayerVE + "|E " + DefaultDamageByPlayerE + "|N " + DefaultDamageByPlayerN + "|H " + DefaultDamageByPlayerH + "|VH " + DefaultDamageByPlayerVH + "|\n"

  message += "\n\n*** Scaling Factores ***\n\n"
  message += "____________|____01____|____02____|____03____|____04____|____05____|____06____|____07____|____08____|____09____|____10____|\n"
  message += "NPC Health  | " + SF_NPCHealthBoost[1] + " | " + SF_NPCHealthBoost[2] + " | " + SF_NPCHealthBoost[3] + " | " + SF_NPCHealthBoost[4] + " | " + SF_NPCHealthBoost[5] + " | " + SF_NPCHealthBoost[6] + " | " + SF_NPCHealthBoost[7] + " | " + SF_NPCHealthBoost[8] + " | " + SF_NPCHealthBoost[9] + " | " + SF_NPCHealthBoost[10] + " |\n"
  message += "PC Health   | " + SF_PCHealthBoost[1] + " | " + SF_PCHealthBoost[2] + " | " + SF_PCHealthBoost[3] + " | " + SF_PCHealthBoost[4] + " | " + SF_PCHealthBoost[5] + " | " + SF_PCHealthBoost[6] + " | " + SF_PCHealthBoost[7] + " | " + SF_PCHealthBoost[8] + " | " + SF_PCHealthBoost[9] + " | " + SF_PCHealthBoost[10] + " |\n"
  message += "Damage To PC| " + SF_DamageToPlayer[1] + " | " + SF_DamageToPlayer[2] + " | " + SF_DamageToPlayer[3] + " | " + SF_DamageToPlayer[4] + " | " + SF_DamageToPlayer[5] + " | " + SF_DamageToPlayer[6] + " | " + SF_DamageToPlayer[7] + " | " + SF_DamageToPlayer[8] + " | " + SF_DamageToPlayer[9] + " | " + SF_DamageToPlayer[10] + " |\n"
  message += "Damage By PC| " + SF_DamageByPlayer[1] + " | " + SF_DamageByPlayer[2] + " | " + SF_DamageByPlayer[3] + " | " + SF_DamageByPlayer[4] + " | " + SF_DamageByPlayer[5] + " | " + SF_DamageByPlayer[6] + " | " + SF_DamageByPlayer[7] + " | " + SF_DamageByPlayer[8] + " | " + SF_DamageByPlayer[9] + " | " + SF_DamageByPlayer[10] + " |\n"

  Debug.Trace(message, 2)
  Debug.Messagebox(message)
EndFunction

;; ****************************************************************************
;; Get the current version of the script
;;
;; Use: player.cf "VPI_LevelBasedScaling.GetVersion"
;;
Function GetVersion()
	Debug.Messagebox("VPI_LevelBasedScaling Version: " + Version)
EndFunction
