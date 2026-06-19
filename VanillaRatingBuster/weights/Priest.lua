-- weights/Priest.lua

VRB_LABELS["Priest"] = { "PriestHEP_2M", "PriestHEP_15M", "PriestHEP_TIG", "PriestShadowDPS_2M", "PriestShadowDPS_9M" }

VRB_WEIGHTS["PriestHEP_TIG"] = {
  ["INT"]       = 1.1607,
  ["MANAREG"]   = 3.5,
  ["HEAL"]      = 1,
  ["SPELLCRIT"] = 1.161317565,
  ["SPI"]       = 0.8275
}

VRB_WEIGHTS["PriestHEP_2M"] = {
  ["INT"]       = 2.322635135,
  ["MANAREG"]   = 3.5,
  ["HEAL"]      = 1,
  ["SPELLCRIT"] = 1.161317565,
  ["SPI"]       = 0.8275
}

VRB_WEIGHTS["PriestHEP_15M"] = {
  ["INT"]       = 0.4351,
  ["MANAREG"]   = 3.5,
  ["HEAL"]      = 1,
  ["SPELLCRIT"] = 1.161317565,
  ["SPI"]       = 0.8275
}

VRB_WEIGHTS["PriestShadowDPS_2M"] = {
  ["DMG"]        = 1,
  ["SHADOWDMG"]  = 1,
  ["INT"]        = 1.52,
  ["MANAREG"]    = 1.8,
  ["SPI"]        = 0.34,
  ["SPELLCRIT"]  = 1.25,
  ["SPELLTOHIT"] = { 8, 10.36, 0 },
}

VRB_WEIGHTS["PriestShadowDPS_9M"] = {
  ["DMG"]        = 1,
  ["SHADOWDMG"]  = 1,
  ["INT"]        = 0.4,
  ["MANAREG"]    = 2.81,
  ["SPI"]        = 0.09,
  ["SPELLCRIT"]  = 0.88,
  ["SPELLTOHIT"] = { 8, 10.02, 0 },
}
