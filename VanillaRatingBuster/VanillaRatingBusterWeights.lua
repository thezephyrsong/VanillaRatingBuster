-- VanillaRatingBusterWeights.lua
-- Initializes the weight and label tables.
-- Actual weights are defined in weights/<Class>.lua files,
-- each of which is loaded by the .toc after this file.

-- From BonusScanner
-- types = {
--   "STR",      -- strength
--   "AGI",      -- agility
--   "STA",      -- stamina
--   "INT",      -- intellect
--   "SPI",      -- spirit
--   "ARMOR",    -- reinforced armor (not base armor)

--   "ARCANERES",  -- arcane resistance
--   "FIRERES",    -- fire resistance
--   "NATURERES",  -- nature resistance
--   "FROSTRES",   -- frost resistance
--   "SHADOWRES",  -- shadow resistance

--   "FISHING",    -- fishing skill
--   "MINING",     -- mining skill
--   "HERBALISM",  -- herbalism skill
--   "SKINNING",   -- skinning skill
--   "DEFENSE",    -- defense skill

--   "BLOCK",      -- chance to block
--   "DODGE",      -- chance to dodge
--   "PARRY",      -- chance to parry
--   "ATTACKPOWER",       -- attack power
--   "ATTACKPOWERUNDEAD", -- attack power against undead

--   "CRIT",              -- chance to get a critical strike
--   "RANGEDATTACKPOWER", -- ranged attack power
--   "RANGEDCRIT",        -- chance to get a crit with ranged weapons
--   "TOHIT",             -- chance to hit

--   "DMG",        -- spell damage
--   "DMGUNDEAD",  -- spell damage against undead

--   "ARCANEDMG",  -- arcane spell damage
--   "FIREDMG",    -- fire spell damage
--   "FROSTDMG",   -- frost spell damage
--   "HOLYDMG",    -- holy spell damage
--   "NATUREDMG",  -- nature spell damage
--   "SHADOWDMG",  -- shadow spell damage
--   "SPELLCRIT",  -- chance to crit with spells
--   "HEAL",       -- healing
--   "HOLYCRIT",   -- chance to crit with holy spells
--   "SPELLTOHIT", -- chance to hit with spells

--   "SPELLPEN",   -- amount of spell resist reduction

--   "HEALTHREG",  -- health regeneration per 5 sec.
--   "MANAREG",    -- mana regeneration per 5 sec.
--   "HEALTH",     -- health points
--   "MANA",       -- mana points
-- };

-- Populated by weights/<Class>.lua files
VRB_WEIGHTS = {}

-- Maps each class name (as returned by UnitClass) to a list of weight table keys.
-- Each weights/<Class>.lua file adds its own entry here.
VRB_LABELS = {}
