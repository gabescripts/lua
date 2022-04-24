local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GabrasticYT/Roblox/Exploit-Related/Libraries/SolarisLib%20UI%20Source.lua"))()
local Window = Library:New({Name = "SolarisLib", FolderToSave = "SolarisLibStuff"})

local Tab1 = Window:Tab("Tab 1")
local Section1 = Tab1:Section("Elements")

local Services = setmetatable({}, {__index = function(t, i) return game:GetService(i) end})
local Client = Services.Players.LocalPlayer

Section1:Button("Button", function()
  Library:Notification("Test", "This is a notification test.")
end)

Section1:Toggle("Toggle", false, "Toggle", function(t)
  print(t)
end)

Section1:Slider("Slider", 0, 25, 0, 2.5, "Slider", function(t)
  print(t)
end)

local PlayerList = {}
for _, player in next, Services.Players:GetPlayers() do
  if player ~= Client then
    table.insert(PlayerList, player.Name)
  end
end
table.sort(PlayerList, function(a, b) return a < b end)
local PlayerDropdown = Section1:Dropdown("Select Player", PlayerList, PlayerList[1], "Dropdown", function(t)
  print(t)
end)

local MultiDropdown = Section1:MultiDropdown("Multi Dropdown", {"a","b","c","d","e"},{"b", "c"},"Dropdown", function(t)
  print(table.concat(t, ", "))
end)

Section1:Colorpicker("Colorpicker", Color3.fromRGB(255,255,255), "Colorpicker", function(t)
  print(t)
end)

Section1:Textbox("Textbox", true, function(t)
  print(t)
end)

Section1:Bind("Hold Bind", Enum.KeyCode.E, true, "BindHold", function(t)
  print(t)
end)

Section1:Bind("Normal Bind", Enum.KeyCode.F, false, "BindNormal", function()
  print("Bind pressed")
end)

Section1:Button("Rejoin", function()
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

local LabelText = Section1:Label("Label")
local Tab2 = Window:Tab("Tab 2")

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
  Section1:Slider(title <string>,default <number>,max <number>,minimum <number>,increment <number>, flag <string>, callback <function>)
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