-- weights/Rogue.lua
--
-- Assumptions:
--   - AGI = 1.0 anchor (gives AP, crit, dodge — core rogue stat)
--   - AP: high value across all specs, roughly 0.5x AGI per point
--   - All sheets show AGI ~817-845, AP ~2750-2944, hit ~22-25%
--   - Weapon skill book = TRUE on all sheets; 305 skill assumed
--     -> 7% hit cap (same as Hunter new system assumption)
--     NOTE: Rogue hit cap for yellow attacks (specials) is separate;
--     these weights focus on overall hit value including white attacks
--   - CRIT: high value for all specs due to combo point generation
--     and Seal Fate (Dagger/Sub) talent
--   - HASTE: moderate; speeds up auto-attack and energy regen indirectly
--   - Dagger: highest crit weight (Seal Fate, Backstab crits)
--   - Combat (Sword/Fist): more AP-focused, slower but harder-hitting
--   - Sub: crit-focused like Dagger but slightly different AP/agi balance

VRB_LABELS["Rogue"] = { "RogueDagger-EP", "RogueCombat-EP", "RogueSub-EP" }

VRB_WEIGHTS["RogueDagger-EP"] = {
  -- Dagger: Backstab crit fishing, Seal Fate for combo points
  -- Highest crit weight of all rogue specs
  ["AGI"]        = 1.00,
  ["ATTACKPOWER"] = 0.50,
  ["CRIT"]       = 24.00,  -- very high; Seal Fate makes each crit generate extra CP
  ["TOHIT"]      = { 7, 28.00, 0 },
  ["HASTE"]      = 9.00,
  ["STR"]        = 0.15,   -- marginal AP contribution
  ["STA"]        = 0.08,
}

VRB_WEIGHTS["RogueCombat-EP"] = {
  -- Combat (Sword/Fist): sustained melee damage, less crit-reliant
  -- AP and haste more important relative to crit vs Dagger/Sub
  ["AGI"]        = 1.00,
  ["ATTACKPOWER"] = 0.55,  -- slightly higher than Dagger; more white damage focused
  ["CRIT"]       = 20.00,
  ["TOHIT"]      = { 7, 28.00, 0 },
  ["HASTE"]      = 11.00,  -- higher than other specs; more auto-attacks per minute
  ["STR"]        = 0.18,
  ["STA"]        = 0.08,
}

VRB_WEIGHTS["RogueSub-EP"] = {
  -- Subtlety: Hemorrhage-based, crit-focused like Dagger
  -- Slightly lower AP weight than Combat, higher crit than Combat
  ["AGI"]        = 1.00,
  ["ATTACKPOWER"] = 0.50,
  ["CRIT"]       = 22.00,
  ["TOHIT"]      = { 7, 28.00, 0 },
  ["HASTE"]      = 9.00,
  ["STR"]        = 0.15,
  ["STA"]        = 0.08,
}
