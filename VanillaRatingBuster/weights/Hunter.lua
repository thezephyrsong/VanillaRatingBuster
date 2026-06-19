-- weights/Hunter.lua
--
-- Assumptions:
--   - 305 weapon skill (book-trained) -> 7% hit cap (new system)
--   - Trueshot Aura now baseline (1.18.1), assumed always active
--   - Steady Shot now baseline (1.18.1)
--   - AGI = 1.0 anchor (gives ~2 RAP, crit, dodge)
--   - Survival: AGI worth more due to Lightning Reflexes talent multiplier,
--     melee AP weighted higher than ranged AP
--
-- 1.18.0 changes applied:
--   - Mongoose Bite now hits both weapons for Surv DW -> AP weight up
--   - Lacerate scales with melee AP -> AP weight up for Surv
--   - Rapid Fire now increases melee + ranged attack speed -> HASTE up for Surv
--
-- 1.18.1 changes applied:
--   - Arcane Shot now scales with ranged weapon damage -> RAP weight up for MM
--   - Volley now has AP scaling -> RAP weight up for MM
--   - Lock and Load procs off MM crits -> CRIT weight up for MM
--   - Rapid Fire now reduces Aimed/Steady Shot cast time -> HASTE up for MM
--   - Kill Command now procs off hunter crits (BM) -> CRIT weight up for BM
--   - Bestial Wrath returned, Scent of Blood added -> pet AP scaling up for BM
--   - Lacerate damage buffed 35% -> 40% AP -> AP weight up for Surv
--   - Surefooted gives +3% hit while DW for Surv -> noted in comment

VRB_LABELS["Hunter"] = { "HunterMM-EP", "HunterBM-EP", "HunterSurv-EP" }

VRB_WEIGHTS["HunterMM-EP"] = {
  -- Marksman: ranged damage primary, agility-stacked, hit to 7% cap
  -- 1.18.1: Arcane Shot + Volley now scale with RAP, Lock and Load procs off
  -- crit -> RAP and CRIT both weighted higher. Rapid Fire reduces cast times
  -- -> HASTE more valuable.
  ["AGI"]               = 1.00,
  ["RANGEDATTACKPOWER"] = 0.52,  -- up from 0.45; more abilities now scale with RAP
  ["ATTACKPOWER"]       = 0.30,
  ["CRIT"]              = 22.00, -- up from 20; Lock and Load procs off crits
  ["RANGEDCRIT"]        = 22.00,
  ["TOHIT"]             = { 7, 25.00, 0 },
  ["HASTE"]             = 10.00, -- up from 8; Rapid Fire now reduces cast times
  ["STA"]               = 0.10,
  ["STR"]               = 0.05,
}

VRB_WEIGHTS["HunterBM-EP"] = {
  -- Beast Mastery: 1.18.1 rework — Kill Command procs off hunter crits,
  -- Bestial Wrath returned, Scent of Blood adds pet damage procs.
  -- Crit now triggers both Kill Command and pet burst windows -> higher value.
  -- AP feeds pet scaling via Spirit Bond -> ATTACKPOWER up slightly.
  ["AGI"]               = 1.00,
  ["RANGEDATTACKPOWER"] = 0.45,
  ["ATTACKPOWER"]       = 0.40,  -- up from 0.35; pet AP scaling more prominent
  ["CRIT"]              = 23.00, -- up from 20; Kill Command procs off hunter crits
  ["RANGEDCRIT"]        = 23.00,
  ["TOHIT"]             = { 7, 25.00, 0 },
  ["HASTE"]             = 7.00,
  ["STA"]               = 0.10,
  ["STR"]               = 0.05,
}

VRB_WEIGHTS["HunterSurv-EP"] = {
  -- Survival: melee-oriented, Lightning Reflexes amplifies AGI value.
  -- Expose Weakness procs off crit, boosting raid AP -> crit worth slightly more.
  -- 1.18.0: Mongoose Bite hits both weapons DW, Lacerate scales with AP,
  --         Rapid Fire now increases melee speed -> AP and HASTE both up.
  -- 1.18.1: Lacerate damage buffed to 40% AP -> AP weight up further.
  --         Surefooted gives +3% hit while DW; DW players effectively have
  --         a ~4% hit cap instead of 7% — we keep 7% as conservative default.
  ["AGI"]               = 1.20,
  ["ATTACKPOWER"]       = 0.50,  -- up from 0.45; Lacerate + Mongoose Bite DW scaling
  ["RANGEDATTACKPOWER"] = 0.30,
  ["CRIT"]              = 22.00,
  ["RANGEDCRIT"]        = 18.00,
  ["TOHIT"]             = { 7, 25.00, 0 },
  ["HASTE"]             = 7.00,  -- up from 5; Rapid Fire now increases melee speed
  ["STA"]               = 0.10,
  ["STR"]               = 0.08,
}