--[[
  made by gabrsaticyt

  READ FIRST IF U CARE:
  this script was released because they banned me from their game for skyrocketing
  to the leaderboard with the autofarm ive created and now u can too
  i left little notes here and there for you to read if youd like to learn how
  it works and stuff or learn to script the basics

  RATES YOU WILL GET WITH SCRIPT:
  i crunched the numbers and compared them to drone afkers here are there values
  so you should easily beat them in speed as you are delivery simulatiously
  and sorry didnt calculate the money earnings

  MY AUTOFARM: 45~ Boxes/min using 4 max drones
  DRONE AFK AUTOCLICK: 20~ Boxes/min using 4 max drones (assuming)

  THINGS I WANTED TO ADD BEFORE I GOT BANNED:
  if you know how to script it shouldnt be that hard but i was planning to add
  an autobuy everything if you had enough money if you were new to the game
  never had to since this script was tested when i was maxed already and fixing
  the auto packabox box combiner

  PACKABOX NOTE:
  below the script is an attempt i had at making a combine packabox automater
  the idea was too complicated and i had a couple attempts failed
  however if you get it working you could easily skyrocket to the leaderboard
  probly too op to share if u get it figured out

]]

do pcall(function()
  for _,sg in pairs(game:GetService("CoreGui"):GetChildren()) do
    if sg.Name == "Discord" then
      sg:Remove()
    end
  end
 end)
end

local Lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
local Window = Lib:Window("Delivery Simulator GUI")

local Server = Window:Server("Main UI", "http://www.roblox.com/asset/?id=6031075938")
local Server2 = Window:Server("Miscellaneous", "")

local Toggles = Server:Channel("Autofarm")
local Buttons = Server:Channel("User Stats")
local Teleports = Server:Channel("Teleports")
local PlayerTab = Server:Channel("Player List")
local Extra = Server:Channel("Extra")

local Features = Server2:Channel("Features")
local Tips = Server2:Channel("Tips")
local Credits = Server2:Channel("Credits")

local WS = game:GetService("Workspace")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RepStorage = game:GetService("ReplicatedStorage")
local BoxData = require(game.ReplicatedStorage.ItemData.Boxes)

local Alarm = WS.GameLogic.DropAlarms.WarningLight.Toggle
local Places = WS.GameLogic.DeliveryPoints

local PickupRemote = RepStorage.Remotes.PickupBox
local StackRemote = RepStorage.Remotes.StackRack
local InsertPack = RepStorage.Remotes.StackPackABox

local carrytoggle = false
local racktoggle = false
local packtoggle = false
local selltoggle = false

local autodeliver = false
local autorestock = false
local autocombine = false
local autoupgrade = false

local spawnedboxes = {} 
local rackedboxes = {}
local addedshelves = {}

local allowedboxes = {}
local plrlist = {}
local storeslist = {}

--// returns store list, basic stuffie
for _, store in pairs(WS.GameLogic.Stores:GetChildren()) do
  if store:FindFirstChild("Trigger") then
    table.insert(storeslist, store.Name .. " Store")
  end
end
local Carry = string.gsub(WS.GameLogic:FindFirstChild("CarryTrigger").Name, "Trigger", "")
table.insert(storeslist, Carry .. " Store")

--// returns players but in alphabetical order
for _,ppl in pairs(Players:GetPlayers()) do
  if ppl ~= LP then
    table.insert(plrlist, ppl.Name)
    table.sort(plrlist,
    function(a, b)
      return a:lower() < b:lower()
    end)
  end
end

--// returns leaderboard values if you are in there \\--
--// if i didnt get banned yet i wouldve added a way to show whos below/above you \\--
function updateboard(part)
  local LB = WS.GameLogic.Leaderboards:GetDescendants()
  local first, second = nil, nil

  for _, v in pairs(LB) do
    if v.Name == "Username" and v.Text == LP.Name then
      local board = v.Parent.Parent.Parent.Parent.Parent.Name
      local place = v.Parent.Number.Text
      if string.match(board:lower(), tostring(part):lower()) then
        first, second = board, place
      end
    end
  end

  return first, second
end

--// finds/returns the warehouse you are using so it works with anywhere \\--
function findspot()
  local WH = WS.GameLogic.Warehouses
  local foundplot = nil

  for i,v in pairs(WH:GetDescendants()) do
    if v:IsA("ObjectValue") and v.Name == "Owner" then
      if tostring(v.Value) == LP.Name then
        foundplot = v.Parent
      end
    end
  end
  return foundplot
end

if findspot() == nil then
  return Lib:Notification("NO PLOT DETECTED!", "For the script to work you need to already have claimed your plot so if you are seeing this message you have to re-execute the script.", "Okay")
end

addedshelves = findspot().Racks:GetChildren()

--// checks if holding/carrying boxes but ended up not using it tho i think \\--
function holdingbox()
  local Toggle = false
  local Value = LP.PlayerGui.Main.Carry.Capacity.Text
  local CarryCurrent = tonumber(string.split(Value, "/")[1])
  local CarryMax = tonumber(string.split(Value, "/")[2])

  if LP.Character:FindFirstChild("Boxes") == nil or CarryCurrent == 0 then
    Toggle = false
  else
    Toggle = true
  end

  return Toggle
end

--// checks if jacking/carrying boxes but ended up not using it tho i think \\--
--// but useful so the script doesnt run functions that arent suppose to ya get me? \\--
function holdingjack()
  local Toggle = false
  local Value = LP.PlayerGui.Main.Jack.Capacity.Text
  local JackCurrent = tonumber(string.split(Value, "/")[1])
  local JackMax = tonumber(string.split(Value, "/")[2])

  if LP.Character:FindFirstChild("Jack") == nil or JackCurrent == 0 then
    Toggle = false
  else
    Toggle = true
  end

  return Toggle
end

--// my own proximity check to see if teleported to deliverypoint is comfirned
function verify()
  local person = require(LP.PlayerScripts.ClientData).DeliveryPoint

  if person and LP.Character then
    local pos = (LP.Character.HumanoidRootPart.Position - person.Position).magnitude
    if pos < 15 then
      return true
    else
      return false
    end
  end
end

function sellbox()
  local delivered = false
  local SellRemote = RepStorage.Remotes.SellBox
  local person = require(LP.PlayerScripts.ClientData).DeliveryPoint 
  -- if variable person is patched then iterate through deliverypoints method

  if holdingjack() or selltoggle or not LP.Character or person == nil then return end

  if tonumber(string.split(LP.PlayerGui.Main.Carry.Capacity.Text, "/")[1]) >= tonumber(string.split(LP.PlayerGui.Main.Carry.Capacity.Text, "/")[2]) then
    selltoggle = true
    repeat wait()
      if not verify() then
        LP.Character.HumanoidRootPart.CFrame = person.CFrame + Vector3.new(0, 3, 0)
      end
      SellRemote:InvokeServer(require(LP.PlayerScripts.ClientData).DeliveryPoint)
    until tonumber(string.split(LP.PlayerGui.Main.Carry.Capacity.Text, "/")[1]) == 0 or person ~= require(LP.PlayerScripts.ClientData).DeliveryPoint
    selltoggle = false
  end
  --// for if they add proximity checks on pickupbox remote \\--
  --[[ 
  if not selltoggle and not delivered then
    delivered = false
    repeat wait()
      LP.Character.HumanoidRootPart.CFrame = findspot().Teleport.CFrame
      delivered = true
    until delivered
  end
  ]]--
end

--// my first method of tracking all the racked boxes but the reason
--// this was inefficient since it did not include boxes that were added by drones

function returnboxes()
  local foundboxes = {}

  for _, found in pairs(addedshelves) do
    for _, box in pairs(found["Boxes"]:GetChildren()) do
      table.insert(foundboxes, box)
    end
  end

  return foundboxes
end

function checkeven(num)
  if type(num) ~= "number" then return end
  return num % 2 == 0
end

--// returns the available shelf with space \\--
function availableshelf(t)
  local foundshelf = {}
  local Max

  for _, shelf in pairs(addedshelves) do
    for _, found in pairs(shelf:GetChildren()) do
      if found.Name == "Boxes" then
        if found.Parent:FindFirstChild("Center") ~= nil then
          Max = tonumber(string.split(found.Parent:FindFirstChild("Center").RackCapacity.Capacity.Text, "/")[2])
          local Shelf = found:GetChildren()
          if #Shelf < Max then
            table.insert(foundshelf, found.Parent)
          end
        end
      end
    end
  end

  if t == "max" then
    if checkeven(Max) then
      if Max > 40 then return 10 end
      return Max / 2
    else
      if Max > 40 then return 10 end
      return Max / 3
    end
  elseif t == "shelf" then
    if #foundshelf == 0 then return end
    return foundshelf[math.random(1, #foundshelf)]
  end
end

--// since the tables are empty this will add them values atm \\--
rackedboxes = returnboxes()
spawnedboxes = WS.GameLogic.SpawnedBoxes:GetChildren()

function bestspawned()
  if #spawnedboxes == 0 then return end
  if #spawnedboxes >= 1 then
    return spawnedboxes[1]
  end
end

function bestracked()
  if #rackedboxes == 0 then return end
  if #rackedboxes >= 1 then
    return rackedboxes[1]
  end
end

function getspawnedbox()
  local Return = RepStorage.Remotes.ReturnBoxes

  if not autorestock or carrytoggle or availableshelf("shelf") == nil or #spawnedboxes == 0 then return end
  if racktoggle or not LP.Character then return end

  if #spawnedboxes <= 0 then
    warn("No Available Boxes Spawned!")
  elseif availableshelf("shelf") == nil then
    warn("All Shelves Are Full!")
  else
    racktoggle = true
    warn("Shelves Empty, Collecting Spawned Boxes!")
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(-465.96, 1.82, 557.36)
    repeat wait()
      PickupRemote:InvokeServer(bestspawned())
      PickupRemote:InvokeServer(spawnedboxes[math.random(1, #spawnedboxes + 1)])
      PickupRemote:InvokeServer(bestspawned())
      PickupRemote:InvokeServer(spawnedboxes[math.random(1, #spawnedboxes + 1)])
      PickupRemote:InvokeServer(bestspawned())
      PickupRemote:InvokeServer(spawnedboxes[math.random(1, #spawnedboxes + 1)])
      wait()
      StackRemote:InvokeServer(availableshelf("shelf"))
      LP.Character.HumanoidRootPart.CFrame = CFrame.new(-465.96, 1.82, 557.36)
    until availableshelf("shelf") == nil
    Return:FireServer()
    racktoggle = false
    warn("Restocking Completed!")
  end
end

function pickupbox()
  --print(#rackedboxes <= availableshelf("max"), holdingjack(), racktoggle, carrytoggle, not autodeliver, #rackedboxes, availableshelf("max"))
  if #rackedboxes <= availableshelf("max") then return getspawnedbox() end
  if holdingjack() or racktoggle or carrytoggle or not autodeliver then return end
  carrytoggle = true

  warn("Shelves Occupied, Delivery Started!")
  LP.Character.HumanoidRootPart.CFrame = require(LP.PlayerScripts.ClientData).DeliveryPoint.CFrame + Vector3.new(0, 3, 0)
  
  repeat wait()
    PickupRemote:InvokeServer(bestracked())
    PickupRemote:InvokeServer(bestracked())
    PickupRemote:InvokeServer(bestracked())
    PickupRemote:InvokeServer(bestracked())
    PickupRemote:InvokeServer(bestracked())
    if tonumber(string.split(LP.PlayerGui.Main.Carry.Capacity.Text, "/")[1]) >= tonumber(string.split(LP.PlayerGui.Main.Carry.Capacity.Text, "/")[2]) then
      sellbox()
    end
  until #rackedboxes <= availableshelf("max")
  if tonumber(string.split(LP.PlayerGui.Main.Carry.Capacity.Text, "/")[1]) > 0 then
    StackRemote:InvokeServer(availableshelf("shelf"))
  end
  carrytoggle = false
  warn("All Deliveries Completed!")
  getspawnedbox()
end

Toggles:Toggle("Auto Deliver", false, function(bool) autodeliver = bool end)
Toggles:Toggle("Auto Restock", false, function(bool) autorestock = bool end)
Toggles:Toggle("Auto Combine (Discontinued)", false, function(bool) autocombine = bool end)
Toggles:Toggle("Auto Upgrade (Discontinued)", false, function(bool) autoupgrade = bool end)

Buttons:Label("Total Amounts:")
Buttons:Button("Deliveries", function()
  local BoxesDelivered = LP.PlayerGui.Main.Settings.BoxesDelivered.Text
  Lib:Notification("Total Boxes Delivered:", string.split(string.split(BoxesDelivered, ">")[2], "<")[1], "Done")
end)
Buttons:Button("Cash Earned", function()
  local CashEarned = LP.PlayerGui.Main.Settings.CashEarned.Text
  Lib:Notification("Total Cash Earned:", string.split(string.split(CashEarned, ">")[2], "<")[1], "Done")
end)
Buttons:Button("Playtime", function()
  local PlayTime = LP.PlayerGui.Main.Settings.Playtime.Text
  Lib:Notification("Total Playtime:", string.split(string.split(PlayTime, ">")[2], "<")[1], "Done")
end)

Buttons:Seperator()

Buttons:Label("Current Amounts:")
Buttons:Button("Cash Available", function()
  Lib:Notification("Cash Left:", LP.PlayerGui.Main.Cash.Cash.Text, "Done")
end)
Buttons:Button("Stars Available", function()
  Lib:Notification("Stars Left:", LP.PlayerGui.Main.Stars.Stars.Text, "Done")
end)

Buttons:Seperator()

Buttons:Label("Leaderboard Placements:")
Buttons:Button("Deliveries", function()
  local board, place = updateboard("boxes")
  local amount

  if place == nil then
    amount = "You are not in the leaderboard!"
  else
    amount = "#" .. place
  end

  Lib:Notification("Placement:", amount, "Done")
end)
Buttons:Button("Cash Earned", function()
  local board, place = updateboard("cash")
  local amount 

  if place == nil then
    amount = "You are not in the leaderboard!"
  else
    amount = "#" .. place
  end

  Lib:Notification("Placement:", amount, "Done")
end)
Buttons:Button("Playtime", function()
  local board, place = updateboard("play")
  local amount

  if place == nil then
    amount = "You are not in the leaderboard!"
  else
    amount = "#" .. place
  end

  Lib:Notification("Placement:", amount, "Done")
end)

local selectedstore
local StoresDrop = Teleports:Dropdown("Select Store:", storeslist, function(selected)
  selectedstore = selected
end)

Teleports:Button("Teleport", function()
  if not LP.Character and not selectedstore then return end
  local chosenstore = string.gsub(selectedstore, " Store", "")
  if string.match(chosenstore, "Carry") then
    LP.Character.HumanoidRootPart.CFrame = WS.GameLogic[chosenstore.."Trigger"].CFrame
  else
    LP.Character.HumanoidRootPart.CFrame = WS.GameLogic.Stores[chosenstore].Trigger.CFrame
  end
end)

local selectedplr
local Dropdown = PlayerTab:Dropdown("Select Player:", plrlist, function(selected)
  selectedplr = selected
end)

--// since this GUI doesnt have a list refresher i figured a way to make it work \\--
function relist()
  Dropdown:Clear()
  for i,v in pairs(plrlist) do
    Dropdown:Add(v)
  end
end

PlayerTab:Button("Teleport", function()
  if not LP.Character and not selectedplr then return end
  print(selectedplr, Players[selectedplr])
  LP.Character.HumanoidRootPart.CFrame = Players[selectedplr].Character.HumanoidRootPart.CFrame
end)

Extra:Toggle("Hide Gamepass UI", false, function(bool)
  if bool then
    LP.PlayerGui.Main.OpenRobuxStore.Visible = false
    LP.PlayerGui.Main.Gamepasses.Visible = false
    LP.PlayerGui.Main.Nuke.Visible = false
  else
    LP.PlayerGui.Main.OpenRobuxStore.Visible = true
    LP.PlayerGui.Main.Gamepasses.Visible = true
    LP.PlayerGui.Main.Nuke.Visible = true
  end
end)

--// pls no remove daddy \\--
Features:Label("Script Features:")
Features:Seperator()
Features:Label("1. Proitizes valuable boxes to collect and sell.")
Features:Label("2. Adjusts to your current player stats. Carry/Rack Capacity.")
Features:Label("3. Tracks your stats and leaderboard rank for convenience.")
Features:Label("4. Player list updates when players leave or join.")
Features:Label("5. Teleport to any store add in the game.")
Features:Label("6. Wont break if you change capacity, vehicle, or shelves.")
Features:Label("7. Will break if you remove all shelves. lazy to fix")

Tips:Label("1. The autofarm gets faster the more boxes you can hold.")
Tips:Label("2. Maximize profit by proritizing your truck upgrade.")
Tips:Label("3. Maxizmize deliveries by buying the best delivery drones.")
Tips:Label("4. Rejoin until delivering to the best neighborhood.")

Credits:Label("Made by GabrasticYT")
Credits:Label("Discord: gabe#0002")
Credits:Label("Youtube: Gabrastic")

--// best method tested so far, compares box value before inserting into table \\--
WS.GameLogic.SpawnedBoxes.ChildAdded:Connect(function(box)
  if BoxData[box.Name].Value > 250 then
    table.insert(spawnedboxes, 1, box)
    if racktoggle then
      PickupRemote:InvokeServer(box)
    end
  else
    table.insert(spawnedboxes, box)
  end
end)

--// boxes are removed from spawnedboxes if they are grabbed \\--
WS.GameLogic.SpawnedBoxes.ChildRemoved:Connect(function(box)
  if #spawnedboxes <= 0 then return end
  for i = 1, #spawnedboxes do
    local removedbox = spawnedboxes[i]
    if removedbox ~= nil then
      if removedbox == box then
        table.remove(spawnedboxes, i)
      end
    end
  end
end)

-- best method so far of comparing which box to add to the table first \\--
findspot().Racks.DescendantAdded:Connect(function(box)
  if string.match(box.Name, "Shelf") then
    table.insert(addedshelves, box)
  end
  if box.Parent.Name == "Boxes" and BoxData[box.Name].Value > 250 then
    table.insert(rackedboxes, 1, box)
  elseif box.Parent.Name == "Boxes" and BoxData[box.Name].Value == 250 then
    table.insert(rackedboxes, box)
  end
end)

findspot().Racks.DescendantRemoving:Connect(function(box)
  if string.match(box.Name, "Shelf") then
    for i = 1, #addedshelves do
      local removedshelf = addedshelves[i]
      if removedshelf ~= nil then
        if removedshelf == box then
          table.remove(addedshelves, i)
        end
      end
    end
  end
  if #rackedboxes <= 0 then return end
  if box.Parent.Name == "Boxes" then
    for i = 1, #rackedboxes do
      local removedbox = rackedboxes[i]
      if removedbox ~= nil then
        if removedbox == box then
          table.remove(rackedboxes, i)
        end
      end
    end
  end
end)

Players.PlayerRemoving:Connect(function(plr)
  for i,v in pairs(plrlist) do
    if v == plr.Name then
      table.remove(plrlist, i)
      table.sort(plrlist,
      function(a, b) 
        return a:lower() < b:lower()
      end)
    end
  end
  relist()
end)

Players.PlayerAdded:Connect(function(plr)
  table.insert(plrlist, plr.Name)
  table.sort(plrlist, 
    function(a, b) 
      return a:lower() < b:lower()
  end)
  relist()
end)

game:GetService("RunService").Heartbeat:Connect(function()
  if autodeliver then
    pickupbox()
  end
  if autorestock then
    getspawnedbox()
  end
end)

--// This was for my atttempt at making an automatic combiner with packabox hopefully you guys can salvage it  \\--
--[[
function checkbox()
end

function combinebox()
  local packtext = string.split(string.split(LP.PlayerGui.PackABoxUI.Frame.Box.Text, ">")[2], "<")[1]
  local Insert = RepStorage.Remotes.StackPackABox
  local Combine = RepStorage.Remotes.UsePackABox
  local PackABox = findspot():FindFirstChildOfClass("Model")
  local firstbox = rackedboxes[math.random(1, #rackedboxes + 1)]
  local secondbox = nil
  local insertedbox 

  local specials = {
    ["Emerald"] = { 31, 41 },
    ["Golden"] = { 32, 41 },
    ["Silver"] = { 32, 41 }
  }

  for name, value in pairs(specials) do
    if string.match(packtext, name) then
      local box = string.sub(packtext, value[1], value[2])
      insertedbox = box
    end
  end
  
  if packtext == "" and firstbox ~= "Obsidian Box" then
    print("found 1st " .. tostring(firstbox))
  end
  
  for _, foundmatch in pairs(rackedboxes) do
    if foundmatch.Name == firstbox.Name then
      if foundmatch ~= firstbox then
        secondbox = foundmatch
      end
    end
  end
  warn("found 2nd ".. tostring(secondbox))

  if secondbox == nil then
    for _, basicbox in pairs(rackedboxes) do
      for blacklist, value in pairs(specials) do
        if basicbox.Name ~= "Obsidian Box" then
          if not string.match(basicbox.Name, blacklist) then
            if basicbox.Name ~= "Golden Box" then
              secondbox = basicbox
            end
          end
        end
      end
    end
    print("found 2nd ".. tostring(secondbox))
  end

  PickupRemote:InvokeServer(firstbox)

  repeat wait(0.5)
    PickupRemote:InvokeServer(firstbox)
    PickupRemote:InvokeServer(secondbox)
    Insert:InvokeServer(PackABox)
    Insert:InvokeServer(PackABox)
    Combine:InvokeServer()
  until LP.PlayerGui.PackABoxUI.Frame.Box.Text == ""
  print("PLACED BOTH BOXES")

  StackRemote:InvokeServer(availableshelf("shelf"))
  print("FINISHED")
end

]]--
