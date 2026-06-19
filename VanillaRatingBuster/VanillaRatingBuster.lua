scoredItemTypes = {
  INVTYPE_2HWEAPON, INVTYPE_CHEST, INVTYPE_CLOAK,
  INVTYPE_FEET, INVTYPE_FINGER, INVTYPE_HAND, INVTYPE_HEAD, INVTYPE_HOLDABLE,
  INVTYPE_LEGS, INVTYPE_NECK, INVTYPE_RANGED, INVTYPE_RELIC, INVTYPE_ROBE, INVTYPE_SHIELD,
  INVTYPE_SHOULDER, INVTYPE_TRINKET, INVTYPE_WAIST, INVTYPE_WEAPON,
  INVTYPE_WEAPONMAINHAND, INVTYPE_WEAPONOFFHAND, INVTYPE_WRIST,
  -- deDE
  "Schusswaffe", "Zauberstab", "Armbrust",
  -- enGB
  "Gun", "Wand", "Crossbow"
}

function istable(t)
  return type(t) == 'table'
end

function VRBRound(num, places)
  local mult = 10^(places or 0)
  return math.floor(num * mult + 0.5) / mult
end

function VRBCheckItemType(slot)
  for id, scoredSlot in pairs(scoredItemTypes) do
    if slot == scoredSlot then
      return true
    end
  end
  return nil
end

function VRBGetValidRatings()
  local ratings
  -- Proper 1.12 API call returns LocalizedName, EnglishUPPERCASEName
  local className, classFileName = UnitClass("player")

  ratings = VRB_LABELS[className]
  if ratings then
    return ratings
  end
  return {}
end

function VRBCalculateRating(weightTable, bonuses)
  local baseScore = 0
  local weightTypes = VRB_WEIGHTS[weightTable]

  -- Safety catch: if the weights table isn't loaded, return 0 instead of crashing
  if not weightTypes then return 0 end

  for t, w in pairs(weightTypes) do
    local itemBonus = bonuses[t]
    if itemBonus then
      if istable(w) then
        -- Threshold-based weight: { cap%, value_before_cap, value_after_cap }
        -- Compare against the player's currently equipped total for this stat,
        -- so we know whether the item pushes them toward or past the cap.
        local threshold    = w[1] or 0
        local beforeWeight = w[2] or 0
        local afterWeight  = w[3] or 0

        local equippedTotal = 0
        if BonusScanner and BonusScanner.bonuses and BonusScanner.bonuses[t] then
          equippedTotal = BonusScanner.bonuses[t]
        end

        if tonumber(equippedTotal) < tonumber(threshold) then
          baseScore = baseScore + (itemBonus * beforeWeight)
        else
          baseScore = baseScore + (itemBonus * afterWeight)
        end
      else
        baseScore = baseScore + (itemBonus * tonumber(w))
      end
    end
  end

  return VRBRound(baseScore, 2)
end

-- Hook into the game's tooltip via a child frame.
--
-- VRBItemScoreTooltip is parented to GameTooltip, so whenever GameTooltip:Show()
-- fires, OnShow also fires on this child frame. This lets us read the tooltip's
-- lines and append our own without ever replacing/wrapping a Blizzard function,
-- which means we never fight other addons over who hooks SetBagItem/SetInventoryItem
-- first or last load order.
--
-- BonusScanner:ScanLine(line) is a real per-line scanning method (confirmed in
-- BonusScanner.lua), so feeding it the tooltip's text lines directly is valid.

local VRB_isUpdating = false

VRBItemScoreTooltip = CreateFrame("Frame", "VRBItemScoreTooltip", GameTooltip)
VRBItemScoreTooltip:SetScript("OnShow", function(self)
    -- Prevent re-entrant calls (e.g. if AddDoubleLine below triggers another OnShow)
    if VRB_isUpdating then return end
    VRB_isUpdating = true

    if not BonusScanner then
        VRB_isUpdating = false
        return
    end

    local lines = GameTooltip:NumLines()

    -- Gate: only proceed if this looks like an item tooltip (has a name line).
    -- Unit tooltips, spell tooltips, etc. will still have GameTooltipTextLeft1
    -- but BonusScanner's line patterns simply won't match anything on those,
    -- so this is a soft guard rather than a strict one.
    local titleLine = getglobal("GameTooltipTextLeft1")
    if not titleLine or not titleLine:GetText() then
        VRB_isUpdating = false
        return
    end

    -- Reset scan state before reading this tooltip's lines
    BonusScanner.temp.sets = {}
    BonusScanner.temp.set = ""
    BonusScanner.temp.bonuses = {}
    BonusScanner.temp.slot = ""

    for i = 2, lines do
        local tmpText = getglobal("GameTooltipTextLeft" .. i)
        if tmpText and tmpText:GetText() then
            BonusScanner:ScanLine(tmpText:GetText())
        end
    end

    local bonuses = BonusScanner.temp.bonuses
    if bonuses then
        local ratings = VRBGetValidRatings()
        local className, classFileName = UnitClass("player")
        if not classFileName then classFileName = string.upper(className) end
        local color = RAID_CLASS_COLORS[classFileName] or { r=1, g=1, b=1 }

        local hasScoreToShow = false

        -- NOTE: Lua 5.0 (WoW 1.12) has no ipairs() global, use pairs() instead.
        for _, r in pairs(ratings) do
            local vrbscore = VRBCalculateRating(r, bonuses)
            if vrbscore > 0 then
                GameTooltip:AddDoubleLine(
                    r .. ": ",
                    vrbscore,
                    color.r, color.g, color.b,
                    color.r, color.g, color.b
                )
                hasScoreToShow = true
            end
        end

        if hasScoreToShow then
            GameTooltip:Show()
        end
    end

    VRB_isUpdating = false
end)

SLASH_VRBSCORE1, SLASH_VRBSCORE2 = '/vrb';