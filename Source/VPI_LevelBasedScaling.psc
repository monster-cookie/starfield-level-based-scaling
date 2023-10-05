;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; This script will scale your damage settings based on your current 
;;; level. You need to link this to your player actor using the command
;;; below:
;;;
;;; player.aps VPI_LevelBasedScaling
;;;
ScriptName VPI_LevelBasedScaling Extends ReferenceAlias


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;

Actor Property PlayerRef Auto

Perk Property Skill_Wellness Auto
Perk Property Skill_EnergyWeaponDissipation Auto
Perk Property Skill_PainTolerance Auto
Perk Property Skill_Rejuvenation Auto

Perk Property Skill_Ballistics Auto 
Perk Property Skill_Lasers Auto
Perk Property Skill_ParticleBeams Auto
Perk Property Skill_Marksmanship Auto

Perk Property Skill_PistolCertification Auto
Perk Property Skill_ShotgunCertification Auto
Perk Property Skill_HeavyWeaponsCertification Auto
Perk Property Skill_RifleCertification Auto

Perk Property Skill_ArmorPenetration Auto
Perk Property Skill_Crippling Auto

String Property Version="1.1.0" Auto

Float Property DefaultNPCHealthBonus=20.00 Auto
Float Property DefaultPlayerHealthBonus=20.00 Auto

Float Property DefaultDamageToPlayerVE=0.50 Auto
Float Property DefaultDamageToPlayerE=0.75 Auto
Float Property DefaultDamageToPlayerN=1.00 Auto
Float Property DefaultDamageToPlayerH=1.50 Auto
Float Property DefaultDamageToPlayerVH=2.00 Auto

Float Property DefaultDamageByPlayerVE=2.00 Auto
Float Property DefaultDamageByPlayerE=1.50 Auto
Float Property DefaultDamageByPlayerN=1.00 Auto
Float Property DefaultDamageByPlayerH=0.75 Auto
Float Property DefaultDamageByPlayerVH=0.50 Auto

Float Property SF_PCHealthBoost_Bracket1=1.00 Auto
Float Property SF_PCHealthBoost_Bracket2=1.00 Auto
Float Property SF_PCHealthBoost_Bracket3=1.00 Auto
Float Property SF_PCHealthBoost_Bracket4=0.85 Auto
Float Property SF_PCHealthBoost_Bracket5=0.75 Auto
Float Property SF_PCHealthBoost_Bracket6=0.75 Auto
Float Property SF_PCHealthBoost_Bracket7=0.50 Auto
Float Property SF_PCHealthBoost_Bracket8=0.25 Auto
Float Property SF_PCHealthBoost_Bracket9=0.00 Auto
Float Property SF_PCHealthBoost_Bracket10=0.00 Auto

Float Property SF_NPCHealthBoost_Bracket1=0.00 Auto
Float Property SF_NPCHealthBoost_Bracket2=0.00 Auto
Float Property SF_NPCHealthBoost_Bracket3=0.50 Auto
Float Property SF_NPCHealthBoost_Bracket4=1.00 Auto
Float Property SF_NPCHealthBoost_Bracket5=1.25 Auto
Float Property SF_NPCHealthBoost_Bracket6=1.50 Auto
Float Property SF_NPCHealthBoost_Bracket7=1.75 Auto
Float Property SF_NPCHealthBoost_Bracket8=2.0 Auto
Float Property SF_NPCHealthBoost_Bracket9=3.0 Auto
Float Property SF_NPCHealthBoost_Bracket10=4.0 Auto

Float Property SF_DamageToPlayer_Bracket1=0.80 Auto
Float Property SF_DamageToPlayer_Bracket2=0.90 Auto
Float Property SF_DamageToPlayer_Bracket3=1.00 Auto
Float Property SF_DamageToPlayer_Bracket4=1.25 Auto
Float Property SF_DamageToPlayer_Bracket5=1.33 Auto
Float Property SF_DamageToPlayer_Bracket6=1.50 Auto
Float Property SF_DamageToPlayer_Bracket7=1.75 Auto
Float Property SF_DamageToPlayer_Bracket8=2.00 Auto
Float Property SF_DamageToPlayer_Bracket9=2.50 Auto
Float Property SF_DamageToPlayer_Bracket10=3.00 Auto

Float Property SF_DamageByPlayer_Bracket1=1.10 Auto
Float Property SF_DamageByPlayer_Bracket2=1.00 Auto
Float Property SF_DamageByPlayer_Bracket3=0.90 Auto
Float Property SF_DamageByPlayer_Bracket4=0.80 Auto
Float Property SF_DamageByPlayer_Bracket5=0.70 Auto
Float Property SF_DamageByPlayer_Bracket6=0.60 Auto
Float Property SF_DamageByPlayer_Bracket7=0.50 Auto
Float Property SF_DamageByPlayer_Bracket8=0.40 Auto
Float Property SF_DamageByPlayer_Bracket9=0.25 Auto
Float Property SF_DamageByPlayer_Bracket10=0.10 Auto

Float Property PerkADJ_DamageReduction=0.5 Auto
Float Property PerkADJ_DamageAdd=0.5 Auto
Float Property PerkADJ_SpecialArmorPen=0.001 Auto
Float Property PerkADJ_SpecialCrippling=0.005 Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

;; OnInit doesn't exit on ReferenceAlias
; Event OnInit()
;   Debug.Messagebox("VPI {LBS}: Loading LBS v" + Version + " in OnPlayerLoadGame. Player is " + PlayerRef + " .")
; EndEvent

Event OnPlayerLoadGame()
  Utility.Wait(1.0)
  
  ;; Not supposed to have to do this the Game should have set these automatically
  if (PlayerRef == None) 
    PlayerRef = Game.GetPlayer()
  EndIf
  if (Skill_Wellness == None)
    Skill_Wellness =  Game.GetForm(0x002CE2E1) as Perk
  EndIf
  if (Skill_EnergyWeaponDissipation == None)
    Skill_EnergyWeaponDissipation =  Game.GetForm(0x002C59E2) as Perk
  EndIf
  if (Skill_PainTolerance == None)
    Skill_PainTolerance =  Game.GetForm(0x002CFCAE) as Perk
  EndIf
  if (Skill_Rejuvenation == None)
    Skill_Rejuvenation =  Game.GetForm(0x0028AE13) as Perk
  EndIf
  if (Skill_Ballistics == None)
    Skill_Ballistics =  Game.GetForm(0x002CFCAB) as Perk
  EndIf
  if (Skill_Lasers == None)
    Skill_Lasers =  Game.GetForm(0x002C59DD) as Perk
  EndIf
  if (Skill_ParticleBeams == None)
    Skill_ParticleBeams =  Game.GetForm(0x0027BAFD) as Perk
  EndIf
  if (Skill_Marksmanship == None)
    Skill_Marksmanship =  Game.GetForm(0x002C890B) as Perk
  EndIf
  if (Skill_PistolCertification == None)
    Skill_PistolCertification =  Game.GetForm(0x002080FF) as Perk
  EndIf
  if (Skill_ShotgunCertification == None)
    Skill_ShotgunCertification =  Game.GetForm(0x0027DF97) as Perk
  EndIf
  if (Skill_HeavyWeaponsCertification == None)
    Skill_HeavyWeaponsCertification =  Game.GetForm(0x00147E38) as Perk
  EndIf
  if (Skill_RifleCertification == None)
    Skill_RifleCertification =  Game.GetForm(0x002CE2E0) as Perk
  EndIf
  if (Skill_ArmorPenetration == None)
    Skill_ArmorPenetration =  Game.GetForm(0x0027DF94) as Perk
  EndIf
  if (Skill_Crippling == None)
    Skill_Crippling =  Game.GetForm(0x0027CBBA) as Perk
  EndIf

  ScaleForMyLevel()
EndEvent

Event OnDifficultyChanged(Int aOldDifficulty, Int aNewDifficulty)
  ScaleForMyLevel()
EndEvent

Event OnEnterShipInterior(ObjectReference akShip)
  ScaleForMyLevel()
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Member Functions
;;;

;; ****************************************************************************
;; Change a default damage to player values
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultDamageToPlayerValue" <difficulty> <newValue>
;;   difficulty -> 0=Very Easy, 1=Easy, 2=Normal, 3=Hard, 4=Very Hard
;;   newValue -> The new float value to set
;;
Function SetDefaultDamageToPlayerValue(int difficulty, Float value)
  If (difficulty == 0)
    DefaultDamageToPlayerVE = value
  ElseIf (difficulty == 1)
    DefaultDamageToPlayerE = value
  ElseIf (difficulty == 2)
    DefaultDamageToPlayerN = value
  ElseIf (difficulty == 3)
    DefaultDamageToPlayerH = value
  ElseIf (difficulty == 4)
    DefaultDamageToPlayerVH = value
  EndIf
EndFunction

;; ****************************************************************************
;; Change a default damage by player values
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultDamageByPlayerValue" <difficulty> <newValue>
;;   difficulty -> 0=Very Easy, 1=Easy, 2=Normal, 3=Hard, 4=Very Hard
;;   newValue -> The new float value to set
;;
Function SetDefaultDamageByPlayerValue(int difficulty, Float value)
  If (difficulty == 0)
    DefaultDamageByPlayerVE = value
  ElseIf (difficulty == 1)
    DefaultDamageByPlayerE = value
  ElseIf (difficulty == 2)
    DefaultDamageByPlayerN = value
  ElseIf (difficulty == 3)
    DefaultDamageByPlayerH = value
  ElseIf (difficulty == 4)
    DefaultDamageByPlayerVH = value
  EndIf
EndFunction

;; ****************************************************************************
;; Change the default NPC health boost
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultNPCHealthBoost" <newValue>
;;   newValue -> The new float value to set
;;
Function SetDefaultNPCHealthBoost(Float value)
  DefaultNPCHealthBonus = value
EndFunction

;; ****************************************************************************
;; Change the default Player health boost
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDefaultPlayerHealthBoost" <newValue>
;;   newValue -> The new float value to set
;;
Function SetDefaultPlayerHealthBoost(Float value)
  DefaultPlayerHealthBonus = value
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for damage to player 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDamageToPlayerSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetDamageToPlayerSFForBracket(int bracket, Float newSF)
  If (bracket == 1)
    SF_DamageToPlayer_Bracket1 = newSF
  ElseIf (bracket == 2)
    SF_DamageToPlayer_Bracket2 = newSF
  ElseIf (bracket == 3)
    SF_DamageToPlayer_Bracket3 = newSF
  ElseIf (bracket == 4)
    SF_DamageToPlayer_Bracket4 = newSF
  ElseIf (bracket == 5)
    SF_DamageToPlayer_Bracket5 = newSF
  ElseIf (bracket == 6)
    SF_DamageToPlayer_Bracket6 = newSF
  ElseIf (bracket == 7)
    SF_DamageToPlayer_Bracket7 = newSF
  ElseIf (bracket == 8)
    SF_DamageToPlayer_Bracket8 = newSF
  ElseIf (bracket == 9)
    SF_DamageToPlayer_Bracket9 = newSF
  ElseIf (bracket == 10)
    SF_DamageToPlayer_Bracket10 = newSF
  EndIf
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for damage by player 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetDamageByPlayerSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetDamageByPlayerSFForBracket(int bracket, Float newSF)
  If (bracket == 1)
    SF_DamageByPlayer_Bracket1 = newSF
  ElseIf (bracket == 2)
    SF_DamageByPlayer_Bracket2 = newSF
  ElseIf (bracket == 3)
    SF_DamageByPlayer_Bracket3 = newSF
  ElseIf (bracket == 4)
    SF_DamageByPlayer_Bracket4 = newSF
  ElseIf (bracket == 5)
    SF_DamageByPlayer_Bracket5 = newSF
  ElseIf (bracket == 6)
    SF_DamageByPlayer_Bracket6 = newSF
  ElseIf (bracket == 7)
    SF_DamageByPlayer_Bracket7 = newSF
  ElseIf (bracket == 8)
    SF_DamageByPlayer_Bracket8 = newSF
  ElseIf (bracket == 9)
    SF_DamageByPlayer_Bracket9 = newSF
  ElseIf (bracket == 10)
    SF_DamageByPlayer_Bracket10 = newSF
  EndIf
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for NPC Bonus Health 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetNPCBonusHealthSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetNPCBonusHealthSFForBracket(int bracket, Float newSF)
  If (bracket == 1)
    SF_NPCHealthBoost_Bracket1 = newSF
  ElseIf (bracket == 2)
    SF_NPCHealthBoost_Bracket2 = newSF
  ElseIf (bracket == 3)
    SF_NPCHealthBoost_Bracket3 = newSF
  ElseIf (bracket == 4)
    SF_NPCHealthBoost_Bracket4 = newSF
  ElseIf (bracket == 5)
    SF_NPCHealthBoost_Bracket5 = newSF
  ElseIf (bracket == 6)
    SF_NPCHealthBoost_Bracket6 = newSF
  ElseIf (bracket == 7)
    SF_NPCHealthBoost_Bracket7 = newSF
  ElseIf (bracket == 8)
    SF_NPCHealthBoost_Bracket8 = newSF
  ElseIf (bracket == 9)
    SF_NPCHealthBoost_Bracket9 = newSF
  ElseIf (bracket == 10)
    SF_NPCHealthBoost_Bracket10 = newSF
  EndIf
EndFunction

;; ****************************************************************************
;; Change a scaling factor in the specified level bracket for Player Bonus Health 
;;
;; Use: player.cf "VPI_LevelBasedScaling.SetPCBonusHealthSFForBracket" <bracket> <newSF>
;;   bracket -> The bracket to change can be 1 to 10 only
;;   newSF -> The new scale factor to set for the bracket
;;
Function SetPCBonusHealthSFForBracket(int bracket, Float newSF)
  If (bracket == 1)
    SF_NPCHealthBoost_Bracket1 = newSF
  ElseIf (bracket == 2)
    SF_NPCHealthBoost_Bracket2 = newSF
  ElseIf (bracket == 3)
    SF_NPCHealthBoost_Bracket3 = newSF
  ElseIf (bracket == 4)
    SF_NPCHealthBoost_Bracket4 = newSF
  ElseIf (bracket == 5)
    SF_NPCHealthBoost_Bracket5 = newSF
  ElseIf (bracket == 6)
    SF_NPCHealthBoost_Bracket6 = newSF
  ElseIf (bracket == 7)
    SF_NPCHealthBoost_Bracket7 = newSF
  ElseIf (bracket == 8)
    SF_NPCHealthBoost_Bracket8 = newSF
  ElseIf (bracket == 9)
    SF_NPCHealthBoost_Bracket9 = newSF
  ElseIf (bracket == 10)
    SF_NPCHealthBoost_Bracket10 = newSF
  EndIf
EndFunction

;; ****************************************************************************
;; Get the scaling factor for damage done to the player by NPCs at the 
;; player's current level
;;
Float Function GetDamageToPlayerScalingFactor() 
  Int playerLevel = PlayerRef.GetLevel()

  Debug.Trace("Damage To Player scaling is being calculated for a player level of " + playerLevel + ".", 0)
  Float scaleFactor = 0
  Int bracket = 0
  If (1 <= playerLevel && playerLevel <= 25)
    ;; Bracket 1
    bracket = 1
    scaleFactor = SF_DamageToPlayer_Bracket1
    Debug.Trace("SF adjusted for B1 SF " + SF_DamageToPlayer_Bracket1 + ".", 0)
  ElseIf (26 <= playerLevel && playerLevel <= 50)
    ;; Bracket 2
    bracket = 2
    scaleFactor = SF_DamageToPlayer_Bracket2
    Debug.Trace("SF adjusted for B2 SF " + SF_DamageToPlayer_Bracket2 + ".", 0)
  ElseIf (51 <= playerLevel && playerLevel <= 75)
    ;; Bracket 3
    bracket = 3
    scaleFactor = SF_DamageToPlayer_Bracket3
    Debug.Trace("SF adjusted for B3 SF " + SF_DamageToPlayer_Bracket3 + ".", 0)
  ElseIf (76 <= playerLevel && playerLevel <= 100)
    ;; Bracket 4
    bracket = 4
    scaleFactor = SF_DamageToPlayer_Bracket4
    Debug.Trace("SF adjusted for B4 SF " + SF_DamageToPlayer_Bracket4 + ".", 0)
  ElseIf (101 <= playerLevel && playerLevel <= 125)
    ;; Bracket 5
    bracket = 5
    scaleFactor = SF_DamageToPlayer_Bracket5
    Debug.Trace("SF adjusted for B5 SF " + SF_DamageToPlayer_Bracket5 + ".", 0)
  ElseIf (126 <= playerLevel && playerLevel <= 150)
    ;; Bracket 6
    bracket = 6
    scaleFactor = SF_DamageToPlayer_Bracket6
    Debug.Trace("SF adjusted for B6 SF " + SF_DamageToPlayer_Bracket6 + ".", 0)
  ElseIf (151 <= playerLevel && playerLevel <= 200)
    ;; Bracket 7
    bracket = 7
    scaleFactor = SF_DamageToPlayer_Bracket7
    Debug.Trace("SF adjusted for B7 SF " + SF_DamageToPlayer_Bracket7 + ".", 0)
  ElseIf (201 <= playerLevel && playerLevel <= 250)
    ;; Bracket 8
    bracket = 8
    scaleFactor = SF_DamageToPlayer_Bracket8
    Debug.Trace("SF adjusted for B8 SF " + SF_DamageToPlayer_Bracket8 + ".", 0)
  ElseIf (251 <= playerLevel && playerLevel <= 300)
    ;; Bracket 9
    bracket = 9
    scaleFactor = SF_DamageToPlayer_Bracket9
    Debug.Trace("SF adjusted for B9 SF " + SF_DamageToPlayer_Bracket9 + ".", 0)
  Else
    ;; Bracket 10
    bracket = 10
    scaleFactor = SF_DamageToPlayer_Bracket10
    Debug.Trace("SF adjusted for B10 SF " + SF_DamageToPlayer_Bracket10 + ".", 0)
  EndIf

  If (playerRef.HasPerk(Skill_Wellness) || playerRef.HasPerk(Skill_EnergyWeaponDissipation) || playerRef.HasPerk(Skill_PainTolerance) || playerRef.HasPerk(Skill_Rejuvenation))
    Float adjustment = PerkADJ_DamageReduction * (bracket/6)
    scaleFactor += adjustment
    Debug.Trace("SF adjusted for damage reduction perks increased by " + adjustment + ".", 0)
  EndIf

  If scaleFactor < 0 
      Return 0.001
  Else 
      Return scaleFactor
  EndIf

  Debug.Trace("Final calculated SF is " + scaleFactor + ".", 0)
EndFunction

;; ****************************************************************************
;; Get the scaling factor for damage done by the player to NPCs at the 
;; player's current level
;;
Float Function GetDamageByPlayerScalingFactor()
  Int playerLevel = PlayerRef.GetLevel()

  Debug.Trace("Damage By Player scaling is being calculated for a player level of " + playerLevel + ".", 0)
  Float scaleFactor = 0
  Int bracket = 0
  If (1 <= playerLevel && playerLevel <= 25)
    ;; Bracket 1
    bracket = 1
    scaleFactor = SF_DamageByPlayer_Bracket1
    Debug.Trace("SF adjusted for B1 SF " + SF_DamageByPlayer_Bracket1 + ".", 0)
  ElseIf (26 <= playerLevel && playerLevel <= 50)
    ;; Bracket 2
    bracket = 2
    scaleFactor = SF_DamageByPlayer_Bracket2
    Debug.Trace("SF adjusted for B2 SF " + SF_DamageByPlayer_Bracket2 + ".", 0)
  ElseIf (51 <= playerLevel && playerLevel <= 75)
    ;; Bracket 3
    bracket = 3
    scaleFactor = SF_DamageByPlayer_Bracket3
    Debug.Trace("SF adjusted for B3 SF " + SF_DamageByPlayer_Bracket3 + ".", 0)
  ElseIf (76 <= playerLevel && playerLevel <= 100)
    ;; Bracket 4
    bracket = 4
    scaleFactor = SF_DamageByPlayer_Bracket4
    Debug.Trace("SF adjusted for B4 SF " + SF_DamageByPlayer_Bracket4 + ".", 0)
  ElseIf (101 <= playerLevel && playerLevel <= 125)
    ;; Bracket 5
    bracket = 5
    scaleFactor = SF_DamageByPlayer_Bracket5
    Debug.Trace("SF adjusted for B5 SF " + SF_DamageByPlayer_Bracket5 + ".", 0)
  ElseIf (126 <= playerLevel && playerLevel <= 150)
    ;; Bracket 6
    bracket = 6
    scaleFactor = SF_DamageByPlayer_Bracket6
    Debug.Trace("SF adjusted for B6 SF " + SF_DamageByPlayer_Bracket6 + ".", 0)
  ElseIf (151 <= playerLevel && playerLevel <= 200)
    ;; Bracket 7
    bracket = 7
    scaleFactor = SF_DamageByPlayer_Bracket7
    Debug.Trace("SF adjusted for B7 SF " + SF_DamageByPlayer_Bracket7 + ".", 0)
  ElseIf (201 <= playerLevel && playerLevel <= 250)
    ;; Bracket 8
    bracket = 8
    scaleFactor = SF_DamageByPlayer_Bracket8
    Debug.Trace("SF adjusted for B8 SF " + SF_DamageByPlayer_Bracket8 + ".", 0)
  ElseIf (251 <= playerLevel && playerLevel <= 300)
    ;; Bracket 9
    bracket = 9
    scaleFactor = SF_DamageByPlayer_Bracket9
    Debug.Trace("SF adjusted for B9 SF " + SF_DamageByPlayer_Bracket9 + ".", 0)
  Else
    ;; Bracket 10
    bracket = 10
    scaleFactor = SF_DamageByPlayer_Bracket10
    Debug.Trace("SF adjusted for B10 SF " + SF_DamageByPlayer_Bracket10 + ".", 0)
  EndIf

  If ((playerRef.HasPerk(Skill_PistolCertification) || playerRef.HasPerk(Skill_ShotgunCertification) || playerRef.HasPerk(Skill_HeavyWeaponsCertification) || playerRef.HasPerk(Skill_RifleCertification)) && (playerRef.HasPerk(Skill_Ballistics) || playerRef.HasPerk(Skill_Lasers) || playerRef.HasPerk(Skill_ParticleBeams) || playerRef.HasPerk(Skill_Marksmanship))) 
    Float adjustment = PerkADJ_DamageAdd * (bracket/6)
    scaleFactor -= adjustment
    Debug.Trace("SF adjusted for damage add perks decreased by " + adjustment + ".", 0)
  EndIf
  If (playerRef.HasPerk(Skill_ArmorPenetration))
    scaleFactor -= PerkADJ_SpecialArmorPen
    Debug.Trace("SF adjusted for Armor Penetration perk decreased by " + PerkADJ_SpecialArmorPen + ".", 0)
  EndIf
  If (playerRef.HasPerk(Skill_Crippling))
    scaleFactor -= PerkADJ_SpecialCrippling
    Debug.Trace("SF adjusted for Crippling perk perk decreased by " + PerkADJ_SpecialCrippling + ".", 0)
  EndIf

  If scaleFactor < 0 
    Return 0.001
  Else 
    Return scaleFactor
  EndIf

  Debug.Trace("Final calculated SF is " + scaleFactor + ".", 0)
EndFunction

;; ****************************************************************************
;; Get the scaling factor for NPC sponginess at the player's current level
;;
Float Function SponginessNPCScalingFactor()
  Int playerLevel = PlayerRef.GetLevel()

  Debug.Trace("NPC Health Boost scaling is being calculated for a player level of " + playerLevel + ".", 0)
  Float scaleFactor = 0
  If (1 <= playerLevel && playerLevel <= 25)
    ;; Bracket 1
    scaleFactor = SF_NPCHealthBoost_Bracket1
    Debug.Trace("SF adjusted for B1 SF " + SF_NPCHealthBoost_Bracket1 + ".", 0)
  ElseIf (26 <= playerLevel && playerLevel <= 50)
    ;; Bracket 2
    scaleFactor = SF_NPCHealthBoost_Bracket2
    Debug.Trace("SF adjusted for B2 SF " + SF_NPCHealthBoost_Bracket2 + ".", 0)
  ElseIf (51 <= playerLevel && playerLevel <= 75)
    ;; Bracket 3
    scaleFactor = SF_NPCHealthBoost_Bracket3
    Debug.Trace("SF adjusted for B3 SF " + SF_NPCHealthBoost_Bracket3 + ".", 0)
  ElseIf (76 <= playerLevel && playerLevel <= 100)
    ;; Bracket 4
    scaleFactor = SF_NPCHealthBoost_Bracket4
    Debug.Trace("SF adjusted for B4 SF " + SF_NPCHealthBoost_Bracket4 + ".", 0)
  ElseIf (101 <= playerLevel && playerLevel <= 125)
    ;; Bracket 5
    scaleFactor = SF_NPCHealthBoost_Bracket5
    Debug.Trace("SF adjusted for B5 SF " + SF_NPCHealthBoost_Bracket5 + ".", 0)
  ElseIf (126 <= playerLevel && playerLevel <= 150)
    ;; Bracket 6
    scaleFactor = SF_NPCHealthBoost_Bracket6
    Debug.Trace("SF adjusted for B6 SF " + SF_NPCHealthBoost_Bracket6 + ".", 0)
  ElseIf (151 <= playerLevel && playerLevel <= 200)
    ;; Bracket 7
    scaleFactor = SF_NPCHealthBoost_Bracket7
    Debug.Trace("SF adjusted for B7 SF " + SF_NPCHealthBoost_Bracket7 + ".", 0)
  ElseIf (201 <= playerLevel && playerLevel <= 250)
    ;; Bracket 8
    scaleFactor = SF_NPCHealthBoost_Bracket8
    Debug.Trace("SF adjusted for B8 SF " + SF_NPCHealthBoost_Bracket8 + ".", 0)
  ElseIf (251 <= playerLevel && playerLevel <= 300)
    ;; Bracket 9
    scaleFactor = SF_NPCHealthBoost_Bracket9
    Debug.Trace("SF adjusted for B9 SF " + SF_NPCHealthBoost_Bracket9 + ".", 0)
  Else
    ;; Bracket 10
    scaleFactor = SF_NPCHealthBoost_Bracket10
    Debug.Trace("SF adjusted for B10 SF " + SF_NPCHealthBoost_Bracket10 + ".", 0)
  EndIf

  If scaleFactor < 0 
    Return 0.001
  Else 
    Return scaleFactor
  EndIf

  Debug.Trace("Final calculated SF is " + scaleFactor + ".", 0)
EndFunction

;; ****************************************************************************
;; Get the scaling factor for Player sponginess at the player's current level
;;
Float Function SponginessPlayerScalingFactor()
  Int playerLevel = PlayerRef.GetLevel()

  Debug.Trace("Player Health Booster scaling is being calculated for a player level of " + playerLevel + ".", 0)
  Float scaleFactor = 0
  If (1 <= playerLevel && playerLevel <= 25)
    ;; Bracket 1
    scaleFactor = SF_PCHealthBoost_Bracket1
    Debug.Trace("SF adjusted for B1 SF " + SF_PCHealthBoost_Bracket1 + ".", 0)
  ElseIf (26 <= playerLevel && playerLevel <= 50)
    ;; Bracket 2
    scaleFactor = SF_PCHealthBoost_Bracket2
    Debug.Trace("SF adjusted for B2 SF " + SF_PCHealthBoost_Bracket2 + ".", 0)
  ElseIf (51 <= playerLevel && playerLevel <= 75)
    ;; Bracket 3
    scaleFactor = SF_PCHealthBoost_Bracket3
    Debug.Trace("SF adjusted for B3 SF " + SF_PCHealthBoost_Bracket3 + ".", 0)
  ElseIf (76 <= playerLevel && playerLevel <= 100)
    ;; Bracket 4
    scaleFactor = SF_PCHealthBoost_Bracket4
    Debug.Trace("SF adjusted for B4 SF " + SF_PCHealthBoost_Bracket4 + ".", 0)
  ElseIf (101 <= playerLevel && playerLevel <= 125)
    ;; Bracket 5
    scaleFactor = SF_PCHealthBoost_Bracket5
    Debug.Trace("SF adjusted for B5 SF " + SF_PCHealthBoost_Bracket5 + ".", 0)
  ElseIf (126 <= playerLevel && playerLevel <= 150)
    ;; Bracket 6
    scaleFactor = SF_PCHealthBoost_Bracket6
    Debug.Trace("SF adjusted for B6 SF " + SF_PCHealthBoost_Bracket6 + ".", 0)
  ElseIf (151 <= playerLevel && playerLevel <= 200)
    ;; Bracket 7
    scaleFactor = SF_PCHealthBoost_Bracket7
    Debug.Trace("SF adjusted for B7 SF " + SF_PCHealthBoost_Bracket7 + ".", 0)
  ElseIf (201 <= playerLevel && playerLevel <= 250)
    ;; Bracket 8
    scaleFactor = SF_PCHealthBoost_Bracket8
    Debug.Trace("SF adjusted for B8 SF " + SF_PCHealthBoost_Bracket8 + ".", 0)
  ElseIf (251 <= playerLevel && playerLevel <= 300)
    ;; Bracket 9
    scaleFactor = SF_PCHealthBoost_Bracket9
    Debug.Trace("SF adjusted for B9 SF " + SF_PCHealthBoost_Bracket9 + ".", 0)
  Else
    ;; Bracket 10
    scaleFactor = SF_PCHealthBoost_Bracket10
    Debug.Trace("SF adjusted for B10 SF " + SF_PCHealthBoost_Bracket10 + ".", 0)
  EndIf

  If scaleFactor < 0 
    Return 0.001
  Else 
    Return scaleFactor
  EndIf

  Debug.Trace("Final calculated SF is " + scaleFactor + ".", 0)
EndFunction

;; ****************************************************************************
;; Get, scale, and update a float based game setting 
;;
Function ScaleFloatGameSetting (String gameSetting, Float defaultValue, Float scaleFactor)
  Float scaledValue = defaultValue * scaleFactor
  Debug.ExecuteConsole("setgs " + gameSetting + " " + scaledValue)
EndFunction

;; ****************************************************************************
;; Update Starfield Damage Scaling Game Setting for my current level and 
;; scaling factor for that level
;;
;; Use: player.cf "VPI_LevelBasedScaling.ScaleForMyLevel"
;;
Function ScaleForMyLevel()
  Float sfDamageByPlayer = GetDamageByPlayerScalingFactor()
  Float sfDamageToPlayer = GetDamageToPlayerScalingFactor()
  Float sfSponginessNPC = SponginessNPCScalingFactor()
  Float sfSponginessPlayer = SponginessPlayerScalingFactor()

  ScaleFloatGameSetting("fNPCHealthLevelBonus", DefaultNPCHealthBonus, sfSponginessNPC)
  ScaleFloatGameSetting("fHealthEnduranceOffset", DefaultPlayerHealthBonus, sfSponginessPlayer)

  ScaleFloatGameSetting("fDiffMultHPByPCVE", DefaultDamageByPlayerVE, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCE", DefaultDamageByPlayerE, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCN", DefaultDamageByPlayerN, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCH", DefaultDamageByPlayerH, sfDamageByPlayer)
  ScaleFloatGameSetting("fDiffMultHPByPCVH", DefaultDamageByPlayerVH, sfDamageByPlayer)

  ScaleFloatGameSetting("fDiffMultHPToPCVE", DefaultDamageToPlayerVE, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCE", DefaultDamageToPlayerE, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCN", DefaultDamageToPlayerN, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCH", DefaultDamageToPlayerH, sfDamageToPlayer)
  ScaleFloatGameSetting("fDiffMultHPToPCVH", DefaultDamageToPlayerVH, sfDamageToPlayer)    
EndFunction

;; ****************************************************************************
;; Convert the difficulty int value to the string value
;;
String Function GetDifficulty(int iDifficulty)
  if (iDifficulty == 0)
    return "Very Easy"
  ElseIf (iDifficulty == 1)
    return "Easy"
  ElseIf (iDifficulty == 2)
    return "Normal"
  ElseIf (iDifficulty == 3)
    return "Hard"
  ElseIf (iDifficulty == 4)
    return "Very Hard"
  Else
    return "Unknown(" + iDifficulty +")"
  EndIf
EndFunction

;; ****************************************************************************
;; Get current scaling settings for your level and difficulty mode
;;
;; Use: player.cf "VPI_LevelBasedScaling.GetScalingMatrix"
;;
Function GetScalingMatrix()
  Int iPlayerLevel = PlayerRef.GetLevel()
  Int iDifficulty = Game.GetDifficulty()
  string sDifficulty = GetDifficulty(iDifficulty)

  Float scaledDamageByPlayerVE = Game.GetGameSettingFloat("fDiffMultHPByPCVE")
  Float scaledDamageByPlayerE = Game.GetGameSettingFloat("fDiffMultHPByPCE")
  Float scaledDamageByPlayerN = Game.GetGameSettingFloat("fDiffMultHPByPCN")
  Float scaledDamageByPlayerH = Game.GetGameSettingFloat("fDiffMultHPByPCH")
  Float scaledDamageByPlayerVH = Game.GetGameSettingFloat("fDiffMultHPByPCVH")

  Float scaledDamageToPlayerVE = Game.GetGameSettingFloat("fDiffMultHPToPCVE")
  Float scaledDamageToPlayerE = Game.GetGameSettingFloat("fDiffMultHPToPCE")
  Float scaledDamageToPlayerN = Game.GetGameSettingFloat("fDiffMultHPToPCN")
  Float scaledDamageToPlayerH = Game.GetGameSettingFloat("fDiffMultHPToPCH")
  Float scaledDamageToPlayerVH = Game.GetGameSettingFloat("fDiffMultHPToPCVH")

  Float scaledSponginessNPC = Game.GetGameSettingFloat("fNPCHealthLevelBonus")
  Float scaledSponginessPlayer = Game.GetGameSettingFloat("fHealthEnduranceOffset")

  String message = "VPI_LevelBasedScaling (v" + Version + ") is set for a player level of " + iPlayerLevel + " in difficulty of " + sDifficulty + ".\n\n"
  message += "Default Health Boosts: NPC=" + DefaultNPCHealthBonus + " PC=" + DefaultPlayerHealthBonus + ".\n"
  message += "Scaled Health Boosts: NPC=" + scaledSponginessNPC + " PC=" + scaledSponginessPlayer + ".\n"
  
  if (iDifficulty == 0)
    ;; Very Easy Difficulty
    message += "Default Damage Boosts: ToPC=" + DefaultDamageToPlayerVE + " ByPC=" + DefaultDamageByPlayerVE + ".\n"
    message += "Damage to player is " + scaledDamageToPlayerVE + " and damage by player is " + scaledDamageByPlayerVE + ".\n"
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    message += "Default Damage Boosts: ToPC=" + DefaultDamageToPlayerE + " ByPC=" + DefaultDamageByPlayerE + ".\n"
    message += "Damage to player is " + scaledDamageToPlayerE + " and damage by player is " + scaledDamageByPlayerE + ".\n"
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    message += "Default Damage Boosts: ToPC=" + DefaultDamageToPlayerN + " ByPC=" + DefaultDamageByPlayerN + ".\n"
    message += "Damage to player is " + scaledDamageToPlayerN + " and damage by player is " + scaledDamageByPlayerN + ".\n"
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    message += "Default Damage Boosts: ToPC=" + DefaultDamageToPlayerH + " ByPC=" + DefaultDamageByPlayerH + ".\n"
    message += "Damage to player is " + scaledDamageToPlayerH + " and damage by player is " + scaledDamageByPlayerH + ".\n"
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    message += "Default Damage Boosts: ToPC=" + DefaultDamageToPlayerVH + " ByPC=" + DefaultDamageByPlayerVH + ".\n"
    message += "Damage to player is " + scaledDamageToPlayerVH + " and damage by player is " + scaledDamageByPlayerVH + ".\n"
  EndIf

  Debug.Messagebox(message)
EndFunction

;; ****************************************************************************
;; Funciton to get the current version of the script
;;
Function GetVersion() Global
	Debug.Messagebox("VPI_LevelBasedScaling Version: " + self.Version)
EndFunction
