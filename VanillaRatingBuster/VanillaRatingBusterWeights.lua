-- VanillaRatingBusterWeights.lua

-- Initializes the weight and label tables.

-- From BonusScanner

-- types = {

-- "STR", -- strength

-- "AGI", -- agility

-- "STA", -- stamina

-- "INT", -- intellect

-- "SPI", -- spirit

-- "ARMOR", -- reinforced armor (not base armor)

--

-- "ARCANERES", -- arcane resistance

-- "FIRERES", -- fire resistance

-- "NATURERES", -- nature resistance

-- "FROSTRES", -- frost resistance

-- "SHADOWRES", -- shadow resistance

--

-- "FISHING", -- fishing skill

-- "MINING", -- mining skill

-- "HERBALISM", -- herbalism skill

-- "SKINNING", -- skinning skill

-- "DEFENSE", -- defense skill

--

-- "BLOCK", -- chance to block

-- "DODGE", -- chance to dodge

-- "PARRY", -- chance to parry

-- "ATTACKPOWER", -- attack power

-- "ATTACKPOWERUNDEAD", -- attack power against undead

--

-- "CRIT", -- chance to get a critical strike

-- "RANGEDATTACKPOWER", -- ranged attack power

-- "RANGEDCRIT", -- chance to get a crit with ranged weapons
-- "FERALATTACKPOWER", -- feral attack power
-- "HASTE", -- increased attack and casting speed

-- "TOHIT", -- chance to hit

--

-- "DMG", -- spell damage

-- "DMGUNDEAD", -- spell damage against undead

--

-- "ARCANEDMG", -- arcane spell damage

-- "FIREDMG", -- fire spell damage

-- "FROSTDMG", -- frost spell damage

-- "HOLYDMG", -- holy spell damage

-- "NATUREDMG", -- nature spell damage

-- "SHADOWDMG", -- shadow spell damage

-- "SPELLCRIT", -- chance to crit with spells

-- "HEAL", -- healing

-- "HOLYCRIT", -- chance to crit with holy spells

-- "SPELLTOHIT", -- chance to hit with spells

--

-- "SPELLPEN", -- amount of spell resist reduction

--

-- "HEALTHREG", -- health regeneration per 5 sec.

-- "MANAREG", -- mana regeneration per 5 sec.

-- "HEALTH", -- health points

-- "MANA", -- mana points

-- };

-- Initialize the tables if they don't exist
VRB_LABELS = VRB_LABELS or {}
VRB_WEIGHTS = VRB_WEIGHTS or {}


VRB_LABELS["Warrior"] = { "WarriorThreat-EP", "WarriorMitigation-EP", "WarriorFury-EP" }

VRB_LABELS["Mage"] = { "MageArcane-EP", "MageFire-EP", "MageFrost-EP" }

VRB_LABELS["Hunter"] = { "HunterMM-EP", "HunterBM-EP", "HunterSurv-EP" }

VRB_LABELS["Druid"] = { "DruidFeralDPS-EP", "DruidTank-EP", "DruidThreat-EP", "DruidResto-EP" }

VRB_LABELS["Paladin"] = { "PaladinProtEH", "PaladinRetDPS", "PaladinHEP" }

VRB_LABELS["Priest"] = { "PriestHEP_2M", "PriestHEP_15M", "PriestHEP_TIG", "PriestShadowDPS_2M", "PriestShadowDPS_9M" }

VRB_LABELS["Rogue"] = { "RogueDagger-EP", "RogueCombat-EP", "RogueSub-EP" }

VRB_LABELS["Shaman"] = { "ShamanElemental-EP", "ShamanElementalFire-EP", "ShamanHEP", "ShamanEnhance-EP", "ShamanEnhanceTank-EP" }

VRB_LABELS["Warlock"] = { "WarlockAffliction-EP", "WarlockSMRuin-EP", "WarlockDemo-EP", "WarlockFire-EP" }

-- Define Weights

VRB_WEIGHTS["WarriorThreat-EP"] = { ["AGI"] = 1.05, ["ARMOR"] = 0.05, ["ATTACKPOWER"] = 1, ["BLOCK"] = 0.04, ["CRIT"] = 22, ["DEFENSE"] = 0.22, ["DODGE"] = 0, ["PARRY"] = 7.47, ["STR"] = 2, ["TOHIT"] = { 14, 27, 0 } }


VRB_WEIGHTS["WarriorMitigation-EP"] = { ["AGI"] = 0.91, ["ARMOR"] = 0.05, ["BLOCK"] = 0.04, ["DEFENSE"] = 2.61, ["DODGE"] = 16.29, ["PARRY"] = 16.29, ["STA"] = 1, ["STR"] = 0.02, ["TOHIT"] = { 9, 27, 0 } }

VRB_WEIGHTS["WarriorFury-EP"] = { ["AGI"] = 1.00, ["ATTACKPOWER"] = 1, ["CRIT"] = 20, ["STR"] = 2, ["TOHIT"] = { 14, 20, 0 } }



VRB_WEIGHTS["MageArcane-EP"] = { ["DMG"] = 1.00, ["INT"] = 0.85, ["SPI"] = 0.35, ["SPELLCRIT"] = 10.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 14.00, ["MANAREG"] = 2.50, ["STA"] = 0.05 }

VRB_WEIGHTS["MageFire-EP"] = { ["DMG"] = 1.00, ["FIREDMG"] = 1.00, ["INT"] = 0.25, ["SPI"] = 0.10, ["SPELLCRIT"] = 19.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 11.00, ["MANAREG"] = 1.00, ["STA"] = 0.05 }

VRB_WEIGHTS["MageFrost-EP"] = { ["DMG"] = 1.00, ["FROSTDMG"] = 1.00, ["INT"] = 0.30, ["SPI"] = 0.10, ["SPELLCRIT"] = 16.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 7.00, ["MANAREG"] = 1.20, ["STA"] = 0.05 }



VRB_WEIGHTS["PaladinRetDPS"] = { ["STR"] = 0.1428571428571429, ["AGI"] = 0.1020, ["CRIT"] = 2.04, ["TOHIT"] = { 5.6, 100, 0 }, ["ATTACKPOWER"] = 0.0714285714285714 }

VRB_WEIGHTS["PaladinHEP"] = { ["INT"] = 1.00, ["MANAREG"] = 1.91, ["HEAL"] = 1.00, ["SPELLCRIT"] = 20.34, ["SPI"] = 0.00 }

VRB_WEIGHTS["PaladinProtEH"] = { ["ARMOR"] = 0.51416, ["STA"] = 10.14596, ["AGI"] = 1.02832, ["STR"] = 0.05, ["DODGE"] = 0, ["PARRY"] = 0, ["DEFENSE"] = 0.08, ["BLOCK"] = 0.04 }



VRB_WEIGHTS["PriestHEP_TIG"] = { ["INT"] = 1.1607, ["MANAREG"] = 3.5, ["HEAL"] = 1, ["SPELLCRIT"] = 1.161317565, ["SPI"] = 0.8275 }

VRB_WEIGHTS["PriestHEP_2M"] = { ["INT"] = 2.322635135, ["MANAREG"] = 3.5, ["HEAL"] = 1, ["SPELLCRIT"] = 1.161317565, ["SPI"] = 0.8275 }

VRB_WEIGHTS["PriestHEP_15M"] = { ["INT"] = 0.4351, ["MANAREG"] = 3.5, ["HEAL"] = 1, ["SPELLCRIT"] = 1.161317565, ["SPI"] = 0.8275 }

VRB_WEIGHTS["PriestShadowDPS_2M"] = { ["DMG"] = 1, ["SHADOWDMG"] = 1, ["INT"] = 1.52, ["MANAREG"] = 1.8, ["SPI"] = 0.34, ["SPELLCRIT"] = 1.25, ["SPELLTOHIT"] = { 8, 10.36, 0 } }

VRB_WEIGHTS["PriestShadowDPS_9M"] = { ["DMG"] = 1, ["SHADOWDMG"] = 1, ["INT"] = 0.4, ["MANAREG"] = 2.81, ["SPI"] = 0.09, ["SPELLCRIT"] = 0.88, ["SPELLTOHIT"] = { 8, 10.02, 0 } }



VRB_WEIGHTS["RogueDagger-EP"] = { ["AGI"] = 1.00, ["ATTACKPOWER"] = 0.50, ["CRIT"] = 24.00, ["TOHIT"] = { 7, 28.00, 0 }, ["HASTE"] = 9.00, ["STR"] = 0.15, ["STA"] = 0.08 }

VRB_WEIGHTS["RogueCombat-EP"] = { ["AGI"] = 1.10, ["ATTACKPOWER"] = 0.55, ["CRIT"] = 20.00, ["TOHIT"] = { 7, 28.00, 0 }, ["HASTE"] = 11.00, ["STR"] = 0.18, ["STA"] = 0.08 }

VRB_WEIGHTS["RogueSub-EP"] = { ["AGI"] = 1.00, ["ATTACKPOWER"] = 0.55, ["CRIT"] = 24.00, ["TOHIT"] = { 7, 28.00, 0 }, ["HASTE"] = 9.00, ["STR"] = 0.15, ["STA"] = 0.08 }



VRB_WEIGHTS["ShamanElemental-EP"] = { ["DMG"] = 1.00, ["NATUREDMG"] = 1.00, ["INT"] = 0.35, ["SPI"] = 0.30, ["SPELLCRIT"] = 18.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 9.00, ["MANAREG"] = 2.00, ["STA"] = 0.05 }

VRB_WEIGHTS["ShamanElementalFire-EP"] = { ["DMG"] = 1.00, ["FIREDMG"] = 1.00, ["NATUREDMG"] = 0.60, ["INT"] = 0.35, ["SPI"] = 0.30, ["SPELLCRIT"] = 19.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 9.00, ["MANAREG"] = 2.00, ["STA"] = 0.05 }

VRB_WEIGHTS["ShamanHEP"] = { ["INT"] = 0.20, ["MANAREG"] = 1.00, ["HEAL"] = 0.14, ["SPELLCRIT"] = 0.00, ["SPI"] = 0.00 }

VRB_WEIGHTS["ShamanEnhance-EP"] = { ["AGI"] = 1.00, ["STR"] = 0.65, ["ATTACKPOWER"] = 0.45, ["CRIT"] = 18.00, ["TOHIT"] = { 5, 22.00, 0 }, ["HASTE"] = 10.00, ["DMG"] = 0.15, ["NATUREDMG"] = 0.15, ["STA"] = 0.08 }

VRB_WEIGHTS["ShamanEnhanceTank-EP"] = { ["DEFENSE"] = 2.20, ["DODGE"] = 14.00, ["PARRY"] = 14.00, ["ARMOR"] = 0.06, ["STA"] = 1.20, ["AGI"] = 0.55, ["ATTACKPOWER"] = 0.15, ["CRIT"] = 5.00, ["TOHIT"] = { 5, 8.00, 0 }, ["HASTE"] = 2.00, ["STR"] = 0.10 }



VRB_WEIGHTS["WarlockAffliction-EP"] = { ["DMG"] = 1.00, ["SHADOWDMG"] = 1.00, ["SPI"] = 0.60, ["INT"] = 0.45, ["SPELLCRIT"] = 4.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 5.00, ["MANAREG"] = 2.00, ["STA"] = 0.05 }

VRB_WEIGHTS["WarlockSMRuin-EP"] = { ["DMG"] = 1.00, ["SHADOWDMG"] = 1.00, ["SPI"] = 0.20, ["INT"] = 0.35, ["SPELLCRIT"] = 20.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 9.00, ["MANAREG"] = 1.50, ["STA"] = 0.05 }

VRB_WEIGHTS["WarlockDemo-EP"] = { ["DMG"] = 1.00, ["SHADOWDMG"] = 1.00, ["SPI"] = 0.30, ["INT"] = 0.40, ["SPELLCRIT"] = 10.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["HASTE"] = 7.00, ["MANAREG"] = 1.50, ["STA"] = 0.15 }

VRB_WEIGHTS["WarlockFire-EP"] = { ["DMG"] = 1.00, ["FIREDMG"] = 1.00, ["SHADOWDMG"] = 0.50, ["SPI"] = 0.15, ["INT"] = 0.30, ["SPELLCRIT"] = 20.00, ["SPELLTOHIT"] = { 16, 18.00, 0 }, ["SPELLPEN"] = 2.00, ["HASTE"] = 9.00, ["MANAREG"] = 1.20, ["STA"] = 0.05 }



VRB_WEIGHTS["HunterMM-EP"] = { ["AGI"] = 1.00, ["RANGEDATTACKPOWER"] = 0.52, ["ATTACKPOWER"] = 0.30, ["CRIT"] = 22.00, ["RANGEDCRIT"] = 22.00, ["TOHIT"] = { 7, 25.00, 0 }, ["HASTE"] = 10.00, ["STA"] = 0.10, ["STR"] = 0.05,}

VRB_WEIGHTS["HunterBM-EP"] = {["AGI"] = 1.00, ["RANGEDATTACKPOWER"] = 0.45, ["ATTACKPOWER"] = 0.40, ["CRIT"] = 23.00, ["RANGEDCRIT"] = 23.00, ["TOHIT"] = { 7, 25.00, 0 }, ["HASTE"] = 7.00, ["STA"] = 0.10, ["STR"] = 0.05,}

VRB_WEIGHTS["HunterSurv-EP"] = {["AGI"] = 1.20, ["ATTACKPOWER"] = 0.50, ["RANGEDATTACKPOWER"] = 0.30, ["CRIT"] = 22.00, ["RANGEDCRIT"] = 18.00, ["TOHIT"] = { 7, 25.00, 0 }, ["HASTE"] = 7.00, ["STA"] = 0.10, ["STR"] = 0.08,}



VRB_WEIGHTS["DruidResto-EP"] = { ["HEAL"] = 1.00, ["DMG"] = 1.00, ["INT"] = 0.3, ["SPI"] = 0.46, ["MANAREG"] = 3.0, ["SPELLCRIT"] = 10, ["MANA"] = 0.02,}

VRB_WEIGHTS["DruidFeralDPS-EP"] = { ["AGI"] = 2.76, ["ARMORPEN"] = 0.5, ["ATTACKPOWER"] = 1, ["CRIT"] = 30.13, ["FERALATTACKPOWER"] = 1, ["HASTE"] = 13.6, ["STR"] = 2.64, ["TOHIT"] = 31.85,}

VRB_WEIGHTS["DruidTank-EP"] = { ["AGI"] = 1.57, ["ARMOR"] = 0.33, ["ARMORPEN"] = 0.5, ["ATTACKPOWER"] = 1, ["CRIT"] = 25.8, ["DEFENSE"] = 0.46, ["FERALATTACKPOWER"] = 1, ["HASTE"] = 26.6, ["HEALTH"] = 0.167, ["STA"] = 2.2, ["STR"] = 2.2, ["TOHIT"] = 36.1}

VRB_WEIGHTS["DruidThreat-EP"] = { ["AGI"] = 1.57, ["ARMORPEN"] = 0.5, ["ATTACKPOWER"] = 1, ["CRIT"] = 25.8, ["FERALATTACKPOWER"] = 1, ["HASTE"] = 26.6, ["STR"] = 2.2, ["TOHIT"] = 36.1}