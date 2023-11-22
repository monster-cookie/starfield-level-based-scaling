Scriptname VPI_DS_NPC_ScalingHandler extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
GlobalVariable Property EnableCombatFactionResize Auto Const Mandatory
GlobalVariable Property EnableCombatFactionStatsScaling Auto Const Mandatory
GlobalVariable Property DSLegendaryChanceNotToSpawn Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Keyword Property NPC_Type_MK1 Auto Const Mandatory
Keyword Property NPC_Type_MK2 Auto Const Mandatory
Keyword Property NPC_Type_MK3 Auto Const Mandatory
Keyword Property NPC_Type_MK4 Auto Const Mandatory
Keyword Property NPC_Type_MK5 Auto Const Mandatory
Keyword Property NPC_Pirate Auto Const Mandatory
Keyword Property NPC_Varuun Auto Const Mandatory
Keyword Property NPC_CrimsonFleet Auto Const Mandatory
Keyword Property NPC_Ecliptic Auto Const Mandatory
Keyword Property NPC_Spacer Auto Const Mandatory
Keyword Property DS_SCALING_APPLIED Auto Const Mandatory

ActorValue Property Health Auto Const Mandatory
ActorValue Property DamageResist Auto Const Mandatory
ActorValue Property EnergyResist Auto Const Mandatory
ActorValue Property ElectromagneticDamageResist Auto Const Mandatory
ActorValue Property ENV_Resist_Radiation Auto Const Mandatory
ActorValue Property ENV_Resist_Corrosive Auto Const Mandatory
ActorValue Property ENV_Resist_Airborne Auto Const Mandatory
ActorValue Property ENV_Resist_Thermal Auto Const Mandatory
ActorValue Property CriticalHitChance Auto Const Mandatory
ActorValue Property CriticalHitDamageMult Auto Const Mandatory
ActorValue Property AttackDamageMult Auto Const Mandatory
ActorValue Property ReflectDamage Auto Const Mandatory

Keyword Property ActorTypeLegendary Auto Const Mandatory
;; ActorValue Property LegendaryRank Auto Const Mandatory
LegendaryAliasQuestScript Property LegendaryAliasQuest Auto Const mandatory

ObjectReference Property Myself Auto
ObjectReference Property PlayerRef Auto Const Mandatory
Actor Property Player Auto
Actor Property RealMe Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCScalingHandler", "OnEffectStart", "OnEffectStart triggered", 0, Venpi_DebugEnabled.GetValueInt())
  Myself = akTarget
  RealMe = akTarget.GetSelfAsActor()
  Player = PlayerRef.GetSelfAsActor()

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  If (Myself.HasKeyword(DS_SCALING_APPLIED)) 
    return
  EndIf

  RealMe.AddKeyword(DS_SCALING_APPLIED)

  ;; Handle Scaling Stuff
  If (EnableCombatFactionStatsScaling.GetValueInt() == 1)
    HandleLevelScaling(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
  Else
    VPI_Helper.DebugMessage("NPCScalingHandler", "OnEffectStart", "Combat Faction NPC Stat Scaling is currently disabled.", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
  If (EnableCombatFactionResize.GetValueInt() == 1)
    HandleHeightScaling(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
  Else
    VPI_Helper.DebugMessage("NPCScalingHandler", "OnEffectStart", "Combat Faction NPC Height Resizing is currently disabled.", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCScalingHandler", "OnEffectFinish", "OnEffectFinish triggered", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;

Function HandleHeightScaling(Int npcType)
  Float currentScale = RealMe.GetScale()
  Float newScale = currentScale
  If (npcType == 5)
    newScale = currentScale * Utility.RandomFloat(1.05,2.0)
    VPI_Helper.DebugMessage("NPCScalingHandler", "HandleHeight", Myself + "> Leveled NPC is a MK5 type and needs enlarged. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0, Venpi_DebugEnabled.GetValueInt())
  ElseIf (npcType == 1)
    newScale = currentScale * Utility.RandomFloat(0.35,0.95)
    VPI_Helper.DebugMessage("NPCScalingHandler", "HandleHeight", Myself + "> Leveled NPC is a MK1 type and needs shrunk. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0, Venpi_DebugEnabled.GetValueInt())
  Else
    VPI_Helper.DebugMessage("NPCScalingHandler", "HandleHeight", Myself + "> Leveled NPC is a normal class so no scaling needed.", 0, Venpi_DebugEnabled.GetValueInt())
    newScale = currentScale
  EndIf
  RealMe.SetScale(newScale)
EndFunction

Function HandleLevelScaling(Int npcType)
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()

  int playerHealth = Player.GetValueInt(Health)
  int myHealth = RealMe.GetValueInt(Health)

  int playerDamageResist = Player.GetValueInt(DamageResist)
  int myDamageResist = RealMe.GetValueInt(DamageResist)
  int playerEnergyResist = Player.GetValueInt(EnergyResist)
  int myEnergyResist = RealMe.GetValueInt(EnergyResist)
  int playerEMDamageResist = Player.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)

  int playerRadiationResist = Player.GetValueInt(ENV_Resist_Radiation)
  int myRadiationResist = RealMe.GetValueInt(ENV_Resist_Radiation)
  int playerCorrosiveResist = Player.GetValueInt(ENV_Resist_Corrosive)
  int myCorrosiveResist = RealMe.GetValueInt(ENV_Resist_Corrosive)
  int playerAirborneResist = Player.GetValueInt(ENV_Resist_Airborne)
  int myAirborneResist = RealMe.GetValueInt(ENV_Resist_Airborne)
  int playerThermalResist = Player.GetValueInt(ENV_Resist_Thermal)
  int myThermalResist = RealMe.GetValueInt(ENV_Resist_Thermal)

  Float playerReflectDamage = Player.GetValue(ReflectDamage)
  Float myReflectDamage = RealMe.GetValue(ReflectDamage)
  Float playerCriticalHitChance = Player.GetValue(CriticalHitChance)
  Float myCriticalHitChance = RealMe.GetValue(CriticalHitChance)
  Float playerCriticalHitDamageMult = Player.GetValue(CriticalHitDamageMult)
  Float myCriticalHitDamageMult = RealMe.GetValue(CriticalHitDamageMult)
  Float playerAttackDamageMult = Player.GetValue(AttackDamageMult)
  Float myAttackDamageMult = RealMe.GetValue(AttackDamageMult)

  int encounterlevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  If (RealMe.HasKeyword(ActorTypeLegendary))
      VPI_Helper.DebugMessage("NPCScalingHandler", "HandleLevelScaling",  Myself + "> is already a legendary and scaling basically negates so skipping for a NPC Type of " + npcType + ".", 0, Venpi_DebugEnabled.GetValueInt())
      DebugLevelScaling(npcType, "FINAL")
      return
  EndIf

  If (DSLegendaryChanceNotToSpawn.GetValueInt() == 0 || Game.GetDieRollSuccess(DSLegendaryChanceNotToSpawn.GetValueInt(), 1, 100, -1, -1))
    ;; Won the lotto I become a legendary
    LegendaryAliasQuest.MakeLegendary(RealMe)
    VPI_Helper.DebugMessage("NPCScalingHandler", "HandleLevelScaling",  Myself + "> hase won the lottoe and is now a legendary and scaling basically negates so skipping for a NPC Type of " + npcType + ".", 0, Venpi_DebugEnabled.GetValueInt())
    DebugLevelScaling(npcType, "FINAL")
    return
  EndIf

  DebugLevelScaling(npcType, "INITIAL")

  ;; Already does what we need so lets reuse that system, another option is the PC Level Multiplier but not sure I can get that
  Float npcScalingAdjustmentToPlayer = GetScalingAdjustmentForDifficultyAndNPCType(Game.GetGameSettingFloat("fLowLevelNPCBaseHealthMult"), npcType)
  string message = Myself + "> Calculated a stat adjustment factor of " + npcScalingAdjustmentToPlayer + " for a NPC Type of " + npcType + ".\n"

  int scaledHealth = Math.Round(playerHealth * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(Health, scaledHealth)
  message += "Adjusting my Health to " + scaledHealth + " from " + myHealth + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerHealth + " health.\n"

  int scaledDamageResist = Math.Round(playerDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(DamageResist, scaledDamageResist)
  message += "Adjusting my Damage Resist stat to " + scaledDamageResist + " from " + myDamageResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerDamageResist + " damage resist.\n"

  int scaledEnergyResist = Math.Round(playerEnergyResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(EnergyResist, scaledEnergyResist)
  message += "Adjusting my Energy Resist stat to " + scaledEnergyResist + " from " + myEnergyResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerEnergyResist + " energy resist.\n"

  int scaledEMDamageResist = Math.Round(playerEMDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(ElectromagneticDamageResist, scaledEMDamageResist)
  message += "Adjusting my EM Damage Resist stat to " + scaledEMDamageResist + " from " + myEMDamageResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerEMDamageResist + " EM damage resist.\n"

  Float scaledCriticalHitChance = Math.Round(playerCriticalHitChance * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(CriticalHitChance, scaledCriticalHitChance)
  message += "Adjusting my EM Damage Resist stat to " + scaledCriticalHitChance + " from " + myCriticalHitChance + " using a scalig factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerCriticalHitChance + " EM damage resist.\n"


  ;; Some stats adjust by rank
  Float scaledAttackDamageMult = myAttackDamageMult
  Float scaledCriticalHitDamageMult = myCriticalHitDamageMult
  If (npcType == 5)
    scaledAttackDamageMult = 1.5
    scaledCriticalHitDamageMult = 1.5
  ElseIf (npcType == 4)
    scaledAttackDamageMult = 1.5
    scaledCriticalHitDamageMult = 1.5
  ElseIf (npcType == 3)
    scaledAttackDamageMult = 1.15
    scaledCriticalHitDamageMult = 1.15
  ElseIf (npcType == 2)
    scaledAttackDamageMult = 1.00
    scaledCriticalHitDamageMult = 1.00
  ElseIf (npcType == 1)
    scaledAttackDamageMult = 0.95
    scaledCriticalHitDamageMult = 0.95
  EndIf
  message += "Adjusting my attack multiplier to " + scaledAttackDamageMult + " from " + myAttackDamageMult + " against the player's " + playerAttackDamageMult + ".\n"
  RealMe.SetValue(AttackDamageMult, scaledAttackDamageMult)

  message += "Adjusting my critical damage multiplier to " + scaledCriticalHitDamageMult + " from " + myCriticalHitDamageMult + " against the player's " + playerCriticalHitDamageMult + ".\n"
  RealMe.SetValue(CriticalHitDamageMult, scaledCriticalHitDamageMult)

  VPI_Helper.DebugMessage("NPCScalingHandler", "HandleLevelScaling", message, 0, Venpi_DebugEnabled.GetValueInt())
  DebugLevelScaling(npcType, "FINAL")
EndFunction

Function DebugLevelScaling(Int npcType, String scalingState)
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()
  string myRace = VPI_Helper.GetNPCRace(Myself, NPC_Varuun, NPC_CrimsonFleet, NPC_Ecliptic, NPC_Spacer)
  string message = Myself + "> Scaling for a player of level " + playerLevel + " and my level is " + myLevel + ".\n"
  message += "I am a class " + npcType + " NPC in combat faction " + myRace + ".\n\n"

  int playerHealth = Player.GetValueInt(Health)
  int myHealth = RealMe.GetValueInt(Health)

  int playerDamageResist = Player.GetValueInt(DamageResist)
  int myDamageResist = RealMe.GetValueInt(DamageResist)
  int playerEnergyResist = Player.GetValueInt(EnergyResist)
  int myEnergyResist = RealMe.GetValueInt(EnergyResist)
  int playerEMDamageResist = Player.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)

  int playerRadiationResist = Player.GetValueInt(ENV_Resist_Radiation)
  int myRadiationResist = RealMe.GetValueInt(ENV_Resist_Radiation)
  int playerCorrosiveResist = Player.GetValueInt(ENV_Resist_Corrosive)
  int myCorrosiveResist = RealMe.GetValueInt(ENV_Resist_Corrosive)
  int playerAirborneResist = Player.GetValueInt(ENV_Resist_Airborne)
  int myAirborneResist = RealMe.GetValueInt(ENV_Resist_Airborne)
  int playerThermalResist = Player.GetValueInt(ENV_Resist_Thermal)
  int myThermalResist = RealMe.GetValueInt(ENV_Resist_Thermal)

  Float playerReflectDamage = Player.GetValue(ReflectDamage)
  Float myReflectDamage = RealMe.GetValue(ReflectDamage)
  Float playerCriticalHitChance = Player.GetValue(CriticalHitChance)
  Float myCriticalHitChance = RealMe.GetValue(CriticalHitChance)
  Float playerCriticalHitDamageMult = Player.GetValue(CriticalHitDamageMult)
  Float myCriticalHitDamageMult = RealMe.GetValue(CriticalHitDamageMult)
  Float playerAttackDamageMult = Player.GetValue(AttackDamageMult)
  Float myAttackDamageMult = RealMe.GetValue(AttackDamageMult)

  int encounterlevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  message += "Current stats (Encounter Level " + encounterlevel +"):\n"
  message += "My/Player Level: " + myLevel + "/" + playerLevel + ".\n"
  message += "My/Player Health: " + myHealth + "/" + playerHealth + ".\n"
  
  message += "My/Player Damage Resist: " + myDamageResist + " | " + playerDamageResist + ".\n"
  message += "My/Player Energy Resist: " + myEnergyResist + " | " + playerEnergyResist + ".\n"
  message += "My/Player EM Resist: " + myEMDamageResist + " | " + playerEMDamageResist + ".\n"

  message += "My/Player Radiation Resist: " + myRadiationResist + " | " + playerRadiationResist + ".\n"
  message += "My/Player Corrosive Resist: " + myCorrosiveResist + " | " + playerCorrosiveResist + ".\n"
  message += "My/Player Airborne Resist: " + myAirborneResist + " | " + playerAirborneResist + ".\n"
  message += "My/Player Thermal Resist: " + myThermalResist + " | " + playerThermalResist + ".\n"

  message += "My/Player Reflect Damage: " + myReflectDamage + " | " + playerReflectDamage + ".\n"
  message += "My/Player Critical Hit Chance: " + myCriticalHitChance + " | " + playerCriticalHitChance + ".\n"
  message += "My/Player Critical Hit Damage Multiplier: " + myCriticalHitDamageMult + " | " + playerCriticalHitDamageMult + ".\n"
  message += "My/Player Attack Damage Multiplier: " + myAttackDamageMult + " | " + playerAttackDamageMult + ".\n"

  VPI_Helper.DebugMessage("NPCScalingHandler", "DebugLevelScaling-" + scalingState, message, 0, Venpi_DebugEnabled.GetValueInt())
EndFunction

Float Function GetScalingAdjustmentForDifficultyAndNPCType(Float adjustmentFactor, int npcType)
  Int iDifficulty = Game.GetDifficulty()
  string sDifficulty = VPI_Helper.GetDifficulty(iDifficulty)

  Float base = ((100 - (100 * adjustmentFactor))/100)
  Float calculated = 1
  if (iDifficulty == 0)
    ;; Very Easy Difficulty
    calculated = base + 0.05
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    calculated = base + 0.10
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    calculated = base + 0.25
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    calculated = base + 0.50
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    calculated = base + 1
  Else 
    ;; Really cna only be survival mode
    calculated = base + 2
  EndIf

  If (npcType == 5) 
    calculated = calculated * 1.25
  ElseIf (npcType == 1)
    calculated = calculated * 0.90
  EndIf

  return calculated
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
