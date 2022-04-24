
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