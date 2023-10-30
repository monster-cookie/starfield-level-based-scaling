ScriptName VPI_DS_NPCScaler Extends Actor


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto

ActorValue Property Endurance Auto
ActorValue Property Health Auto

ActorValue Property UnarmedDamage Auto
ActorValue Property MeleeDamage Auto
ActorValue Property RangedDamage Auto
ActorValue Property ReflectDamage Auto

ActorValue Property CriticalHitChance Auto
ActorValue Property CriticalHitDamageMult Auto

ActorValue Property DamageResist Auto
ActorValue Property EnergyResist Auto
ActorValue Property ElectromagneticDamageResist Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

; Fired in this order, but on load seems to actually be best and they used it too 

;; Cannot use its called when the leveld list is populated and scaling that early isn't valid plus it fired hundreds of times. 
; Event OnInit() 
;   DebugNPC()
;   Debug.Trace("VPI_DS_EVENT (NPCScaler): OnInit triggered", 0)
; EndEvent

Event OnCellAttach()
  Debug.Trace("VPI_DS_EVENT (NPCScaler): OnCellAttach triggered", 0)
  ScaleToPlayer()
EndEvent

Event OnLoad()
  Debug.Trace("VPI_DS_EVENT (NPCScaler): OnLoad triggered", 0)
EndEvent

Event OnCellLoad()
  Debug.Trace("VPI_DS_EVENT (NPCScaler): OnCellLoad triggered", 0)
EndEvent

; Event OnCombatStateChanged(ObjectReference akTarget, Int aeCombatState)
;   Debug.Trace("VPI_DS_EVENT (NPCScaler): OnCombatStateChanged triggered", 0)
; EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;

; Doesn't work something on the leveled char is overriding its changes after being called
Function ScaleToPlayer()
  int playerLevel = PlayerRef.GetLevel()
  int myLevel = GetLevel()

  int playerHealth = PlayerRef.GetValueInt(Health)
  int myHealth = GetValueInt(Health)

  Float npcScalingAdjustmentToPlayer = (100 - (100 * Game.GetGameSettingFloat("fLowLevelNPCBaseHealthMult")))/100 ;; Already does what we need so lets reuse that system

  ;; The built in autoscaler handles everything but health 
  Float calculatedHealthForNPC = (playerHealth * npcScalingAdjustmentToPlayer) + myHealth
  SetValue(Health, calculatedHealthForNPC)

  ;; Assuming auto scale failed 
  if (myLevel+10 < playerLevel)
    int myDamageResist = GetValueInt(DamageResist)
    int playerDamageResist = PlayerRef.GetValueInt(DamageResist)
    Float calculatedDamageResistForNPC = (playerDamageResist * npcScalingAdjustmentToPlayer) + myDamageResist
    ModValueTo(DamageResist, calculatedDamageResistForNPC)

    int myEnergyResist = GetValueInt(EnergyResist)
    int playerEnergyResist = PlayerRef.GetValueInt(EnergyResist)
    Float calculatedEnergyResistForNPC = (playerEnergyResist * npcScalingAdjustmentToPlayer) + myEnergyResist
    ModValueTo(EnergyResist, calculatedEnergyResistForNPC)
  
    int myEMDamageResist = GetValueInt(ElectromagneticDamageResist)
    int playerEMDamageResist = PlayerRef.GetValueInt(ElectromagneticDamageResist)
    Float calculatedEMDamageResistForNPC = (playerEMDamageResist * npcScalingAdjustmentToPlayer) + myEMDamageResist
    ModValueTo(ElectromagneticDamageResist, calculatedEMDamageResistForNPC)
  EndIf
  DebugNPC("FINAL")
EndFunction

Function DebugNPC(string checkPlace)
  int playerLevel = PlayerRef.GetLevel()
  int myLevel = GetLevel()

  int playerHealth = PlayerRef.GetValueInt(Health)
  int myHealth = GetValueInt(Health)

  int playerDamageResist = PlayerRef.GetValueInt(DamageResist)
  int myDamageResist = GetValueInt(DamageResist)

  int playerEnergyResist = PlayerRef.GetValueInt(EnergyResist)
  int myEnergyResist = GetValueInt(EnergyResist)

  int playerEMDamageResist = PlayerRef.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = GetValueInt(ElectromagneticDamageResist)

  int playerMeleeDamage = PlayerRef.GetValueInt(MeleeDamage)
  int myMeleeDamage = GetValueInt(MeleeDamage)

  int playerUnarmedDamage = PlayerRef.GetValueInt(UnarmedDamage)
  int myUnarmedDamage = GetValueInt(UnarmedDamage)

  int playerRangedDamage = PlayerRef.GetValueInt(RangedDamage)
  int myRangedDamage = GetValueInt(RangedDamage)

  int playerReflectDamage = PlayerRef.GetValueInt(ReflectDamage)
  int myReflectDamage = GetValueInt(ReflectDamage)

  int playerCriticalHitChance = PlayerRef.GetValueInt(CriticalHitChance)
  int myCriticalHitChance = GetValueInt(CriticalHitChance)

  int playerCriticalHitDamageMult = PlayerRef.GetValueInt(CriticalHitDamageMult)
  int myCriticalHitDamageMult = GetValueInt(CriticalHitDamageMult)

  int encounterlevel = CalculateEncounterLevel(Game.GetDifficulty())

  string message = "Current stats (EncLevel " + encounterlevel +"):\n\n"
  message += "My/Player Level: " + myLevel + "/" + playerLevel + ".\n"
  message += "My/Player Health: " + myHealth + "/" + playerHealth + ".\n"
  
  message += "My/Player Damage Resist: " + myDamageResist + "/" + playerDamageResist + ".\n"
  message += "My/Player Energy Resist: " + myEnergyResist + "/" + playerEnergyResist + ".\n"
  message += "My/Player EM Resist: " + myEMDamageResist + "/" + playerEMDamageResist + ".\n"

  message += "My/Player Reflect Damage: " + myReflectDamage + "/" + playerReflectDamage + ".\n"
  message += "My/Player Melee Damage: " + myMeleeDamage + "/" + playerMeleeDamage + ".\n"
  message += "My/Player Unarmed Damage: " + myUnarmedDamage + "/" + playerUnarmedDamage + ".\n"
  message += "My/Player Ranged Damage: " + myReflectDamage + "/" + playerReflectDamage + ".\n"

  message += "My/Player Critical Chance: " + myCriticalHitChance + "/" + playerCriticalHitChance + ".\n"
  message += "My/Player Critical Multiplier: " + myCriticalHitDamageMult + "/" + playerCriticalHitDamageMult + ".\n"

  Debug.Trace("VPI_DS_DEBUG (NPCScaler): [" + checkPlace + "]" + message, 0)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
