do pcall(function()
  for _,sg in pairs(game:GetService("CoreGui"):GetChildren()) do
    if sg.Name == "ScreenGui" then
      sg:Remove()
    end
  end
end) end

local Library = loadstring(game:HttpGet("https://pastebin.com/raw/yCyDsrwR", true))()
local Window = Library:CreateWindow("Window")
local Players = game:GetService("Players")
local plrlist = {}
local selectedplayer = ""

for _,ppl in pairs(Players:GetPlayers()) do
  if ppl.DisplayName ~= ppl.Name then
    table.insert(plrlist, ppl.DisplayName.."/"..ppl.Name)
  elseif ppl.DisplayName == ppl.Name then
    table.insert(plrlist, ppl.Name)
  end
  table.sort(plrlist,
  function(a, b)
    return a:lower() < b:lower()
  end)
end

local Fold = Window:AddFolder("Folder")
local changed = Window:AddLabel({text = "Label"})
Window:AddButton({text = "Button", flag = "button", callback = function() 
  changed:SetText("HEHE")
end})
Fold:AddToggle({text = "Toggle", flag = "toggle", state = false, callback = function(a) print(a) end})
Window:AddToggle({text = "Toggle", flag = "toggle1", state = true, callback = function(a) print(a) end})

local locallist = Window:AddList({
  text = "Player List:",
  flag = "list",
  value = "Value",
  values = plrlist,
  callback = function(a)
    if a:match("/") then
      selectedplayer = string.split(a, "/")[2]
    elseif not a:match("/") then
      selectedplayer = a
    end
    print(selectedplayer)
  end
})
Window:AddButton({text = "Button", callback = function() 
  locallist:RemoveValue("HEHE")
  locallist:RemoveValue("HI")
end})

Window:AddBox({text = "Box", flag = "box", value = "Value", callback = function(a) print(a) end})
Window:AddSlider({text = "Slider", flag = "slider", value = 100, min = 20, max = 200, float = 0.3, callback = function(a) print(a) end})
Window:AddSlider({text = "Slider", flag = "slider1", value = 0, min = -50, max = 100, callback = function(a) print(a) end})
Window:AddBind({text = "Bind", flag = "bind", key = "MouseButton1", callback = function() print"pressed" end})
Window:AddBind({text = "Bind", flag = "bind", hold = true, key = "E" , callback = function(a) if a then print"let go" else print"holding" end end})
Window:AddBind({text = "Toggle UI", key = "RightShift", callback = function() Library:Close() end})
Window:AddColor({text = "Color", flag = "color", color = Color3.fromRGB(255, 65, 65), callback = function(a) print(a) end})
Window:AddColor({text = "Color", flag = "color", color = {1, 0.2, 0.2}, callback = function(a) print(a) end})

Library:Init()

Players.PlayerRemoving:Connect(function(plr)
  for i,v in pairs(plrlist) do
    if string.match(v, "/") then
      if string.split(v, "/")[2] == plr.Name then
        table.remove(plrlist, i)
        locallist:RemoveValue(v)
      end
    elseif not string.match(v, "/") then
      if v == plr.Name then
        table.remove(plrlist, i)
        locallist:RemoveValue(v)
      end
    end
  end
  table.sort(plrlist,
  function(a, b) 
    return a:lower() < b:lower()
  end)
end)

Players.PlayerAdded:Connect(function(plr)
  table.insert(plrlist, plr.Name)
  locallist:AddValue(plr.Name)
  table.sort(plrlist, 
    function(a, b) 
      return a:lower() < b:lower()
  end)
end)

--// Key can also be Enum.KeyCode.E, instead of the name/string
--// Flags can be useful for a lot of stuff, get creative with them :)
--// You can also get the value/state/key from each option if they're defined
--// To close/open the UI (after it's been initialized) use Library:Close() to toggle it, use the keybind option to quickly make a toggle for it without hassle (there is an example below)
--// There is a special property for windows which can be set to false (Window.canInit = false), if done so the window will not be initialized when Library:Init() is called
--// All options will by default have their flag names set to whatever the text is, unless the flag is set
--// Folders can be used exactly like windows, they can hold all the options, you can even put folders inside of folders inside of folders.. and so on
--// If the state is set to true by default then it will fire the callback when the library is initialized
--// If the set value is not in the values table then it will get added to it
--// key can also be Enum.UserInputType.MouseButton1, instead of the name/string
--// Uses a table instead of a color value (each value has to range from 0 to 1, think of it as using Color3.new), useful for loading json encoded options from a save file

for i,v in next, game:GetDescendants() do
  if v:IsA("TextLabel") then
    if v.Text == "HI" then
      print(v:GetFullName())
    end
  end
end

for i,v in next, game.CoreGui:FindFirstChild("ScreenGui"):GetDescendants() do
  if v:IsA("TextLabel") then
    if v.Text:match("HI") then
      v:Destroy()
    end
  end
end
