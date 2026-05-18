repeat task.wait() until game:IsLoaded() and pcall(function() return game.Players.LocalPlayer end)
local Services = setmetatable({}, {__index = function(self, service) return game:GetService(service) end})

local Client = Services.Players.LocalPlayer
local Camera = Services.Workspace.CurrentCamera
local Mouse = Client:GetMouse()

local Functions = {"getprotos", "getsenv", "firetouchinterest", "getgc", "islclosure", "getconnections", "firesignal", "identifyexecutor", "loadstring", "queue_on_teleport", "hookmetamethod", "getscriptclosure", "getconstants", "getupvalues", "hookfunction", "newcclosure", "getfenv", "checkcaller", "fireproximityprompt", "fireclickdetector", "isfile", "isfolder", "makefolder", "readfile", "writefile"}

--// Drawing Notification System
local active_notifications = {}
local config = {
  spacing = 25,          
  duration = 3,          
  fade_speed = 2,        
  lerp_speed = 10,       
  
  -- Next.js Braille Spinner Configuration
  grid_cols = 2,       -- Columns
  grid_rows = 4,       -- Rows (Taller than standard 2x4 braille as requested)
  dot_spacing = 3,     -- Distance between dots
  dot_radius = 1.5,    -- Size of the individual braille dots
  spin_speed = 20,     -- Frames per second for the snake animation
  snake_length = 5     -- How many dots are visible in the spinning "tail"
}

--// Dynamically generate the clockwise path around any 2xN grid
local function generate_perimeter_path(cols, rows)
    local path = {}
    -- Top edge (Left to Right)
    for c = 1, cols do table.insert(path, {c, 1}) end
    -- Right edge (Top to Bottom)
    for r = 2, rows do table.insert(path, {cols, r}) end
    -- Bottom edge (Right to Left)
    for c = cols - 1, 1, -1 do table.insert(path, {c, rows}) end
    -- Left edge (Bottom to Top)
    for r = rows - 1, 2, -1 do table.insert(path, {1, r}) end
    return path
end
local braille_path = generate_perimeter_path(config.grid_cols, config.grid_rows)

--// Drawing Notification RunService Connection
Services.RunService.RenderStepped:Connect(function(delta_time)
  for index = #active_notifications, 1, -1 do
    local data = active_notifications[index]
    local drawing_obj = data.drawing

    local current_pos = drawing_obj.Position
    local new_y = current_pos.Y + (data.target_y - current_pos.Y) * config.lerp_speed * delta_time
    drawing_obj.Position = Vector2.new(current_pos.X, new_y)

    data.time_alive = data.time_alive + delta_time

    -- Handle the Next.js CLI Braille Animation
    if data.is_loading and data.dots then
        local text_bounds = drawing_obj.TextBounds
        
        local grid_width = (config.grid_cols - 1) * config.dot_spacing
        local grid_height = (config.grid_rows - 1) * config.dot_spacing

        -- Position the grid to the left of the text, perfectly centered vertically
        local start_x = current_pos.X - (text_bounds.X / 2) - grid_width - 12
        local start_y = current_pos.Y + (text_bounds.Y / 2) - (grid_height / 2) 

        -- Determine the leading index of our "snake"
        local active_index = (math.floor(data.time_alive * config.spin_speed) % #data.dots) + 1

        for i, dot in ipairs(data.dots) do
            -- Update position
            local coord = braille_path[i]
            dot.Position = Vector2.new(
                start_x + ((coord[1] - 1) * config.dot_spacing),
                start_y + ((coord[2] - 1) * config.dot_spacing)
            )
            
            -- Check if this specific dot falls within the trailing "snake" length
            local is_active = false
            for s = 0, config.snake_length - 1 do
                -- We wrap around the array backwards using modulo arithmetic
                local check_index = ((active_index - 1 - s) % #data.dots)
                if check_index < 0 then check_index = check_index + #data.dots end
                check_index = check_index + 1
                
                if i == check_index then
                    is_active = true
                    break
                end
            end

            -- Sync transparency with text fade, but hide non-active dots
            if is_active then
                -- Optional: Add fading tail logic by multiplying by (1 - (s / snake_length)) here
                dot.Transparency = drawing_obj.Transparency 
            else
                dot.Transparency = 0 
            end
        end
    end

    -- Fade-out logic
    if data.time_alive >= config.duration then
      local new_transparency = drawing_obj.Transparency - (config.fade_speed * delta_time)
      drawing_obj.Transparency = new_transparency

      if data.dots then
          for _, dot in ipairs(data.dots) do
              -- Only fade the ones that are currently visible
              if dot.Transparency > 0 then
                  dot.Transparency = new_transparency
              end
          end
      end

      if drawing_obj.Transparency <= 0 then
        drawing_obj:Remove()
        if data.dots then
            for _, dot in ipairs(data.dots) do
                dot:Remove()
            end
        end
        table.remove(active_notifications, index)
      end
    end
  end
end)

local Get = setmetatable({}, {
  __call = function(_, Method, Array)
    local Target, Distance = nil, ((Method == "Mouse" or Method == "Center") and Array and Array.Radius) or math.huge
    local Mouse, Camera = Client:GetMouse(), Services.Workspace.CurrentCamera

    local function Authorized(player)
      return Client.Character and player.Character and Client.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
    end

    for _, player in next, Services.Players:GetPlayers() do
      --// Avoid Checks For Name Finder
      if Method == "Name" and Array and Array.Name and typeof(Array and Array.Name) == "string" and #Array.Name > 0 then
        local Name = string.sub(player.Name:lower(), 1, #Array.Name) == Array.Name:lower()
        local Display = string.sub(player.DisplayName:lower(), 1, #Array.Name) == Array.Name:lower()

        if Display or Name then return player end
      end

      --// Checks For Other Methods
      if not Authorized(player) then continue end;
      if Array and Array.TeamCheck and player.Team == Client.Team then continue end;

      local ClientPart, PlayerPart = Client.Character:FindFirstChild("Head"), player.Character:FindFirstChild("Head")

      if Method == "Nearest" and Client ~= player then
        local Magnitude = (PlayerPart.Position - ClientPart.Position).Magnitude

        if Magnitude < Distance then Target, Distance = player, Magnitude end
      elseif Method == "Mouse" and Client ~= player then
        local ScreenPoint, OnScreen = Camera:WorldToScreenPoint(PlayerPart.Position)
        local ScreenPos, MousePos = Vector2.new(ScreenPoint.X, ScreenPoint.Y), Vector2.new(Mouse.X, Mouse.Y)
        local Magnitude = (ScreenPos - MousePos).Magnitude
  
        if Magnitude < Distance and OnScreen then Target, Distance = player, Magnitude end
      elseif Method == "Center" and Client ~= player then
        local Viewpoint, OnScreen = Camera:WorldToViewportPoint(PlayerPart.Position)
        local ViewPos, CenterPos = Vector2.new(Viewpoint.X, Viewpoint.Y), (Camera.ViewportSize / 2)
        local Magnitude = (ViewPos - CenterPos).Magnitude

        if Magnitude < Distance and OnScreen then Target, Distance = player, Magnitude end
      end
    end

    if Method == "LastUpdate" then
      local Time = string.split(Services.MarketplaceService:GetProductInfo(game.PlaceId).Updated, "T")[1]
      local TimeSplit = string.split(Time, "-")
      
      local OldUnix = os.time({year = tonumber(TimeSplit[1]), month = tonumber(TimeSplit[2]), day = tonumber(TimeSplit[3])})
      local DaysPast = (os.time() - OldUnix) / 86400
      
      local YearFormat = DaysPast >= 365 and string.format("%i %s ago", math.floor(DaysPast / 365), (math.floor(DaysPast / 365) <= 1 and "year") or "years")
      local MonthFormat = DaysPast >= 30 and string.format("%i %s ago", math.floor(DaysPast / 30), (math.floor(DaysPast / 30) <= 1 and "month") or "months")
      local WeekFormat = DaysPast >= 7 and string.format("%i %s ago", math.floor(DaysPast / 7), (math.floor(DaysPast / 7) <= 1 and "week") or "weeks")
      local DayFormat = DaysPast < 30 and DaysPast >= 1 and string.format("%i %s ago", math.floor(DaysPast / 1), (math.floor(DaysPast / 1) <= 1 and "day") or "days")
      local HourFormat = DaysPast < 1 and (os.time() - OldUnix) / 3600 >= 1 and string.format("%i %s ago", math.floor((os.time() - OldUnix) / 3600), (math.floor((os.time() - OldUnix) / 3600) <= 1 and "hour") or "hours")
      local SecondFormat = (os.time() - OldUnix) / 3600 < 1 and "Few seconds ago"
    
      Target = YearFormat or MonthFormat or WeekFormat or DayFormat or HourFormat or SecondFormat
    end

    return Target
  end
})

return setmetatable({}, {
  __index = function(self, Function : Name)
    if Function == "Notify" then return function(title, text, image) Services.StarterGui:SetCore("SendNotification", {Title = title, Text = text, Icon = string.format("rbxthumb://type=Asset&id=%i&w=420&h=420", image)}) end end;
    if Function == "Request" then return (syn and syn.request) or (http and http.request) or request or http_request end;
    if Function == "Hook" then return hookfunc or hookfunction end;
    if Function == "Camera" then return Camera end;
    if Function == "Mouse" then return Mouse end;
    if Function == "Client" then return Client end;
    if Function == "Get" then return Get end;

    if Function == "Alert" then
      return function(is_loading: boolean, text_content: string)
        if type(is_loading) == "string" then
            text_content = is_loading
            is_loading = false
        end

        -- Finish previous loading animations
        for _, data in ipairs(active_notifications) do
            if data.is_loading then
                data.is_loading = false
                data.drawing.Text = "[OK] " .. data.base_text 
                
                -- Cleanup the physical braille dots
                if data.dots then
                    for _, dot in ipairs(data.dots) do
                        dot:Remove()
                    end
                    data.dots = nil
                end
            end
        end

        local center_screen = Camera.ViewportSize / 2
        local base_position = center_screen + Vector2.new(0, 150) 

        local text_obj = Drawing.new("Text")
        text_obj.Size = 20
        text_obj.Visible = true
        text_obj.Center = true
        text_obj.Font = 3 -- Monospace
        text_obj.Color = Color3.fromRGB(255, 255, 255)
        text_obj.Transparency = 1 
        text_obj.Position = base_position

        local dots = {}

        if is_loading then
            text_obj.Text = tostring(text_content)
            
            -- Create a dot for every position on the perimeter path
            for i = 1, #braille_path do
                local dot = Drawing.new("Circle")
                dot.Radius = config.dot_radius
                dot.Filled = true
                dot.Color = Color3.fromRGB(255, 255, 255)
                dot.Transparency = 0 -- Hidden by default, animation loop handles visibility
                dot.Visible = true
                table.insert(dots, dot)
            end
        else
            text_obj.Text = "> " .. tostring(text_content)
        end

        local notif_data = {
          drawing = text_obj,
          dots = dots,
          target_y = base_position.Y,
          time_alive = 0,
          base_text = tostring(text_content),
          is_loading = is_loading
        }

        for index, data in ipairs(active_notifications) do
          data.target_y = base_position.Y - (index * config.spacing)
        end

        table.insert(active_notifications, 1, notif_data)
      end
    end

    if Function == "Touch" then
      return function(Part1, Part2)
        firetouchinterest(Part1, Part2, 0); firetouchinterest(Part1, Part2, 1);
      end
    end
    if Function == "Teleport" then
      return function(Position : Vector3)
        Client.Character.HumanoidRootPart.CFrame = Client.Character.HumanoidRootPart.CFrame.Rotation + Position
      end
    end
    if Function == "Convert" then
      return function(Seconds : Number)
        return string.format("%02i:%02i:%02i", math.floor(Seconds / 3600), math.floor(Seconds / 60) % 60, math.floor(Seconds % 60))
      end
    end
    if Function == "TeleportQueue" then
      return function(Script : String)
        local teleport_queue = (syn and syn.queue_on_teleport) or queue_on_teleport
        return teleport_queue(Script)
      end
    end
    if Function == "Revert" then
      return function(Input : Number, Letters : Table)
        local Letters, Converted = letters or {"K", "M", "B", "T"}, Input

        if string.match(Converted, ",") then Converted = string.gsub(Converted, ",", "") end
        if not string.match(Converted, "%a") then return tonumber(Converted) end

        return math.pow(10, table.find(Letters, string.upper(string.match(Converted, "%a"))) * 3) * tonumber(string.match(Converted, "%d+.%d+") or string.match(Converted, "(%d+)%a"))
      end
    end
    if Function == "CheckExploit" then
      local Executor = identifyexecutor and identifyexecutor() or "Your Executor"
      local Supported = {"Synapse X", "ScriptWare", "ScriptWare Mac", "Krnl"}

      return function()
        if syn then return true, Executor end
        for _, func in next, Functions do
          if getgenv()[func] then continue end;
          return false, string.format("%s Is Not Compatible!", Executor)
        end
        if not table.find(Supported, Executor) then 
          return false, string.format("%s Is Not Compatible!", Executor)
        end
        return true, Executor
      end
    end
    if Function == "GetThread" then
      if syn then return syn.get_thread_identity end
      return getthreadidentity or getthreadcontext or getidentity
    end
    if Function == "SetThread" then
      if syn then return syn.set_thread_identity end
      return setthreadidentity or setthreadcontext or setidentity
    end
    if Function == "UnixToDate" then
      return function(Time : Unix)
        local Seconds_Passed = os.time() - Time
        local Minutes_Passed = math.floor(Seconds_Passed / 60)
        local Hours_Passed = math.floor(Minutes_Passed / 60) 
        local Days_Passed = math.floor(Hours_Passed / 24)
        local Months_Passed = math.floor(Days_Passed / 31)
        local Years_Passed = math.floor(Months_Passed / 12)
        
        return (Years_Passed > 0 and string.format("%i year%s ago", Years_Passed, Years_Passed > 1 and "s" or "")) or (Months_Passed > 0 and string.format("%i month%s ago", Months_Passed % 12, Months_Passed > 1 and "s" or "")) or (Days_Passed > 0 and string.format("%i day%s ago", Days_Passed % 31, Days_Passed > 1 and "s" or "")) or (Hours_Passed > 0 and string.format("%i hour%s ago", Hours_Passed % 24, Hours_Passed > 1 and "s" or "")) or (Minutes_Passed > 0 and string.format("%i minute%s ago", Minutes_Passed % 60, Minutes_Passed > 1 and "s" or "")) or "Few seconds ago"
      end
    end
    if Function == "Settings" then
      return function(Type, Settings)
        local Directory = "gabescripts"
        local SaveFile = string.format("%s/%s.json", Directory, game.GameId)

        if Type == "Load" then
          if not isfolder(Directory) then makefolder(Directory) end
          if not isfile(SaveFile) then writefile(SaveFile, Services.HttpService:JSONEncode(Settings)) return false end
  
          return Services.HttpService:JSONDecode(readfile(SaveFile))
        elseif Type == "Save" then
          return writefile(SaveFile, Services.HttpService:JSONEncode(Settings))
        end
      end
    end
    if Function == "Invite" then
      return function()
        local Request = (syn and syn.request) or (http and http.request) or request or http_request
        local InviteLink = "FF6NGCgZcg"

        setclipboard(string.format("https://discord.com/invite/%s", InviteLink))
        Request({Url = "http://127.0.0.1:6463/rpc?v=1", Method = "POST", Headers = {["Content-Type"] = "application/json", Origin = "https://discord.com"}, Body = Services.HttpService:JSONEncode({cmd = "INVITE_BROWSER", args = {code = InviteLink}, nonce = Services.HttpService:GenerateGUID(false)})})
      end
    end
    if Function == "FirstUpper" then
      return function(string)
        return string.upper(string.sub(string, 1, 1)) .. string.sub(string, 2, string.len(string))
      end
    end

    local Response, Output = pcall(function() return Services[Function] end)
    return (Response and Output) or (not Response and error("attempt to call a nil value"))
  end
})
