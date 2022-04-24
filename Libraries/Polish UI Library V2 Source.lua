local Library = {}
local TabXPos = 30

local UILib = Instance.new("ScreenGui")
UILib.Name = "UILib"
UILib.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

function Library:Tab(text)
	
	local Tab = Instance.new("TextLabel")
	local Underline = Instance.new("Frame")
	local Minimize = Instance.new("ImageButton")
	local TabFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local ContainerSize = 0
	local Minimized = false
	
	local function Resize(value)
		ContainerSize = ContainerSize + value
		TabFrame.Size = UDim2.new(0, 167, 0, ContainerSize)
	end
	
	
	
	Tab.Name = text
	Tab.Parent = UILib
	Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Tab.BorderSizePixel = 0
	Tab.Position = UDim2.new(0, TabXPos, 0, 30)
	Tab.Size = UDim2.new(0, 167, 0, 34)
	Tab.Font = Enum.Font.SourceSansLight
	Tab.Text = "   "..text
	Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	Tab.TextSize = 19.000
	Tab.TextXAlignment = Enum.TextXAlignment.Left
	
	TabXPos = TabXPos + 200
	
	Underline.Name = "Underline"
	Underline.Parent = Tab
	Underline.BackgroundColor3 = Color3.fromRGB(245, 136, 69)
	Underline.BorderSizePixel = 0
	Underline.Position = UDim2.new(0, 0, 1, 0)
	Underline.Size = UDim2.new(0, 167, 0, 1)
	
	Minimize.Name = "Minimize"
	Minimize.Parent = Tab
	Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Minimize.BackgroundTransparency = 1.000
	Minimize.BorderSizePixel = 0
	Minimize.Position = UDim2.new(0.810650885, 0, 0.117647059, 0)
	Minimize.Size = UDim2.new(0, 25, 0, 25)
	Minimize.Image = "rbxassetid://5165666242"
	Minimize.MouseButton1Down:Connect(function()
		if not Minimized then
			game:GetService("TweenService"):Create(Minimize, TweenInfo.new(0.3), {Rotation = -90}):Play()
			TabFrame:TweenSize(UDim2.new(0, 167, 0, 0))
			Minimized = true
		else
			game:GetService("TweenService"):Create(Minimize, TweenInfo.new(0.3), {Rotation = 0}):Play()
			TabFrame:TweenSize(UDim2.new(0, 167, 0, ContainerSize))
			Minimized = false
		end
	end)
	
	TabFrame.Name = "TabFrame"
	TabFrame.Parent = Tab
	TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TabFrame.BorderSizePixel = 0
	TabFrame.Position = UDim2.new(0, 0, 1.02941179, 0)
	TabFrame.Size = UDim2.new(0, 167, 0, ContainerSize)
	TabFrame.ClipsDescendants = true
	
	UIListLayout.Parent = TabFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)
	
	UIPadding.Parent = TabFrame
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingRight = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 5)
	
	local a = {}
	
	function a:Button(text, callback)
		Resize(35)
		callback = callback or function()end
		
		local Button = Instance.new("TextButton")
		
		Button.Name = text
		Button.Parent = TabFrame
		Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(0.029940119, 0, 0.0500000007, 0)
		Button.Size = UDim2.new(0, 157, 0, 28)
		Button.AutoButtonColor = false
		Button.Font = Enum.Font.SourceSansLight
		Button.Text = text
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.TextSize = 19.000
		Button.MouseButton1Down:Connect(callback)
		Button.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
		end)
		
		Button.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
		end)
	end
	
	function a:Toggle(text, callback)
		Resize(35)
		local toggled = false
		callback = callback or function()end
		
		local Toggle = Instance.new("Frame")
		local ToggleName = Instance.new("TextLabel")
		local TextButton = Instance.new("TextButton")
		
		Toggle.Name = text
		Toggle.Parent = TabFrame
		Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Toggle.BorderSizePixel = 0
		Toggle.Size = UDim2.new(0, 157, 0, 28)
		
		ToggleName.Name = "ToggleName"
		ToggleName.Parent = Toggle
		ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.BackgroundTransparency = 1.000
		ToggleName.BorderSizePixel = 0
		ToggleName.Size = UDim2.new(0, 123, 0, 28)
		ToggleName.Font = Enum.Font.SourceSansLight
		ToggleName.Text = text
		ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
		ToggleName.TextSize = 19.000
		
		TextButton.Parent = Toggle
		TextButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		TextButton.BorderSizePixel = 0
		TextButton.Position = UDim2.new(0.830437362, 0, 0.137647361, 0)
		TextButton.Size = UDim2.new(0, 24, 0, 20)
		TextButton.AutoButtonColor = false
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.TextSize = 14.000
		TextButton.TextTransparency = 1.000
		TextButton.MouseButton1Down:Connect(function()
			if TextButton.BackgroundColor3 == Color3.fromRGB(255, 0, 0) then
				callback(true)
				game:GetService("TweenService"):Create(TextButton, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}):Play()
			else
				callback(false)
				game:GetService("TweenService"):Create(TextButton, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
			end
		end)
	end
	
	function a:TextBox(text, callback)
		Resize(35)
		local Box = Instance.new("TextBox")
		callback = callback or function()end
		local value = Box.Text
		
		Box.Name = text
		Box.Parent = TabFrame
		Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Box.BorderSizePixel = 0
		Box.Size = UDim2.new(0, 157, 0, 28)
		Box.Font = Enum.Font.SourceSansLight
		Box.PlaceholderText = text
		Box.Text = ""
		Box.TextColor3 = Color3.fromRGB(255, 255, 255)
		Box.TextSize = 19.000
		Box.FocusLost:Connect(function()
			callback = value
		end)
	end
	
	function a:Slider(text, minvalue, maxvalue, callback)
		Resize(35)
		local Slider = Instance.new("Frame")
		local SliderName = Instance.new("TextLabel")
		local SliderValue = Instance.new("TextLabel")
		local SliderButton = Instance.new("TextButton")
		local SliderInner = Instance.new("Frame")
		
		Slider.Name = text
		Slider.Parent = TabFrame
		Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(0, 157, 0, 28)
		
		SliderName.Name = "SliderName"
		SliderName.Parent = Slider
		SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.BackgroundTransparency = 1.000
		SliderName.Size = UDim2.new(0, 48, 0, 14)
		SliderName.Font = Enum.Font.SourceSansLight
		SliderName.Text = "  "..text
		SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
		SliderName.TextScaled = true
		SliderName.TextSize = 14.000
		SliderName.TextWrapped = true
		SliderName.TextXAlignment = Enum.TextXAlignment.Left
		
		SliderValue.Name = "SliderValue"
		SliderValue.Parent = Slider
		SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.BackgroundTransparency = 1.000
		SliderValue.Position = UDim2.new(0.783439517, 0, 0, 0)
		SliderValue.Size = UDim2.new(0, 31, 0, 14)
		SliderValue.Font = Enum.Font.SourceSansLight
		SliderValue.Text = "  "..minvalue
		SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.TextScaled = true
		SliderValue.TextSize = 14.000
		SliderValue.TextWrapped = true
		
		SliderButton.Name = "SliderButton"
		SliderButton.Parent = Slider
		SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderButton.Position = UDim2.new(0.0320000015, 0, 0.600000024, 0)
		SliderButton.Size = UDim2.new(0, 146, 0.107143722, 4)
		SliderButton.AutoButtonColor = false
		SliderButton.Font = Enum.Font.SourceSans
		SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		SliderButton.TextSize = 14.000
		SliderButton.TextTransparency = 1.000
		
		SliderInner.Name = "SliderInner"
		SliderInner.Parent = SliderButton
		SliderInner.BackgroundColor3 = Color3.fromRGB(245, 136, 69)
		SliderInner.BorderSizePixel = 0
		SliderInner.Size = UDim2.new(0, 0, 0, 7)
		
		-----Values-----
		minvalue = minvalue or 0
		maxvalue = maxvalue or 100
		 
		 
		-----Callback-----
		callback = callback or function() end
		 
		 
		-----Variables-----
		local mouse = game.Players.LocalPlayer:GetMouse()
		local uis = game:GetService("UserInputService")
		local Value;
		 
		 
		 
		 
		-----Main Code-----
		 
		SliderButton.MouseButton1Down:Connect(function()
		    Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 146) * SliderInner.AbsoluteSize.X) + tonumber(minvalue)) or 0
		    pcall(function()
		        callback(Value)
		    end)
		    SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 146), 0, 7)
		    moveconnection = mouse.Move:Connect(function()
		        SliderValue.Text = Value
		        Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 146) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
		        pcall(function()
		            callback(Value)
		        end)
		        SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 146), 0, 7)
		    end)
		    releaseconnection = uis.InputEnded:Connect(function(Mouse)
		        if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
		            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 146) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
		            pcall(function()
		                callback(Value)
		            end)
		            SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 146), 0, 7)
		            moveconnection:Disconnect()
		            releaseconnection:Disconnect()
		        end
		    end)
		end)
	end
	
	function a:Label(text)
		Resize(35)
		local Label = Instance.new("TextLabel")
		
		Label.Name = text
		Label.Parent = TabFrame
		Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Label.BorderSizePixel = 0
		Label.Size = UDim2.new(0, 157, 0, 28)
		Label.Font = Enum.Font.SourceSansLight
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(255, 255, 255)
		Label.TextSize = 19.000
	end
	return a;
end
return Library;