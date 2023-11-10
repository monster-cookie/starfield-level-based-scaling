ScriptName VPI_DS_PlayerIntegration Extends Actor


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property BaseNPCHealthBonus Auto Const Mandatory
GlobalVariable Property BasePlayerHealthBonus Auto Const Mandatory
GlobalVariable Property BaseLowLevelNPCHealthAdjustment Auto Const Mandatory
GlobalVariable Property BaseLowLevelNPCVsPlayerLevelDifference Auto Const Mandatory
GlobalVariable Property BaseDamageToPlayerVE Auto Const Mandatory
GlobalVariable Property BaseDamageToPlayerE Auto Const Mandatory
GlobalVariable Property BaseDamageToPlayerN Auto Const Mandatory
GlobalVariable Property BaseDamageToPlayerH Auto Const Mandatory
GlobalVariable Property BaseDamageToPlayerVH Auto Const Mandatory
GlobalVariable Property BaseDamageByPlayerVE Auto Const Mandatory
GlobalVariable Property BaseDamageByPlayerE Auto Const Mandatory
GlobalVariable Property BaseDamageByPlayerN Auto Const Mandatory
GlobalVariable Property BaseDamageByPlayerH Auto Const Mandatory
GlobalVariable Property BaseDamageByPlayerVH Auto Const Mandatory
GlobalVariable Property BaseResistanceScalingFactor Auto Const Mandatory
GlobalVariable Property BasePerkAdjustmentDamageReduction Auto Const Mandatory
GlobalVariable Property BasePerkAdjustmentDamageAdd Auto Const Mandatory
GlobalVariable Property EnableScalingDamage Auto Const Mandatory
GlobalVariable Property EnableScalingHealth Auto Const Mandatory
GlobalVariable Property EnableScalingXP Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
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
Perk Property Skill_HeavyWeaponCertification Auto
Perk Property Skill_RifleCertification Auto

ActorValue Property Endurance Auto
ActorValue Property Health Auto

ActorValue Property DamageResist Auto
ActorValue Property EnergyResist Auto
ActorValue Property ElectromagneticDamageResist Auto

Float[] Property SF_PCHealthBoost Auto
Float[] Property SF_NPCHealthBoost Auto
Float[] Property SF_DamageToPlayer Auto
Float[] Property SF_DamageByPlayer Auto
Float[] Property SF_LowLevelNPCHealthAdjustment Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

;; This event will run once, when the script is initialized and is a member of any and all scripts 
;; per docs. In the terms of ReferenceAlias is called when the script is bound to something. 
Event OnInit() 
  ; Debug.Trace("VPI_DS_EVENT (PCIntegration): OnInit triggered regenerating scaling values", 0)
  CreateBracketArrays()
  ScaleSettings()
EndEvent

;; Event called when the player loads a save game. 
Event OnPlayerLoadGame()
  ; Debug.Trace("VPI_DS_EVENT (PCIntegration): OnPlayerLoadGame triggered regenerating scaling values", 0)
  CreateBracketArrays()
  ScaleSettings()
EndEvent

Event OnDifficultyChanged(Int aOldDifficulty, Int aNewDifficulty)
  ; Debug.Trace("VPI_DS_EVENT (PCIntegration): OnDifficultyChanged triggered regenerating scaling values", 0)
  ScaleSettings()
EndEvent

; Using ReferenceAlias (vs Actor) this is now actually triggered so don't think I need OnEnterShipInterior/OnExitShipInterior
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  ; Debug.Trace("VPI_DS_EVENT (PCIntegration): OnLocationChange triggered regenerating scaling values", 0)
  ScaleSettings()
EndEvent

;; Called on ever thing you kill player or beast -- don't use it gets called way too much
; Event OnKill(ObjectReference akVictim)
;   Debug.Trace("VPI_DS_EVENT (PCIntegration): OnKill triggered regenerating scaling values", 1)
;   ScaleSettings()
; EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;

;; ****************************************************************************
;; Created and populate the bracket arrays if they do not already exist. This should only 
;; happen on init or first load after adding the mod. 
Function CreateBracketArrays() 
  If (SF_PCHealthBoost == None)
    SF_PCHealthBoost = new Float[11]
    SF_PCHealthBoost[1] = 1.00
    SF_PCHealthBoost[2] = 1.00
    SF_PCHealthBoost[3] = 1.00
    SF_PCHealthBoost[4] = 1.00
    SF_PCHealthBoost[5] = 1.00
    SF_PCHealthBoost[6] = 1.00
    SF_PCHealthBoost[7] = 1.00
    SF_PCHealthBoost[8] = 1.00
    SF_PCHealthBoost[9] = 1.00
    SF_PCHealthBoost[10] = 1.00
  EndIf
  If (SF_NPCHealthBoost == None)
    SF_NPCHealthBoost = new Float[11]
    SF_NPCHealthBoost[1] = 1.00
    SF_NPCHealthBoost[2] = 1.00
    SF_NPCHealthBoost[3] = 1.00
    SF_NPCHealthBoost[4] = 1.00
    SF_NPCHealthBoost[5] = 1.00
    SF_NPCHealthBoost[6] = 1.00
    SF_NPCHealthBoost[7] = 1.00
    SF_NPCHealthBoost[8] = 1.00
    SF_NPCHealthBoost[9] = 1.00
    SF_NPCHealthBoost[10] = 1.00
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
  If (SF_LowLevelNPCHealthAdjustment == None)
    SF_LowLevelNPCHealthAdjustment = new Float[11]
    SF_LowLevelNPCHealthAdjustment[1] = 0.10
    SF_LowLevelNPCHealthAdjustment[2] = 0.10
    SF_LowLevelNPCHealthAdjustment[3] = 0.10
    SF_LowLevelNPCHealthAdjustment[4] = 0.05
    SF_LowLevelNPCHealthAdjustment[5] = 0.05
    SF_LowLevelNPCHealthAdjustment[6] = 0.05
    SF_LowLevelNPCHealthAdjustment[7] = 0.05
    SF_LowLevelNPCHealthAdjustment[8] = 0.01
    SF_LowLevelNPCHealthAdjustment[9] = 0.01
    SF_LowLevelNPCHealthAdjustment[10] = 0.01
  EndIf
EndFunction


;; ****************************************************************************
;; Get the scaling factor for damage done to the player by NPCs at the 
;; player's current level
;;
Float Function GetDamageToPlayerScalingFactor()
  Int playerLevel = GetLevel()
  Int playerBracket = VPI_Helper.GetBracketForPlayerLevel(playerLevel)
  Float playerPhysicalResist = GetValue(DamageResist)
  Float playerEnergyResist = GetValue(EnergyResist)
  Float playerElectromagneticResist = GetValue(ElectromagneticDamageResist)
  Float scalefactorResistance = BaseResistanceScalingFactor.GetValue()
  Float scalefactorDamageReduction = BasePerkAdjustmentDamageReduction.GetValue()
  Float playerbaseScalingToAdjustForArmor = ((playerPhysicalResist + playerEnergyResist + playerElectromagneticResist)/3) * (scalefactorResistance * Math.Floor(playerLevel/50))
  Float scaleFactor = SF_DamageToPlayer[playerBracket] + playerbaseScalingToAdjustForArmor
  Debug.Trace("VPI_DS_DEBUG (PCIntegration): Player Armor Adjustment Factor is " + playerbaseScalingToAdjustForArmor + " base bracket scale factor is " + SF_DamageToPlayer[playerBracket], 0)
  Debug.Trace("VPI_DS_DEBUG (PCIntegration): Damage To Player scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  ;; Debug.Trace("VPI_DS_DEBUG (PCIntegration): Armor Adustment --->\n\n((playerPhysicalResist + playerEnergyResist + playerElectromagneticResist)/3) * (scalefactorResistance * Math.Floor(playerLevel/50))\n((" + playerPhysicalResist + " + " + playerEnergyResist + " + " + playerElectromagneticResist + ")/3) * (" + scalefactorResistance + " * Math.Floor(" + playerLevel + "/50))\n", 2)
  
  If (HasPerk(Skill_Wellness) || HasPerk(Skill_EnergyWeaponDissipation) || HasPerk(Skill_PainTolerance) || HasPerk(Skill_Rejuvenation))
    Float adjustment = scalefactorDamageReduction * (playerBracket/6)
    scaleFactor += adjustment
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): SF adjusted for damage reduction perks increased by " + adjustment + ".", 0)
  EndIf

  If scaleFactor < 0 
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): SF is less than 0 so adjusting to minimum of 0.001.", 0)
    scaleFactor=0.001
  EndIf

  Debug.Trace("VPI_DS_FINAL_RESULT (PCIntegration): Final Damage To Player scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + " (Base from armor was " + playerbaseScalingToAdjustForArmor + ").", 1)
  Return scaleFactor
EndFunction

;; ****************************************************************************
;; Get the scaling factor for damage done by the player to NPCs at the 
;; player's current level
;;
Float Function GetDamageByPlayerScalingFactor()
  Int playerLevel = GetLevel()
  Int playerBracket = VPI_Helper.GetBracketForPlayerLevel(playerLevel)
  Float scalefactorDamageAdd = BasePerkAdjustmentDamageAdd.GetValue()
  Float scaleFactor = SF_DamageByPlayer[playerBracket];

  Debug.Trace("VPI_DS_DEBUG (PCIntegration): Damage By Player scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  If ((HasPerk(Skill_PistolCertification) || HasPerk(Skill_ShotgunCertification) || HasPerk(Skill_HeavyWeaponCertification) || HasPerk(Skill_RifleCertification)) && (HasPerk(Skill_Ballistics) || HasPerk(Skill_Lasers) || HasPerk(Skill_ParticleBeams) || HasPerk(Skill_Marksmanship))) 
    Float adjustment = scalefactorDamageAdd * (playerBracket/6)
    scaleFactor -= adjustment
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): SF adjusted for damage add perks decreased by " + adjustment + ".", 0)
  EndIf

  If scaleFactor < 0 
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): SF is less than 0 so adjusting to minimum of 0.001.", 0)
    scaleFactor=0.001
  EndIf

  Debug.Trace("VPI_DS_FINAL_RESULT (PCIntegration): Final Damage By Player scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + ".", 1)
  Return scaleFactor
EndFunction

;; ****************************************************************************
;; Get the scaling factor for NPC sponginess at the player's current level
;;
Float Function SponginessNPCScalingFactor()
  Int playerLevel = GetLevel()
  Int playerBracket = VPI_Helper.GetBracketForPlayerLevel(playerLevel)
  Float scaleFactor = SF_NPCHealthBoost[playerBracket];

  Debug.Trace("VPI_DS_DEBUG (PCIntegration): NPC Bonus Health scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  If scaleFactor < 0 
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): SF is less than 0 so adjusting to minimum of 0.001.", 0)
    scaleFactor=0.001
  EndIf

  Debug.Trace("VPI_DS_FINAL_RESULT (PCIntegration): Final NPC Bonus Health scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + ".", 1)
  Return scaleFactor
EndFunction

;; ****************************************************************************
;; Get the scaling factor for Player sponginess at the player's current level
;;
Float Function SponginessPlayerScalingFactor()
  Int playerLevel = GetLevel()
  Int playerBracket = VPI_Helper.GetBracketForPlayerLevel(playerLevel)
  Float scaleFactor = SF_PCHealthBoost[playerBracket];

  Debug.Trace("VPI_DS_DEBUG (PCIntegration): Player Bonus Health scaling is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + scaleFactor + ".", 0)

  If scaleFactor < 0 
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): SF is less than 0 so adjusting to minimum of 0.001.", 0)
    scaleFactor=0.001
  EndIf

  Debug.Trace("VPI_DS_FINAL_RESULT (PCIntegration): Final Player Bonus Health scaling has been calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an final SF of " + scaleFactor + ".", 1)
  Return scaleFactor
EndFunction

;; ****************************************************************************
;; Get the bracket value for Low Level NPC health Adjustment at the player's current level
;;
Float Function BracketAdjustmentForLowLevelNPCHealthAdjustment()
  Int playerLevel = GetLevel()
  Int playerBracket = VPI_Helper.GetBracketForPlayerLevel(playerLevel)
  Float bracketValue = SF_LowLevelNPCHealthAdjustment[playerBracket];

  Debug.Trace("VPI_DS_DEBUG (PCIntegration): Low Level NPC Health Adjustment is being calculated for a player level of " + playerLevel + " using bracket " + playerBracket + " resulting in an initial SF of " + bracketValue + ".", 0)
  Return bracketValue
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;

;; ****************************************************************************
;; Update Starfield Damage Scaling Game Settings for my current level and 
;; scaling factor for that level
;;
;; Use: player.cf "ScaleSettings"
;;
Function ScaleSettings()
  If (IsInCombat())
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): Player is in combat so no new scaling values will be calculated.", 1)
    return
  EndIf

  Int playerLevel = GetLevel()
  Int adjustedScalingLevel = playerLevel + 5;
  
  Debug.Trace("VPI_DS_DEBUG (PCIntegration): Setting iCalcLevelAdjustUp to " + adjustedScalingLevel + " for a player level of " + playerLevel + ".", 0)
  VPI_Helper.SetGameSettingInt("iCalcLevelAdjustUp", adjustedScalingLevel)
  VPI_Helper.SetGameSettingInt("iCalcLevelAdjustDown", 0)

  Float bvLowLevelNPCHealthAdjustment = BracketAdjustmentForLowLevelNPCHealthAdjustment()
  VPI_Helper.SetGameSettingFloat("fLowLevelNPCBaseHealthMult", bvLowLevelNPCHealthAdjustment)

  Int bvLowLevelNPCVsPlayerLevelDifference = BaseLowLevelNPCVsPlayerLevelDifference.GetValueInt()
  VPI_Helper.SetGameSettingInt("iLowLevelNPCMaxLevel", bvLowLevelNPCVsPlayerLevelDifference)

  If (EnableScalingDamage.GetValueInt() == 1)
    Float sfDamageByPlayer = GetDamageByPlayerScalingFactor()
    Float sfDamageToPlayer = GetDamageToPlayerScalingFactor()

    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPByPCVE", BaseDamageByPlayerVE.GetValue(), sfDamageByPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPByPCE", BaseDamageByPlayerE.GetValue(), sfDamageByPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPByPCN", BaseDamageByPlayerN.GetValue(), sfDamageByPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPByPCH", BaseDamageByPlayerH.GetValue(), sfDamageByPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPByPCVH", BaseDamageByPlayerVH.GetValue(), sfDamageByPlayer)
  
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPToPCVE", BaseDamageToPlayerVE.GetValue(), sfDamageToPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPToPCE", BaseDamageToPlayerE.GetValue(), sfDamageToPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPToPCN", BaseDamageToPlayerN.GetValue(), sfDamageToPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPToPCH", BaseDamageToPlayerH.GetValue(), sfDamageToPlayer)
    VPI_Helper.ScaleGameSettingFloat("fDiffMultHPToPCVH", BaseDamageToPlayerVH.GetValue(), sfDamageToPlayer)    
  Else
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): Damage Scaling is disabled.", 0)
  EndIF

  If (EnableScalingHealth.GetValueInt() == 1)
    Float sfSponginessNPC = SponginessNPCScalingFactor()
    Float sfSponginessPlayer = SponginessPlayerScalingFactor()

    VPI_Helper.ScaleGameSettingFloat("fNPCHealthLevelBonus", BaseNPCHealthBonus.GetValueInt(), sfSponginessNPC)
    VPI_Helper.ScaleGameSettingFloat("fHealthEnduranceOffset", BasePlayerHealthBonus.GetValueInt(), sfSponginessPlayer)
  Else
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): Health Scaling is disabled.", 0)
  EndIF

  If (EnableScalingHealth.GetValueInt() == 1)
    ;; COMING SOON LOL
  Else
    Debug.Trace("VPI_DS_DEBUG (PCIntegration): XP Scaling is disabled.", 0)
  EndIF
EndFunction


;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for damage to player 
;;
;; Use: player.cf "SetDamageToPlayerSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetDamageToPlayerSFForBracket(int bracket, Float newSF)
  SF_DamageToPlayer[bracket] = newSF
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for damage by player 
;;
;; Use: player.cf "SetDamageByPlayerSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetDamageByPlayerSFForBracket(int bracket, Float newSF)
  SF_DamageByPlayer[bracket]=newSF
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for NPC Bonus Health 
;;
;; Use: player.cf "SetNPCBonusHealthSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetNPCBonusHealthSFForBracket(int bracket, Float newSF)
  SF_NPCHealthBoost[bracket]=newSF
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for Player Bonus Health 
;;
;; Use: player.cf "SetPCBonusHealthSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetPCBonusHealthSFForBracket(int bracket, Float newSF)
  SF_PCHealthBoost[bracket] = newSF
EndFunction

;; ****************************************************************************
;; Change a bracket values in the specified level bracket for the low level NPC health adjustment
;;
;; Use: player.cf "SetLowLevelNPCHealthAdjustmentValueForBracket" <bracket> <newValue>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newValue -> The new value to set for the bracket
;;
Function SetLowLevelNPCHealthAdjustmentValueForBracket(int bracket, Float newValue)
  SF_LowLevelNPCHealthAdjustment[bracket]=newValue
EndFunction


;; ****************************************************************************
;; Get current scaling settings for your level and difficulty mode
;;
;; Use: player.cf "GetScalingMatrix"
;;
Function GetScalingMatrix()
  Int iPlayerLevel = GetLevel()
  Int iPlayerBracket = VPI_Helper.GetBracketForPlayerLevel(iPlayerLevel)
  Int iDifficulty = Game.GetDifficulty()
  string sDifficulty = VPI_Helper.GetDifficulty(iDifficulty)

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

  Float scaledLowLevelNPCHealthAdjustment = Game.GetGameSettingFloat("fLowLevelNPCBaseHealthMult")

  String message = "Scaling for a player level of " + iPlayerLevel + " using scaling data from the level " + iPlayerBracket + " bracket.\n"

  message += "NPC Health Boost is " + scaledSponginessNPC + " (Default:" + BaseNPCHealthBonus.GetValueInt() + " X SF:" + sfSponginessNPC + ").\n"
  message += "Player Health Boost is " + scaledSponginessPlayer + " (Default:" + BasePlayerHealthBonus.GetValueInt() + " X SF:" + sfSponginessPlayer + ").\n"

  message += "Low Level NPC Health Adjustment is " + scaledLowLevelNPCHealthAdjustment + " %, subtracted from the players max health. NPC is considered low level after being " + BaseLowLevelNPCVsPlayerLevelDifference.GetValueInt() + " levels below player.\n"

  if (iDifficulty == 0)
    ;; Very Easy Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerVE + " (Default:" + BaseDamageToPlayerVE.GetValue() + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerVE + " (Default:" + BaseDamageByPlayerVE.GetValue() + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerE + " (Default:" + BaseDamageToPlayerE.GetValue() + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerE + " (Default:" + BaseDamageByPlayerE.GetValue() + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerN + " (Default:" + BaseDamageToPlayerN.GetValue() + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerN + " (Default:" + BaseDamageByPlayerN.GetValue() + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerH + " (Default:" + BaseDamageToPlayerH.GetValue() + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerH + " (Default:" + BaseDamageByPlayerH.GetValue() + " X SF:" + sfDamageByPlayer + ").\n"
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    message += "Damage To Player is " + scaledDamageToPlayerVH + " (Default:" + BaseDamageToPlayerVH.GetValue() + " X SF:" + sfDamageToPlayer + ").\n"
    message += "Damage By Player is " + scaledDamageByPlayerVH + " (Default:" + BaseDamageByPlayerVH.GetValue() + " X SF:" + sfDamageByPlayer + ").\n"
  EndIf

  Debug.Trace("VPI_DS_DEBUG (PCIntegration): " + message, 2)
  Debug.Messagebox(message)
EndFunction

;; ****************************************************************************
;; Get the current level scaling config from the player object
;;
;; Use: player.cf "DumpLevelScalingConfig"
;;
Function DumpLevelScalingConfig()
  string message = "*** Defaults ***\n\n"
  message += "NPC Health " + BaseNPCHealthBonus.GetValueInt() + ".\nPlayer Health " + BasePlayerHealthBonus.GetValueInt() + ".\n"
  message += "Low Level NPC Health Adjustment " + BaseLowLevelNPCHealthAdjustment.GetValue() + ".\nNPC is considered low level whe under " + BaseLowLevelNPCVsPlayerLevelDifference.GetValueInt() + " level from player.\n"
  message += "Damage To Player: VE " + BaseDamageToPlayerVE.GetValue() + "; E " + BaseDamageToPlayerE.GetValue() + "; N " + BaseDamageToPlayerN.GetValue() + "; H " + BaseDamageToPlayerH.GetValue() + "; VH " + BaseDamageToPlayerVH.GetValue() + "\n"
  message += "Damage By Player: VE " + BaseDamageByPlayerVE.GetValue() + "; E " + BaseDamageByPlayerE.GetValue() + "; N " + BaseDamageByPlayerN.GetValue() + "; H " + BaseDamageByPlayerH.GetValue() + "; VH " + BaseDamageByPlayerVH.GetValue() + "\n"


  message += "\n\n*** Scaling Factors ***\n\n"
  message += "______________|____01____|____02____|____03____|____04____|____05____|____06____|____07____|____08____|____09____|____10____|\n"

  If (EnableScalingHealth.GetValueInt() == 1)
    message += "NPC Health    | " + SF_NPCHealthBoost[1] + " | " + SF_NPCHealthBoost[2] + " | " + SF_NPCHealthBoost[3] + " | " + SF_NPCHealthBoost[4] + " | " + SF_NPCHealthBoost[5] + " | " + SF_NPCHealthBoost[6] + " | " + SF_NPCHealthBoost[7] + " | " + SF_NPCHealthBoost[8] + " | " + SF_NPCHealthBoost[9] + " | " + SF_NPCHealthBoost[10] + " |\n"
    message += "PC Health     | " + SF_PCHealthBoost[1] + " | " + SF_PCHealthBoost[2] + " | " + SF_PCHealthBoost[3] + " | " + SF_PCHealthBoost[4] + " | " + SF_PCHealthBoost[5] + " | " + SF_PCHealthBoost[6] + " | " + SF_PCHealthBoost[7] + " | " + SF_PCHealthBoost[8] + " | " + SF_PCHealthBoost[9] + " | " + SF_PCHealthBoost[10] + " |\n"
  Else
    message += "NPC Health    | DISABLED                                                                                                    |\n"
    message += "PC Health     | DISABLED                                                                                                    |\n"
  EndIF

  If (EnableScalingDamage.GetValueInt() == 1)
    message += "Damage To PC  | " + SF_DamageToPlayer[1] + " | " + SF_DamageToPlayer[2] + " | " + SF_DamageToPlayer[3] + " | " + SF_DamageToPlayer[4] + " | " + SF_DamageToPlayer[5] + " | " + SF_DamageToPlayer[6] + " | " + SF_DamageToPlayer[7] + " | " + SF_DamageToPlayer[8] + " | " + SF_DamageToPlayer[9] + " | " + SF_DamageToPlayer[10] + " |\n"
    message += "Damage By PC  | " + SF_DamageByPlayer[1] + " | " + SF_DamageByPlayer[2] + " | " + SF_DamageByPlayer[3] + " | " + SF_DamageByPlayer[4] + " | " + SF_DamageByPlayer[5] + " | " + SF_DamageByPlayer[6] + " | " + SF_DamageByPlayer[7] + " | " + SF_DamageByPlayer[8] + " | " + SF_DamageByPlayer[9] + " | " + SF_DamageByPlayer[10] + " |\n"
  Else
    message += "Damage To PC  | DISABLED                                                                                                    |\n"
    message += "Damage By PC  | DISABLED                                                                                                    |\n"
  EndIf

  message += "LL NPC HP ADJ | " + SF_LowLevelNPCHealthAdjustment[1] + " | " + SF_LowLevelNPCHealthAdjustment[2] + " | " + SF_LowLevelNPCHealthAdjustment[3] + " | " + SF_LowLevelNPCHealthAdjustment[4] + " | " + SF_LowLevelNPCHealthAdjustment[5] + " | " + SF_LowLevelNPCHealthAdjustment[6] + " | " + SF_LowLevelNPCHealthAdjustment[7] + " | " + SF_LowLevelNPCHealthAdjustment[8] + " | " + SF_LowLevelNPCHealthAdjustment[9] + " | " + SF_LowLevelNPCHealthAdjustment[10] + " |\n"

  Int iPlayerLevel = GetLevel()
  Float playerHealth = GetValue(Health)
  Float playerScaledBonusHealth = Game.GetGameSettingFloat("fHealthEnduranceOffset")
  Float playerBaseHealth = Game.GetGameSettingFloat("fDefaultHealth")
  Float playerLeveledBonusHealth = (iPlayerLevel - 1) * playerScaledBonusHealth
  
  message += "\n\n*** Mathmatics ***\n\n"
  if (HasPerk(Skill_Wellness)) 
    Float playerCalculatedHealth = (playerBaseHealth + playerLeveledBonusHealth) * 1.40
    message += "Player Heath (" + playerHealth + ") = Base Health (" + playerBaseHealth + ") + Bonus HP Per level (" + playerLeveledBonusHealth + ") * Wellness Perk (40%) => " + playerCalculatedHealth + "(calculated)"
  Else
    Float playerCalculatedHealth = playerBaseHealth + playerLeveledBonusHealth
    message += "Player Heath (" + playerHealth + ") = Base Health (" + playerBaseHealth + ") + Bonus HP Per level (" + playerLeveledBonusHealth + ") * Wellness Perk (0%) => " + playerCalculatedHealth + "(calculated)"
  EndIf

  Debug.Trace("VPI_DS_DEBUG (PCIntegration): " + message, 2)
  Debug.Messagebox(message)
EndFunction