ScriptName VPI_LevelBasedScaling Extends Actor

Event OnInit()
    ScaleForMyLevel()
EndEvent

Event OnPlayerLoadGame()
    ScaleForMyLevel()
EndEvent

Event OnDifficultyChanged(Int aOldDifficulty, Int aNewDifficulty)
    ScaleForMyLevel()
EndEvent

Event OnEnterShipInterior(ObjectReference akShip)
    ScaleForMyLevel()
EndEvent

;; ****************************************************************************
;; Get the scaling factor for damage done to the player by NPCs at the 
;; player's current level
;;
Float Function GetDamageToPlayerScalingFactor() Global
    Actor playerRef = Game.GetPlayer()
    Int playerLevel = playerRef.GetLevel()

    Perk skill_wellness = Game.GetForm(0x002CE2E1) as Perk
    Perk skill_energyweapondissipation = Game.GetForm(0x002C59E2) as Perk
    Perk skill_paintolerance = Game.GetForm(0x002CFCAE) as Perk
    Perk skill_rejuvenation = Game.GetForm(0x0028AE13) as Perk


    Float scaleFactor = 0
    If (1 <= playerLevel && playerLevel <= 25)
        scaleFactor = 0.80
    ElseIf (26 <= playerLevel && playerLevel <= 50)
        scaleFactor = 0.90
    ElseIf (51 <= playerLevel && playerLevel <= 75)
        scaleFactor = 1.00
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 0.10
        EndIf
    ElseIf (76 <= playerLevel && playerLevel <= 100)
        scaleFactor = 1.25
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 0.30
        EndIf
    ElseIf (101 <= playerLevel && playerLevel <= 125)
        scaleFactor = 1.33
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 0.30
        EndIf
    ElseIf (126 <= playerLevel && playerLevel <= 150)
        scaleFactor = 1.50
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 0.30
        EndIf
    ElseIf (151 <= playerLevel && playerLevel <= 200)
        scaleFactor = 1.75
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 0.50
        EndIf
    ElseIf (201 <= playerLevel && playerLevel <= 250)
        scaleFactor = 2.00
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 0.50
        EndIf
    ElseIf (251 <= playerLevel && playerLevel <= 300)
        scaleFactor = 2.5
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 1.0
        EndIf
    Else
        scaleFactor = 3.5
        If (playerRef.HasPerk(skill_wellness) || playerRef.HasPerk(skill_energyweapondissipation) || playerRef.HasPerk(skill_paintolerance) || playerRef.HasPerk(skill_rejuvenation)) 
            scaleFactor += 1.0
        EndIf
    EndIf

    If scaleFactor < 0 
        Return 0.001
    Else 
        Return scaleFactor
    EndIf
EndFunction

;; ****************************************************************************
;; Get the scaling factor for damage done by the player to NPCs at the 
;; player's current level
;;
Float Function GetDamageByPlayerScalingFactor() Global
    Actor playerRef = Game.GetPlayer()
    Int playerLevel = playerRef.GetLevel()

    Perk skill_ballistics = Game.GetForm(0x002CFCAB) as Perk
    Perk skill_lasers = Game.GetForm(0x002C59DD) as Perk
    Perk skill_particlebeams = Game.GetForm(0x0027BAFD) as Perk
    Perk skill_marksmanship = Game.GetForm(0x002C890B) as Perk

    Perk skill_pistolcertification = Game.GetForm(0x002080FF) as Perk
    Perk skill_shotguncertification = Game.GetForm(0x0027DF97) as Perk
    Perk skill_heavyweaponscertification = Game.GetForm(0x00147E38) as Perk
    Perk skill_riflecertification = Game.GetForm(0x002CE2E0) as Perk

    Perk skill_armorpenetration = Game.GetForm(0x0027DF94) as Perk
    Perk skill_crippling = Game.GetForm(0x0027CBBA) as Perk

    Float scaleFactor = 0
    If (1 <= playerLevel && playerLevel <= 25)
        scaleFactor = 1.10
    ElseIf (26 <= playerLevel && playerLevel <= 50)
        scaleFactor = 1.00
    ElseIf (51 <= playerLevel && playerLevel <= 75)
        scaleFactor = 0.90
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    ElseIf (76 <= playerLevel && playerLevel <= 100)
        scaleFactor = 0.80
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    ElseIf (101 <= playerLevel && playerLevel <= 125)
        scaleFactor = 0.70
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    ElseIf (126 <= playerLevel && playerLevel <= 150)
        scaleFactor = 0.60
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    ElseIf (151 <= playerLevel && playerLevel <= 200)
        scaleFactor = 0.50
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    ElseIf (201 <= playerLevel && playerLevel <= 250)
        scaleFactor = 0.40
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    ElseIf (251 <= playerLevel && playerLevel <= 300)
        scaleFactor = 0.25
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    Else
        scaleFactor = 0.10
        If ((playerRef.HasPerk(skill_pistolcertification) || playerRef.HasPerk(skill_shotguncertification) || playerRef.HasPerk(skill_heavyweaponscertification) || playerRef.HasPerk(skill_riflecertification)) && (playerRef.HasPerk(skill_ballistics) || playerRef.HasPerk(skill_lasers) || playerRef.HasPerk(skill_particlebeams) || playerRef.HasPerk(skill_marksmanship))) 
            scaleFactor -= 0.05
        EndIf
        If (playerRef.HasPerk(skill_armorpenetration) || playerRef.HasPerk(skill_crippling))
            scaleFactor -= 0.10
        EndIf
    EndIf

    If scaleFactor < 0 
        Return 0.001
    Else 
        Return scaleFactor
    EndIf
EndFunction

;; ****************************************************************************
;; Get the scaling factor for NPC sponginess at the player's current level
;;
Float Function SponginessNPCScalingFactor() Global
    Int playerLevel = Game.GetPlayer().GetLevel()

    Float scaleFactor = 0
    If (1 <= playerLevel && playerLevel <= 25)
        scaleFactor = 0.00
    ElseIf (26 <= playerLevel && playerLevel <= 50)
        scaleFactor = 0.00
    ElseIf (51 <= playerLevel && playerLevel <= 75)
        scaleFactor = 0.50
    ElseIf (76 <= playerLevel && playerLevel <= 100)
        scaleFactor = 1.00
    ElseIf (101 <= playerLevel && playerLevel <= 125)
        scaleFactor = 1.25
    ElseIf (126 <= playerLevel && playerLevel <= 150)
        scaleFactor = 1.50
    ElseIf (151 <= playerLevel && playerLevel <= 200)
        scaleFactor = 1.75
    ElseIf (201 <= playerLevel && playerLevel <= 250)
        scaleFactor = 2.00
    ElseIf (251 <= playerLevel && playerLevel <= 300)
        scaleFactor = 3.00
    Else
        scaleFactor = 4.00
    EndIf

    If scaleFactor < 0 
        Return 0.001
    Else 
        Return scaleFactor
    EndIf
EndFunction

;; ****************************************************************************
;; Get the scaling factor for Player sponginess at the player's current level
;;
Float Function SponginessPlayerScalingFactor() Global
    Int playerLevel = Game.GetPlayer().GetLevel()

    Float scaleFactor = 0
    If (1 <= playerLevel && playerLevel <= 25)
        scaleFactor = 1.00
    ElseIf (26 <= playerLevel && playerLevel <= 50)
        scaleFactor = 1.00
    ElseIf (51 <= playerLevel && playerLevel <= 75)
        scaleFactor = 1.00
    ElseIf (76 <= playerLevel && playerLevel <= 100)
        scaleFactor = 0.85
    ElseIf (101 <= playerLevel && playerLevel <= 125)
        scaleFactor = 0.75
    ElseIf (126 <= playerLevel && playerLevel <= 150)
        scaleFactor = 0.75
    ElseIf (151 <= playerLevel && playerLevel <= 200)
        scaleFactor = 0.50
    ElseIf (201 <= playerLevel && playerLevel <= 250)
        scaleFactor = 0.25
    ElseIf (251 <= playerLevel && playerLevel <= 300)
        scaleFactor = 0.00
    Else
        scaleFactor = 0.00
    EndIf

    If scaleFactor < 0 
        Return 0.001
    Else 
        Return scaleFactor
    EndIf
EndFunction

;; ****************************************************************************
;; Get, scale, and update a float based game setting 
;;
Function ScaleFloatGameSetting (String gameSetting, Float dfGameSettingValue, Float scaleFactor) Global
    Float scaledValue = dfGameSettingValue * scaleFactor
    Debug.ExecuteConsole("setgs " + gameSetting + " " + scaledValue)
EndFunction

;; ****************************************************************************
;; cgf "VPI_LevelBasedScaling.ScaleForMyLevel"
;;
;; Update Starfield Damage Scaling Game Setting for my current level and 
;; scaling factor for that level
;;
Function ScaleForMyLevel() Global
    Float sfDamageByPlayer = GetDamageByPlayerScalingFactor()
    Float sfDamageToPlayer = GetDamageToPlayerScalingFactor()
    Float sfSponginessNPC = SponginessNPCScalingFactor()
    Float sfSponginessPlayer = SponginessPlayerScalingFactor()

    ScaleFloatGameSetting("fNPCHealthLevelBonus", 20.0, sfSponginessNPC)
    ScaleFloatGameSetting("fHealthEnduranceOffset", 20.0, sfSponginessPlayer)

    ScaleFloatGameSetting("fDiffMultHPByPCVE", 2.00, sfDamageByPlayer)
    ScaleFloatGameSetting("fDiffMultHPByPCE", 1.50, sfDamageByPlayer)
    ScaleFloatGameSetting("fDiffMultHPByPCN", 1.00, sfDamageByPlayer)
    ScaleFloatGameSetting("fDiffMultHPByPCH", 0.75, sfDamageByPlayer)
    ScaleFloatGameSetting("fDiffMultHPByPCVH", 0.50, sfDamageByPlayer)

    ScaleFloatGameSetting("fDiffMultHPToPCVE", 0.50, sfDamageToPlayer)
    ScaleFloatGameSetting("fDiffMultHPToPCE", 0.75, sfDamageToPlayer)
    ScaleFloatGameSetting("fDiffMultHPToPCN", 1.00, sfDamageToPlayer)
    ScaleFloatGameSetting("fDiffMultHPToPCH", 1.50, sfDamageToPlayer)
    ScaleFloatGameSetting("fDiffMultHPToPCVH", 2.00, sfDamageToPlayer)    
EndFunction


;; ****************************************************************************
;; cgf "VPI_LevelBasedScaling.GetScalingMatrix"
;;
;; Get current scaling settings for your level and difficulty mode
;;
Function GetScalingMatrix() Global

    Int playerLevel = Game.GetPlayer().GetLevel()
    Int difficulty = Game.GetDifficulty()

    Float sfDamageByPlayer = GetDamageByPlayerScalingFactor()
    Float sfDamageToPlayer = GetDamageToPlayerScalingFactor()
    Float sfSponginessNPC = SponginessNPCScalingFactor()
    Float sfSponginessPlayer = SponginessPlayerScalingFactor()

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

    if (difficulty == 0) 
        ;; Should be Very Easy Mode
        Debug.MessageBox( \
            "Scaling is set for a player level of " + playerLevel + " in difficulty of very easy.\n\n" + \
            "NPC Bonus Health is " + scaledSponginessNPC + " used scaling factor of " + sfSponginessNPC + "\n" + \
            "Player Bonus Health is " + scaledSponginessPlayer + " used scaling factor of " + sfSponginessPlayer + "\n" + \
            "Damage to player is " + scaledDamageToPlayerVE + " used scaling factor of " + sfDamageToPlayer + "\n" + \
            "Damage by player is " + scaledDamageByPlayerVE + " used scaling factor of " + sfDamageByPlayer + "\n" \
        )
    ElseIf (difficulty == 1)
        ;; Should be Easy
        Debug.MessageBox( \
            "Scaling is set for a player level of " + playerLevel + " in difficulty of easy.\n\n" + \
            "NPC Bonus Health is " + scaledSponginessNPC + " used scaling factor of " + sfSponginessNPC + "\n" + \
            "Player Bonus Health is " + scaledSponginessPlayer + " used scaling factor of " + sfSponginessPlayer + "\n" + \
            "Damage to player is " + scaledDamageToPlayerE + " used scaling factor of " + sfDamageToPlayer + "\n" + \
            "Damage by player is " + scaledDamageByPlayerE + " used scaling factor of " + sfDamageByPlayer + "\n" \
        )
    ElseIf (difficulty == 2)
        ;; Should be Normal
        Debug.MessageBox( \
            "Scaling is set for a player level of " + playerLevel + " in difficulty of normal.\n\n" + \
            "NPC Bonus Health is " + scaledSponginessNPC + " used scaling factor of " + sfSponginessNPC + "\n" + \
            "Player Bonus Health is " + scaledSponginessPlayer + " used scaling factor of " + sfSponginessPlayer + "\n" + \
            "Damage to player is " + scaledDamageToPlayerN + " used scaling factor of " + sfDamageToPlayer + "\n" + \
            "Damage by player is " + scaledDamageByPlayerN + " used scaling factor of " + sfDamageByPlayer + "\n" \
        )
    ElseIf (difficulty == 3)
        ;; Should be Hard
        Debug.MessageBox( \
            "Scaling is set for a player level of " + playerLevel + " in difficulty of hard.\n\n" + \
            "NPC Bonus Health is " + scaledSponginessNPC + " used scaling factor of " + sfSponginessNPC + "\n" + \
            "Player Bonus Health is " + scaledSponginessPlayer + " used scaling factor of " + sfSponginessPlayer + "\n" + \
            "Damage to player is " + scaledDamageToPlayerH + " used scaling factor of " + sfDamageToPlayer + "\n" + \
            "Damage by player is " + scaledDamageByPlayerH + " used scaling factor of " + sfDamageByPlayer + "\n" \
        )
    ElseIf (difficulty == 4)
        ;; Should be Vary Hard
        Debug.MessageBox( \
            "Scaling is set for a player level of " + playerLevel + " in difficulty of very hard.\n\n" + \
            "NPC Bonus Health is " + scaledSponginessNPC + " used scaling factor of " + sfSponginessNPC + "\n" + \
            "Player Bonus Health is " + scaledSponginessPlayer + " used scaling factor of " + sfSponginessPlayer + "\n" + \
            "Damage to player is " + scaledDamageToPlayerVH + " used scaling factor of " + sfDamageToPlayer + "\n" + \
            "Damage by player is " + scaledDamageByPlayerVH + " used scaling factor of " + sfDamageByPlayer + "\n" \
        )
    Else
        Debug.MessageBox("Found unexpected Difficulty mode ," + difficulty + ".")
    EndIf

EndFunction