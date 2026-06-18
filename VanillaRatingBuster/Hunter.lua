-- weights/Hunter.lua
--
-- Assumptions:
--   - 305 weapon skill (book-trained) -> 7% hit cap (new system)
--   - Raid buffed (Trueshot Aura, BoK, etc.)
--   - AGI = 1.0 anchor (gives ~2 RAP, crit, dodge)
--   - Survival: AGI worth more due to Lightning Reflexes talent multiplier,
--     melee AP weighted higher than ranged AP

VRB_LABELS["Hunter"] = { "HunterMM-EP", "HunterBM-EP", "HunterSurv-EP" }

VRB_WEIGHTS["HunterMM-EP"] = {
  -- Marksman: ranged damage primary, agility-stacked, hit to 7% cap
  ["AGI"]               = 1.00,
  ["RANGEDATTACKPOWER"] = 0.45,
  ["ATTACKPOWER"]       = 0.30,
  ["CRIT"]              = 20.00,
  ["RANGEDCRIT"]        = 20.00,
  ["TOHIT"]             = { 7, 25.00, 0 },
  ["HASTE"]             = 8.00,
  ["STA"]               = 0.10,
  ["STR"]               = 0.05,
}

VRB_WEIGHTS["HunterBM-EP"] = {
  -- Beast Mastery: similar to MM, slightly more AP bias from pet scaling
  ["AGI"]               = 1.00,
  ["RANGEDATTACKPOWER"] = 0.45,
  ["ATTACKPOWER"]       = 0.35,
  ["CRIT"]              = 20.00,
  ["RANGEDCRIT"]        = 20.00,
  ["TOHIT"]             = { 7, 25.00, 0 },
  ["HASTE"]             = 7.00,
  ["STA"]               = 0.10,
  ["STR"]               = 0.05,
}

VRB_WEIGHTS["HunterSurv-EP"] = {
  -- Survival: melee-oriented, Lightning Reflexes amplifies AGI value
  -- Expose Weakness procs off crit, boosting raid AP -> crit worth slightly more
  ["AGI"]               = 1.20,
  ["ATTACKPOWER"]       = 0.45,
  ["RANGEDATTACKPOWER"] = 0.30,
  ["CRIT"]              = 22.00,
  ["RANGEDCRIT"]        = 18.00,
  ["TOHIT"]             = { 7, 25.00, 0 },
  ["HASTE"]             = 5.00,
  ["STA"]               = 0.10,
  ["STR"]               = 0.08,
}
