ScriptName VPI_DS_ConfigTerminal Extends ActiveMagicEffect


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
Actor Property PlayerRef Auto
Form Property DS_ConfigTerminal Auto
Message Property DS_ConfigMenuMain Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  If akTarget == PlayerRef as ObjectReference
    PlayerRef.AddItem(DS_ConfigTerminal, 1, True) ;; Need to replace the item we just consumed to trigger the menu
    Self.ProcessMenu(DS_ConfigMenuMain, -1, True)
  EndIf
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
Function ProcessMenu(Message message, Int menuButtonClicked, Bool menuActive)
  While (menuActive)
    If (message == DS_ConfigMenuMain)
      menuButtonClicked = DS_ConfigMenuMain.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; Close Menu Clicked
        menuActive = False

      ElseIf (menuButtonClicked == 1)
        ;; Enable Damage Scaling Clicked
        EnableScalingDamage.SetValue(1)

      ElseIf (menuButtonClicked == 2)
        ;; Disable Damage Scaling Clicked
        EnableScalingDamage.SetValue(0)

      ElseIf (menuButtonClicked == 3)
        ;; Enable Health Scaling Clicked
        EnableScalingHealth.SetValue(1)

      ElseIf (menuButtonClicked == 4)
        ;; Disable Health Scaling Clicked
        EnableScalingHealth.SetValue(0)

      ElseIf (menuButtonClicked == 5)
        ;; Enable XP Scaling Clicked
        EnableScalingXP.SetValue(1)

      ElseIf (menuButtonClicked == 6)
        ;; Disable XP Scaling Clicked
        EnableScalingXP.SetValue(0)

      ElseIf (menuButtonClicked == 7)
        ;; Show Low Level NPC Settings Menu
        ;; message = DS_ConfigMenuDamageScalingDefaults

      ElseIf (menuButtonClicked == 8)
        ;; Show Sponginess Defaults Menu
        ;; message = DS_ConfigMenuDamageScalingDefaults

      ElseIf (menuButtonClicked == 9)
        ;; Show Damage Scaling Defaults Menu
        ;; message = DS_ConfigMenuDamageScalingDefaults

      EndIf
    EndIf
  EndWhile
EndFunction
