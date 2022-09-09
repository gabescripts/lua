do pcall(function()
  for _,sg in pairs(game:GetService("CoreGui"):GetChildren()) do
    if sg.Name == "ScreenGui" then
      sg:Remove()
    end
  end
end) end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/gabescripts/lua/scripts/Test.lua"))()
local Window = Library:New({Name = "Game Name", FolderToSave = "SolarisLibStuff"})

local Tab1 = Window:Tab("Tab 1")
local Section1 = Tab1:Section("Toggles Section")

local Services = setmetatable({}, {__index = function(t, i) return game:GetService(i) end})
local Client = Services.Players.LocalPlayer

local LabelText = Section1:Label("Toggle Label Text")

Section1:Toggle("Toggle", false, "Toggle", function(t) print(t) end)

local setslider = 0
local NumVal = Instance.new("NumberValue")
local Check = Section1:Slider(string.format("Slider: %i", setslider), 0, 25, setslider, 0.5, "Slider", function(t) 
  setslider = t;
  NumVal.Value = setslider
end)
NumVal:GetPropertyChangedSignal("Value"):Connect(function()
  Check:Set(setslider, string.format("Slider: %i", setslider))
end)

local Section2 = Tab1:Section("Player Section")
local PlayerList = {}
for _, player in next, Services.Players:GetPlayers() do
  if player ~= Client then
    table.insert(PlayerList, player.Name)
  end
end
table.sort(PlayerList, function(a, b) return a < b end)
local PlayerDropdown = Section2:Dropdown("Select Player", PlayerList, PlayerList[1], "Dropdown", function(t)
  print(t)
end)
local MultiDropdown = Section2:MultiDropdown("Whitelist", PlayerList, {PlayerList[1]},"Dropdown", function(t)
  print(table.concat(t, ", "))
end)

local Section3 = Tab1:Section("Others Section")
Section3:Colorpicker("Colorpicker", Color3.fromRGB(255, 255, 255), "Colorpicker", function(t) print(t) end)
Section3:Textbox("Textbox", false, function(t) print(t) end)

Section3:Bind("Hold Bind", Enum.KeyCode.E, true, "BindHold", function(t) print(t) end)
Section3:Bind("Teleport Key", Enum.KeyCode.Q, false, "BindNormal", function() if Mouse.Target then Client.Character.HumanoidRootPart.CFrame = Client.Character.HumanoidRootPart.CFrame.Rotation + Vector3.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z) end end)

Section3:Button("Notification", function() Library:Notification("Test", "This is a notification test.") end)
Section3:Button("SetKey", function() Check:Set(8) end)
Section3:Button("Rejoin", function() Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId) end)

--[[
  SolarisLib:New({
    Name - Title of the UI <string>
    FolderToSave - Name of the folder where the UI files will be stored <string>
  })

  win:Tab(title <string>)
  tab:Section(title <string>)
  Section1:Button(title <string>, callback <function>)
  Section1:Toggle(title <string>,default <boolean>, flag <string>, callback <function>)
  toggle:Set(state <boolean>)
  slider:Set(state <number>)
  Dropdown:Refresh(options <table>, deletecurrent <boolean>)
  Dropdown:Set(option <string>)
  Section1:Slider(title <string>,minimum <number>,max <number>,default <number>,increment <number>, flag <string>, callback <function>)
  Section1:Dropdown(title <string>,options <table>,default <string>, flag <string>, callback <function>)
  Section1:MultiDropdown(title <string>,options <table>,default <table>, flag <string>, callback <function>)
  Dropdown:Refresh(options <table>, deletecurrent <boolean>)
  Dropdown:Set(option <table>)
  Section1:Colorpicker(title <string>, default <color3>, flag <string>, callback <function>)
  Section1:Textbox(title <string> ,disappear <boolean>, callback <function>)
  Section1:Bind(title <string>, default <keycode>, hold <boolean>, flag <string>, callback <function>)
  bind:Set(state <keycode>)
  Section1:Label(text <string>)
  label:Set(text <string>)
]]--