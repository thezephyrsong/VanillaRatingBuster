-- weights/Shaman.lua

VRB_LABELS["Shaman"] = { "ShamanHEP", "ShamanMelee" }

VRB_WEIGHTS["ShamanHEP"] = {
  ["INT"]       = 0.20,
  ["MANAREG"]   = 1.00,
  ["HEAL"]      = 0.14,
  ["SPELLCRIT"] = 0.00,
  ["SPI"]       = 0.00
}

VRB_WEIGHTS["ShamanMelee"] = {
  ["STR"]         = 0.1428571428571429,
  ["AGI"]         = 0.1020,
  ["CRIT"]        = 2.04,
  ["TOHIT"]       = { 5.6, 2.04, 0 },
  ["ATTACKPOWER"] = 0.0714285714285714
}
