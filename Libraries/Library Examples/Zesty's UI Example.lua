local lib = loadstring(game:HttpGet"https://fluxteam.xyz/external-files/lib.lua")()

lib:CreateWindow(title)
local window = lib:CreateWindow("window title")
 
window:AddButton(title, callback)
window:AddButton("Button",function()
    -- button function
    print("use fluxus, its cool!")
end)

window:AddToggle(title, callback)
local tog1 = false
window:AddToggle("Toggle", function()
    -- toggle function
    tog1 = not tog1
    print(tostring(tog1))
end)

window:AddSlider(title, minvalue, maxvalue, startpoint, callback)
window:AddSlider("Slider",0, 100, 0, function(var)
    -- slider function
    print(var)
end)