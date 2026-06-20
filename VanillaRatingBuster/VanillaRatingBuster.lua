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
  local class = UnitClass("player")

  ratings = VRB_LABELS[class]
  if ratings then
    return ratings
  end
  return {}

end


function VRBCalculateRating(weightTable, bonuses)

  local baseScore = 0
  local weightTypes = VRB_WEIGHTS[weightTable]

  for t,w in pairs(weightTypes) do
    
    -- Reset currentBonus at the start of every stat iteration to prevent state leaks
    local currentBonus = 0

    if (BonusScanner.bonuses and BonusScanner.bonuses[t]) then
      currentBonus = BonusScanner.bonuses[t]
    end

    if(bonuses[t]) then
      -- Now check if the weight is a compound structure; has a threshold
      if type(w) == "table" then  -- Changed from istable(w) to standard Lua for safety
        local threshold = w[1]
        local beforeWeight = w[2]
        local afterWeight = w[3]
        
        if tonumber(currentBonus) < tonumber(threshold) then
          baseScore = baseScore + ( bonuses[t] * beforeWeight )
        else
          baseScore = baseScore + ( bonuses[t] * afterWeight )
        end
      else
        baseScore = baseScore + ( bonuses[t] * w )
      end
    end

  end

  return VRBRound(baseScore, 2)

end


----------------------------------------------------------------------
-- Equipped-item comparison
----------------------------------------------------------------------

-- Maps an item's INVTYPE_* equip location to one or more comparison
-- "groups". Each group is a list of slot IDs whose bonuses get merged
-- together before scoring -- a single slot for most gear, but two slots
-- for a 2H weapon being compared against a current dual-wield setup.
local function VRB_BuildSlotMap()
  local function id(slotName)
    local slotID = GetInventorySlotInfo(slotName)
    return slotID
  end

  local mainHand = id("MainHandSlot")
  local offHand = id("SecondaryHandSlot")

  return {
    [INVTYPE_HEAD]          = { { slots = { id("HeadSlot") }, label = "equipped" } },
    [INVTYPE_NECK]          = { { slots = { id("NeckSlot") }, label = "equipped" } },
    [INVTYPE_SHOULDER]      = { { slots = { id("ShoulderSlot") }, label = "equipped" } },
    [INVTYPE_CLOAK]         = { { slots = { id("BackSlot") }, label = "equipped" } },
    [INVTYPE_CHEST]         = { { slots = { id("ChestSlot") }, label = "equipped" } },
    [INVTYPE_ROBE]          = { { slots = { id("ChestSlot") }, label = "equipped" } },
    [INVTYPE_WRIST]         = { { slots = { id("WristSlot") }, label = "equipped" } },
    [INVTYPE_HAND]          = { { slots = { id("HandsSlot") }, label = "equipped" } },
    [INVTYPE_WAIST]         = { { slots = { id("WaistSlot") }, label = "equipped" } },
    [INVTYPE_LEGS]          = { { slots = { id("LegsSlot") }, label = "equipped" } },
    [INVTYPE_FEET]          = { { slots = { id("FeetSlot") }, label = "equipped" } },
    [INVTYPE_FINGER]        = { { slots = { id("Finger0Slot") }, label = "Ring 1" }, { slots = { id("Finger1Slot") }, label = "Ring 2" } },
    [INVTYPE_TRINKET]       = { { slots = { id("Trinket0Slot") }, label = "Trinket 1" }, { slots = { id("Trinket1Slot") }, label = "Trinket 2" } },
    [INVTYPE_WEAPON]        = { { slots = { mainHand }, label = "Main Hand" }, { slots = { offHand }, label = "Off Hand" } },
    -- 2H replaces whatever's in BOTH hands, so compare against them combined
    -- (covers dual-wield -> 2H, and 1H+shield -> 2H)
    [INVTYPE_2HWEAPON]      = { { slots = { mainHand, offHand }, label = nil, dynamicLabel = true } },
    [INVTYPE_WEAPONMAINHAND]= { { slots = { mainHand }, label = "equipped" } },
    [INVTYPE_WEAPONOFFHAND] = { { slots = { offHand }, label = "equipped" } },
    [INVTYPE_SHIELD]        = { { slots = { offHand }, label = "equipped" } },
    [INVTYPE_HOLDABLE]      = { { slots = { offHand }, label = "equipped" } },
    [INVTYPE_RANGED]        = { { slots = { id("RangedSlot") }, label = "equipped" } },
    [INVTYPE_RELIC]         = { { slots = { id("RangedSlot") }, label = "equipped" } },
  }
end

local VRB_SLOT_MAP = nil

local function VRB_GetComparisonSlots(link)
  if not VRB_SLOT_MAP then
    VRB_SLOT_MAP = VRB_BuildSlotMap()
  end
  if not link then
    return nil
  end
  local _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(link)
  if not equipLoc then
    return nil
  end
  return VRB_SLOT_MAP[equipLoc]
end

-- Hidden tooltip used only to scan an equipped item's stat lines; never shown
-- on screen, exists purely so BonusScanner can read its text lines.
local VRBScanTooltip = CreateFrame("GameTooltip", "VRBScanTooltip", UIParent, "GameTooltipTemplate")

local function VRB_CopyTable(t)
  local copy = {}
  for k, v in pairs(t) do
    copy[k] = v
  end
  return copy
end

local function VRB_MergeBonusesInto(target, source)
  for k, v in pairs(source) do
    target[k] = (target[k] or 0) + v
  end
end

-- Returns itemLink, bonusesTable for whatever is currently in the given
-- inventory slot, or nil, nil if the slot is empty.
local function VRB_GetSlotBonuses(slotID)
  if not slotID then
    return nil, nil
  end

  local link = GetInventoryItemLink("player", slotID)
  if not link then
    return nil, nil
  end

  BonusScanner.temp.sets = {}
  BonusScanner.temp.set = ""
  BonusScanner.temp.bonuses = {}
  BonusScanner.temp.slot = ""

  VRBScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
  VRBScanTooltip:SetInventoryItem("player", slotID)

  local lines = VRBScanTooltip:NumLines()
  for i = 1, lines do
    local fs = getglobal("VRBScanTooltipTextLeft"..i)
    if fs and fs:GetText() then
      BonusScanner:ScanLine(fs:GetText())
    end
  end

  VRBScanTooltip:Hide()

  return link, VRB_CopyTable(BonusScanner.temp.bonuses)
end

-- Returns hasAnyItem, mergedBonuses, occupiedCount across every slot in the
-- group (e.g. main+off hand combined for a 2H comparison).
local function VRB_GetGroupBonuses(slotIDs)
  local merged = {}
  local occupiedCount = 0
  for _, slotID in ipairs(slotIDs) do
    local link, bonuses = VRB_GetSlotBonuses(slotID)
    if link then
      occupiedCount = occupiedCount + 1
      VRB_MergeBonusesInto(merged, bonuses)
    end
  end
  return occupiedCount > 0, merged, occupiedCount
end


VRBItemScoreTooltip = CreateFrame( "Frame" , "VRBItemScoreTooltip", GameTooltip )
VRBItemScoreTooltip:SetScript("OnShow", function (self)
    local itemLevel = nil
    local itemRarity = nil
    local itemSlot = nil
    local itemName = nil
    local itemID = nil
    local bonuses = nil
    local tmpTxt, line;
    local lines = GameTooltip:NumLines();
    local hasScoreToShow = false
    local vrbscore = 0
    local normalizedLabel = nil

    BonusScanner.temp.sets = {};
    BonusScanner.temp.set = "";
    BonusScanner.temp.bonuses = {};
    BonusScanner.temp.slot = "";

    local lbl = getglobal("GameTooltipTextLeft1")
    if lbl then

      for i=2, lines, 1 do
        tmpText = getglobal("GameTooltipTextLeft"..i);
        val = nil;
        if (tmpText:GetText()) then
          line = tmpText:GetText();
          BonusScanner:ScanLine(line);
        end
      end

      bonuses = BonusScanner.temp.bonuses;

      if(bonuses) then

        local ratings = VRBGetValidRatings()
        local className, classFileName = UnitClass("player")
        local color = RAID_CLASS_COLORS[classFileName]

        local _, hoveredLink = GameTooltip:GetItem()
        local comparisonSlots = VRB_GetComparisonSlots(hoveredLink)

        for _, r in ipairs(ratings) do
          if VRBIsRatingEnabled(r) then
            vrbscore = VRBCalculateRating(r, bonuses)
            if vrbscore > 0 then
              normalizedLabel = string.gsub(r, className, "")
              -- GameTooltip:AddLine(normalizedLabel .. ": " .. vrbscore, color.r, color.g, color.b)
              GameTooltip:AddDoubleLine(normalizedLabel .. ": ", vrbscore , color.r, color.g, color.b, color.r, color.g, color.b)
              hasScoreToShow = true

              if comparisonSlots then
                for _, group in ipairs(comparisonSlots) do
                  local hasItem, eqBonuses, occupiedCount = VRB_GetGroupBonuses(group.slots)
                  if hasItem then
                    local eqScore = VRBCalculateRating(r, eqBonuses)
                    local diff = VRBRound(vrbscore - eqScore, 2)
                    local diffText = (diff >= 0 and "+" or "") .. diff
                    local diffR, diffG, diffB = 1, 1, 1
                    if diff > 0 then
                      diffR, diffG, diffB = 0, 1, 0
                    elseif diff < 0 then
                      diffR, diffG, diffB = 1, 0.2, 0.2
                    end

                    local slotLabel = group.label
                    if group.dynamicLabel then
                      slotLabel = (occupiedCount > 1) and "Main + Off Hand" or "Main Hand"
                    end

                    GameTooltip:AddDoubleLine("  vs " .. slotLabel .. ":", diffText, 0.8, 0.8, 0.8, diffR, diffG, diffB)
                  end
                end
              end
            end
          end
        end

        if hasScoreToShow then
          GameTooltip:Show()
        end

      end

    end

  end)


SLASH_VRBSCORE1, SLASH_VRBSCORE2 = '/vrb';
SlashCmdList["VRBSCORE"] = function(msg)
  if VRB_ToggleOptions then
    VRB_ToggleOptions()
  end
end