local CreateESP = {}
local Total = {}

CreateESP.__index = CreateESP
function CreateESP.new(Settings, Services)
  local self = setmetatable({}, CreateESP)
  self.Object = (Settings.Adornee and Settings.Object[Settings.Adornee]) or Settings.Object
  self.Settings = Settings
  self.Connections = {}

  local FolderName = "gabescripts_esp"
  local Folder = Services.CoreGui:FindFirstChild(FolderName) or Instance.new("Folder", Services.CoreGui)
  Folder.Name = FolderName

  local TextFolder = Folder:FindFirstChild("Text") or Instance.new("Folder", Folder)
  TextFolder.Name = "Text"

  local Core = Instance.new("BillboardGui", TextFolder)
  local TopLabel = Instance.new("TextLabel", Core)
  local BottomLabel;
  
  Core.Adornee = self.Object
  Core.ExtentsOffset = Vector3.new(0, 1, 0)
  Core.AlwaysOnTop = false
  Core.Size = UDim2.new(0, 5, 0, 5)
  Core.StudsOffset = Vector3.new(0, 1, 0)
  Core.Name = Settings.Type
  Core.Enabled = false

  TopLabel.Name = Settings.Text.Top
  TopLabel.BackgroundTransparency = 1
  TopLabel.Position = UDim2.new(0, 0, 0, -35)
  TopLabel.Size = UDim2.new(1, 0, 10, 0)
  TopLabel.Font = "GothamBold"
  TopLabel.FontSize = 6
  TopLabel.Text = Settings.Text.Top
  TopLabel.TextStrokeTransparency = 0.5
  TopLabel.TextColor3 = Settings.Color.Top

  if Settings.Labels == 2 then
    BottomLabel = Instance.new("TextLabel", Core)
    BottomLabel.Name = Settings.Text.Bottom
    BottomLabel.BackgroundTransparency = 1
    BottomLabel.Position = UDim2.new(0, 0, 0, -20)
    BottomLabel.Size = UDim2.new(1, 0, 11, 0)
    BottomLabel.Font = "GothamBold"
    BottomLabel.FontSize = 5
    BottomLabel.Text = Settings.Text.Bottom
    BottomLabel.TextStrokeTransparency = 0.5
    BottomLabel.TextColor3 = Settings.Color.Bottom
  end
  self.Labels = {Core, TopLabel, BottomLabel}

  --// Player Connection Will Make Re-Adornee Much Easier
  if Settings.AddPlayerConn and Settings.ReParent and Settings.Object then
    local Player = Services.Players[Settings.Object.Name]
    self.Connections.ReParent = Player.CharacterAdded:Connect(function(Character)
      local NewAdornee = Character:WaitForChild(Settings.Adornee)
      Core.Adornee = NewAdornee
      Settings.Object = Character

      if Settings.Humanoid then
        self.Connections.Humanoid:Disconnect()
        self.Connections.Humanoid = nil

        repeat task.wait() until Character:FindFirstChildWhichIsA("Humanoid")
        local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
        BottomLabel.Text = string.gsub(BottomLabel.Text, "HP: %d+", string.format("HP: %i", Humanoid.Health))

        self.Connections.Humanoid = Humanoid.HealthChanged:Connect(function(Health)
          BottomLabel.Text = string.gsub(BottomLabel.Text, "HP: %d+", string.format("HP: %i", Health))
        end)
      end
    end)

    if Settings.AddTeamConn then
      self.Connections.Team = Player:GetPropertyChangedSignal("Team"):Connect(function()
        --// Enter Bottom Label Change
      end)
    end

    --// Disconnects All Connections From Player Connection
    self.Connections.Removing = Services.Players.PlayerRemoving:Connect(function(RemovedPlayer)
      if Player ~= RemovedPlayer then return end;
      self:Destroy()
    end)
  elseif Settings.ReParent and Settings.Object then
    self.Connections.ReParent = Settings.Object.ChildAdded:Connect(function(Object)
      if (Settings.Adornee and Object:WaitForChild(Settings.Adornee, 5)) or (not Settings.Adornee and Object.Name == Settings.Object.Name and Object.ClassName == Settings.Object.ClassName) then
        self.Object = (Settings.Adornee and Settings.Object[Settings.Adornee]) or Settings.Object
        Core.Adornee = self.Object
      end
    end)
  end

  if Settings.AddPropertyConn then
    local Property = Settings.AddPropertyConn
    self.Connections.Property = Property.Object:GetPropertyChangedSignal(Property.ToChange):Connect(function()
      local NewValue = Property[Property.ToChange]
      BottomLabel.Text = string.gsub(BottomLabel.Text, Property.Suffix .. ": %d+", string.format("%s: %s", Property.Suffix, NewValue))
    end)
  end

  local Humanoid = Settings.Object:FindFirstChildWhichIsA("Humanoid")
  if Settings.Humanoid and Humanoid then
    self.Connections.Humanoid = Humanoid.HealthChanged:Connect(function(Health)
      BottomLabel.Text = string.gsub(BottomLabel.Text, "HP: %d+", string.format("HP: %i", Health))
    end)
  end

  function self:ReParent(Part) Core.Adornee = Part; return end
  function self:Toggle(State) Core.Enabled = State return end
  function self:SetAbove(State) Core.AlwaysOnTop = State return end
  
  function self:SetTopColor(Color) TopLabel.TextColor3 = Color return end
  function self:SetBottomColor(Color) BottomLabel.TextColor3 = Color return end

  function self:SetTopSize(Size) TopLabel.FontSize = Size return end
  function self:SetBottomSize(Size) BottomLabel.FontSize = Size - 1 return end

  function self:SetTopOffset(Offset) TopLabel.Position = UDim2.new(0, 0, 0, -35 + Offset) return end
  function self:SetBottomOffset(Offset) BottomLabel.Position = UDim2.new(0, 0, 0, -20 + Offset) return end

  function self:Destroy()
    for name, connection in next, self.Connections do
      connection:Disconnect()
      self.Connections[name] = nil
    end
    Core:Destroy()
    table.remove(Total, table.find(Total, self))
  end

  table.insert(Total, self)
  return self
end

return CreateESP, Total
