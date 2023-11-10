ScriptName VPI_DS_SE_ScaleNPC Extends ActiveMagicEffect

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  If (afMagnitude < 1)
    Debug.Trace("VPI_DS_DEBUG (ScaleNPCSpell): NPC is rescaling down " + Math.Round(100*afMagnitude) + ".", 0)
  ElseIf (afMagnitude > 1)
    Debug.Trace("VPI_DS_DEBUG (ScaleNPCSpell): NPC is rescaling up " + Math.Round(100*afMagnitude) + ".", 0)
  Else
    Debug.Trace("VPI_DS_DEBUG (ScaleNPCSpell): NPC is not going to be scaled magnitude is 1", 0)
    return
  EndIf
  akTarget.SetScale(afMagnitude)
  akCaster.SetScale(afMagnitude)
EndEvent
