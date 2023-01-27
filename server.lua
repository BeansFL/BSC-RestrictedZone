-- Handles the "zoneAdd" command
RegisterCommand(Config.CreateCommand, function(source, args, rawCommand)
    -- Get the radius of the zone from the command arguments
    local radius = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(source)
    if isallowed(source) then
          local location = xPlayer.getCoords(true)
          
          TriggerClientEvent("bsc_conclusionzone:addZone", location, radius)
            -- Show a notification to the player
          TriggerClientEvent('esx:showAdvancedNotification', -1, Config.NotifyTitle, '~r~', Config.NotifyMessage, Config.NotifyPicture, 3)
          
          --make same blip for all players under jobs in config.jobs

          local xPlayers = ESX.GetPlayers()

          for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          
            xPlayer.triggerEvent('bsc_conclusionzone:addZone', location,radius)
          end

    end
            
end)
  
  -- Handles the "zoneRemove" command
  RegisterCommand(Config.RemoveCommand, function(source, args, rawCommand)
    -- Get the player who sent the command
    local xPlayer = ESX.GetPlayerFromId(source)
  
    -- Check if the player has an allowed job
      if isallowed(source) then
        -- Trigger an event to remove the zone on the client
        TriggerClientEvent("bsc_conclusionzone:clearZone", -1, source)
  
        -- Show a notification to the player
        TriggerClientEvent('esx:showAdvancedNotification', -1, Config.NotifyTitle,  '~r~',  Config.NotifyMessageRemoved, Config.NotifyPicture, 3)
      end   
  end)
   


function isallowed(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob().name
    local allowed = false

    for k,v in pairs(Config.Jobs) do

      if job == v then
          allowed = true
          break
      else
          allowed = false
      end
    end
    
    return allowed
end








