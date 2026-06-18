-- weights/Warrior.lua

VRB_LABELS["Warrior"] = { "WarriorThreat-EP", "WarriorMitigation-EP", "WarriorFury-EP" }

VRB_WEIGHTS["WarriorThreat-EP"] = {
  ["AGI"]          = 1.05,
  ["ARMOR"]        = 0.05,
  ["ATTACKPOWER"]  = 1,
  ["BLOCK"]        = 0.04,
  ["CRIT"]         = 22,
  ["DEFENSE"]      = 0.22,
  ["DODGE"]        = 0,
  ["PARRY"]        = 7.47,
  ["STR"]          = 2,
  ["TOHIT"]        = { 14, 27, 0 },
}

VRB_WEIGHTS["WarriorMitigation-EP"] = {
  ["AGI"]          = 0.91,
  ["ARMOR"]        = 0.05,
  ["BLOCK"]        = 0.04,
  ["DEFENSE"]      = 2.61,
  ["DODGE"]        = 16.29,
  ["PARRY"]        = 16.29,
  ["STA"]          = 1,
  ["STR"]          = 0.02,
  ["TOHIT"]        = { 9, 27, 0 },
}

VRB_WEIGHTS["WarriorFury-EP"] = {
  ["AGI"]          = 1.00,
  ["ATTACKPOWER"]  = 1,
  ["CRIT"]         = 20,
  ["STR"]          = 2,
  ["TOHIT"]        = { 14, 20, 0 },
}
