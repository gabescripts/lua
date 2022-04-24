local ShowerLib2 = {}
ShowerLib2.Settings = {}
ShowerLib2.Tabs = {}
ShowerLib2.Settings.Default = {}
ShowerLib2.Mouse = game:GetService("Players").LocalPlayer:GetMouse()
ShowerLib2.Settings.Default.TabSelectorFont = nil
ShowerLib2.Settings.Default.TabSelectorSize = nil
ShowerLib2.Settings.Default.TabSelectorColor =  nil
ShowerLib2.Settings.Default.ItemFontSize = 10
ShowerLib2.Settings.Default.ItemBackgroundColor = Color3.fromRGB(22, 22, 22);
ShowerLib2.Settings.Default.ItemFont = Enum.Font.GothamSemibold
ShowerLib2.Settings.Default.ItemTextColor = Color3.fromRGB(190, 190, 190);
ShowerLib2.Settings.Default.ButtonBackgroundColor = Color3.fromRGB(18, 18, 19)
ShowerLib2.Settings.Default.TextBoxBackgroundColor = Color3.fromRGB(18, 18, 19)
ShowerLib2.Settings.Default.SideBarBackgroundColor = Color3.fromRGB(28, 28, 28)
ShowerLib2.Settings.Default.PageIndicatorBackgroundColor = Color3.fromRGB(16, 16, 16)

--PageIndicator
--Color3.fromRGB(28, 28, 28)

local UIName = tostring(math.random(1, 100))..tostring("ShowerLib")..tostring(math.random(1, 100))

ShowerLib2.Settings.Parent = game:GetService("CoreGui")
ShowerLib2.Settings.Sliding = false;
ShowerLib2.Settings.Tabs = 0;

function ShowerLib2:Create(InstanceClass, Properties)
    local Inst = Instance.new(InstanceClass)
    for k, v in pairs(Properties) do
        if k ~= "Parent" then Inst[k] = v end
    end
    Inst.Parent = Properties.Parent
    return Inst
end

function ShowerLib2:HSVtoRGB(hsv)
    local color3 = hsv
    local r = math.floor(color3.R * 255)
    local g = math.floor(color3.G * 255)
    local b = math.floor(color3.B * 255)
    return r,g,b
  end
  
  function ShowerLib2:RGBtoHSV(rgb)
      local h, s, v = Color3.toHSV(rgb)
      return h,s,v
  end

function ShowerLib2:Destroy()
    game.CoreGui[UIName]:Destroy()
end

function ShowerLib2:OpenClose()
    if game.CoreGui[UIName].Enabled then
        game.CoreGui[UIName].Enabled = false
    else
        game.CoreGui[UIName].Enabled = true
    end
end

--ShowerLib:SetSettings({})

function ShowerLib2:SetSettings(Table)
    ShowerLib2.Settings.Default.TabSelectorFont = Table.TabSelectorFont or nil
    ShowerLib2.Settings.Default.TabSelectorSize = Table.TabSelectorSize or nil
    ShowerLib2.Settings.Default.TabSelectorColor = Table.TabSelectorColor or nil
    ShowerLib2.Settings.Default.ItemFont = Table.ItemFont or Enum.Font.GothamSemibold
    ShowerLib2.Settings.Default.ItemFontSize = Table.ItemFontSize or 10
    ShowerLib2.Settings.Default.ItemTextColor =  Table.ItemTextColor or Color3.fromRGB(190, 190, 190);
    ShowerLib2.Settings.Default.ItemBackgroundColor = Table.ItemBackgroundColor or Color3.fromRGB(22, 22, 22);
    ShowerLib2.Settings.Default.ButtonBackgroundColor = Table.ButtonBackgroundColor or Color3.fromRGB(18, 18, 19)
    ShowerLib2.Settings.Default.TextBoxBackgroundColor = Table.TextBoxBackgroundColor or Color3.fromRGB(18, 18, 19)
    ShowerLib2.Settings.Default.SideBarBackgroundColor = Table.SideBarBackgroundColor or Color3.fromRGB(28, 28, 28)
    ShowerLib2.Settings.Default.PageIndicatorBackgroundColor = Table.PageIndicatorBackgroundColor or Color3.fromRGB(16, 16, 16)

end

function ShowerLib2:Notify(Table)
    assert(Table.Text, "Text expected");
    local TextSize = Table.TextSize or 17
    local Duration = Table.Duration or 3
    local Font = Table.Font or Enum.Font.SourceSansLight
    local IsRGB = Table.RGB or Table.Rgb or false
    local DefaultColor = Table.UnderlineColor or Table.Underlinecolor or Color3.fromRGB(255, 255, 255)

    local NotifyGui = ShowerLib2:Create("ScreenGui", {
        Name = "ShowerLibNotify";
        Parent = game.CoreGui;
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    })

    local NotifyFrame = ShowerLib2:Create("Frame", {
        Parent = NotifyGui;
        BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392);
        BorderColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392);
        Position = UDim2.new(0, -1000, 0.888000011, 0);
        Size = UDim2.new(0, 220, 0, 57);
    })

    local NotifyLabel = ShowerLib2:Create("TextLabel", {
        Parent = NotifyFrame;
        BackgroundColor3 = Color3.new(1, 1, 1);
        BackgroundTransparency = 1;
        Position = UDim2.new(0.0446608812, 0, 0.191880628, 0);
        Size = UDim2.new(0, 200, 0, 34);
        Font = Font;
        Text = Table.Text;
        TextColor3 = Color3.new(1, 1, 1);
        TextSize = TextSize;
        TextWrapped = true;
    })

    local RGB = ShowerLib2:Create("Frame", {
        Name = "RGB";
        Parent = NotifyFrame;
        BackgroundColor3 = DefaultColor;
        BorderColor3 = DefaultColor;
        Position = UDim2.new(0, 0, 1, 0);
        Size = UDim2.new(0, 220, 0, 1);
    })

    function Rgb()
        while true do
            for i = 0,100 do
                BorderColor3 = Color3.fromHSV(i/100,0.75,0.75)
                BackgroundColor3 = Color3.fromHSV(i/100,0.75,0.75) 
                wait()
            end
        end
    end

    spawn(function()
        NotifyFrame:TweenPosition(UDim2.new(0.008, 0,0.888, 0), Enum.EasingDirection.In,  Enum.EasingStyle.Back, 1)
        wait(tonumber(Duration))
        NotifyFrame:TweenPosition(UDim2.new(0, -1000, 0.888000011, 0), Enum.EasingDirection.Out,  Enum.EasingStyle.Back,4.5)
        wait(5)
        NotifyGui:Destroy()
    end)

    if IsRGB then
        spawn(Rgb)
    end
end

function ShowerLib2:CreateWindow(Name)
    local Nigger = {}
    local FirstTab = false;

    ShowerLib2.Settings.ScreenGui = ShowerLib2:Create("ScreenGui", {
        Name = tostring(UIName);
        Parent = ShowerLib2.Settings.Parent;
    })

    ShowerLib2.Settings.ShowerLibMainFrame = ShowerLib2:Create("Frame", {
        Name = "ShowerLib";
        Parent = ShowerLib2.Settings.ScreenGui;
        BackgroundColor3 = Color3.fromRGB(12, 12, 12);
        BorderColor3 = Color3.fromRGB(12, 12, 12);
        Position = UDim2.new(0.310956806, 0, 0.208737865, 0);
        Size = UDim2.new(0, 425, 0, 272);
    })

    ShowerLib2.Settings.TopBar = ShowerLib2:Create("Frame", {
        Name = "TopBar";
        Parent = ShowerLib2.Settings.ShowerLibMainFrame;
        BackgroundColor3 = ShowerLib2.Settings.Default.SideBarBackgroundColor;
        BorderColor3 = ShowerLib2.Settings.Default.SideBarBackgroundColor;
        Position = UDim2.new(0.164705887, 0, 0, 0);
        Size = UDim2.new(0, 355, 0, 13);    
    })

    ShowerLib2.Settings.PageIndicator = ShowerLib2:Create("Frame", {
        Name = "PageIndicator";
        Parent = ShowerLib2.Settings.ShowerLibMainFrame;
        BackgroundColor3 = ShowerLib2.Settings.Default.PageIndicatorBackgroundColor;
        BorderColor3 = ShowerLib2.Settings.Default.PageIndicatorBackgroundColor;
        Position = UDim2.new(0.164705887, 0, 0.0477941185, 0);
        Size = UDim2.new(0, 355, 0, 23);
    })

    ShowerLib2.Settings.CurrentPageName = ShowerLib2:Create("TextLabel", {
        Parent = ShowerLib2.Settings.PageIndicator;
        BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        BackgroundTransparency = 1.000;
        Position = UDim2.new(0.030985916, 0, 0, 0);
        Size = UDim2.new(0, 100, 0, 23);
        Font = ShowerLib2.Settings.Default.ItemFont;
        Text = "NIGGER";
        TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
        TextSize = ShowerLib2.Settings.Default.ItemFontSize;
        TextWrapped = true;
        TextXAlignment = Enum.TextXAlignment.Left;
    })

    ShowerLib2.Settings.SideBar = ShowerLib2:Create("Frame", {
        Name = "SideBar";
        Parent = ShowerLib2.Settings.ShowerLibMainFrame;
        BackgroundColor3 = ShowerLib2.Settings.Default.SideBarBackgroundColor;
        BorderColor3 = ShowerLib2.Settings.Default.SideBarBackgroundColor;
        Size = UDim2.new(0, 70, 0, 272);
    })

    
    local dragging
    local dragInput
    local dragStart
    local startPos

    ShowerLib2.Settings.SideBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = ShowerLib2.Settings.ShowerLibMainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    ShowerLib2.Settings.SideBar .InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch  then
            dragInput = input
        end
    end)

    ShowerLib2.Settings.TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = ShowerLib2.Settings.ShowerLibMainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    ShowerLib2.Settings.TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch  then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            ShowerLib2.Settings.ShowerLibMainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)



    ShowerLib2.Settings.SideBarTitle = ShowerLib2:Create("TextButton", {
        Name = "Title";
        Parent = ShowerLib2.Settings.SideBar;
        BackgroundColor3 = Color3.fromRGB(45, 49, 54);
        BackgroundTransparency = 1.000;
        BorderColor3 = Color3.fromRGB(45, 49, 54);
        Position = UDim2.new(0, 0, 0.0477941185, 0);
        Size = UDim2.new(0, 70, 0, 36);
        AutoButtonColor = false;
        Font = Enum.Font.GothamBold;
        Text = Name;
        TextColor3 = Color3.fromRGB(255, 255, 255);
        TextSize = 14.000;
    })

    ShowerLib2.Settings.SideBarTitle.MouseButton1Down:connect(function()
        if not State then
            game:GetService("TweenService"):Create(ShowerLib2.Settings.SideBarTitle, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 180}):Play()
        else
            game:GetService("TweenService"):Create(ShowerLib2.Settings.SideBarTitle, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 0}):Play()
        end
        State = not State
    end)

    ShowerLib2.Settings.TabSelector = ShowerLib2:Create("Frame", {
        Name = "TabSelector";
        Parent = ShowerLib2.Settings.SideBar;
        BackgroundColor3 = ShowerLib2.Settings.Default.SideBarBackgroundColor;
        BorderColor3 = ShowerLib2.Settings.Default.SideBarBackgroundColor;
        Position = UDim2.new(0, 0, 0.261000007, 0);
        Size = UDim2.new(0, 70, 0, 201);
    })

    local UIListLayout = ShowerLib2:Create("UIListLayout", {
        Parent = ShowerLib2.Settings.TabSelector;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Padding = UDim.new(0, 5);
    })
    
    function Nigger:Section(Name)

        local Nigga = {}
        local SectionName = tostring(Name)..tostring(math.random(1, 100));

        local Vis = false;
        if FirstTab == false then
            ShowerLib2.Settings.CurrentPageName.Text = Name;
            FirstTab = true;
            Vis = true;
        end


        ShowerLib2.Tabs[SectionName] = ShowerLib2:Create("ScrollingFrame", {
            Name = Name;
            Parent = ShowerLib2.Settings.ShowerLibMainFrame;
            Active = true;
            BackgroundColor3 = Color3.fromRGB(12, 12, 12);
            BackgroundTransparency = 1.000;
            BorderColor3 = Color3.fromRGB(12, 12, 12);
            Position = UDim2.new(0.190588236, 0, 0.158088237, 0);
            Size = UDim2.new(0, 337, 0, 219);
            ScrollBarThickness = 3;
            Visible = Vis;
        })

        local ScrollLayout = ShowerLib2:Create("UIListLayout", {
            Parent = ShowerLib2.Tabs[SectionName];
            SortOrder = Enum.SortOrder.LayoutOrder;
            Padding = UDim.new(0, 5);
        })

        ScrollLayout.Changed:Connect(function()
            ShowerLib2.Tabs[SectionName].CanvasSize = UDim2.new(0, 0, 0, ( ScrollLayout.AbsoluteContentSize.Y + 5))
        end)

        local Button = ShowerLib2:Create("TextButton", {
            Name = "HomeTabButton";
            Parent = ShowerLib2.Settings.TabSelector;
            BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            BackgroundTransparency = 1.000;
            Size = UDim2.new(0, 70, 0, 21);
            AutoButtonColor = false;
            Font = ShowerLib2.Settings.Default.ItemFont;
            Text = Name;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextSize = ShowerLib2.Settings.Default.ItemFontSize;    
        })

        Button.MouseButton1Down:connect(function()
            ShowerLib2.Settings.CurrentPageName.Text = Button.Text
            for i,v in pairs(ShowerLib2.Settings.ShowerLibMainFrame:GetChildren()) do
                if v.ClassName == "ScrollingFrame" and v.Name ~= Button.Name  then
                    v.Visible = false;
                end
            end
            ShowerLib2.Tabs[SectionName].Visible = true;
        end)

        function Nigga:AddLabel(Name)
            local LabelFrame = ShowerLib2:Create("Frame", {
                Name = "Label";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local Label = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = LabelFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size = UDim2.new(0, 303, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
            })
        end

        function Nigga:AddButton(Name, Callback)

            local ButtonFrame = ShowerLib2:Create("Frame", {
                Name = "Button";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local ButtonLabel = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = ButtonFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size =  UDim2.new(0, 131, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

            local Button = ShowerLib2:Create("TextButton", {
                Name = "Button";
                Parent = ButtonFrame;
                BackgroundColor3 = ShowerLib2.Settings.Default.ButtonBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ButtonBackgroundColor;
                BorderSizePixel = 0;
                Position = UDim2.new(0.585114539, 0, 0.175925925, 0);
                Size = UDim2.new(0, 126, 0, 16);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                AutoButtonColor = false;
            })
            Button.MouseButton1Down:connect(function()
                Callback()
            end)
        end

        function Nigga:AddBind(Name,First, Callback)

            local OldBind = First.Name;
            
            local BindFrame = ShowerLib2:Create("Frame", {
                Name = "Button";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local BindLabel = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = BindFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size =  UDim2.new(0, 131, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

            local Bind = ShowerLib2:Create("TextButton", {
                Name = "Bind";
                Parent = BindFrame;
                BackgroundColor3 = ShowerLib2.Settings.Default.ButtonBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ButtonBackgroundColor;
                BorderSizePixel = 0;
                Position = UDim2.new(0.85, 0, 0.175925925, 0);
                Size = UDim2.new(0, 40, 0, 16);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = OldBind;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                AutoButtonColor = false;
            })

            Bind.MouseButton1Click:connect(function(e) 
                Bind.Text = "..."
                local a, b = game:GetService('UserInputService').InputBegan:wait();
                if a.KeyCode.Name ~= "Unknown" then
                    Bind.Text = a.KeyCode.Name
                    OldBind = a.KeyCode.Name;
                end
            end)
    
            game:GetService("UserInputService").InputBegan:connect(function(Nigger1, Nigger) 
                if not Nigger then 
                    if Nigger1.KeyCode.Name == OldBind then 
                        Callback()
                    end
                end
            end)
        end

        function Nigga:AddToggle(Name, Callback)
            local Enabled = false;

            local ToggleFrame = ShowerLib2:Create("Frame", {
                Name = "Toggle";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local ToggleLabel = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = ToggleFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size =  UDim2.new(0, 131, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

            local ToggleButton = ShowerLib2:Create("TextButton", {
                Name = "ToggleButton";
                Parent = ToggleFrame;
                BackgroundColor3 = Color3.fromRGB(255, 7, 65);
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = UDim2.new(0.92, 0, 0.25, 0);
                Size = UDim2.new(0, 17, 0, 16);
                Font = Enum.Font.SourceSans;
                Text = "";
                TextColor3 = Color3.fromRGB(0, 0, 0);
                TextSize = 14.000;        
            })

            local ToggleState = ShowerLib2:Create("ImageLabel", {
                Name = "State";
                Parent = ToggleButton;
                Active = true;
                AnchorPoint = Vector2.new(0.5, 0.5);
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.5, 0, 0.5, 0);
                Selectable = true;
                Size = UDim2.new(1, 0, 1, 0);
                Image = "rbxassetid://3570695787";
                ImageColor3 = Color3.fromRGB(175, 0, 0);
                ScaleType = Enum.ScaleType.Slice;
                SliceCenter = Rect.new(100, 100, 100, 100);
                SliceScale = 0.030;
            })

            ToggleButton.MouseButton1Down:connect(function()
                if Enabled then
                    game:GetService("TweenService"):Create(ToggleState, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageColor3 = (Color3.fromRGB(175, 0, 0))}):Play()
                else
                    game:GetService("TweenService"):Create(ToggleState, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageColor3 = (Color3.fromRGB(0, 179, 83))}):Play()
                end
                Enabled = not Enabled

                Callback(Enabled)
            end)
        end

        function Nigga:ColorPicker(Name, DefaultColor, Callback)
            local Data = {}
            local Enabled = true;
            Default = DefaultColor or Color3.fromRGB(255,255,255)
            local ColorFrame = ShowerLib2:Create("Frame", {
                Name = "ColorFrame";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local ColorLabel = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = ColorFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size =  UDim2.new(0, 131, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

            local ColorButton = ShowerLib2:Create("TextButton", {
                Name = "ColorButton";
                Parent = ColorFrame;
                BackgroundColor3 = Color3.fromRGB(255,255,255);
                BackgroundTransparency = 1.000;
                BorderSizePixel = 0;
                Position = UDim2.new(0.88, 0, 0.25, 0);
                Size = UDim2.new(0, 30, 0, 16);
                Font = Enum.Font.SourceSans;
                Text = "";
                TextColor3 = Color3.fromRGB(0, 0, 0);
                TextSize = 14.000;        
            })

            local ColorState = ShowerLib2:Create("ImageLabel", {
                Name = "State";
                Parent = ColorButton;
                Active = true;
                AnchorPoint = Vector2.new(0.5, 0.5);
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.5, 0, 0.50, 0);
                Selectable = true;
                Size = UDim2.new(1, 0, 1, 0);
                Image = "rbxassetid://3570695787";
                ImageColor3 = Default;
                ScaleType = Enum.ScaleType.Slice;
                SliceCenter = Rect.new(100, 100, 100, 100);
                SliceScale = 0.030;
            })

            local ActualColor = ShowerLib2:Create("Frame", {
                Name = "ActualColorPicker";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = Color3.fromRGB(22, 22, 22);
                BorderColor3 = Color3.fromRGB(22, 22, 22);
                Position = UDim2.new(0.0148367956, 0, 0.732431829, 0);
                Size = UDim2.new(0, 331, 0, 114);
                Visible = false;
            })

            ColorButton.MouseButton1Down:connect(function()
                if ActualColor.Visible == false then
                    ActualColor.Visible = true;
                else
                    ActualColor.Visible = false;
                end
            end)

            local PickerFrame = ShowerLib2:Create("Frame", {
                Name = "ColorPicker";
                Parent = ActualColor;
                BackgroundColor3 = Color3.fromRGB(26, 26, 26);
                BorderColor3 = Color3.fromRGB(26, 26, 26);
                Position = UDim2.new(0.0340557247, 0, 0.0964912325, 0);
                Size = UDim2.new(0, 155, 0, 91);
            })

            local ActualPicker = ShowerLib2:Create("ImageButton", {
                Name = "RGB";
                Parent = PickerFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                Position = UDim2.new(0.0597463287, 0, 0.11349152, 0);
                Size = UDim2.new(0.657302141, 1, 0.798508525, 1);
                Image = "rbxassetid://1433361550";
            })

            local PickerMarker = ShowerLib2:Create("ImageLabel", {
                Name = "Marker";
                Parent = ActualPicker;
                AnchorPoint = Vector2.new(0.5, 0.5);
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                BorderColor3 = Color3.fromRGB(255, 255, 255);
                Position = UDim2.new(0.0233191848, 0, 0.965222716, 0);
                Size = UDim2.new(0, 5, 0, 5);
                ZIndex = 5;
                Image = "rbxassetid://3570695787";
                ImageColor3 = Color3.fromRGB(28, 28, 28);
                ScaleType = Enum.ScaleType.Slice;
                SliceCenter = Rect.new(100, 100, 100, 100);
            })

            local ActualValue = ShowerLib2:Create("ImageButton", {
                Name = "Value";
                Parent = PickerFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                BorderSizePixel = 0;
                ClipsDescendants = true;
                Position = UDim2.new(0.770402253, 0, 0.113491185, 0);
                Size = UDim2.new(0.139275447, 1, 0.798508883, 1);
                ZIndex = 3;
                Image = "rbxassetid://359311684";
            })

            local PickerValue = ShowerLib2:Create("Frame", {
                Name = "Marker";
                Parent = ActualValue;
                BackgroundColor3 = Color3.fromRGB(25, 25, 25);
                BorderColor3 = Color3.fromRGB(0, 0, 0);
                BorderSizePixel = 0;
                Position = UDim2.new(-0.200239256, 0, 0, 0);
                Size = UDim2.new(0, 28, 0, 4);
                ZIndex = 5;
            })

            local RainbowToggleFrame = ShowerLib2:Create("Frame", {
                Name = "Toggle";
                Parent = ActualColor;
                BackgroundColor3 = Color3.fromRGB(18, 18, 18);
                BorderColor3 = Color3.fromRGB(18, 18, 18);
                Position = UDim2.new(0.557275534, 0, 0.0964912027, 0);
                Size = UDim2.new(0, 140, 0, 27);
            })

            local RainbowLabel = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = RainbowToggleFrame;
                BackgroundColor3 = Color3.fromRGB(18, 18, 18);
                BackgroundTransparency = 1.000;
                BorderColor3 = Color3.fromRGB(18, 18, 18);
                Position = UDim2.new(0.0340817571, 0, 0.222222224, 0);
                Size = UDim2.new(0, 65, 0, 15);
                Font = Enum.Font.GothamSemibold;
                Text = "Rainbow";
                TextColor3 = Color3.fromRGB(190, 190, 190);
                TextSize = 10.000;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

            local RainbowToggleButton = ShowerLib2:Create("TextButton", {
                Name = "ToggleButton";
                Parent = RainbowToggleFrame;
                BackgroundColor3 = Color3.fromRGB(255, 7, 65);
                BackgroundTransparency = 1.000;
                BorderSizePixel = 0;
                Position = UDim2.new(0.825198233, 0, 0.17592591, 0);
                Size = UDim2.new(0, 17, 0, 16);
                Font = Enum.Font.SourceSans;
                Text = "";
                TextColor3 = Color3.fromRGB(0, 0, 0);
                TextSize = 14.000;
            })

            local RainbowToggleState = ShowerLib2:Create("ImageLabel", {
                Name = "State";
                Parent = RainbowToggleButton;
                Active = true;
                AnchorPoint = Vector2.new(0.5, 0.5);
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.500000238, 0, 0.5, 0);
                Selectable = true;
                Size = UDim2.new(1, 0, 1, 0);
                Image = "rbxassetid://3570695787";
                ImageColor3 = Color3.fromRGB(175, 0, 0);
                ScaleType = Enum.ScaleType.Slice;
                SliceCenter = Rect.new(100, 100, 100, 100);
                SliceScale = 0.030;
            })

            function SetColor(hue,sat,val)
                Data = {hue or Data[1],sat or Data[2],val or 1}
                ColorState.ImageColor3 = Color3.fromHSV(Data[1],Data[2],Data[3])
                ActualValue.ImageColor3 = Color3.fromHSV(Data[1],Data[2],1)
                local R,G,B = ShowerLib2:HSVtoRGB(Color3.fromHSV(Data[1],Data[2],Data[3]))
                Callback(Color3.fromRGB(R,G,B))
            end

            RainbowToggleButton.MouseButton1Down:connect(function()
                if Enabled then
                    game:GetService("TweenService"):Create(RainbowToggleState, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageColor3 = (Color3.fromRGB(175, 0, 0))}):Play()
                else
                    game:GetService("TweenService"):Create(RainbowToggleState, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageColor3 = (Color3.fromRGB(0, 179, 83))}):Play()
                end
                Enabled = not Enabled
                spawn(function()
                    while wait() and Enabled do
                        local H = tick()%5/5
                        local S = 0.75
                        local V = 0.75 
                        PickerMarker:TweenPosition(UDim2.new(H,1,S,1),"InOut","Sine",0.04,true)
                        SetColor(H,S,V)        
                    end
                end)
            end)
 
            function GetXY(frame)
                local x,y = ShowerLib2.Mouse.X - frame.AbsolutePosition.X - 2,ShowerLib2.Mouse.Y - frame.AbsolutePosition.Y - 2
                local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
                x = math.clamp(x, 0, maxX);
                y = math.clamp(y, 0, maxY);
                return x/maxX,y/maxY
            end
            
            function UpdateRGB()
                local x,y = GetXY(ActualPicker)
                if x and y then
                    PickerMarker:TweenPosition(UDim2.new(x,1,y,1),"InOut","Sine",0.04,true)
                    SetColor(1 - x,1 - y)
                end
            end
            
            function UpdateValue()
                local x,y = GetXY(PickerValue.Parent)
                if x and y then
                    PickerValue:TweenPosition(UDim2.new(0,0,y,-3.5),"InOut","Sine",0.04,true)
                    SetColor(nil,nil,1 - y)
                end
            end

            game:GetService("UserInputService").InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ConnectNigger then
                        ConnectNigger:Disconnect()
                        ConnectNigger = nil
                    end
                end
            end)
            
            game:GetService("UserInputService").InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ConnectNigga then
                        ConnectNigga:Disconnect()
                        ConnectNigga = nil
                    end
                end
            end)
            
            ActualPicker.MouseButton1Down:Connect(function()
                if ConnectNigga then
                    ConnectNigga = nil
                end
                ConnectNigga = game:GetService("RunService").Stepped:Connect(function()
                    UpdateRGB()
                end)
            end)
            
            ActualValue.MouseButton1Down:Connect(function()
                if ConnectNigger then
                    ConnectNigger = nil
                end
                ConnectNigger = game:GetService("RunService").Stepped:Connect(function()
                    UpdateValue()
                end)
            end)
        end

        function Nigga:AddBox(Name, Callback)
            local Enabled = false;

            local BoxFrame = ShowerLib2:Create("Frame", {
                Name = "Box";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local BoxLabel = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = BoxFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size =  UDim2.new(0, 131, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

            local TextBox = ShowerLib2:Create("TextBox", {
                Parent = BoxFrame;
                BackgroundColor3 = ShowerLib2.Settings.Default.TextBoxBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.TextBoxBackgroundColor;
                Position = UDim2.new(0.584999979, 0, 0.175999999, 0);
                Size = UDim2.new(0, 126, 0, 16);
                Font = Enum.Font.SourceSansSemibold;
                PlaceholderColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = 14.000;
                TextStrokeColor3 = ShowerLib2.Settings.Default.ItemTextColor;
            })

            TextBox.FocusLost:Connect(function(EnterPressed)
                if not EnterPressed then return end
                Callback(TextBox.Text)
                TextBox.Text = ""
            end)
        end

        function Nigga:AddDrop(Name, Tbl, Callback)

            local Dropped = false;
            local ScrollBarThickness = 0;
            local ScrollBarSize = 27;
            local TblSize = table.getn(Tbl);
            if TblSize > 1 then
                ScrollBarThickness = 1.5;
            end

            if TblSize == 2 then
                ScrollBarSize = 54
            elseif TblSize > 2 then
                ScrollBarSize = 81
            end

            local Enabled = false;

            local DropDownFrame = ShowerLib2:Create("Frame", {
                Name = "DropDown";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local DropDownLabel = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = DropDownFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size =  UDim2.new(0, 131, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name;
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

            local DropButton = ShowerLib2:Create("ImageButton", {
                Name = "DropButton";
                Parent = DropDownFrame;
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Position = UDim2.new(0.922230303, 0, 0.175925925, 0);
                Size = UDim2.new(0, 17, 0, 16);
                AutoButtonColor = false;
                Image = "http://www.roblox.com/asset/?id=5231616421";
            })
            
            local ActualDropdown = ShowerLib2:Create("ScrollingFrame", {
                Name = SectionName;
                Parent = ShowerLib2.Tabs[SectionName];
                Active = true;
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Position = UDim2.new(0.0449676514, 0, 0.147286817, 0);
                Size = UDim2.new(0, 331, 0, ScrollBarSize);
                ScrollBarThickness = ScrollBarThickness;
                Visible = false;
                VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left;
            })

            local Layout = ShowerLib2:Create("UIListLayout", {
                Parent = ActualDropdown;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Padding = UDim.new(0, 0);
            })

            Layout.Changed:Connect(function()
                ActualDropdown.CanvasSize = UDim2.new(0, 0, 0, ( Layout.AbsoluteContentSize.Y + 5))
            end)

            for i,v in pairs(Tbl) do

                local ActualButton = ShowerLib2:Create("TextButton", {
                    Name = v;
                    Parent = ActualDropdown;
                    BackgroundColor3 = Color3.fromRGB(20, 20, 20);
                    BackgroundColor3 = Color3.fromRGB(20, 20, 20);
                    BorderSizePixel = 0;
                    Position = UDim2.new(0.0340818055, 0, 0.175925925, 0);
                    Size = UDim2.new(0, 329, 0, 23);
                    Font = ShowerLib2.Settings.Default.ItemFont;
                    Text = v;
                    TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                    TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                    AutoButtonColor = false;
                })
    
                ActualButton.MouseButton1Down:connect(function()
                    Dropped = not Dropped;
                    DropDownLabel.Text = ActualButton.Text
                    game:GetService("TweenService"):Create(DropButton, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 0}):Play()
                    ActualDropdown.Visible = false;
                    Callback(DropDownLabel.Text)
                end)
            end

            DropButton.MouseButton1Down:connect(function()
                if not Dropped then
                    game:GetService("TweenService"):Create(DropButton, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 180}):Play()
                    ActualDropdown.Visible = true;
                else
                    game:GetService("TweenService"):Create(DropButton, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 0}):Play()
                    ActualDropdown.Visible = false;
                end
                Dropped = not Dropped;
            end)
    
        end

        function Nigga:AddSlider(Name, Min, Max, Current, Callback)
            local SliderFrame = ShowerLib2:Create("Frame", {
                Name = "Slider";
                Parent = ShowerLib2.Tabs[SectionName];
                BackgroundColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                BorderColor3 = ShowerLib2.Settings.Default.ItemBackgroundColor;
                Size = UDim2.new(0, 331, 0, 27);
            })

            local SliderName = ShowerLib2:Create("TextLabel", {
                Name = "Name";
                Parent = SliderFrame;
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BackgroundTransparency = 1.000;
                Position = UDim2.new(0.0340818055, 0, 0.222222224, 0);
                Size =  UDim2.new(0, 131, 0, 15);
                Font = ShowerLib2.Settings.Default.ItemFont;
                Text = Name .. " | "..tostring(Current).."/"..tostring(Max);
                TextColor3 = ShowerLib2.Settings.Default.ItemTextColor;
                TextSize = ShowerLib2.Settings.Default.ItemFontSize;
                TextWrapped = true;
                TextXAlignment = Enum.TextXAlignment.Left;
            })

        

            local ActualSliding = ShowerLib2:Create("ImageLabel", {
                Parent = SliderFrame;
                BackgroundTransparency = 1;
                Position = UDim2.new(1, -80, 0.5, -4);
                Size = UDim2.new(0, 70, 0, 6);
                Image = "rbxassetid://3570695787";
                ImageColor3 = Color3.fromRGB(75, 75, 75);
                ScaleType = "Slice";
                SliceCenter = Rect.new(100, 100, 100, 100);
            });

            local SlidingPart = ShowerLib2:Create("ImageLabel", {
                Parent = ActualSliding;
                BackgroundTransparency = 1;
                Position = UDim2.new((Current or 0)/Max, -6, 0.5, -5);
                Size = UDim2.new(0, 10, 0, 10);
                Image = "rbxassetid://3570695787";
                ScaleType = "Slice";
                SliceCenter = Rect.new(100, 100, 100, 100);
                ImageColor3 = Color3.fromRGB(255, 255, 255);
            });

            function move(input)
                ShowerLib2.Settings.Sliding = true;
                local pos = UDim2.new(math.clamp((input.Position.X - ActualSliding.AbsolutePosition.X) / ActualSliding.AbsoluteSize.X, 0, 1), -6, 0.5, -5)
                SlidingPart:TweenPosition(pos, "Out", "Sine", 0.1, true);
                local value = math.floor(((pos.X.Scale * Max) / Max) * (Max - Min) + Min)
                SliderName.Text = Name .. " | "..tostring(value).."/"..tostring(Max);
                ShowerLib2.Settings.Sliding = false;
                Callback(value)
            end
            
            SlidingPart.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = true;
                    ShowerLib2.Settings.Sliding = false;    
                end
            end)

            SlidingPart.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false;
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    move(input)
                end
            end)
        end

        return Nigga;
    end

    return Nigger;
end

return ShowerLib2


--[[
    ShowerLib made by ShowerHead
    Documentation:

    Section A: Library

        ShowerLib:CreateWindow(<string> Name) -> Sets the name of the UI library
        ShowerLib:Destroy(<no arguments>) -> Destroys the GUI
        ShowerLib:OpenClose(<no arguments>) -> Opens / Closes the UI depending if the UI is open or not
        ShowerLib:Notify(<table>) -> Creates a notification
            -> Text (REQUIRED)
            -> TextSize (OPTIONAL)
            -> Duration (OPTIONAL)
            -> Font (OPTIONAL)
            -> IsRGB (OPTIONAL)
            -> DefaultColor (OPTIONAL)
        ShowerLib:SetSettings(<table>) -> Modifies ShowerLib Settings
            -> TabSelectorFont (OPTIONAL) -> Sets TabSelectorFont, Takes font like Enum.Fonts.SourceSansBold
            -> TabSelectorSize (OPTIONAL) -> Sets TabSelectorSize, Takes int
            -> TabSelectorColor (OPTIONAL) -> Sets TabSelectorColor, Takes int
            -> ItemFontSize (OPTIONAL) -> Sets Default TextSize, Takes int
            -> ItemBackgroundColor (OPTIONAL) -> Sets Default ItemBackgroundColor such as the button frame, Takes Color like Color3.fromRGB(255,255,255)
            -> ItemFont (OPTIONAL) -> Sets Default Font, Takes font like Enum.Fonts.SourceSansBold
            -> ItemTextColor (OPTIONAL) -> Sets Default ItemTextColor such as the button text label, Takes Color like Color3.fromRGB(255,255,255)
            -> ButtonBackgroundColor (OPTIONAL) -> Sets All the Button BackgroundColor, Takes Color like Color3.fromRGB(255,255,255)
            -> TextBoxBackgroundColor (OPTIONAL) -> Sets All the Button TextBox BackgroundColor, Takes Color like Color3.fromRGB(255,255,255)
            -> SideBarBackgroundColor (OPTIONAL) -> Sets Sidebar color, Takes Color like Color3.fromRGB(255,255,255)
            -> PageIndicatorBackgroundColor (OPTIONAL) -> Sets PageIndicatorBackgroundColor, Takes Color like Color3.fromRGB(255,255,255)

    Section B: Windows

        Window:Section(<string> Text) -> Creates a Section

    Section C: Sections

        Sections:AddBox(<string> Text, <closure / function> Callback) -> Creates a textbox
        Sections:AddToggle(<string> Text, <closure / function> Callback) -> Creates a toggle
        Sections:AddBind(<string> Text, <closure / function> Callback) -> Creates a keybind
        Sections:AddDropDown(<string> Text, <table> <closure / function> Callback) -> Creates a dropdown
        Sections:AddSlider(<string> Text, <int> Min, <int> Max, <int> CurrentValue <closure / function> Callback) -> Creates a Slider
        Sections:AddLabel(<string> Text) -> Creates a Label
        Section:ColorPicker(<string> Text, <Color3> DefaultColor, <closure / function> Callback) -> Creates a color picker

    Section D: Example

        local ShowerLib = loadstring(game:HttpGet("https://fluxteam.xyz/scripts/others/ShowerLib.lua"))()
        local Window = ShowerLib:CreateWindow("F"); --Clicking this will make it rotate.
        local HomePage = Window:Section("Home")
        
        HomePage:AddLabel("Added Labels!")

        HomePage:ColorPicker("Baseplate Color", Color3.fromRGB(255,255,255), function(Color)
            workspace.Baseplate.Color = Color
        end)

        HomePage:AddBox("Type Something!", function(Text)
            print(Text) -- returns what the user typed
        end)

        HomePage:AddSlider("Walkspeed", 16, 500, 10, function(Value)
            game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value -- Value is the value of the slider
        end)

        HomePage:AddToggle("GDK?", function(State)
            print(State) -- State will return true if the toggle is enabled or return false if its disabled
        end)

        HomePage:AddButton("Destroy GUI", function()
            ShowerLib:Destroy() -- Kills the GUI
        end)

        HomePage:AddBind("Close Keybind", Enum.KeyCode.F, function()
            ShowerLib:OpenClose() -- opens or closes the UI
        end)

        HomePage:AddDrop("Favorite Food?", {"Dick", "Pussy", "Cow", "Pig", "Bacon"}, function(Selected)
            print(Selected) -- prints what the user selected
        end)
]]
