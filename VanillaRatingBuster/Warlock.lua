-- weights/Warlock.lua
--
-- Assumptions:
--   - SP = 1.0 anchor for all specs (DMG key = generic spell damage)
--   - Spell hit cap: 16% shown across all sheets
--   - Affliction: SPI very high value (Shadow Mastery, Dark Pact mana),
--     SP primary, crit low (DoTs don't crit in vanilla)
--   - Demonology (SM/Ruin variant): balanced SP/crit, Demonic Embrace
--     makes STA meaningful, Ruin makes crit extremely valuable
--   - SM/Ruin: crit is king due to Ruin (doubles crit bonus damage),
--     SP still primary, INT moderate for mana
--   - Fire Destro: FIREDMG counts fully, very high crit from Ruin,
--     spell pen matters for fire resist

VRB_LABELS["Warlock"] = { "WarlockAffliction-EP", "WarlockSMRuin-EP", "WarlockDemo-EP", "WarlockFire-EP" }

VRB_WEIGHTS["WarlockAffliction-EP"] = {
  -- Affliction: DoT-focused, DoTs don't crit so SPELLCRIT is low value
  -- SPI very high due to Dark Pact (converts pet mana) and mana sustain
  -- SP primary, hit to 16%, INT moderate for mana pool
  ["DMG"]        = 1.00,
  ["SHADOWDMG"]  = 1.00,   -- shadow-specific SP counts fully
  ["SPI"]        = 0.60,   -- very high; Dark Pact and mana regen
  ["INT"]        = 0.45,   -- mana pool and regen
  ["SPELLCRIT"]  = 4.00,   -- low; DoTs don't crit, only direct spells
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["HASTE"]      = 5.00,   -- low; DoT GCD management, not heavily haste-scaled
  ["MANAREG"]    = 2.00,
  ["STA"]        = 0.05,
}

VRB_WEIGHTS["WarlockSMRuin-EP"] = {
  -- SM/Ruin: Shadow Mastery + Ruin spec; direct Shadow Bolt spam
  -- Ruin doubles crit bonus (150% -> 200% damage), making SPELLCRIT
  -- extremely valuable — highest crit weight of all warlock specs
  ["DMG"]        = 1.00,
  ["SHADOWDMG"]  = 1.00,
  ["SPI"]        = 0.20,
  ["INT"]        = 0.35,
  ["SPELLCRIT"]  = 20.00,  -- very high; Ruin makes each crit worth ~2x normal
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["HASTE"]      = 9.00,   -- moderate; faster Shadow Bolts
  ["MANAREG"]    = 1.50,
  ["STA"]        = 0.05,
}

VRB_WEIGHTS["WarlockDemo-EP"] = {
  -- Demonology: Demonic Embrace boosts STA significantly (shown TRUE on sheets)
  -- Pet damage meaningful, balanced between SP and sustain
  -- Moderate crit value; not Ruin-specced so crit bonus normal
  ["DMG"]        = 1.00,
  ["SHADOWDMG"]  = 1.00,
  ["SPI"]        = 0.30,
  ["INT"]        = 0.40,
  ["SPELLCRIT"]  = 10.00,
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["HASTE"]      = 7.00,
  ["MANAREG"]    = 1.50,
  ["STA"]        = 0.15,   -- higher than other specs; Demonic Embrace multiplier
}

VRB_WEIGHTS["WarlockFire-EP"] = {
  -- Fire Destruction: Conflagrate/Incinerate focused, Ruin for crits
  -- FIREDMG counts fully, spell pen can matter vs fire-resistant targets
  -- Very high crit like SM/Ruin due to Ruin talent
  ["DMG"]        = 1.00,
  ["FIREDMG"]    = 1.00,   -- fire-specific SP counts fully
  ["SHADOWDMG"]  = 0.50,   -- shadow spells still used (Corruption, Curse)
  ["SPI"]        = 0.15,
  ["INT"]        = 0.30,
  ["SPELLCRIT"]  = 20.00,  -- very high; Ruin doubles crit bonus
  ["SPELLTOHIT"] = { 16, 18.00, 0 },
  ["SPELLPEN"]   = 2.00,   -- fire resist is common on some bosses
  ["HASTE"]      = 9.00,
  ["MANAREG"]    = 1.20,
  ["STA"]        = 0.05,
}
