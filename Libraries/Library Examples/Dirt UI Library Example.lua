local Lib = loadstring(game:HttpGet("https://pastebin.com/raw/LWzMC6WK",true))()
local Window = Lib:CreateWindow("Example GUI")
local Table = {}

Window:Section("Section")

Window:Button("Button",function()
  print("Nice")
end)

Window:Toggle("Toggle", {
  default = true,
  location = Table,
  flag = "Toggle"
}, function()
  print(Table["Toggle"])
end)

Window:Slider("Slider", {
  location = Table,
  min = 1,
  max = 64,
  default = 32,
  precise = true, --// 0.00 Instead of 0
  flag = "Slider"
}, function()
  print(Table["Slider"])
end)

Window:Dropdown("Select Player", {
  location = Table,
  flag = "Dropdown",
  search = true, --// Adds Search Bar
  list = {}, --// Wont work when PlayerList = true
  PlayerList = true
}, function()
  print(Table["Dropdown"])
end)

Window:Bind("KeyBind", {
  location = Table,
  flag = "KeyBind",
  default = Enum.KeyCode.B
}, function()
  print(Table["KeyBind"])
end)

Window:Box("Box", {
  location = Table,
  flag = "Box",
  type = "number", --// Turns The List Into The Players In The Server
  hold = "Numbers" --// PlaceHolder Text
}, function()
  print(Table["Box"])
end)

Window:Search(Color3.fromRGB(255,0,255))