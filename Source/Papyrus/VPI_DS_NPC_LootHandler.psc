Scriptname VPI_DS_NPC_LootHandler extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property DSDebugMode Auto Const Mandatory


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

MiscObject Property Contraband_VaRuunHereticPamphlets Auto Const Mandatory
LeveledItem Property LL_Contraband_Any Auto Const Mandatory
LeveledItem Property LL_Loot_Aid_or_Chem_Leveled_Any Auto Const Mandatory
LeveledItem Property LL_Loot_Digipick Auto Const Mandatory
LeveledItem Property LL_Loot_Legendary_Human Auto Const Mandatory
LeveledItem Property LL_Loot_Misc Auto Const Mandatory

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
    If (Myself.HasKeyword(NPC_Varuun))
      HandleLootVaruun(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
    ElseIf (Myself.HasKeyword(NPC_Pirate))
      HandleLootPirate(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
    Else
      HandleLootGeneric(VPI_Helper.GetNPCType(akTarget, NPC_Type_MK5, NPC_Type_MK4, NPC_Type_MK3, NPC_Type_MK2, NPC_Type_MK1))
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
    Myself.AddItem(LL_Loot_Misc as Form, 3, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    If (Utility.RandomInt(1,25) > 15)
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootGeneric", Myself + "> Generic Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction

Function HandleLootPirate(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(4,10), true)
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(LL_Loot_Misc as Form, 3, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(1,6), true)
    If (Utility.RandomInt(1,25) > 15)
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(1,4), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(1,2), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootPirate", Myself + "> Pirate Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction

Function HandleLootVaruun(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(5,25), true)
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, Utility.RandomInt(3,6), true)
    Myself.AddItem(LL_Loot_Misc as Form, 1, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(5,15), true)
    If (Utility.RandomInt(1,25) > 15)
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, Utility.RandomInt(1,6), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(1,10), true)
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, Utility.RandomInt(1,3), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(1,5), true)
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, 1, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCLootHandler", "HandleLootVaruun", Myself + "> Va'ruun Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, 1, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
