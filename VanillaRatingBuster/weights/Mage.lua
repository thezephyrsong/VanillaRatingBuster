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
--
-- 1.18.0 changes applied:
--   - Ignite duration reduced 6s -> 4s; more Fire Mages needed to maintain
--     stacks, individual crit more competitive -> Fire SPELLCRIT up
--   - Hot Streak reduced to 2 ranks -> slightly more accessible, mild buff
--     to crit value for Fire
--
-- 1.18.1 changes applied:
--   - Improved Fire Blast GCD reduction increased -> minor HASTE value up
--     for Fire (faster rotation cadence)

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
  -- Fire: SP primary, SPELLCRIT extremely valuable due to Ignite talent.
  -- 1.18.0: Ignite duration reduced to 4s means more Fire Mages needed to
  -- maintain stacks — individual crit more valuable as a result.
  -- Hot Streak now 2 ranks -> slightly more accessible crit synergy.
  -- 1.18.1: Improved Fire Blast GCD reduction buffed -> minor HASTE bump.
  ["DMG"]        = 1.00,
  ["FIREDMG"]    = 1.00,   -- fire-specific SP counts fully
  ["INT"]        = 0.25,   -- less mana-hungry than Arcane
  ["SPI"]        = 0.10,
  ["SPELLCRIT"]  = 19.00,  -- up from 18; Ignite duration nerf makes crit more competitive
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["HASTE"]      = 11.00,  -- up from 10; Improved Fire Blast GCD reduction buffed
  ["MANAREG"]    = 1.00,
  ["STA"]        = 0.05,
}

VRB_WEIGHTS["MageFrost-EP"] = {
  -- Frost: SP primary, SPELLCRIT very high due to Shatter (frozen targets
  -- take double crit chance), hit to 16%, INT moderate, haste low.
  -- 1.18.1: Ice Barrier now grants 10% Frost damage on cast independently
  -- of the shield — no direct stat weight change but confirms Frost is
  -- in a good place without needing further adjustments here.
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