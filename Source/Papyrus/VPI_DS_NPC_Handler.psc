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
  Debug.Trace("VPI_DS_EVENT (NPCHandler): OnEffectStart triggered", 0)

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  if (akTarget.HasKeyword(DS_SCALING_APPLIED)) 
    return
  Else 
    akTarget.AddKeyword(DS_SCALING_APPLIED)
  EndIf

  HandleLoot(akTarget)
  HandleHeight(akTarget)

  ; RegisterForSingleUpdate(0.25)
EndEvent

; Event OnUpdate()
; 	; RegisterForSingleUpdate(0.25)
; EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  Debug.Trace("VPI_DS_EVENT (NPCHandler): OnEffectFinish triggered", 0)

	; UnregisterForUpdate()
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Member Functions
;;;
Int Function GetNPCVersion(ObjectReference myself)
  If (myself.HasKeyword(NPC_Type_MK5))
    Debug.Trace("VPI_DS_DEBUG (NPCHandler): I'm a MK5 Base NPC.", 0)
    return 5
  ElseIf (myself.HasKeyword(NPC_Type_MK4))
    Debug.Trace("VPI_DS_DEBUG (NPCHandler): I'm a MK4 Base NPC.", 0)
    return 4
  ElseIf (myself.HasKeyword(NPC_Type_MK3))
    Debug.Trace("VPI_DS_DEBUG (NPCHandler): I'm a MK3 Base NPC.", 0)
    return 3
  ElseIf (myself.HasKeyword(NPC_Type_MK2))
    Debug.Trace("VPI_DS_DEBUG (NPCHandler): I'm a MK2 Base NPC.", 0)
    return 2
  ElseIf (myself.HasKeyword(NPC_Type_MK1))
    Debug.Trace("VPI_DS_DEBUG (NPCHandler): I'm a MK1 Base NPC.", 0)
    return 1
  Else
    Debug.Trace("VPI_DS_DEBUG (NPCHandler): I'm a MK? Base NPC.", 0)
    return 0
  EndIf
EndFunction

Function HandleLoot(ObjectReference myself)
  If (self.GetNPCVersion(myself) == 5)
    Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK5 class and needs loot updated.", 0)
    if (myself.HasKeyword(NPC_Pirate))
      Debug.Trace("VPI_DS_EVENT (NPCHandler): I'm a pirate so injection contraband loot.", 0)
      myself.AddItem(LL_Contraband_Any as Form, 5, true)
    EndIf
    myself.AddItem(LL_Loot_Legendary_Human as Form, 1, true)
    myself.AddItem(LL_Loot_Misc as Form, 3, true)
    myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  ElseIf (self.GetNPCVersion(myself) == 1)
    Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK1 class and needs loot updated.", 0)
    if (myself.HasKeyword(NPC_Pirate))
      myself.AddItem(LL_Contraband_Any as Form, 1, true)
    EndIf
    myself.AddItem(LL_Loot_Digipick as Form, 1, true)
  EndIf
EndFunction

Function HandleHeight(ObjectReference myself)
  If (self.GetNPCVersion(myself) == 5)
    Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK5 class and needs enlarged.", 0)
    myself.SetScale(1.50)
  ElseIf (self.GetNPCVersion(myself) == 1)
    Debug.Trace("VPI_DS_EVENT (NPCHandler): Leveled NPC is a MK1 class and needs shrunk.", 0)
    myself.SetScale(0.50)
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Public Member Functions
;;;
