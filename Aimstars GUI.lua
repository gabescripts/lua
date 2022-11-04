--// GameId: 1794805560

getgenv().CompleteBar = true;
if game.PlaceId == 5153937061 then
  getgenv().Message = string.format("Execute In-Game Not In Lobby!"); 
  return
end

--// Script Debugging
if not LPH_OBFUSCATED then
  function LPH_NO_VIRTUALIZE(...) return ... end;
  function LPH_JIT_MAX(...) return ... end;
  function LPH_JIT_ULTRA(...) return ... end;
  function LPH_CRASH() return end;
  function LPH_ENCSTR(...) return ... end;
  lgVarsTbl = {hoursRemaining = 0}
end

repeat task.wait() until game:IsLoaded()
local Server = "https://raw.githubusercontent.com/gabescripts/lua/scripts/Server.lua";
local Services = loadstring(game:HttpGet(Server))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/gabescripts/lua/scripts/Libraries/SolarisLib%20UI%20Source.lua"))()
local Window = Library:New({Name = " Aimstars FPS AIM TRAINER", FolderToSave = "SolarisLibStuff"})

local Tab1 = Window:Tab("Main")
local Tab2 = Window:Tab("Updates")
local GameSection = Tab2:Section("Game Logs")
GameSection:Label(string.format("Game Updated: %s", Services.Get("LastUpdate")))
GameSection:Button(string.format("Server ID: %s", game.JobId), function()
  assert(setclipboard, "Missing setclipboard!")
  setclipboard(game.JobId)
  Library:Notification("Server ID Copied!", "Copied server id to your clipboard, paste to view.")
end)

local Update1 = Tab2:Section(string.format("Created %s", Services.UnixToDate(1666706400)))
Update1:Label("[+] Created Script.")

local Tab3 = Window:Tab("FAQ")
local KeySection = Tab3:Section("Key Info")
--// Convert Hours To Seconds
repeat task.wait() until typeof(lgVarsTbl) == "table" and rawget(lgVarsTbl, "hoursRemaining")
local Timeleft = tonumber(lgVarsTbl["hoursRemaining"]) --// Convert Hours To Seconds * (60^2) 
local Executes = tonumber(lgVarsTbl["totalExecutions"])
local KeyInfo = KeySection:Label(string.format("Key Expiration: %i Days, %i Hours", math.floor(Timeleft / 24), math.floor(Timeleft % 24)))
local ExecuteInfo = KeySection:Label(string.format("Total Executes: %s", (not Executes and "Server Error..") or Executes))

local FAQSection = Tab3:Section("FAQ Section")
local FAQs = {"1. Killer aim will kill all the dots instantly.", "2. Holding smooth aim hold key turns smooth aim on.", "3. Auto fire will fire gun when center is touching dot.", "4. Auto fire might glitch sometimes with moving targets."}
for _, faq in next, FAQs do FAQSection:Label(faq) end;

local Attempts = 0;
while not Fire do task.wait()
  for i,v in next, getgc(true) do 
    if type(v) == "table" and rawget(v, "bullet") then 
      Fire = v.bullet
      break
    end
  end

  if Attempts >= 10 then return Services.Client:Kick("Bullet System Changed, Report To Gabe!") end;
  Attempts += 1
end

--// Default Values And Toggles
local Default_Values = {
  Accuracy = 98.5,
  SmoothSpeed = 0.15,
  Timer = 0,
  GameType = (Services.Workspace.Bots:FindFirstChild("Humanoid", true) and "Humanoid") or "Dot"
}
local Default_Toggles = {
  AutoFire = true,
}

--// Metatable For New Values And Toggles
local Values = setmetatable(Default_Values, {__index = function(self, key) return rawget(self, key) or 0 end})
local Toggles = setmetatable(Default_Toggles, {__index = function(self, key) return rawget(self, key) or false end})

--// Functions
function NearestTarget()
  local Nearest, Distance = nil, math.huge
  if Values.GameType == "Dot" then
    for _, dot in next, Services.Workspace.Bots:GetChildren() do
      if not dot:FindFirstChild("Target") then continue end;
      if not dot:IsA("Part") then continue end;
  
      local Viewport, OnScreen = Services.Camera.WorldToViewportPoint(Services.Camera, dot.Position)
      local ViewPos, CenterPos = Vector2.new(Viewport.X, Viewport.Y), Services.Camera.ViewportSize / 2
      local Magnitude = (ViewPos - CenterPos).Magnitude
  
      if Magnitude > Distance then continue end;
      Nearest, Distance = dot, Magnitude
    end
  else
    for _, bot in next, Services.Workspace.Bots:GetChildren() do
      if not bot:FindFirstChild("Humanoid") then continue end;
      if not bot:FindFirstChild("Head") then continue end;

      local Viewport, OnScreen = Services.Camera.WorldToViewportPoint(Services.Camera, bot.Head.Position)
      local ViewPos, CenterPos = Vector2.new(Viewport.X, Viewport.Y), Services.Camera.ViewportSize / 2
      local Magnitude = (ViewPos - CenterPos).Magnitude
  
      if Magnitude > Distance then continue end;
      Nearest, Distance = bot.Head, Magnitude
    end
  end

  return Nearest
end

function IsHovering(part)
  local Params = RaycastParams.new()
  Params.FilterType = Enum.RaycastFilterType.Whitelist
  Params.FilterDescendantsInstances = {Services.Workspace.Bots}

  local Direction = Services.Camera.CFrame.LookVector.Unit * 5000
  local Raycast = Services.Workspace:Raycast(Services.Camera.CFrame.Position, Direction, Params)

  --// Checks If Returns Dot Instead Of Nil
  return typeof(Raycast) == "RaycastResult"
end

function Percent(chance) return chance >= math.random(1, 100) end;

local Section1 = Tab1:Section("Aiming Section")
local Silent = Section1:Toggle("Silent Aim", Toggles.SilentAim, "", function(t) Toggles.SilentAim = t; end)
local Smooth = Section1:Toggle("Smooth Aim", Toggles.SmoothAim, "", function(t) Toggles.SmoothAim = t; end)
Section1:Toggle("Killer Aim", Toggles.KillAll, "", function(t) Toggles.KillAll = t;
  LPH_JIT_MAX(function()
    coroutine.wrap(function()
      while Toggles.KillAll do task.wait()
        if Values.Timer <= 0 then continue end;
        Fire()
      end
    end)()
  end)()
end)
Section1:Toggle("Auto Fire", Toggles.AutoFire, "", function(t) Toggles.AutoFire = t;
  LPH_JIT_MAX(function()
    coroutine.wrap(function()
      while Toggles.AutoFire do task.wait()
        local Target = NearestTarget()
        if not IsHovering(Target) then continue end;
        if not Target then continue end;
        if Values.Timer <= 0 then continue end;

        local Position = Target.Position
        Fire()
        repeat task.wait()
          if Target.Anchored then continue end;
          if not IsHovering(Target) then continue end;
          if not Target:FindFirstChild("Health") then continue end;
          if Target.Health.Value <= 0 then continue end;

          Fire()
          task.wait(0.1)
        until (Target.Position ~= Position and Target.Anchored and Values.GameType == "Dot") or (not Target.Parent or not Target:FindFirstChild("Target") or not Toggles.AutoFire or (Target ~= NearestTarget() and Values.GameType == "Humanoid"))
      end
    end)()
  end)()
end)

local AimSettings = Tab1:Section("Aiming Settings")
local Accuracy; Accuracy = AimSettings:Textbox(string.format("Silent Aim Accuracy: %.1f", Values.Accuracy), false, function(t) 
  if t == "" or not tonumber(t) then return end;
  Values.Accuracy = math.clamp(t, 0, 100);
  Accuracy:Set(string.format("Silent Aim Accuracy: %.1f", Values.Accuracy))
end)
local SmoothSpeed; SmoothSpeed = AimSettings:Textbox(string.format("Smooth Aim Speed: %.2f", Values.SmoothSpeed), false, function(t)
  if t == "" or not tonumber(t) then return end;
  Values.SmoothSpeed = tonumber(t);
  SmoothSpeed:Set(string.format("Smooth Aim Speed: %.2f", Values.SmoothSpeed))
end)

local Section3 = Tab1:Section("Keybinds Section")
Section3:Bind("Smooth Aim Hold", Enum.UserInputType.MouseButton2, true, "BindNormal", function(bool) Toggles.SmoothAim = bool; Smooth:Set(bool); end)
Section3:Bind("Silent Aim Hold", Enum.KeyCode.C, true, "BindNormal", function(bool) Toggles.SilentAim = bool; Silent:Set(bool); end)

--// Timer Update Connection
Services.Client.PlayerGui.MainGUI["HUD"].Timer:GetPropertyChangedSignal("Text"):Connect(function()
  Values.Timer = tonumber(Services.Client.PlayerGui.MainGUI["HUD"].Timer.Text)
end)

LPH_JIT_MAX(function()
  --// Smooth Aim Loop
  coroutine.wrap(function()
    while true do task.wait()
      local Target = NearestTarget()

      if (Toggles.SmoothAim) and Target and Values.Timer > 0 then
        local Position = Target.Position
        local Tween = Services.TweenService:Create(Services.Camera, TweenInfo.new(Values.SmoothSpeed, Enum.EasingStyle.Circular), {CFrame = CFrame.new(Services.Camera.CFrame.Position, Target.Position)})

        Tween:Play()
        local SpeedTick = tick()
        repeat task.wait() until not Toggles.SmoothAim or (tick() - SpeedTick) >= Values.SmoothSpeed or ((Position ~= Target.Position and Values.GameType == "Dot") or (not Target.Parent or not Target:FindFirstChild("Target")))
        Tween:Cancel()
      end
    end
  end)()

  --// Silent Aim/Kill All Hook
  local namecall; namecall = hookmetamethod(game, "__namecall", function(self, ...)

    local method = getnamecallmethod()
    local args = {...}

    if (method == "FindPartOnRayWithIgnoreList" and tostring(self) == "Workspace") and ((Toggles.SilentAim and Percent(Values.Accuracy) and not checkcaller()) or (Toggles.KillAll and checkcaller())) then
      local Nearest = NearestTarget()
      if Nearest then
        local Direction = (Nearest.Position - Services.Camera.CFrame.Position).Unit * 5000
        local Input = Ray.new(Services.Camera.CFrame.Position, Direction)
        
        return self.FindPartOnRayWithWhitelist(self, Input, {Nearest})
      end
    end

    return namecall(self, ...)
  end)
end)()

coroutine.wrap(function()
  while Timeleft > 0 do
    Timeleft -= 1
    KeyInfo:Set(string.format("Key Expiration: %i Days, %i Hours", math.floor(Timeleft / 24), math.floor(Timeleft % 24)))
    task.wait(3600)
  end
  KeyInfo:Set("Key Expiration: Currently Expired!")
end)()

getgenv().Executed = true