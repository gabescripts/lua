local Services = setmetatable({}, {__index = function(t, i) return game:GetService(i) end})
local Client = Services.Players.LocalPlayer

local Waiter = Services.Workspace.Lib.JobSystem.Jobs.JobLocations.Waiter:FindFirstChildOfClass("Part")
local Janitor = Services.Workspace.Lib.JobSystem.Jobs.JobLocations.Janitor:FindFirstChildOfClass("Part")
local Bouncer = Services.Workspace.Lib.JobSystem.Jobs.JobLocations.Bouncer:FindFirstChildOfClass("Part")

if Bouncer then
  local Prompt = Bouncer:FindFirstChild("ProximityPrompt")
  local Part = Bouncer:FindFirstChildOfClass("Model")

  if Part then
    Client.Character.PrimaryPart.CFrame = Client.Character.PrimaryPart.CFrame.Rotation + Part.PrimaryPart.Position
  else
    firetouchinterest(Bouncer, Client.Character.PrimaryPart, 0); firetouchinterest(Bouncer, Client.Character.PrimaryPart, 1);
    return
  end
  task.wait(0.15)
  fireproximityprompt(Prompt)
end

if Janitor then
  local Prompt = Janitor:FindFirstChild("ProximityPrompt")
  local Clean = Janitor:FindFirstChild("Gradient")
  local Mesh = Janitor:FindFirstChildOfClass("MeshPart")

  if Clean then
    Client.Character.PrimaryPart.CFrame = Client.Character.PrimaryPart.CFrame.Rotation + Clean.Position
  else
    Client.Character.PrimaryPart.CFrame = Client.Character.PrimaryPart.CFrame.Rotation + Mesh.Position
  end
  task.wait(0.15)
  fireproximityprompt(Prompt)
end

if Waiter then
  local Prompt, WalkPart = Waiter:FindFirstChild("ProximityPrompt"), Waiter:FindFirstChild("Gradient")
  Client.Character.Humanoid:MoveTo(WalkPart.Position)
  Client.Character.Humanoid.MoveToFinished:Wait()
  fireproximityprompt(Prompt)
end

Services.RunService.Heartbeat:Connect(function()
  for i,v in next, Services.Workspace.CurrencyPickups:GetChildren() do 
    if math.round(v.BeatCoin.Transparency) < 1 then
      firetouchinterest(v.BeatCoin, Client.Character.PrimaryPart, 0); firetouchinterest(v.BeatCoin, Client.Character.PrimaryPart, 1);
    end
  end
end)

print("Executed Autofarm")
