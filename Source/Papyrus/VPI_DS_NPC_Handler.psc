Scriptname VPI_DS_NPC_Handler extends ActiveMagicEffect  

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
Keyword Property DS_SCALING_APPLIED Auto Const Mandatory

LeveledItem Property LL_Contraband_Any Auto Const Mandatory
LeveledItem Property LL_Loot_Legendary_Human Auto Const Mandatory
LeveledItem Property LL_Loot_Misc Auto Const Mandatory
LeveledItem Property LL_Loot_Digipick Auto Const Mandatory

LeveledItem Property LL_Loot_Aid_or_Chem_Leveled_Any Auto Const Mandatory
MiscObject Property Contraband_VaRuunHereticPamphlets Auto Const Mandatory

ObjectReference Property Myself Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCHandler", "OnEffectStart", "OnEffectStart triggered", 0, DSDebugMode.GetValueInt())
  Myself = akTarget

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  If (Myself.HasKeyword(DS_SCALING_APPLIED)) 
    return
  Else 
    Myself.AddKeyword(DS_SCALING_APPLIED)

    ;; Handle Loot on Faction or other factors
    If (Myself.HasKeyword(NPC_Varuun))
      HandleLootVaruun(self.GetNPCVersion())
    ElseIf (Myself.HasKeyword(NPC_Pirate))
      HandleLootPirate(self.GetNPCVersion())
    Else
      HandleLootGeneric(self.GetNPCVersion())
    EndIf

    ;; Handle Scaling Stuff
    HandleHeight(self.GetNPCVersion())
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Helper.DebugMessage("NPCHandler", "OnEffectFinish", "OnEffectFinish triggered", 0, DSDebugMode.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;
Int Function GetNPCVersion()
  If (Myself.HasKeyword(NPC_Type_MK5))
    return 5
  ElseIf (Myself.HasKeyword(NPC_Type_MK4))
    return 4
  ElseIf (Myself.HasKeyword(NPC_Type_MK3))
    return 3
  ElseIf (Myself.HasKeyword(NPC_Type_MK2))
    return 2
  ElseIf (Myself.HasKeyword(NPC_Type_MK1))
    return 1
  Else
    return 0
  EndIf
EndFunction

Function HandleLootGeneric(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootGeneric", "Generic Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(LL_Loot_Misc as Form, 3, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootGeneric", "Generic Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    If (Utility.RandomInt(1,25) > 15)
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootGeneric", "Generic Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootGeneric", "Generic Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootGeneric", "Generic Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction

Function HandleLootPirate(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootPirate", "Pirate Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(3,10), true)
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(LL_Loot_Misc as Form, 3, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootPirate", "Pirate Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(3,8), true)
    If (Utility.RandomInt(1,25) > 15)
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootPirate", "Pirate Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(2,6), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootPirate", "Pirate Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, Utility.RandomInt(1,3), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootPirate", "Pirate Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(LL_Contraband_Any as Form, 1, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction

Function HandleLootVaruun(Int npcType)
  If (npcType == 5)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootVaruun", "Va'ruun Leveled NPC is a MK5 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(5,25), true)
    Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, Utility.RandomInt(3,6), true)
    Myself.AddItem(LL_Loot_Misc as Form, 1, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 4)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootVaruun", "Va'ruun Leveled NPC is a MK4 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(5,15), true)
    If (Utility.RandomInt(1,25) > 15)
      Myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    EndIf
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, Utility.RandomInt(1,6), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 3)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootVaruun", "Va'ruun Leveled NPC is a MK3 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(1,10), true)
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, Utility.RandomInt(1,3), true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 2)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootVaruun", "Va'ruun Leveled NPC is a MK2 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, Utility.RandomInt(1,5), true)
    Myself.AddItem(LL_Loot_Aid_or_Chem_Leveled_Any as Form, 1, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (npcType == 1)
    VPI_Helper.DebugMessage("NPCHandler", "HandleLootVaruun", "Va'ruun Leveled NPC is a MK1 class and needs loot updated.", 0, DSDebugMode.GetValueInt())
    Myself.AddItem(Contraband_VaRuunHereticPamphlets as Form, 1, true)
    Myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction

Function HandleHeight(Int npcType)
  Float currentScale = Myself.GetScale()
  Float newScale = currentScale
  If (npcType == 5)
    newScale = currentScale * Utility.RandomFloat(1.25,2.5)
    VPI_Helper.DebugMessage("NPCHandler", "HandleHeight", "Leveled NPC is a MK5 type and needs enlarged. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0, DSDebugMode.GetValueInt())
  ElseIf (npcType == 1)
    newScale = currentScale * Utility.RandomFloat(0.25,0.90)
    VPI_Helper.DebugMessage("NPCHandler", "HandleHeight", "Leveled NPC is a MK1 type and needs shrunk. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0, DSDebugMode.GetValueInt())
  Else
    VPI_Helper.DebugMessage("NPCHandler", "HandleHeight", "Leveled NPC is a normal class so no scaling needed.", 0, DSDebugMode.GetValueInt())
    newScale = currentScale
  EndIf
  Myself.SetScale(newScale)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
