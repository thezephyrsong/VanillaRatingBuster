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
--
-- 1.18.0 changes applied:
--   - Blade Rush (Combat) now reduces energy regen tick interval by Agility
--     -> AGI gives energy regen on top of normal benefits for Combat -> up
--   - Honor Among Thieves (Sub) now also triggers from own crits, CD reduced
--     -> crit generates energy for Sub -> CRIT weight up for Sub
--   - Mark for Death (Sub) now scales AP/SP from rogue's melee AP
--     -> ATTACKPOWER weight up for Sub (more AP = bigger raid buff)
--
-- 1.18.1 changes applied:
--   - Taste for Blood now 2 points, damage scales per combo point
--     -> no direct stat weight change
--   - Corrosive/Dissolvent Poison restricted to specific mob types
--     -> no stat weight change

VRB_LABELS["Rogue"] = { "RogueDagger-EP", "RogueCombat-EP", "RogueSub-EP" }

VRB_WEIGHTS["RogueDagger-EP"] = {
  -- Dagger: Backstab crit fishing, Seal Fate for combo points.
  -- Highest crit weight of all rogue specs. No changes from 1.18.x.
  ["AGI"]         = 1.00,
  ["ATTACKPOWER"] = 0.50,
  ["CRIT"]        = 24.00,  -- very high; Seal Fate makes each crit generate extra CP
  ["TOHIT"]       = { 7, 28.00, 0 },
  ["HASTE"]       = 9.00,
  ["STR"]         = 0.15,
  ["STA"]         = 0.08,
}

VRB_WEIGHTS["RogueCombat-EP"] = {
  -- Combat (Sword/Fist): sustained melee damage.
  -- 1.18.0: Blade Rush now reduces energy regen tick interval by Agility
  -- -> AGI now gives energy regeneration on top of AP/crit/dodge,
  --    making it worth more per point than before.
  ["AGI"]         = 1.10,  -- up from 1.00; Blade Rush gives AGI -> energy regen
  ["ATTACKPOWER"] = 0.55,
  ["CRIT"]        = 20.00,
  ["TOHIT"]       = { 7, 28.00, 0 },
  ["HASTE"]       = 11.00,
  ["STR"]         = 0.18,
  ["STA"]         = 0.08,
}

VRB_WEIGHTS["RogueSub-EP"] = {
  -- Subtlety: Hemorrhage-based.
  -- 1.18.0: Honor Among Thieves now procs off own crits + shorter CD
  --   -> each crit generates energy, making crit worth more.
  -- 1.18.0: Mark for Death AP/SP scaling from rogue's melee AP
  --   -> higher AP = stronger raid buff, AP weight up slightly.
  ["AGI"]         = 1.00,
  ["ATTACKPOWER"] = 0.55,  -- up from 0.50; Mark for Death scales from melee AP
  ["CRIT"]        = 24.00, -- up from 22; Honor Among Thieves procs off own crits
  ["TOHIT"]       = { 7, 28.00, 0 },
  ["HASTE"]       = 9.00,
  ["STR"]         = 0.15,
  ["STA"]         = 0.08,
}