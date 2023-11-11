Scriptname VPI_DS_NPC_ScalingHandler extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property DSDebugMode Auto Const Mandatory


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
Keyword Property ActorTypeLegendary Auto Const Mandatory

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
ActorValue Property LegendaryRank Auto Const Mandatory

ObjectReference Property Myself Auto
ObjectReference Property PlayerRef Auto Const Mandatory
Actor Property Player Auto
Actor Property RealMe Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCScalingHandler", "OnEffectStart", "OnEffectStart triggered", 0, DSDebugMode.GetValueInt())
  Myself = akTarget
  RealMe = akTarget.GetSelfAsActor()
  Player = PlayerRef.GetSelfAsActor()

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  If (Myself.HasKeyword(DS_SCALING_APPLIED)) 
    return
  EndIf

  RealMe.AddKeyword(DS_SCALING_APPLIED)

  ;; Handle Scaling Stuff
  HandleLevelScaling(VPI_Helper.GetNPCVersion(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
  HandleHeightScaling(VPI_Helper.GetNPCVersion(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCScalingHandler", "OnEffectFinish", "OnEffectFinish triggered", 0, DSDebugMode.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;

Function HandleHeightScaling(Int npcType)
  Float currentScale = RealMe.GetScale()
  Float newScale = currentScale
  If (npcType == 5)
    newScale = currentScale * Utility.RandomFloat(1.25,2.5)
    VPI_Helper.DebugMessage("NPCScalingHandler", "HandleHeight", "Leveled NPC is a MK5 type and needs enlarged. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0, DSDebugMode.GetValueInt())
  ElseIf (npcType == 1)
    newScale = currentScale * Utility.RandomFloat(0.25,0.90)
    VPI_Helper.DebugMessage("NPCScalingHandler", "HandleHeight", "Leveled NPC is a MK1 type and needs shrunk. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0, DSDebugMode.GetValueInt())
  Else
    VPI_Helper.DebugMessage("NPCScalingHandler", "HandleHeight", "Leveled NPC is a normal class so no scaling needed.", 0, DSDebugMode.GetValueInt())
    newScale = currentScale
  EndIf
  RealMe.SetScale(newScale)
EndFunction

Function HandleLevelScaling(Int npcType)
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()
  VPI_Helper.DebugMessage("NPCScalingHandler", "HandleHeight", "Scaling for a player of level " + playerLevel + " and my level is " + myLevel + ".", 0, DSDebugMode.GetValueInt())

  int playerHealth = Player.GetValueInt(Health)
  int myHealth = RealMe.GetValueInt(Health)

  int playerDamageResist = Player.GetValueInt(DamageResist)
  int myDamageResist = RealMe.GetValueInt(DamageResist)

  int playerEnergyResist = Player.GetValueInt(EnergyResist)
  int myEnergyResist = RealMe.GetValueInt(EnergyResist)

  int playerEMDamageResist = Player.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)

  int playerReflectDamage = Player.GetValueInt(ReflectDamage)
  int myReflectDamage = RealMe.GetValueInt(ReflectDamage)

  int encounterlevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  string message = "Current stats (Encounter Level " + encounterlevel +"):\n\n"
  message += "My/Player Level: " + myLevel + "/" + playerLevel + ".\n"
  message += "My/Player Health: " + myHealth + "/" + playerHealth + ".\n"
  
  message += "My/Player Damage Resist: " + myDamageResist + " | " + playerDamageResist + ".\n"
  message += "My/Player Energy Resist: " + myEnergyResist + " | " + playerEnergyResist + ".\n"
  message += "My/Player EM Resist: " + myEMDamageResist + " | " + playerEMDamageResist + ".\n"
  message += "My/Player Reflect Damage: " + myReflectDamage + " | " + playerReflectDamage + ".\n"
  VPI_Helper.DebugMessage("NPCScalingHandler", "HandleLevelScaling", message, 0, DSDebugMode.GetValueInt())

EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
