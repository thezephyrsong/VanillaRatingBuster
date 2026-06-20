-- VanillaRatingBusterOptions.lua
-- Adds: per-character SavedVariables, a checkbox GUI for picking which weight
-- profiles show on tooltips, and a draggable minimap button to open it.
-- Written for the Vanilla 1.12.1 API (no modern widget templates/timers).

VRBOptionsDB = VRBOptionsDB or {}

local VRB_DEFAULT_MINIMAP_POS = 220 -- degrees around the minimap, top-right-ish

local function VRB_CharKey()
  return UnitName("player") .. "-" .. GetRealmName()
end

----------------------------------------------------------------------
-- SavedVariables bootstrap / enabled-rating helpers
----------------------------------------------------------------------

local function VRB_EnsureDB()
  if not VRBOptionsDB.enabledRatings then
    VRBOptionsDB.enabledRatings = {}
  end
  if not VRBOptionsDB.minimap then
    VRBOptionsDB.minimap = { hide = false, minimapPos = VRB_DEFAULT_MINIMAP_POS }
  end

  local charKey = VRB_CharKey()
  if not VRBOptionsDB.enabledRatings[charKey] then
    VRBOptionsDB.enabledRatings[charKey] = {}
    -- Default: show every valid rating for this character until they opt out
    local ratings = VRBGetValidRatings()
    for _, r in ipairs(ratings) do
      VRBOptionsDB.enabledRatings[charKey][r] = true
    end
  end
end

-- Returns true unless the player has explicitly unchecked this rating
function VRBIsRatingEnabled(label)
  if not VRBOptionsDB or not VRBOptionsDB.enabledRatings then
    return true
  end
  local charKey = VRB_CharKey()
  local charTable = VRBOptionsDB.enabledRatings[charKey]
  if not charTable then
    return true
  end
  if charTable[label] == nil then
    -- New rating added (e.g. an addon update introduced a new spec profile)
    -- that this character hasn't seen before -- default it on.
    charTable[label] = true
    return true
  end
  return charTable[label]
end

local function VRB_SetRatingEnabled(label, enabled)
  VRB_EnsureDB()
  local charKey = VRB_CharKey()
  VRBOptionsDB.enabledRatings[charKey][label] = enabled
end

----------------------------------------------------------------------
-- Options frame
----------------------------------------------------------------------

local VRB_OptionsFrame = nil
local VRB_Checkboxes = {}

local function VRB_RefreshCheckboxes()
  local class, classFileName = UnitClass("player")
  local ratings = VRBGetValidRatings()

  for _, cb in ipairs(VRB_Checkboxes) do
    cb:Hide()
  end
  VRB_Checkboxes = {}

  local yOffset = -40
  for _, r in ipairs(ratings) do
    local cb = CreateFrame("CheckButton", "VRBOptionCheck"..r, VRB_OptionsFrame, "UICheckButtonTemplate")
    cb:SetPoint("TOPLEFT", 20, yOffset)
    cb:SetWidth(24)
    cb:SetHeight(24)

    local label = string.gsub(r, class, "")
    getglobal(cb:GetName().."Text"):SetText(label)

    cb:SetChecked(VRBIsRatingEnabled(r))
    cb.ratingLabel = r
    cb:SetScript("OnClick", function()
      VRB_SetRatingEnabled(this.ratingLabel, this:GetChecked() and true or false)
    end)

    table.insert(VRB_Checkboxes, cb)
    yOffset = yOffset - 26
  end

  local neededHeight = (-yOffset) + 30
  if neededHeight < 140 then
    neededHeight = 140
  end
  VRB_OptionsFrame:SetHeight(neededHeight)
end

local function VRB_CreateOptionsFrame()
  if VRB_OptionsFrame then
    return VRB_OptionsFrame
  end

  local f = CreateFrame("Frame", "VRBOptionsFrame", UIParent)
  f:SetWidth(260)
  f:SetHeight(140)
  f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  f:SetFrameStrata("DIALOG")
  f:SetMovable(true)
  f:EnableMouse(true)
  f:SetClampedToScreen(true)
  f:RegisterForDrag("LeftButton")
  f:SetScript("OnDragStart", function() this:StartMoving() end)
  f:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)

  f:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
  })

  local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", f, "TOP", 0, -16)
  title:SetText("VanillaRatingBuster")

  local subtitle = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  subtitle:SetPoint("TOP", title, "BOTTOM", 0, -4)
  subtitle:SetText("Show on tooltip (this character):")

  local closeButton = CreateFrame("Button", "VRBOptionsCloseButton", f, "UIPanelCloseButton")
  closeButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)

  f:Hide()
  VRB_OptionsFrame = f
  return f
end

function VRB_ToggleOptions()
  VRB_EnsureDB()
  local f = VRB_CreateOptionsFrame()
  if f:IsShown() then
    f:Hide()
  else
    VRB_RefreshCheckboxes()
    f:Show()
  end
end

----------------------------------------------------------------------
-- Minimap button
----------------------------------------------------------------------

local VRB_MinimapButton = nil

local function VRB_UpdateMinimapPosition()
  local angle = math.rad(VRBOptionsDB.minimap.minimapPos or VRB_DEFAULT_MINIMAP_POS)
  local radius = 80
  local x = math.cos(angle) * radius
  local y = math.sin(angle) * radius
  VRB_MinimapButton:ClearAllPoints()
  VRB_MinimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

local function VRB_CreateMinimapButton()
  if VRB_MinimapButton then
    return VRB_MinimapButton
  end

  local btn = CreateFrame("Button", "VRBMinimapButton", Minimap)
  btn:SetWidth(31)
  btn:SetHeight(31)
  btn:SetFrameStrata("MEDIUM")
  btn:SetFrameLevel(8)
  btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  btn:RegisterForDrag("LeftButton")

  local overlay = btn:CreateTexture(nil, "OVERLAY")
  overlay:SetWidth(53)
  overlay:SetHeight(53)
  overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
  overlay:SetPoint("TOPLEFT", btn, "TOPLEFT", 0, 0)

  local icon = btn:CreateTexture(nil, "BACKGROUND")
  icon:SetWidth(20)
  icon:SetHeight(20)
  icon:SetTexture("Interface\\Icons\\INV_Misc_Note_01")
  icon:SetPoint("CENTER", btn, "CENTER", 0, 1)

  btn:SetScript("OnClick", function()
    VRB_ToggleOptions()
  end)

  btn:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT")
    GameTooltip:AddLine("VanillaRatingBuster")
    GameTooltip:AddLine("Left-click: choose which weights show on tooltips", 1, 1, 1)
    GameTooltip:AddLine("Drag: move this button", 1, 1, 1)
    GameTooltip:Show()
  end)
  btn:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  btn:SetScript("OnDragStart", function()
    this:SetScript("OnUpdate", function()
      local mx, my = Minimap:GetCenter()
      local px, py = GetCursorPosition()
      local scale = Minimap:GetEffectiveScale()
      px, py = px / scale, py / scale
      local angle = math.atan2(py - my, px - mx)
      VRBOptionsDB.minimap.minimapPos = math.deg(angle)
      VRB_UpdateMinimapPosition()
    end)
  end)
  btn:SetScript("OnDragStop", function()
    this:SetScript("OnUpdate", nil)
  end)

  VRB_MinimapButton = btn
  return btn
end

----------------------------------------------------------------------
-- Init
----------------------------------------------------------------------

local VRB_OptionsInitFrame = CreateFrame("Frame")
VRB_OptionsInitFrame:RegisterEvent("ADDON_LOADED")
VRB_OptionsInitFrame:RegisterEvent("PLAYER_LOGIN")
VRB_OptionsInitFrame:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and arg1 ~= "VanillaRatingBuster" then
    return
  end

  VRB_EnsureDB()

  if not VRB_MinimapButton then
    VRB_CreateMinimapButton()
    VRB_UpdateMinimapPosition()
    if VRBOptionsDB.minimap.hide then
      VRB_MinimapButton:Hide()
    end
  end
end)
