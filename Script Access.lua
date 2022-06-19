local Services, Tick do
  print("Waiting For Server Response..")
  game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Waiting Response..", Text = "Requesting server response..", Icon = string.format("rbxthumb://type=Asset&id=%i&w=420&h=420", 275671231)})

  local Tick = tick()
  local Success, Message = pcall(function()
    Services = loadstring(game:HttpGet("https://raw.githubusercontent.com/gabescripts/lua/scripts/Server.lua"))()
  end)

  if Success and Services then
    local Scripts, PlaceId = LPH_ENCSTR("https://gabescripts.000webhostapp.com/active_scripts/"), game.PlaceId
    local Server = (Services.Request({Url = string.format("%s%i.lua", Scripts, PlaceId)})) or {Success = false}

    if Server.Success then
      if Server.StatusCode == 0 then return warn("Server Script Response Delayed, Retry In 1-2 Minutes..") end

      if getgenv().Executed then
        warn("Script Already Executed, Please Rejoin Then Execute.")
        Services.Notify("Execute Failed!", "Failed, please rejoin to re-execute script..", 899041982)
      else
        loadstring(Server.Body)()
        repeat task.wait() until getgenv().Executed
        warn(string.format("Script Execution Complete, Took %.2f Seconds!", tick() - Tick))
        Services.Notify("Script Executed!", string.format("Successfully loaded, Took %.2f Seconds!", tick() - Tick), 7871748216)
      end
    else
      warn("No Script Available, Please See Supported Games.")
    end
  else
    print("Connection Timeout, Retry In 1-2 Minutes..")
    Services.Notify("Request Timeout..", "Server took too long to respond, retry later..", 275671231)
  end
end