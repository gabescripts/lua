local CreateAvatar = {}
local Total = {}

CreateAvatar.__index = CreateAvatar
function CreateAvatar.new(Player, Services)
  local self = setmetatable({}, CreateAvatar)
  self.Player = Player

  local Content;
  local IsReady;
  while not IsReady do task.wait()
    Content, IsReady = Services.Players:GetUserThumbnailAsync(self.Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
  end

  local FolderName = "gabescripts_esp"
  local Folder = Services.CoreGui:FindFirstChild(FolderName) or Instance.new("Folder", Services.CoreGui)
  Folder.Name = FolderName

  local AvatarFolder = Folder:FindFirstChild("Avatar") or Instance.new("Folder", Folder)
  AvatarFolder.Name = "Avatar"

  local HeadshotSize = 2
  local Billboard = Instance.new("BillboardGui", AvatarFolder)
  local Frame = Instance.new("Frame", Billboard)
  local ImageLabel = Instance.new("ImageLabel", Frame)

  local FrameCorner = Instance.new("UICorner", Frame)
  local ImageCorner = Instance.new("UICorner", ImageLabel)
  FrameCorner.CornerRadius = UDim.new(1, 0)
  ImageCorner.CornerRadius = UDim.new(1, 0)

  Billboard.Name = self.Player.Name
  Billboard.Active = true;
  Billboard.Adornee = self.Player.Character:WaitForChild("Head")
  Billboard.Size = UDim2.new(HeadshotSize, 20, HeadshotSize, 20)
  Billboard.SizeOffset = Vector2.new(0, 1.3)
  Billboard.AlwaysOnTop = false;
  Billboard.Enabled = false;
  
  Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  Frame.ClipsDescendants = true;
  Frame.Size = UDim2.new(1, 0, 1, 0)
  
  ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  ImageLabel.BackgroundTransparency = 1.000
  ImageLabel.ClipsDescendants = true;
  ImageLabel.Size = UDim2.new(1, 0, 1, 0)
  ImageLabel.Image =  Content or "rbxassetid://119097235"

  self.Labels = {Billboard, Frame, ImageLabel}

  local OnCharacaterAdded;
  OnCharacaterAdded = self.Player.CharacterAdded:Connect(function(Character)
    local Head = Character:WaitForChild("Head")
    Billboard.Adornee = Head
  end)

  local OnPlayerRemoving;
  OnPlayerRemoving = Services.Players.PlayerRemoving:Connect(function(Player)
    if self.Player.Name ~= Player.Name then return end;
    self:Destroy()
  end)
  
  function self:ReParent(Part) Billboard.Adornee = Part return end
  function self:Toggle(State) Billboard.Enabled = State return end
  function self:ToggleBG(State) Frame.BackgroundTransparency = (State and 1) or 0 return end
  function self:SetAbove(State) Billboard.AlwaysOnTop = State return end
  
  function self:SetSize(Size) Billboard.Size = UDim2.new(HeadshotSize, Size, HeadshotSize, Size) return end
  function self:SetOffset(Offset) Frame.Position = UDim2.new(0, 0, 0, Offset) return end

  function self:Destroy()
    if OnCharacaterAdded then
      OnCharacaterAdded:Disconnect()
      OnCharacaterAdded = nil
    end
    if OnPlayerRemoving then
      OnPlayerRemoving:Disconnect()
      OnPlayerRemoving = nil
    end
    Billboard:Destroy()
    table.remove(Total, table.find(Total, self))
  end

  table.insert(Total, self)
  return self
end

return CreateAvatar, Total
