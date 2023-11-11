scriptname VPI_DS_InitScript extends Quest


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;


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
  Debug.Trace("VPI_DS_EVENT (InitScript): OnQuestInit triggered", 0)
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
  EndIf
EndFunction

Function HandleSpell()
  PlayerRef.AddSpell(DS_NPC_CloakEnabler_Ability, false)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
