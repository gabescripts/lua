local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/gabescripts/lua/scripts/Libraries/Uwuware%20V2/Gabe's%20Modified%20Source.lua"))()

--// Legit Section
local LegitTab = Library:AddTab("Legit")
local LegitColunm1 = LegitTab:AddColumn()
local LegitMain = LegitColunm1:AddSection("Aim Assist")

LegitMain:AddDivider("Main")
LegitMain:AddToggle({text = "Enabled", flag = "AimbotEnabled"})
LegitMain:AddSlider({text = "Aimbot FOV", flag = "AimbotFov", min = 0, max = 750, value = 105, suffix = "°"})
LegitMain:AddSlider({text = "Smoothing Factor", flag = "Smoothing", min = 0, max = 30, value = 3, suffix = "%"})
LegitMain:AddList({text = "Hit Box", flag = "AimbotHitbox", value = "Head", values = {"Head", "Torso"}})
LegitMain:AddList({text = "Aimbot Key", flag = "AimbotKey", value = "On Aim", values = {"On Aim", "On Shoot"}})
LegitMain:AddDivider("Draw Fov")

LegitMain:AddToggle({text = "Enabled", flag = "CircleEnabled"}):AddColor({flag = "CircleColor", color = Color3.new(1, 1, 1)})
LegitMain:AddSlider({text = "Num Sides", flag = "CircleNumSides", min = 3, max = 48, value = 48, suffix = "°"})

local LegitSecond = LegitColunm1:AddSection("Extend Hitbox")
LegitSecond:AddDivider("Main")
LegitSecond:AddToggle({text = "Enabled", flag = "HitboxEnabled"})
LegitSecond:AddList({text = "Hit Box", flag = "ExtendHitbox", value = "Head", values = {"Head", "Torso"}})
LegitSecond:AddSlider({text = "Extend Rate", flag = "ExtendRate", min = 0, max = 10, value = 10, suffix = "%"})

local LegitThird = LegitColunm1:AddSection("Trigger Bot")
LegitThird:AddDivider("Main")
LegitThird:AddToggle({text = "Enabled", flag = "TriggerEnabled"}):AddBind({flag = "TriggerBind", key = "One"});
LegitThird:AddSlider({text = "Trigger Speed", flag = "TriggerSpeed", min = 0, max = 1000, value = 10, suffix = "%"})

local LegitColunm2 = LegitTab:AddColumn();
local LegitForth = LegitColunm2:AddSection("Bullet Redirection")
LegitForth:AddDivider("Main")
LegitForth:AddToggle({text = "Enabled", flag = "SilentAimEnabled"})
LegitForth:AddSlider({text = "Silent Aim FOV", flag = "SilentAimFOV", min = 0, max = 750, value = 105, suffix = "°"})
LegitForth:AddSlider({text = "Hit Chances", flag = "HitChances", min = 0, max = 100, value = 100, suffix = "%"})
LegitForth:AddList({text = "Redirection Mode", flag = "RedirectionMode", value = "P Mode", values = {"P Mode", "Normal Mode"}})
LegitForth:AddList({text = "Hit Box", flag = "SilentAimHitbox", value = "Head", values = {"Head", "Torso"}})
LegitForth:AddDivider("Draw Fov")
LegitForth:AddToggle({text = "Enabled", flag = "Circle2Enabled"}):AddColor({flag = "Circle2Color", color = Color3.new(1, 1, 1)})
LegitForth:AddSlider({text = "Num Sides", flag = "Circle2NumSides", min = 3, max = 48, value = 48, suffix = "°"})
LegitForth:AddDivider("Checks")
LegitForth:AddToggle({text = "Enabled", flag = "VisibleCheck"})

local LegitFifth = LegitColunm2:AddSection("Recoil Control")
LegitFifth:AddDivider("Main")
LegitFifth:AddToggle({text = "Enabled", flag = "RecoilControlEnabled"})
LegitFifth:AddSlider({text = "Model Kick", flag = "ModelKick", min = 5, max = 100, value = 100, suffix = "%"})
LegitFifth:AddSlider({text = "Camera Kick", flag = "CameraKick", min = 5, max = 100, value = 100, suffix = "%"})

--// Rage Section
local RageTab = Library:AddTab("Blatant"); 
local RageColunm1 = RageTab:AddColumn();
local RageMain = RageColunm1:AddSection("Auto Wall")

RageMain:AddDivider("Main");
RageMain:AddToggle{text = "Enabled", flag = "AutoWallEnabled"}

--// Visuals Section
local VisualsTab = Library:AddTab("Visuals")
local VisualsColunm1 = VisualsTab:AddColumn()
local VisualsMain = VisualsColunm1:AddSection("Local Visuals")

VisualsMain:AddDivider("Main")
VisualsMain:AddToggle({text = "Enabled", flag = "LocalVisualsEnabled"})
VisualsMain:AddToggle({text = "Custom Arm", flag = "CustomArm"}):AddColor({flag = "ArmColor", color = Color3.new(0.599623620510101318359375, 0.447115242481231689453125, 0.97174417972564697265625)})
VisualsMain:AddSlider({text = "Transparency", flag = "ArmTransparency", min = 0.10, max = 0.95, float = 0.01, value = 0.85, suffix = "%"})
VisualsMain:AddList({text = "Material", flag = "ArmMaterial", value = "ForceField", values = {"ForceField", "Neon", "SmoothPlastic"}})
VisualsMain:AddToggle({text = "Custom Weapon", flag = "CustomWeapon"}):AddColor({flag = "WeaponColor", color = Color3.new(1, 1, 1)})
VisualsMain:AddSlider({text = "Transparency", flag = "WeaponTransparency", min = 0.10, max = 0.95, float = 0.01, value = 0.85, suffix = "%"})
VisualsMain:AddList({text = "Material", flag = "WeaponMaterial", value = "ForceField", values = {"ForceField", "Neon", "SmoothPlastic"}})
VisualsMain:AddDivider("Mesh")
VisualsMain:AddToggle({text = "Enabled", flag = "TextureEnabled"})
VisualsMain:AddList({text = "Arm Animation", flag = "ArmAnimation", value = "Bubbles", values = {"Bubbles", "Scanning"}})
VisualsMain:AddList({text = "Weapon Animation", flag = "WeaponAnimation", value = "Bubbles", values = {"Bubbles", "Scanning"}})
VisualsMain:AddDivider("Third Person")
VisualsMain:AddToggle({text = "Enabled", flag = "ThirdPersonEnabled"}):AddColor({flag = "ThirdPersonColor", color = Color3.new(1, 1, 1)})
VisualsMain:AddList({text = "Material", flag = "ThirdPersonMaterial", value = "ForceField", values = {"ForceField", "SmoothPlastic"}})

local VisualsColunm2 = VisualsTab:AddColumn()
local VisualsSecond = VisualsColunm2:AddSection("Camera Visuals")

VisualsSecond:AddDivider("Main")
VisualsSecond:AddToggle({text = "Enabled", flag = "CameraVisualsEnabled"})
VisualsSecond:AddToggle({text = "Change Camera FOV", flag = "ChangeCameraFOV"})
VisualsSecond:AddSlider({text = "Camera FOV", flag = "CameraFOV", min = 10, max = 120, value = 120, suffix = "°"})
VisualsSecond:AddToggle({text = "Remove Round Lock", flag = "RemoveRoundLock"})
VisualsSecond:AddToggle({text = "No Camera Bob", flag = "NoCameraBob"})
VisualsSecond:AddToggle({text = "No Gun Bob", flag = "NoGunBob"})
VisualsSecond:AddToggle({text = "Remove Gun Scope", flag = "RemoveGunScope"})
VisualsSecond:AddToggle({text = "Anti Suppression", flag = "AntiSuppression"})

--// Settings
local SettingsTab = Library:AddTab("Settings")
local SettingsColumn = SettingsTab:AddColumn()
local SettingsColumn2 = SettingsTab:AddColumn()
local SettingSection = SettingsColumn:AddSection("Menu")
local ConfigSection = SettingsColumn2:AddSection("Configuration")
local Warning = Library:AddWarning({type = "confirm"})

SettingSection:AddBind({text = "Open/Close", flag = "UI Toggle", nomouse = true, key = "End", callback = function() Library:Close() end})
SettingSection:AddColor({text = "Accent Color", flag = "Menu Accent Color", color = Color3.fromRGB(0, 155, 0), callback = function(color)
  if Library.currentTab then Library.currentTab.button.TextColor3 = color end
  for _, theme in pairs(Library.theme) do
    theme[(theme.ClassName == "TextLabel" and "TextColor3") or (theme.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = color
  end
end})

local BackgroundImages = {Floral = "rbxassetid://5553946656", Flowers = "rbxassetid://6071575925", Circles = "rbxassetid://6071579801", Hearts = "rbxassetid://6073763717"}
local BackgroundList = SettingSection:AddList({text = "Background", max = 4, flag = "background", values = {"Floral", "Flowers", "Circles", "Hearts"}, value = "Floral", callback = function(v)
  if Library.main then Library.main.Image = BackgroundImages[v] end
end})
BackgroundList:AddColor({flag = "backgroundcolor", color = Color3.new(), callback = function(color)
  if Library.main then
    Library.main.ImageColor3 = color
  end
end, trans = 1, calltrans = function(trans)
  if Library.main then
    Library.main.ImageTransparency = 1 - trans
  end
end})
SettingSection:AddSlider({text = "Tile Size", min = 50, max = 500, value = 50, callback = function(size)
  if Library.main then Library.main.TileSize = UDim2.new(0, size, 0, size) end
end})
SettingSection:AddButton({text = "Discord", callback = function() end})
ConfigSection:AddBox({text = "Config Name", skipflag = true})
ConfigSection:AddList({text = "Configs", skipflag = true, value = "", flag = "Config List", values = Library:GetConfigs()})
ConfigSection:AddButton({text = "Create", callback = function()
  Library:GetConfigs()
  writefile(Library.foldername .. "/" .. Library.flags["Config Name"] .. Library.fileext, "{}")
  Library.options["Config List"]:AddValue(Library.flags["Config Name"])
end})
ConfigSection:AddButton({text = "Save", callback = function()
  local r, g, b = Library.round(Library.flags["Menu Accent Color"])
  Warning.text = "Are you sure you want to save the current settings to config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. Library.flags["Config List"] .. "</font>?"
  if Warning:Show() then
    Library:SaveConfig(Library.flags["Config List"])
  end
end})
ConfigSection:AddButton({text = "Load", callback = function()
  local r, g, b = Library.round(Library.flags["Menu Accent Color"])
  Warning.text = "Are you sure you want to load config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. Library.flags["Config List"] .. "</font>?";
  if Warning:Show() then
    Library:LoadConfig(Library.flags["Config List"]);
  end
end})
ConfigSection:AddButton({text = "Delete", callback = function()
  local r, g, b = Library.round(Library.flags["Menu Accent Color"])
  Warning.text = "Are you sure you want to delete config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. Library.flags["Config List"] .. "</font>?"
  if Warning:Show() then
    local config = Library.flags["Config List"]
    if table.find(Library:GetConfigs(), config) and isfile(Library.foldername .. "/" .. config .. Library.fileext) then
      Library.options["Config List"]:RemoveValue(config)
      delfile(Library.foldername .. "/" .. config .. Library.fileext)
    end
  end
end})

Library:Init()
Library:selectTab(Library.tabs[1])