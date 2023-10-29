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
Event OnInit() 
  ; Debug.Trace("VPI_DS_EVENT (NPCScaler): OnInit triggered", 0)
EndEvent

Event OnCellAttach()
;   Debug.Trace("VPI_DS_EVENT (NPCScaler): OnCellAttach triggered", 0)
ScaleToPlayer()
EndEvent

; Event OnLoad()
;   Debug.Trace("VPI_DS_EVENT (NPCScaler): OnLoad triggered", 0)
; EndEvent

; Event OnCombatStateChanged(ObjectReference akTarget, Int aeCombatState)
;   Debug.Trace("VPI_DS_EVENT (NPCScaler): OnCombatStateChanged triggered", 0)
; EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;
Function ScaleToPlayer()
  int playerLevel = PlayerRef.GetLevel()
  Debug.Trace("VPI_DS_DEBUG (NPCScaler): Scaling for a player of level " + playerLevel, 0)
  
  int myLevel = GetLevel()
  int myHealth = GetValueInt(Health)
  int myDamageResist = GetValueInt(DamageResist)
  int myEnergyResist = GetValueInt(EnergyResist)
  int myEMDamageResist = GetValueInt(ElectromagneticDamageResist)
  string message = "My current stats:\n\n"
  message += "My Level: " + myLevel + ".\n"
  message += "My Health: " + myHealth + ".\n"
  message += "My Damage Resist: " + myDamageResist + ".\n"
  message += "My Energy Resist: " + myEnergyResist + ".\n"
  message += "My EM Resist: " + myEMDamageResist + ".\n"
  Debug.Trace("VPI_DS_DEBUG (NPCScaler):" + message, 0)

  ;; The built in autoscaler handles everything but health 
  Float healthAdjustmentLowLevelNPCs = (100 - (100 * Game.GetGameSettingFloat("fLowLevelNPCBaseHealthMult")))/100 ;; Already does what we need so reuse that system
  Float playerHealth = PlayerRef.GetValue(Health)
  Float calculatedHealthForNPC = (playerHealth * healthAdjustmentLowLevelNPCs) + myHealth
  SetValue(Health, calculatedHealthForNPC)
  Debug.Trace("VPI_DS_FINAL_RESULT (NPCScaler): For a player level of " + playerLevel + " and a player health pool of " + playerHealth + ", resulting in an adjusted health pool of " + calculatedHealthForNPC + " for me using a Low Level adjustment (fNPCHealthLevelBonus) of " + healthAdjustmentLowLevelNPCs + ".", 0)
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
