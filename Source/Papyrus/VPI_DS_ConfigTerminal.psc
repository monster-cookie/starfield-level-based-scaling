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
Message Property DS_ConfigMenu_LowLevelNPCBaseline Auto
Message Property DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor Auto
Message Property DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference Auto


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
        message = DS_ConfigMenu_LowLevelNPCBaseline
        Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Main Menu Button 7 clicked launching DS_ConfigMenu_LowLevelNPCBaseline.", 0)
      ElseIf (menuButtonClicked == 8)
        ;; Show Sponginess Defaults Menu
        ;; message = DS_ConfigMenuHealthScalingBaseline
      ElseIf (menuButtonClicked == 9)
        ;; Show Damage Scaling Defaults Menu
        ;; message = DS_ConfigMenuDamageScalingBaseline
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Low Level NPC Configuration Menu
    ElseIF (message == DS_ConfigMenu_LowLevelNPCBaseline)
      menuButtonClicked = DS_ConfigMenu_LowLevelNPCBaseline.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenuMain ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; Close Menu Clicked
      ElseIF (menuButtonClicked == 1) 
        ;; Show Low Level NPC Adjustment Factor Menu
        message = DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor
        Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Low Level NPC Menu Button 1 clicked launching DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor.", 0)
      ElseIF (menuButtonClicked == 2) 
        ;; Show Low Level NPC Level Difference Menu
        message = DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference
        Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Low Level NPC Menu Button 2 clicked launching DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference.", 0)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Low Level NPC Adjustment Factor Menu
    ElseIF (message == DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor)
      menuButtonClicked = DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_LowLevelNPCBaseline ;; Return to previous menu
      If (menuButtonClicked == 0)
        ;; Close Menu Clicked
      ElseIF (menuButtonClicked == 1) 
        ;; Set to 95% or 0.05 -- Recommended Setting -- Works weird actual is 95 = 100-(100*0.05)
        BaseLowLevelNPCHealthAdjustment.SetValue(0.05)
      ElseIF (menuButtonClicked == 2) 
        ;; Set to 90% or 0.10
        BaseLowLevelNPCHealthAdjustment.SetValue(0.10)
      ElseIF (menuButtonClicked == 3) 
        ;; Set to 85% or 0.15
        BaseLowLevelNPCHealthAdjustment.SetValue(0.15)
      ElseIF (menuButtonClicked == 4) 
        ;; Set to 80% or 0.20
        BaseLowLevelNPCHealthAdjustment.SetValue(0.20)
      ElseIF (menuButtonClicked == 5) 
        ;; Set to 75% or 0.25 -- Vanilla Setting
        BaseLowLevelNPCHealthAdjustment.SetValue(0.25)
      ElseIF (menuButtonClicked == 6) 
        ;; Set to 70% or 0.30
        BaseLowLevelNPCHealthAdjustment.SetValue(0.30)
      ElseIF (menuButtonClicked == 7) 
        ;; Set to 50% or 0.50
        BaseLowLevelNPCHealthAdjustment.SetValue(0.50)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Low Level NPC Level Difference Menu
    ElseIF (message == DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference)
      menuButtonClicked = DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_LowLevelNPCBaseline ;; Return to previous menu
      If (menuButtonClicked == 0)
        ;; Close Menu Clicked
      ElseIF (menuButtonClicked == 1) 
        ;; Set to 3 Levels -- Vanilla Setting
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(3)
      ElseIF (menuButtonClicked == 2) 
        ;; Set to 5 Levels -- Recommended Setting
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(5)
      ElseIF (menuButtonClicked == 3) 
        ;; Set to 10 Levels
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(10)
      ElseIF (menuButtonClicked == 4) 
        ;; Set to 25 Levels
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(25)
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction
