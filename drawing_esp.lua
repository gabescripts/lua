--// Drawing ESP Section
local CreateDraw = {}
local TotalDraw = {}

if not LPH_OBFUSCATED then
    function LPH_NO_VIRTUALIZE(...) return ... end;
end

CreateDraw.__index = CreateDraw
function CreateDraw.new(Settings, Services)

    --// Micro Optimizations
    local Players = Services.Players
    local Client = Services.Client
    local Camera = Services.Camera
    local WorldToViewportPoint = Camera.WorldToViewportPoint
    local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
    local FindFirstChild = game.FindFirstChild
    local FindFirstChildOfClass = game.FindFirstChildOfClass
    local CreateVector3 = Vector3.new
    local CreateVector2 = Vector2.new
    local CreateColor = Color3.fromRGB
    local ViewportSize = Camera.ViewportSize
    local InputService = Services.UserInputService
    local MouseLocation = InputService.GetMouseLocation

    --// Initalize Object Class
    local self = setmetatable({}, CreateDraw)
    self.Options = {Enabled = true, Skeleton = false, Boxes = false, HealthBar = false, Distance = false, Tracers = true}
    self.Types = {"Player", "Object", "Humanoid", "Custom"}

    self.Destroyed = false
    self.Object = Settings.Object
    self.Creations = {}
    self.Connections = {}
    self.Methods = {}

    self.CenterPos = ViewportSize / 2
    self.LeftCenterPos = CreateVector2(0, self.CenterPos.Y)
    self.RightCenterPos = CreateVector2(ViewportSize.X, self.CenterPos.Y)
    self.TopCenterPos = CreateVector2(self.CenterPos.X, 0)
    self.BottomCenterPos = CreateVector2(self.CenterPos.X, ViewportSize.Y)

    self.LimbsOffset = CreateVector3(0, 1, 0)
    self.HeadOffset = CreateVector3(0, 1, 0)

    --// Create Tracer Line
    self.Creations.LineTracer = Drawing.new("Line")
    self.Creations.LineTracer.Thickness = 1
    self.Creations.LineTracer.Color = CreateColor(255, 255, 255)
    
    --// Create Name Text
    self.Creations.Name = Drawing.new("Text")
    self.Creations.Name.Size = 22
    self.Creations.Name.Outline = true
    self.Creations.Name.OutlineColor = CreateColor(0, 0, 0)
    self.Creations.Name.Center = true
    self.Creations.Name.Text = Settings.Name or self.Object.Name
    self.Creations.Name.Color = CreateColor(255, 255, 255)

    --// Create Distance Text
    self.Creations.Distance = Drawing.new("Text")
    self.Creations.Distance.Size = 22
    self.Creations.Distance.Outline = true
    self.Creations.Distance.OutlineColor = CreateColor(0, 0, 0)
    self.Creations.Distance.Center = true
    self.Creations.Distance.Color = CreateColor(255, 255, 255)

    if Settings.Type ~= "Object" then
        self.Creations.BoxMain = Drawing.new("Square")
        self.Creations.BoxMain.Thickness = 1
        self.Creations.BoxMain.Color = CreateColor(255, 255, 255)
        self.Creations.BoxMain.Filled = false

        self.Creations.HealthBarOutline = Drawing.new("Square")
        self.Creations.HealthBarOutline.Thickness = 4
        self.Creations.HealthBarOutline.Filled = false
        self.Creations.HealthBarOutline.Color = CreateColor(0, 0, 0)
        self.Creations.HealthBarOutline.Transparency = 1

        self.Creations.HealthBar = Drawing.new("Square")
        self.Creations.HealthBar.Thickness = 2
        self.Creations.HealthBar.Filled = false
        self.Creations.HealthBar.Color = CreateColor(0, 255, 0)
        self.Creations.HealthBar.Transparency = 1

        self.Creations.RootLine = Drawing.new("Line")
        self.Creations.RootLine.Thickness = 1
        self.Creations.RootLine.Color = CreateColor(255, 255, 255)

        self.Creations.RightHandLine = Drawing.new("Line")
        self.Creations.RightHandLine.Thickness = 1
        self.Creations.RightHandLine.Color = CreateColor(255, 255, 255)

        self.Creations.LeftHandLine = Drawing.new("Line")
        self.Creations.LeftHandLine.Thickness = 1
        self.Creations.LeftHandLine.Color = CreateColor(255, 255, 255)

        self.Creations.RightFootLine = Drawing.new("Line")
        self.Creations.RightFootLine.Thickness = 1
        self.Creations.RightFootLine.Color = CreateColor(255, 255, 255)
        
        self.Creations.LeftFootLine = Drawing.new("Line")
        self.Creations.LeftFootLine.Thickness = 1
        self.Creations.LeftFootLine.Color = CreateColor(255, 255, 255)
    end
    
    LPH_NO_VIRTUALIZE(function()
        task.spawn(function()
            while not self.Destroyed do 
                task.wait(Settings.Options.Tick or 0.025)
                
                -- [[ FIX 1: Universal Character Resolution ]]
                -- If it's a Player, grab their character. If it's an NPC, the Object IS the character.
                if Settings.Type == "Player" and not self.Object.Character then continue end;
                if self.Destroyed then break end;
        
                local canShow = false
                local Character = (Settings.Type == "Player" and self.Object.Character) or self.Object

                -- Validation Logic
                if Character and Character.Parent then
                    local RootPart = FindFirstChild(Character, "HumanoidRootPart")
                    local Humanoid = FindFirstChildOfClass(Character, "Humanoid")
                    
                    if RootPart and (Settings.Type == "Object" or Humanoid) then
                        canShow = true
                    end
                end

                if not canShow then
                    for _, drawing in next, self.Creations do drawing.Visible = false end
                    continue
                end

                local RootPart = FindFirstChild(Character, "HumanoidRootPart")
                local Humanoid = FindFirstChildOfClass(Character, "Humanoid")
                local Head = FindFirstChild(Character, "Head")
                local RightHand = FindFirstChild(Character, "RightHand") or FindFirstChild(Character, "Right Arm")
                local LeftHand = FindFirstChild(Character, "LeftHand") or FindFirstChild(Character, "Left Arm")
                local RightFoot = FindFirstChild(Character, "RightFoot") or FindFirstChild(Character, "Right Leg")
                local LeftFoot = FindFirstChild(Character, "LeftFoot") or FindFirstChild(Character, "Left Leg")
        
                if RootPart then
                    local RootPartPos, RootPartVis = WorldToViewportPoint(Camera, RootPart.Position)
                    if self.Creations.LineTracer then
                        if self.Destroyed then break end;
                        if RootPartVis then
                            self.Creations.LineTracer.From = (Settings.Options.TracerSide == "Center" and self.CenterPos) or (Settings.Options.TracerSide == "Top" and self.TopCenterPos) or (Settings.Options.TracerSide == "Right" and self.RightCenterPos) or (Settings.Options.TracerSide == "Left" and self.LeftCenterPos) or (Settings.Options.TracerSide == "Mouse" and MouseLocation(InputService)) or self.BottomCenterPos
                            self.Creations.LineTracer.To = CreateVector2(RootPartPos.X, RootPartPos.Y)

                            if Settings.Options.TracerVisibility then
                                local PartPos = (Head and Head.Position) or RootPart.Position
                                self.Creations.LineTracer.Color = (self:IsObstructed(PartPos, Settings.IgnoreList) and Settings.Options.TracerVisibleColors.False) or Settings.Options.TracerVisibleColors.True
                            end
                        end
                        self.Creations.LineTracer.Visible = (RootPartVis and Settings.Options.Enabled and Settings.Options.Tracer) or false  
                    end
                else
                    self.Creations.LineTracer.Visible = false
                end

                --// Skeleton Update
                if RootPart then
                    if Head and not self.Destroyed then
                        HeadPos, HeadVis = WorldToViewportPoint(Camera, Head.Position + CreateVector3(0, 1, 0))
                        RootPos, RootVis = WorldToViewportPoint(Camera, RootPart.Position - CreateVector3(0, 1, 0))
                        self.Creations.RootLine.From = CreateVector2(RootPos.X, RootPos.Y)
                        self.Creations.RootLine.To = CreateVector2(HeadPos.X, HeadPos.Y)
                    end
                    self.Creations.RootLine.Visible = (Settings.Options.Skeleton and Settings.Options.Enabled and Head and RootPart and HeadVis and RootVis) or false

                    if RightHand and not self.Destroyed then
                        RightHandPos, RightHandVis = WorldToViewportPoint(Camera, RightHand.Position - ((Humanoid.RigType == Enum.HumanoidRigType.R6 and CreateVector3(0, 1, 0)) or CreateVector3()))
                        self.Creations.RightHandLine.From = (self.Creations.RootLine.From + self.Creations.RootLine.To) / 2
                        self.Creations.RightHandLine.To = CreateVector2(RightHandPos.X, RightHandPos.Y)
                    end
                    self.Creations.RightHandLine.Visible = (Settings.Options.Skeleton and Settings.Options.Enabled and RightHand and RightHandVis and not Settings.Options.HideArms) or false

                    if LeftHand and not self.Destroyed then
                        LeftHandPos, LeftHandVis = WorldToViewportPoint(Camera, LeftHand.Position - ((Humanoid.RigType == Enum.HumanoidRigType.R6 and CreateVector3(0, 1, 0)) or CreateVector3()))
                        self.Creations.LeftHandLine.From = (self.Creations.RootLine.From + self.Creations.RootLine.To) / 2
                        self.Creations.LeftHandLine.To = CreateVector2(LeftHandPos.X, LeftHandPos.Y)
                    end
                    self.Creations.LeftHandLine.Visible = (Settings.Options.Skeleton and Settings.Options.Enabled and LeftHand and LeftHandVis and not Settings.Options.HideArms) or false

                    if LeftFoot and not self.Destroyed and Humanoid then
                        LeftFootPos, LeftFootVis = WorldToViewportPoint(Camera, LeftFoot.Position - ((Humanoid.RigType == Enum.HumanoidRigType.R6 and CreateVector3(0, 1, 0)) or CreateVector3()))
                        self.Creations.LeftFootLine.From = self.Creations.RootLine.From
                        self.Creations.LeftFootLine.To = CreateVector2(LeftFootPos.X, LeftFootPos.Y)
                    end
                    self.Creations.LeftFootLine.Visible = (Settings.Options.Skeleton and Settings.Options.Enabled and LeftFoot and LeftFootVis) or false

                    if RightFoot and not self.Destroyed and Humanoid then
                        RighFootPos, RightFootVis = WorldToViewportPoint(Camera, RightFoot.Position - ((Humanoid.RigType == Enum.HumanoidRigType.R6 and CreateVector3(0, 1, 0)) or CreateVector3()))
                        self.Creations.RightFootLine.From = self.Creations.RootLine.From
                        self.Creations.RightFootLine.To = CreateVector2(RighFootPos.X, RighFootPos.Y)
                    end
                    self.Creations.RightFootLine.Visible = (Settings.Options.Skeleton and Settings.Options.Enabled and RightFoot and RightFootVis) or false
                end

                --// Health, Distance, Boxes Update
                if RightHand and LeftHand and Head and RightFoot and LeftFoot and RootPart then
                    if self.Destroyed then break end;
                    
                    local AddOffset = (Humanoid.RigType == Enum.HumanoidRigType.R6 and self.LimbsOffset) or CreateVector3()
                    local HeadPos, HeadVis = WorldToViewportPoint(Camera, Head.Position + self.HeadOffset)
                    local LeftFootPos, LeftFootVis = WorldToViewportPoint(Camera, LeftFoot.Position - AddOffset)
                    local RootPartPos, RootPartVis = WorldToViewportPoint(Camera, RootPart.Position)
    
                    local HandsVisible = RightHandVis and LeftHandVis
                    local FeetVisible = RightFootVis and LeftFootVis
                    
                    if self.Creations.Name and self.Creations.BoxMain and self.Creations.Distance and self.Creations.HealthBarOutline and self.Creations.HealthBar then
                        if self.Destroyed then break end;
                        
                        if HandsVisible and FeetVisible and HeadVis then
                            self.Creations.BoxMain.Size = CreateVector2(3000 / RootPartPos.Z, LeftFootPos.Y - HeadPos.Y)
                            self.Creations.BoxMain.Position = CreateVector2(RootPartPos.X - self.Creations.BoxMain.Size.X / 2, HeadPos.Y)
        
                            if not Settings.Options.Distance then
                                self.Creations.Name.Position = CreateVector2(HeadPos.X, self.Creations.BoxMain.Position.Y - 20 - ((Settings.Options.HealthSide == "Top" and 15) or 0))
                            elseif Settings.Options.Distance and Client.Character and Client.Character.PrimaryPart and RootPart then
                                self.Creations.Name.Position = CreateVector2(HeadPos.X, self.Creations.BoxMain.Position.Y - 35 - ((Settings.Options.HealthSide == "Top" and 15) or 0))
                                local Meters = (Client.Character.PrimaryPart.Position - RootPart.Position).Magnitude / 3.57
                                self.Creations.Distance.Position = CreateVector2(HeadPos.X, self.Creations.BoxMain.Position.Y - 20 - ((Settings.Options.HealthSide == "Top" and 15) or 0))
                                self.Creations.Distance.Text = string.format("%.1fm away", Meters)
                            end
        
                            if Humanoid then
                                self.Creations.HealthBar.Color = (Settings.Options.NoColors and CreateColor(255, 255, 255)) or (CreateColor(255 - 255 / (Humanoid.MaxHealth / Humanoid.Health), 255 / (Humanoid.MaxHealth / Humanoid.Health), 0))
        
                                if Settings.Options.HealthSide == "Right" or Settings.Options.HealthSide == "Left" then
                                    self.Creations.HealthBar.Size = CreateVector2(3, (LeftFootPos.Y - HeadPos.Y) / (Humanoid.MaxHealth / Humanoid.Health))
                                elseif Settings.Options.HealthSide == "Top" or Settings.Options.HealthSide == "Bottom" then
                                    self.Creations.HealthBar.Size = CreateVector2((3000 / RootPartPos.Z) / (Humanoid.MaxHealth / Humanoid.Health), 3)
                                end
                            end
        
                            if Settings.Options.HealthSide == "Left" then
                                local ProperXPos = self.Creations.BoxMain.Position.X - 10
                                self.Creations.HealthBarOutline.Size = CreateVector2(3, LeftFootPos.Y - HeadPos.Y)
                                self.Creations.HealthBarOutline.Position = CreateVector2(ProperXPos, self.Creations.BoxMain.Position.Y + (1 / self.Creations.HealthBar.Size.Y))
                                self.Creations.HealthBar.Position = CreateVector2(ProperXPos, self.Creations.BoxMain.Position.Y + (1 / self.Creations.HealthBar.Size.Y))
                            elseif Settings.Options.HealthSide == "Right" then
                                local ProperXPos = RootPartPos.X + self.Creations.BoxMain.Size.X / 2
                                self.Creations.HealthBarOutline.Size = CreateVector2(3, LeftFootPos.Y - HeadPos.Y)
                                self.Creations.HealthBarOutline.Position = CreateVector2(ProperXPos + 10, self.Creations.BoxMain.Position.Y + (1 / self.Creations.HealthBar.Size.Y))
                                self.Creations.HealthBar.Position = CreateVector2(ProperXPos + 10, self.Creations.BoxMain.Position.Y + (1 / self.Creations.HealthBar.Size.Y))
                            elseif Settings.Options.HealthSide == "Bottom" then
                                local ProperYPos = self.Creations.BoxMain.Position.Y + self.Creations.BoxMain.Size.Y
                                self.Creations.HealthBarOutline.Size = CreateVector2(3000 / RootPartPos.Z, 3)
                                self.Creations.HealthBarOutline.Position = CreateVector2(self.Creations.BoxMain.Position.X + (1 / self.Creations.HealthBar.Size.X), ProperYPos + 10)
                                self.Creations.HealthBar.Position = CreateVector2(self.Creations.BoxMain.Position.X + (1 / self.Creations.HealthBar.Size.X), ProperYPos + 10)
                            elseif Settings.Options.HealthSide == "Top" then
                                local ProperYPos = self.Creations.BoxMain.Position.Y
                                self.Creations.HealthBarOutline.Size = CreateVector2(3000 / RootPartPos.Z, 3)
                                self.Creations.HealthBarOutline.Position = CreateVector2(self.Creations.BoxMain.Position.X + (1 / self.Creations.HealthBar.Size.X), ProperYPos - 10)
                                self.Creations.HealthBar.Position = CreateVector2(self.Creations.BoxMain.Position.X + (1 / self.Creations.HealthBar.Size.X), ProperYPos - 10)
                            end
                        end
                        self.Creations.BoxMain.Visible = (HandsVisible and FeetVisible and Settings.Options.Enabled and Settings.Options.Boxes) or false
                        self.Creations.HealthBarOutline.Visible = (HandsVisible and FeetVisible and Settings.Options.Enabled and Settings.Options.Health) or false
                        self.Creations.HealthBar.Visible = (HandsVisible and FeetVisible and Settings.Options.Enabled and Settings.Options.Health) or false
                        self.Creations.Name.Visible = (RootPartVis and Settings.Options.Enabled) or false
                        self.Creations.Distance.Visible = (RootPartVis and Settings.Options.Enabled and Settings.Options.Distance) or false
                    end
                end
            end
        end)
    end)()

    -- [[ FIX 2: Ancestry Memory Management ]]
    if Settings.Type == "Player" then
        self.Connections.OnPlayerRemoving = Players.PlayerRemoving:Connect(function(Player)
            if self.Object == Player then self:Destroy() end
        end)
    else
        -- For NPCs, destroy the ESP instantly when the game deletes the model
        self.Connections.OnAncestryChanged = self.Object.AncestryChanged:Connect(function(_, parent)
            if not parent then self:Destroy() end
        end)
    end

    --// Standard Methods Omitted for Brevity (Keep your exact Name, Distance, Tracer, Box methods here)
    self.Methods.Name = {}
    function self.Methods.Name:SetText(self, Text) self.Creations.Name.Text = Text end
    function self.Methods.Name:SetColor(self, Color) self.Creations.Name.Color = Color end
    function self.Methods.Name:SetSize(self, Size) self.Creations.Name.Size = Size end

    self.Methods.Distance = {}
    function self.Methods.Distance:Toggle(State) Settings.Options.Distance = State return end
    function self.Methods.Distance:SetText(self, Text) self.Creations.Distance.Text = Text end
    function self.Methods.Distance:SetColor(self, Color) self.Creations.Distance.Color = Color end
    function self.Methods.Distance:SetSize(self, Size) self.Creations.Distance.Size = Size end

    self.Methods.Tracer = {}
    function self.Methods.Tracer:SetColor(self, Color) self.Creations.LineTracer.Color = Color end
    function self.Methods.Tracer:SetSize(self, Value) self.Creations.LineTracer.Thickness = 1 + Value end
    function self.Methods.Tracer:Toggle(State) Settings.Options.Tracer = State end
    function self.Methods.Tracer:ToggleVisibility(State) Settings.Options.TracerVisibility = State end
    function self.Methods.Tracer:SetSide(Side) Settings.Options.TracerSide = Side end
    function self.Methods.Tracer:SetVisibleColors(ColorsTable) Settings.Options.TracerVisibleColors = ColorsTable end

    self.Methods.Boxes = {}
    function self.Methods.Boxes:SetColor(self, Color) self.Creations.BoxMain.Color = Color end
    function self.Methods.Boxes:SetSize(self, Size) self.Creations.BoxMain.Thickness = 1 + Size end
    function self.Methods.Boxes:Toggle(State) Settings.Options.Boxes = State end

    self.Methods.Skeleton = {}
    function self.Methods.Skeleton:SetColor(self, Color)
        self.Creations.RootLine.Color = Color
        self.Creations.RightHandLine.Color = Color
        self.Creations.LeftHandLine.Color = Color
        self.Creations.LeftFootLine.Color = Color
        self.Creations.RightFootLine.Color = Color
    end
    function self.Methods.Skeleton:SetSize(self, Size)
        self.Creations.RootLine.Thickness = Size + 1
        self.Creations.RightHandLine.Thickness = Size + 1
        self.Creations.LeftHandLine.Thickness = Size + 1
        self.Creations.LeftFootLine.Thickness = Size + 1
        self.Creations.RightFootLine.Thickness = Size + 1
    end
    function self.Methods.Skeleton:HideArms(State) Settings.Options.HideArms = State end
    function self.Methods.Skeleton:Toggle(State) Settings.Options.Skeleton = State end

    self.Methods.Health = {}
    function self.Methods.Health:SetSide(Side) Settings.Options.HealthSide = Side end
    function self.Methods.Health:NoColor(State) Settings.Options.NoColors = State end
    function self.Methods.Health:Toggle(State) Settings.Options.Health = State end

    function self:SetTick(Tick) Settings.Options.Tick = Tick end
    function self:Toggle(State) Settings.Options.Enabled = State end
    
    function self:IsObstructed(Position, Ignore)
        -- Dynamic Ignore prevents dead bodies from blocking the raycast
        local TargetChar = (Settings.Type == "Player" and self.Object.Character) or self.Object
        local dynamic_ignore = {Client.Character, TargetChar}
        for _, obj in pairs(Ignore or {}) do table.insert(dynamic_ignore, obj) end
        return #GetPartsObscuringTarget(Camera, {Position}, dynamic_ignore) > 0
    end

    function self:Destroy()
        self.Destroyed = true
        for name, connection in next, self.Connections do
            connection:Disconnect()
            self.Connections[name] = nil
        end
        for _, object in next, self.Creations do
            object:Remove()
        end
        
        local idx = table.find(TotalDraw, self)
        if idx then table.remove(TotalDraw, idx) end
    end

    table.insert(TotalDraw, self)
    return self
end


return CreateDraw, TotalDraw
