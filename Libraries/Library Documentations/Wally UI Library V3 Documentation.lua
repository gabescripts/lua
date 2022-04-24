
-----
Main

local library = loadstring(game:HttpGet(('https://pastebin.com/raw/FsJak6AT')))() 

Put this at the start of your script.
-----
Window / Section

local window = library:CreateWindow("Window")

The section of your dropdown
-----
Folder

local folder = w:CreateFolder("Folder")

The section inside of the section
-----
Label

b:Label("Pretty Useless NGL",Color3.fromRGB(38,38,38),Color3.fromRGB(0,216,111)) --BgColor,TextColor

Make sure to change "B" To what the folder is called / What the window is called
-----
Button

b:Button("Button",function()
    print("Elym Winning")
end)

Change "Button" to what the button will show up as.
-----
Toggle

b:Toggle("Toggle",function(bool)
    shared.toggle = bool
    print(shared.toggle)
end)

use external varible
-----
Slider

b:Slider("Slider",10,30,function(value) --MinValue,MaxValue
    print(value)
end)

Says it all.
-----
Dropdown

b:Dropdown("Dropdown",{"A","B","C"},function(mob)
    print(mob)
end)

Mob is what you chose. You can change it. A,B,C are the dropdown options. 
-----
Bind

b:Bind("Bind",Enum.KeyCode.C,function() --Default bind
    print("Yes")
end)

"Bind" is what the text is. Change C to the deafult bind. When the bind is pressed something happens. 
The bind can be changed by the user.
-----
TextBox

b:Box("Box","number",function(value) -- "number" or "string"
    print(value)
end)

Change "number" to "string" if you want text to go in there instead of numbers.
-----
No need to add anything else. Bare minimums. Enjoy.