Scriptname VPI_DS_NPC_Handler extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;


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
Keyword Property DS_SCALING_APPLIED Auto Const Mandatory

LeveledItem Property LL_Contraband_Any Auto Const mandatory
LeveledItem Property LL_Loot_Legendary_Human Auto Const mandatory
LeveledItem Property LL_Loot_Misc Auto Const mandatory
LeveledItem Property LL_Loot_Digipick Auto Const mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; Debug.Trace("VPI_DS_EVENT (NPCHandler): OnEffectStart triggered", 0)

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  if (akTarget.HasKeyword(DS_SCALING_APPLIED)) 
    return
  Else 
    akTarget.AddKeyword(DS_SCALING_APPLIED)

    HandleLoot(akTarget)
    HandleHeight(akTarget)
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; Debug.Trace("VPI_DS_EVENT (NPCHandler): OnEffectFinish triggered", 0)
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;
Int Function GetNPCVersion(ObjectReference myself)
  If (myself.HasKeyword(NPC_Type_MK5))
    return 5
  ElseIf (myself.HasKeyword(NPC_Type_MK4))
    return 4
  ElseIf (myself.HasKeyword(NPC_Type_MK3))
    return 3
  ElseIf (myself.HasKeyword(NPC_Type_MK2))
    return 2
  ElseIf (myself.HasKeyword(NPC_Type_MK1))
    return 1
  Else
    return 0
  EndIf
EndFunction

Function HandleLoot(ObjectReference myself)
  If (self.GetNPCVersion(myself) == 5)
    ; Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK5 class and needs loot updated.", 0)
    if (myself.HasKeyword(NPC_Pirate))
      ; Debug.Trace("VPI_DS_EVENT (NPCHandler): I'm a pirate so injection contraband loot.", 0)
      myself.AddItem(LL_Contraband_Any as Form, 5, true)
    EndIf
    myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    myself.AddItem(LL_Loot_Misc as Form, 3, true)
    myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (self.GetNPCVersion(myself) == 1)
    ; Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK1 class and needs loot updated.", 0)
    if (myself.HasKeyword(NPC_Pirate))
      myself.AddItem(LL_Contraband_Any as Form, 1, true)
    EndIf
    myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction

Function HandleHeight(ObjectReference myself)
  Float currentScale = myself.GetScale()
  Float newScale = currentScale
  If (self.GetNPCVersion(myself) == 5)
    Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK5 class and needs enlarged. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0)
    newScale = currentScale * 1.50
  ElseIf (self.GetNPCVersion(myself) == 1)
    Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK1 class and needs shrunk. Current scale is " + currentScale + " moving to new scale of " + newScale + ".", 0)
    newScale = currentScale * 0.50
  Else
    ; Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a normal class so no scaling needed.", 0)
    newScale = currentScale
  EndIf
  myself.SetScale(newScale)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
