local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
	Title = "Example GUI",
	Style = 1,
	SizeX = 300,
	SizeY = 350,
	Theme = "Dark",
	ColorOverrides = {
		MainFrame = Color3.fromRGB(0, 0, 0)
	}
})

local floors = {
	"Floor 1",
	"Floor 2",
	"Floor 3",
	"Floor 4",
	"Floor 5"
}

local Window1 = X.New({Title = "Toggles"})
local Window2 = X.New({Title = "Selections"})

local A = Window1.Button({
	Text = "Kill All",
	Callback = function()
		print("hello")
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "This function can get you banned in up-to-date servers; use at your own risk."
			})
		end
	}
})

local B = Window1.Toggle({
	Text = "I'm a switch",
	Callback = function(Value)
		print(Value)
	end,
	Enabled = false
})

local C = Window1.Slider({
	Text = "Slip and... you get the idea",
	Callback = function(Value)
		print(Value)
	end,
	Min = 200,
	Max = 400,
	Def = 300
})

local D = Window1.Dropdown({
	Text = "Dropping care package",
	Callback = function(Value)
		print(Value)
	end,
	Options = floors,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Test alert!"
			})
		end
	}
})

local E = Window1.ChipSet({
	Text = "Chipping away",
	Callback = function(ChipSet)
		table.foreach(ChipSet, function(Option, Value)
			print(Option, Value)
		end)
	end,
	Options = {
		ESP = true,
		TeamCheck = false,
		UselessBool = {
			Enabled = true,
			Menu = {
				Information = function(self)
					X.Banner({
						Text = "This bool has absolutely no purpose whatsoever."
					})
				end
			}
		}
	}
})

local F = Window1.DataTable({
	Text = "Chipping away",
	Callback = function(ChipSet)
		table.foreach(ChipSet, function(Option, Value)
			print(Option, Value)
		end)
	end,
	Options = {
		ESP2 = true,
		TeamCheck2 = false,
		UselessBool2 = {
			Enabled = true,
			Menu = {
				Information = function(self)
					X.Banner({
						Text = "This bool ALSO has absolutely no purpose. SorrWindow1."
					})
				end
			}
		}
	}
})

local G = Window1.ColorPicker({
	Text = "ESP Colour",
	Default = Color3.fromRGB(0,255,110),
	Callback = function(Value)
		print("RGB:", Value.R * 255, Value.G * 255, Value.B * 255)
	end,
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "This changes the color of your ESP."
			})
		end
	}
})

local H = Window1.TextField({
	Text = "Country",
	Callback = function(Value)
		print(Value)
	end,
	Menu = {
		GB = function(self)
			self.SetText("GB")
		end,
		JP = function(self)
			self.SetText("JP")
		end,
		KO = function(self)
			self.SetText("KO")
		end
	}
})