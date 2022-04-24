How to get Started
first you want to add the UI library to your script

local library = loadstring(game:HttpGet("https://zypher.wtf/UI-Lib"))()

After adding the UI library to your script you want to add the main. From here you will add categories.

local main = library:CreateMain(<string, projectName>)

Now you can add your first category. Categories are used to sort your sections and make it easier for the player to use.

local category = library:CreateCategory(<string, categoryName>, <imageID>)

Inside the category you can now create a section. Here you can put all your buttons, sliders, etc.

local section = category:CreateSection(<string, sectionName>)

Example
You now have fully setup your environment to start working on the interactables. Your code should look something like this

local library = loadstring(game:HttpGet("https://zypher.wtf/UI-Lib"))()

local main = library:CreateMain("Example")
 
local category = main:CreateCategory("Category")
 
local section = category:CreateSection("Section")


Interactables
Here is a list of interactables you can add to your section.

Button, Toggle, Slider, Textbox, Dropdown, Keybind, Colorpicker

Adding a interactable will work with the same script, as shown down here

section:Create(
    <string, interactableType>,
    <string, interactableName>,
    <function>,
    <options>
)

First were going to start by adding a button to our section. We also added the animated option. This is optional!

section:Create(
    "Button",
    "Button",
    function()
        print("button pressed")
    end,
    {
        animated = true,
    }
)

Next were going to add the toggle, this can be used for toggling on and off scripts. Such as autofarms. We also added the default option. Here you can choose the starting state of your toggle. This is optional!

section:Create(
    "Toggle",
    "Toggle",
    function(state)
        print("Current state:", state)
    end,
    {
        default = true,
    }
)

Another interactable is the Slider. The slider allows the player to change values. This is mainly used for scripts which needs a variable input.

section:Create(
    "Slider",
    "Slider",
    function(value)
        print(value)
    end,
    {
        min = 0,
        max = 5,
        -- Optional
        default = 2,
        precise = true, -- ex: 0.1, 0.2, 0.3
        changablevalue = true
    }
)

You can also add a TextBox. Players can add a custom input which can be handled by the script.

section:Create(
    "TextBox",
    "TextBox",
    function(input)
        print("Input changed to:", input)
    end,
    {
        text = "I am a textbox"
    }
)

A keybind can be used to run functions upon a keypress. The key used can be configured in the options table. A list of keycodes can be found here

section:Create(
    "KeyBind",
    "KeyBind", 
    function()
        print("Key pressed")
    end,
    {
        default = Enum.KeyCode.K
    }
)

Next off we have the dropdown. Dropdowns are very useful when you want to list stuff and dont want tons of buttons for each one.

section:Create(
    "DropDown",
    "DropDown", 
    function(current)
        print("Selected to:", current)
    end,
    {
        options = {
            "First",
            "Second",
            "Third",
            "4th",
            "5th",
            "6th"
        },
         -- Optional
        default = "First",
        search = true
    }
)

Last but not least, we have the ColorPicker. Colorpicker allows the player pick a color. Like changing ESP color, crosshairs, etc.

Section:Create(
    "ColorPicker",
    "ColorPicker",
    function(color)
        print("Current color:", color)
    end,
    {
        default = Color3.fromRGB(255,255,255)
    }
)
Final Example
Down here you will have a full example including the ui library. You can use this to get started, but we recommend you to read the documentation.

local library = loadstring(game:HttpGet("https://zypher.wtf/UI-Lib"))()

local main = library:CreateMain("Example")

local category = main:CreateCategory("Category")

local section = category:CreateSection("Section")

section:Create(
    "Button",
    "Button",
    function()
        print("button pressed")
    end,
    {
        animated = true,
    }
)
section:Create(
    "Toggle",
    "Toggle",
    function(state)
        print("Current state:", state)
    end,
    {
        default = true,
    }
)section:Create(
  "Slider",
  "Slider",
  function(value)
      print(value)
  end,
  {
      min = 0,
      max = 5,
      -- Optional
      default = 2,
      precise = true, -- ex: 0.1, 0.2, 0.3
      changablevalue = true
  }
)
section:Create(
    "TextBox",
    "TextBox",
    function(input)
        print("Input changed to:", input)
    end,
    {
        text = "I am a textbox"
    }
)
section:Create(
    "KeyBind",
    "KeyBind", 
    function()
        print("Key pressed")
    end,
    {
        default = Enum.KeyCode.K
    }
)
section:Create(
    "DropDown",
    "DropDown", 
    function(current)
        print("Selected to:", current)
    end,
    {
        options = {
            "First",
            "Second",
            "Third",
            "4th",
            "5th",
            "6th"
        },
         -- Optional
        default = "First",
        search = true
    })
section:Create(
    "ColorPicker",
    "ColorPicker", 
    function(Color)
        print("Current color:", Color)
    end,
    {
        default = Color3.fromRGB(0,255,255)
    }
)