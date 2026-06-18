-- weights/Mage.lua
--
-- Assumptions:
--   - SP = 1.0 anchor stat for all specs
--   - Spell hit cap: 16% (shown across all sheets, talents included)
--   - INT: high value for Arcane (mana = DPS), lower for Fire/Frost
--   - SPI: meaningful for Arcane due to mana sustain, low elsewhere
--   - SPELLCRIT: highest for Fire (Ignite/Combustion), very high for Frost
--     (Shatter combos), moderate for Arcane
--   - HASTE: high for Arcane (more Arcane Blasts per cast sequence),
--     moderate for Fire (faster Scorch/Fireball), low for Frost
--   - MANAREG: relevant for long fights; Arcane most mana-hungry

VRB_LABELS["Mage"] = { "MageArcane-EP", "MageFire-EP", "MageFrost-EP" }

VRB_WEIGHTS["MageArcane-EP"] = {
  -- Arcane: SP primary, INT extremely valuable (mana = more Arcane Blasts),
  -- spell hit to 16% cap, haste highly valued, SPI meaningful for mana regen
  ["DMG"]        = 1.00,
  ["INT"]        = 0.85,   -- very high; mana directly scales Arcane output
  ["SPI"]        = 0.35,   -- mana regen matters for sustain
  ["SPELLCRIT"]  = 10.00,  -- moderate; Arcane is less crit-dependent than Fire
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["HASTE"]      = 14.00,  -- very valuable; shortens cast time on Arcane Blast
  ["MANAREG"]    = 2.50,   -- sustain matters, especially longer fights
  ["STA"]        = 0.05,
}

VRB_WEIGHTS["MageFire-EP"] = {
  -- Fire: SP primary, SPELLCRIT extremely valuable due to Ignite talent
  -- (crits deal 40% extra via Ignite DoT, stacking), hit to 16%,
  -- haste moderate, INT lower value than Arcane
  ["DMG"]        = 1.00,
  ["FIREDMG"]    = 1.00,   -- fire-specific SP counts fully
  ["INT"]        = 0.25,   -- less mana-hungry than Arcane
  ["SPI"]        = 0.10,
  ["SPELLCRIT"]  = 18.00,  -- very high; Ignite makes each crit worth much more
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["HASTE"]      = 10.00,  -- moderate; faster Fireballs/Scorch is good
  ["MANAREG"]    = 1.00,
  ["STA"]        = 0.05,
}

VRB_WEIGHTS["MageFrost-EP"] = {
  -- Frost: SP primary, SPELLCRIT very high due to Shatter (frozen targets
  -- take double crit chance), hit to 16%, INT moderate, haste low
  -- (cast sequences less haste-dependent than Arcane)
  ["DMG"]        = 1.00,
  ["FROSTDMG"]   = 1.00,   -- frost-specific SP counts fully
  ["INT"]        = 0.30,
  ["SPI"]        = 0.10,
  ["SPELLCRIT"]  = 16.00,  -- high; Shatter makes crit very valuable
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["HASTE"]      = 7.00,   -- lower; Frost rotation less haste-sensitive
  ["MANAREG"]    = 1.20,
  ["STA"]        = 0.05,
}
