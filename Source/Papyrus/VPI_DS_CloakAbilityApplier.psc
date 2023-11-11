Scriptname VPI_DS_CloakAbilityApplier extends ActiveMagicEffect  

Spell Property AbilityToApply Auto Const Mandatory

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; Debug.Trace("VPI_DS_EVENT (AbilityApplier): OnEffectStart triggered", 0)
  Actor target = akTarget.GetSelfAsActor()
	target.AddSpell(AbilityToApply, false)
  ; Debug.Trace("VPI_DS_DEBUG (AbilityApplier): Added ability with form ID " + AbilityToApply + " to target with form ID " + target + ".", 0)
EndEvent