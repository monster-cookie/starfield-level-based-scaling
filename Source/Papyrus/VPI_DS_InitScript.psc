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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnQuestInit()
  VPI_Debug.DebugMessage("InitScript", "OnQuestInit", "OnQuestInit triggered.", 0, Venpi_DebugEnabled.GetValueInt())
  HandleInventory()
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function HandleInventory()
  If PlayerRef.GetItemCount(DS_ConfigTerminal) <= 0
    PlayerRef.AddItem(DS_ConfigTerminal, 1, false)
    VPI_Debug.DebugMessage("InitScript", "HandleInventory", "Config Terminal Item added to player inventory.", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndFunction
