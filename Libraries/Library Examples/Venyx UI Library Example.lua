do pcall(function()
  for _,sg in pairs(game:GetService("CoreGui"):GetChildren()) do
    if sg.Name == "Example GUI" then
      sg:Remove()
    end
  end
 end)
end

--// Locals

local library = loadstring(game:HttpGet("https://pastebin.com/raw/qwdPKKDN"))()
local Venyx = library.new("Example GUI", 5013109572)
local WS = game:GetService("Workspace")
local PLRS = game:GetService("Players")
local LP = PLRS.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local rS = game:GetService("RunService")
local plrs = {}

for _,ppl in pairs(PLRS:GetPlayers()) do
  table.insert(plrs, ppl.Name)
  table.sort(plrs,
  function(a, b)
    return a:lower() < b:lower()
  end)
end

PLRS.PlayerRemoving:Connect(function(plr)
  for i,v in pairs(plrs) do
    if v == plr.Name then
      table.remove(plrs, i)
      table.sort(plrs,
      function(a, b)
        return a:lower() < b:lower()
      end)
    end
  end
end)

PLRS.PlayerAdded:Connect(function(plr)
  table.insert(plrs, plr.Name)
  table.sort(plrs,
  function(a, b)
    return a:lower() < b:lower()
  end)
end)

--// Themes

local themes = {
  Background = Color3.fromRGB(24, 24, 24),
  Glow = Color3.fromRGB(0, 0, 0),
  Accent = Color3.fromRGB(10, 10, 10),
  LightContrast = Color3.fromRGB(20, 20, 20),
  DarkContrast = Color3.fromRGB(14, 14, 14),
  TextColor = Color3.fromRGB(255, 255, 255)
}

--// First Page

local Page = Venyx:addPage("Test", 5012544693)

local Section1 = Page:addSection("Section 1")
local Section2 = Page:addSection("Section 2")
local Section3 = Page:addSection("Section 3")

Section1:addToggle("Toggle", true, function(value)
  print("Toggled", value)
end)

Section1:addButton("Button", function()
  print("Clicked")
  Venyx:Notify("Notification", "Selected Player!")
end)

Section1:addTextbox("Notification", "Default", function(value, focusLost)
  print("Input", value)
  if focusLost then
    Venyx:Notify("Title", value)
  end
end)

Section2:addKeybind("Toggle Keybind", Enum.KeyCode.One, function()
  print("Activated Keybind")
  Venyx:toggle()
  end, function()
  print("Changed Keybind")
end)

Section2:addColorPicker("ColorPicker", Color3.fromRGB(50, 50, 50))
Section2:addColorPicker("ColorPicker2")

Section2:addSlider("Slider", 0, -100, 100, function(value)
  print("Dragged", value)
end)

Section2:addButton("Button")

--// Second Page
--// Theme Changer

local theme = Venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do
  colors:addColorPicker(theme, color, function(color3)
  Venyx:setTheme(theme, color3)
end)
end

--// Page Startup Selection

Venyx:SelectPage(Venyx.pages[1], true)