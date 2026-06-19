-- weights/Druid.lua

VRB_LABELS["Druid"] = { "DruidFeralDPS-EP", "DruidTank-EP", "DruidThreat-EP", "DruidResto-EP" }

VRB_WEIGHTS["DruidResto-EP"] = {
  ["HEAL"]      = 1.00,
  ["DMG"]       = 1.00,
  ["INT"]       = 0.3,
  ["SPI"]       = 0.46,
  ["MANAREG"]   = 3.0,
  ["SPELLCRIT"] = 10,
  ["MANA"]      = 0.02,
}

VRB_WEIGHTS["DruidFeralDPS-EP"] = {
  ["AGI"]              = 2.76,
  ["ARMORPEN"]         = 0.5,
  ["ATTACKPOWER"]      = 1,
  ["CRIT"]             = 30.13,
  ["FERALATTACKPOWER"] = 1,
  ["HASTE"]            = 13.6,
  ["STR"]              = 2.64,
  ["TOHIT"]            = 31.85,
}

VRB_WEIGHTS["DruidTank-EP"] = {
  ["AGI"]              = 1.57,
  ["ARMOR"]            = 0.33,
  ["ARMORPEN"]         = 0.5,
  ["ATTACKPOWER"]      = 1,
  ["CRIT"]             = 25.8,
  ["DEFENSE"]          = 0.46,
  ["FERALATTACKPOWER"] = 1,
  ["HASTE"]            = 26.6,
  ["HEALTH"]           = 0.167,
  ["STA"]              = 2.2,
  ["STR"]              = 2.2,
  ["TOHIT"]            = 36.1
}

VRB_WEIGHTS["DruidThreat-EP"] = {
  ["AGI"]              = 1.57,
  ["ARMORPEN"]         = 0.5,
  ["ATTACKPOWER"]      = 1,
  ["CRIT"]             = 25.8,
  ["FERALATTACKPOWER"] = 1,
  ["HASTE"]            = 26.6,
  ["STR"]              = 2.2,
  ["TOHIT"]            = 36.1
}
