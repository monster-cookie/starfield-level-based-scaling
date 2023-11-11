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
Message Property DS_ConfigMenu_HealthScalingBaseline Auto
Message Property DS_ConfigMenu_HealthScalingBaseline_NPCBonusHeath Auto
Message Property DS_ConfigMenu_HealthScalingBaseline_PlayerBonusHeath Auto
Message Property DS_ConfigMenu_DamageScalingBaseline Auto
Message Property DS_ConfigMenu_DamageScalingBaseline_DMGByPlayer Auto
Message Property DS_ConfigMenu_DamageScalingBaseline_DMGToPlayer Auto


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
        ; Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Main Menu Button 7 clicked launching DS_ConfigMenu_LowLevelNPCBaseline.", 0)
      ElseIf (menuButtonClicked == 8)
        ;; Show Sponginess Defaults Menu
        message = DS_ConfigMenu_HealthScalingBaseline
      ElseIf (menuButtonClicked == 9)
        ;; Show Damage Scaling Defaults Menu
        message = DS_ConfigMenu_DamageScalingBaseline
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Low Level NPC Configuration Menu
    ElseIF (message == DS_ConfigMenu_LowLevelNPCBaseline)
      menuButtonClicked = DS_ConfigMenu_LowLevelNPCBaseline.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenuMain ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Configure Low Level NPC Adjustment Factor
        message = DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor
        ; Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Low Level NPC Menu Button 1 clicked launching DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor.", 0)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Configure how many levels below player is considered low level
        message = DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference
        ; Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Low Level NPC Menu Button 2 clicked launching DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference.", 0)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Low Level NPC Adjustment Factor Menu
    ElseIF (message == DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor)
      menuButtonClicked = DS_ConfigMenu_LowLevelNPCBaseline_AdjustmentFactor.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_LowLevelNPCBaseline ;; Return to previous menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to Low Level NPC Configuration Menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Set to 95% of player level (Recommended) -- Global has to be 0.05
        BaseLowLevelNPCHealthAdjustment.SetValue(0.05)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Set to 90% of player level -- Global has to be 0.10
        BaseLowLevelNPCHealthAdjustment.SetValue(0.10)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Set to 85% of player level -- Global has to be 0.15
        BaseLowLevelNPCHealthAdjustment.SetValue(0.15)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Set to 80% of player level -- Global has to be 0.20
        BaseLowLevelNPCHealthAdjustment.SetValue(0.20)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Set to 75% of player level (Vanilla) -- Global has to be 0.25
        BaseLowLevelNPCHealthAdjustment.SetValue(0.25)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Set to 70% of player level -- Global has to be 0.30
        BaseLowLevelNPCHealthAdjustment.SetValue(0.30)
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Set to 50% of player level -- Global has to be 0.50
        BaseLowLevelNPCHealthAdjustment.SetValue(0.50)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Low Level NPC Level Difference Menu
    ElseIF (message == DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference)
      menuButtonClicked = DS_ConfigMenu_LowLevelNPCBaseline_LevelDifference.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_LowLevelNPCBaseline ;; Return to previous menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to Low Level NPC Configuration Menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: 3 Levels (Vanilla)
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(3)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: 5 Levels (Recommended)
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(5)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: 10 Levels
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(10)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: 25 Levels
        BaseLowLevelNPCVsPlayerLevelDifference.SetValueInt(25)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Baseline Health Configuration Menu
    ElseIF (message == DS_ConfigMenu_HealthScalingBaseline)
      menuButtonClicked = DS_ConfigMenu_HealthScalingBaseline.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenuMain ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Configure NPC Bonus Health Baseline
        message = DS_ConfigMenu_HealthScalingBaseline_NPCBonusHeath
        ; Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Health Scaling Baseline Menu Button 1 clicked launching DS_ConfigMenu_HealthScalingBaseline_NPCBonusHeath.", 0)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Configure Player Bonus Health Baseline
        message = DS_ConfigMenu_HealthScalingBaseline_PlayerBonusHeath
        ; Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Health Scaling Baseline Menu Button 2 clicked launching DS_ConfigMenu_HealthScalingBaseline_PlayerBonusHeath.", 0)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show NPC Bonus Health Configuration Menu
    ElseIF (message == DS_ConfigMenu_HealthScalingBaseline_NPCBonusHeath)
      menuButtonClicked = DS_ConfigMenu_HealthScalingBaseline_NPCBonusHeath.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_HealthScalingBaseline ;; Return to previous menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to Health Scaling Baseline Configuration Menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: 0 Health Bonus per Level
        BaseNPCHealthBonus.SetValueInt(0)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: 2 Health Bonus per Level
        BaseNPCHealthBonus.SetValueInt(2)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: 5 Health Bonus per Level (Recommended)
        BaseNPCHealthBonus.SetValueInt(5)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: 10 Health Bonus per Level
        BaseNPCHealthBonus.SetValueInt(10)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: 15 Health Bonus per Level
        BaseNPCHealthBonus.SetValueInt(15)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: 20 Health Bonus per Level (Vanilla)
        BaseNPCHealthBonus.SetValueInt(20)
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: 15 Health Bonus per Level
        BaseNPCHealthBonus.SetValueInt(25)
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: 50 Health Bonus per Level
        BaseNPCHealthBonus.SetValueInt(50)
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: 100 Health Bonus per Level
        BaseNPCHealthBonus.SetValueInt(100)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Player Bonus Health Configuration Menu
    ElseIF (message == DS_ConfigMenu_HealthScalingBaseline_PlayerBonusHeath)
      menuButtonClicked = DS_ConfigMenu_HealthScalingBaseline_PlayerBonusHeath.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_HealthScalingBaseline ;; Return to previous menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to Health Scaling Baseline Configuration Menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: 0 Health Bonus per Level
        BasePlayerHealthBonus.SetValueInt(0)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: 2 Health Bonus per Level
        BasePlayerHealthBonus.SetValueInt(2)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: 5 Health Bonus per Level (Recommended)
        BasePlayerHealthBonus.SetValueInt(5)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: 10 Health Bonus per Level
        BasePlayerHealthBonus.SetValueInt(10)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: 15 Health Bonus per Level
        BasePlayerHealthBonus.SetValueInt(15)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: 20 Health Bonus per Level (Vanilla)
        BasePlayerHealthBonus.SetValueInt(20)
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: 15 Health Bonus per Level
        BasePlayerHealthBonus.SetValueInt(25)
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: 50 Health Bonus per Level
        BasePlayerHealthBonus.SetValueInt(50)
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: 100 Health Bonus per Level
        BasePlayerHealthBonus.SetValueInt(100)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Baseline Damage Configuration Menu
    ElseIF (message == DS_ConfigMenu_DamageScalingBaseline)
      menuButtonClicked = DS_ConfigMenu_DamageScalingBaseline.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenuMain ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Configure Damage To Player
        message = DS_ConfigMenu_DamageScalingBaseline_DMGToPlayer
        ; Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Damage Scaling Baseline Menu Button 1 clicked launching DS_ConfigMenu_DamageScalingBaseline_DMGToPlayer.", 0)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Configure Damage By Player
        message = DS_ConfigMenu_DamageScalingBaseline_DMGByPlayer
        ; Debug.Trace("VPI_DS_DEBUG (ConfigTerminal): Damage Scaling Baseline Menu Button 2 clicked launching DS_ConfigMenu_DamageScalingBaseline_DMGByPlayer.", 0)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Baseline Damage To Player Configuration Menu
    ElseIF (message == DS_ConfigMenu_DamageScalingBaseline_DMGToPlayer)
      menuButtonClicked = DS_ConfigMenu_DamageScalingBaseline_DMGToPlayer.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_DamageScalingBaseline ;; Return to previous menu
      Int difficulty = Game.GetDifficulty()
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to Damage Scaling Baseline Configuration Menu
      ElseIF (menuButtonClicked == 1)
        ;; CLICKED 1: Set to 0.25
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(0.25)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(0.25)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(0.25)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(0.25)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(0.25)
        EndIf
      ElseIF (menuButtonClicked == 2)
        ;; CLICKED 2: Set to 0.50
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(0.50)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(0.50)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(0.50)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(0.50)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(0.50)
        EndIf
      ElseIF (menuButtonClicked == 3)
        ;; CLICKED 3: Set to 0.75
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(0.75)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(0.75)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(0.75)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(0.75)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(0.75)
        EndIf
      ElseIF (menuButtonClicked == 4)
        ;; CLICKED 4: Set to 1.00
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(1.00)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(1.00)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(1.00)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(1.00)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(1.00)
        EndIf
      ElseIF (menuButtonClicked == 5)
        ;; CLICKED 5: Set to 1.25
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(1.25)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(1.25)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(1.25)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(1.25)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(1.25)
        EndIf
      ElseIF (menuButtonClicked == 6)
        ;; CLICKED 6: Set to 1.50
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(1.50)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(1.50)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(1.50)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(1.50)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(1.50)
        EndIf
      ElseIF (menuButtonClicked == 7)
        ;; CLICKED 7: Set to 1.75
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(1.75)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(1.75)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(1.75)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(1.75)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(1.75)
        EndIf
      ElseIF (menuButtonClicked == 8)
        ;; CLICKED 8: Set to 2.00
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(2.00)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(2.00)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(2.00)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(2.00)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(2.00)
        EndIf
      ElseIF (menuButtonClicked == 9)
        ;; CLICKED 9: Set to 2.25
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(2.25)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(2.25)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(2.25)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(2.25)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(2.25)
        EndIf
      ElseIF (menuButtonClicked == 10)
        ;; CLICKED 10: Set to 2.50
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(2.50)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(2.50)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(2.50)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(2.50)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(2.50)
        EndIf
      ElseIF (menuButtonClicked == 11)
        ;; CLICKED 11: Set to 2.75
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(2.75)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(2.75)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(2.75)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(2.75)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(2.75)
        EndIf
      ElseIF (menuButtonClicked == 12)
        ;; CLICKED 12: Set to 3.00
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageToPlayerVE.SetValue(3.00)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageToPlayerE.SetValue(3.00)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageToPlayerN.SetValue(3.00)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageToPlayerH.SetValue(3.00)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageToPlayerVH.SetValue(3.00)
        EndIf
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Baseline Damage By Player Configuration Menu
    ElseIF (message == DS_ConfigMenu_DamageScalingBaseline_DMGByPlayer)
      menuButtonClicked = DS_ConfigMenu_DamageScalingBaseline_DMGByPlayer.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = DS_ConfigMenu_DamageScalingBaseline ;; Return to previous menu
      Int difficulty = Game.GetDifficulty()
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to Damage Scaling Baseline Configuration Menu
      ElseIF (menuButtonClicked == 1)
        ;; CLICKED 1: Set to 0.25
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(0.25)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(0.25)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(0.25)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(0.25)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(0.25)
        EndIf
      ElseIF (menuButtonClicked == 2)
        ;; CLICKED 2: Set to 0.50
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(0.50)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(0.50)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(0.50)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(0.50)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(0.50)
        EndIf
      ElseIF (menuButtonClicked == 3)
        ;; CLICKED 3: Set to 0.75
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(0.75)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(0.75)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(0.75)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(0.75)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(0.75)
        EndIf
      ElseIF (menuButtonClicked == 4)
        ;; CLICKED 4: Set to 1.00
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(1.00)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(1.00)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(1.00)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(1.00)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(1.00)
        EndIf
      ElseIF (menuButtonClicked == 5)
        ;; CLICKED 5: Set to 1.25
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(1.25)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(1.25)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(1.25)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(1.25)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(1.25)
        EndIf
      ElseIF (menuButtonClicked == 6)
        ;; CLICKED 6: Set to 1.50
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(1.50)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(1.50)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(1.50)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(1.50)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(1.50)
        EndIf
      ElseIF (menuButtonClicked == 7)
        ;; CLICKED 7: Set to 1.75
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(1.75)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(1.75)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(1.75)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(1.75)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(1.75)
        EndIf
      ElseIF (menuButtonClicked == 8)
        ;; CLICKED 8: Set to 2.00
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(2.00)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(2.00)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(2.00)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(2.00)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(2.00)
        EndIf
      ElseIF (menuButtonClicked == 9)
        ;; CLICKED 9: Set to 2.25
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(2.25)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(2.25)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(2.25)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(2.25)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(2.25)
        EndIf
      ElseIF (menuButtonClicked == 10)
        ;; CLICKED 10: Set to 2.50
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(2.50)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(2.50)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(2.50)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(2.50)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(2.50)
        EndIf
      ElseIF (menuButtonClicked == 11)
        ;; CLICKED 11: Set to 2.75
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(2.75)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(2.75)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(2.75)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(2.75)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(2.75)
        EndIf
      ElseIF (menuButtonClicked == 12)
        ;; CLICKED 12: Set to 3.00
        If (difficulty == 0) ;; Very Easy Difficulty
          BaseDamageByPlayerVE.SetValue(3.00)
        ElseIf (difficulty == 1) ;; Easy Difficulty
          BaseDamageByPlayerE.SetValue(3.00)
        ElseIf (difficulty == 2) ;; Normal Difficulty
          BaseDamageByPlayerN.SetValue(3.00)
        ElseIf (difficulty == 3) ;; Hard Difficulty
          BaseDamageByPlayerH.SetValue(3.00)
        ElseIf (difficulty == 4) ;; Very Hard Difficulty
          BaseDamageByPlayerVH.SetValue(3.00)
        EndIf
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction
