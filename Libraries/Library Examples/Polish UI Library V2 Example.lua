local lib = loadstring(game:HttpGet("https://pastebin.com/raw/SR1QawZs",true))()

Examples of using the UI.

local Tab1 = lib:Tab("Tab1")

Tab1:Label("Label Test")

Tab1:Toggle("Enable Gravity", function(arg)
    if arg then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 200
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

Tab1:Button("Test")

local Tab2 = lib:Tab("Tab2")

Tab2:Slider("Walkspeed",16,200, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

Tab2:TextBox("Print", function(arg)
    print(arg)
end)

Have fun.