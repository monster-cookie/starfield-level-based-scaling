Scriptname VPI_DS_NPC_LootHandler extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property DSDebugMode Auto Const Mandatory
GlobalVariable Property EnableCustomLoot Auto Const Mandatory


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
Keyword Property DS_LOOT_APPLIED Auto Const Mandatory

LeveledItem Property LL_Loot_Legendary_Human Auto Const Mandatory
LeveledItem Property DS_Pirate_Recruit Auto Const Mandatory
LeveledItem Property DS_Pirate_Normal Auto Const Mandatory
LeveledItem Property DS_Pirate_Miniboss Auto Const Mandatory
LeveledItem Property DS_Generic_Recruit Auto Const Mandatory
LeveledItem Property DS_Generic_Normal Auto Const Mandatory
LeveledItem Property DS_Generic_Miniboss Auto Const Mandatory
LeveledItem Property DS_Varuun_Recruit Auto Const Mandatory
LeveledItem Property DS_Varuun_Normal Auto Const Mandatory
LeveledItem Property DS_Varuun_Miniboss Auto Const Mandatory

ObjectReference Property Myself Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCLootHandler", "OnEffectStart", "OnEffectStart triggered", 0, DSDebugMode.GetValueInt())
  Myself = akTarget

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  If (Myself.HasKeyword(DS_LOOT_APPLIED)) 
    return
  Else 
    Myself.AddKeyword(DS_LOOT_APPLIED)

    ;; Handle Loot on Faction or other factors
    if (EnableCustomLoot.GetValueInt() == 1)
      If (Myself.HasKeyword(NPC_Varuun))
        HandleLootVaruun(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
      ElseIf (Myself.HasKeyword(NPC_Pirate))
        HandleLootPirate(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
      Else
        HandleLootGeneric(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
      EndIf
    EndIf
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCLootHandler", "OnEffectFinish", "OnEffectFinish triggered", 0, DSDebugMode.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;
Function HandleLootGeneric(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(DS_Generic_Miniboss as Form, 4, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    If (Game.GetDieRollSuccess(40, 1, 100, -1, -1))
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(DS_Generic_Normal as Form, 3, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Generic_Normal as Form, 3, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Generic_Normal as Form, 2, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Generic_Recruit as Form, 2, true)
  EndIf
EndFunction

Function HandleLootPirate(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(DS_Pirate_Miniboss as Form, 5, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    If (Game.GetDieRollSuccess(40, 1, 100, -1, -1))
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(DS_Pirate_Normal as Form, 3, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Pirate_Normal as Form, 3, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Pirate_Normal as Form, 2, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Pirate_Normal as Form, 2, true)
  EndIf
EndFunction

Function HandleLootVaruun(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(DS_Varuun_Miniboss as Form, 5, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    If (Game.GetDieRollSuccess(40, 1, 100, -1, -1))
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(DS_Varuun_Normal as Form, 3, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Varuun_Normal as Form, 3, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Varuun_Normal as Form, 2, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(DS_Varuun_Normal as Form, 2, true)
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
