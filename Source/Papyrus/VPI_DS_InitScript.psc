scriptname VPI_DS_InitScript extends Quest

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto Const Mandatory
Form Property DS_ConfigTerminal Auto Const Mandatory
Spell Property DS_NPC_CloakEnabler_Ability Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnQuestInit()
  VPI_Debug.DebugMessage("InitScript", "OnQuestInit", "OnQuestInit triggered.", 0, Venpi_DebugEnabled.GetValueInt())
  HandleInventory()
  HandleSpell()
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;
Function HandleInventory()
  If PlayerRef.GetItemCount(DS_ConfigTerminal) <= 0
    PlayerRef.AddItem(DS_ConfigTerminal, 1, false)
    VPI_Debug.DebugMessage("InitScript", "HandleInventory", "Config Terminal Item added to player inventory.", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndFunction

Function HandleSpell()
  PlayerRef.AddSpell(DS_NPC_CloakEnabler_Ability, false)
  VPI_Debug.DebugMessage("InitScript", "HandleSpell", "Cloak enabler spell added to playerref.", 0, Venpi_DebugEnabled.GetValueInt())
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
