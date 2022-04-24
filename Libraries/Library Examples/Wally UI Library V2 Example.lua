do pcall(function()
  for _,sg in pairs(game:GetService("CoreGui"):GetChildren()) do
    if sg.Name == "ScreenGui" then
      sg:Remove()
    end
  end
 end)
end

local Library = loadstring(game:HttpGet("https://pastebin.com/raw/tV5XWC7p", true))()
local Window = Library:CreateWindow('Example')
local WS = game:GetService("Workspace")
local PLRS = game:GetService("Players")
local LP = PLRS.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local rS = game:GetService("RunService")

Window:Section('Top')

Window:Toggle('Example Toggle', {flag = "toggle1"}, function()
end)

Window:Button("Example Button", function()
   print(w.flags.toggle1)
end)


Window:Slider("FOV", {
   min = math.floor(workspace.CurrentCamera.FieldOfView);
   max = 120;
   flag = ""
}, function()
end)

Window:Box('WalkSpeed', {
   flag = "ws";
   type = "Number";
}, function(new, old, enter)
   print(new, old, enter)
end)

Window:SearchBox("gamers", {
   location = shared;
   flag = "memes";
   list = {
       "kiriot";
       "magikmanz";
       "gamer vision";
       "ironbrew";
       "wally";
       "firefox";
       "this is epic";
   }
}, warn)

Window:Dropdown("locations", {
   location = _G;
   flag = "memes";
   list = {
       "jewelryin";
       "jewelryout";
       'bank';
       'gas';
       'prison';
       'crimbase1';
       'crimbase2';
   }
}, function(new)
   warn(new)
   print(_G.memes)
end)

Window:Bind("Kill Player", {
   flag = "killbind";
   kbonly = true;
   default = Enum.KeyCode.RightAlt;
}, function()
   game.Players.LocalPlayer.Character:BreakJoints()
end)