local Services = setmetatable({}, {__index = function(t, i) return game:GetService(i) end})
local Client = Services.Players.LocalPlayer

Updated