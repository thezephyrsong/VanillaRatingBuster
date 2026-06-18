-- weights/Paladin.lua

VRB_LABELS["Paladin"] = { "PaladinProtEH", "PaladinRetDPS", "PaladinHEP" }

VRB_WEIGHTS["PaladinRetDPS"] = {
  ["STR"]         = 0.1428571428571429,
  ["AGI"]         = 0.1020,
  ["CRIT"]        = 2.04,
  ["TOHIT"]       = { 5.6, 100, 0 },
  ["ATTACKPOWER"] = 0.0714285714285714
}

VRB_WEIGHTS["PaladinHEP"] = {
  ["INT"]       = 1.00,
  ["MANAREG"]   = 1.91,
  ["HEAL"]      = 1.00,
  ["SPELLCRIT"] = 20.34,
  ["SPI"]       = 0.00
}

VRB_WEIGHTS["PaladinProtEH"] = {
  ["ARMOR"]   = 0.51416,
  ["STA"]     = 10.14596,
  ["AGI"]     = 1.02832,
  ["STR"]     = 0.05,
  ["DODGE"]   = 0,
  ["PARRY"]   = 0,
  ["DEFENSE"] = 0.08,
  ["BLOCK"]   = 0.04
}
