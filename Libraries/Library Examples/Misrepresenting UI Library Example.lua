local game = game
if (not game.IsLoaded(game)) then
    game.Loaded.Wait(game.Loaded)
end

local GetService = game.GetService
local RunService = GetService(game, "RunService")
local Players = GetService(game, "Players")
local GetPlayers = Players.GetPlayers
local UserInputService = GetService(game, "UserInputService")
local Workspace = GetService(game, "Workspace")
local HttpService = GetService(game, "HttpService")

local UILibrary = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/fatesc/fates-esp/main/ui.lua"))()
local UI = UILibrary.new(Color3.fromRGB(255, 79, 87))

local Window = UI:LoadWindow('<font color="#00FF00">gabes</font> ui', UDim2.fromOffset(400, 279))

local ESP = Window.NewPage("Window1")

local TracersSection = ESP.NewSection("Tracers")
local EspSection = ESP.NewSection("Other")

Window.SetPosition(UDim2.new(0.5, -200, 0.5, -139))

TracersSection.Toggle("Enable Tracers", false, function(Callback)
end)
TracersSection.Dropdown("To", {"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"}, function(Callback)
end)
TracersSection.Dropdown("From", {"Top", "Bottom", "Left", "Right"}, function(Callback)
end)

TracersSection.Slider("Tracer Transparency", {Min = 0, Max = 1, Default = 0, Step = .1}, function(Callback)
end)
TracersSection.Slider("Tracer Thickness", {Min = 0, Max = 5, Default = 0, Step = .1}, function(Callback)
end)

EspSection.Toggle("Team Colors", false, function(Callback)
end)
EspSection.ColorPicker("Esp Color", Color3.fromRGB(20, 226, 207), function(Callback)
end)
EspSection.Toggle("Show Names", false, function(Callback)
end)
EspSection.Toggle("Show Health", false, function(Callback)
end)
EspSection.Toggle("Show Distance", false, function(Callback)
end)
EspSection.Slider("Render Distance", {Min = 0, Max = 7000, Default = 0, Step = 10}, function(Callback)
end)
EspSection.Dropdown("Team", {"Allies", "Enemies", "All"}, function(Callback)
end)
EspSection.Toggle("Box Esp", false, function(Callback)
end)
EspSection.Slider("Box Thickness", {Min = 0, Max = 5, Default = 0, Step = .1}, function(Callback)
end)
EspSection.Slider("Box Transparency", {Min = 0, Max = 1, Default = 0, Step = .1}, function(Callback)
end)