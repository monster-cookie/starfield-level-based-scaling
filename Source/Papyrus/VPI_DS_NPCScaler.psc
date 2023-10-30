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
  int playerEnergyResist = PlayerRef.GetValueInt(EnergyResist)
  int playerEMDamageResist = PlayerRef.GetValueInt(ElectromagneticDamageResist)
  int myDamageResist = GetValueInt(DamageResist)
  int myEnergyResist = GetValueInt(EnergyResist)
  int myEMDamageResist = GetValueInt(ElectromagneticDamageResist)

  int encounterlevel = CalculateEncounterLevel(Game.GetDifficulty())

  string message = "Current stats (EncLevel " + encounterlevel +"):\n\n"
  message += "My/Player Level: " + myLevel + "/" + playerLevel + ".\n"
  message += "My/Player Health: " + myHealth + "/" + playerHealth + ".\n"
  message += "My/Player Damage Resist: " + myDamageResist + "/" + playerDamageResist + ".\n"
  message += "My/Player Energy Resist: " + myEnergyResist + "/" + playerEnergyResist + ".\n"
  message += "My/Player EM Resist: " + myEMDamageResist + "/" + playerEMDamageResist + ".\n"
  Debug.Trace("VPI_DS_DEBUG (NPCScaler): [" + checkPlace + "]" + message, 0)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
