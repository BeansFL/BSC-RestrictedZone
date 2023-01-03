    -- Handles the "zoneAdd" command
RegisterCommand(Config.CreateCommand, function(source, args, rawCommand)
    -- Get the radius of the zone from the command arguments
    local radius = tonumber(args[1])
  
    -- Get the player who sent the command
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Coords of the player who sent the command
    local coords = table.pack(GetEntityCoords(GetPlayerPed(source), true))
  
    -- Check if the player has an allowed job
    for k,v in pairs(Config.Jobs) do
      if xPlayer.job.name == v then
        
        -- Trigger an event to create the zone on the client
        TriggerClientEvent("bsc_conclusionzone:addZone", -1, source, radius, coords)
  
        -- Show a notification to the player
        TriggerClientEvent('esx:showAdvancedNotification', source, Config.NotifyTitle, '~r~', Config.NotifyMessage, Config.NotifyPicture, 3)
        
      end
    end
  end)
  
  -- Handles the "zoneRemove" command
  RegisterCommand(Config.RemoveCommand, function(source, args, rawCommand)
    -- Get the player who sent the command
    local xPlayer = ESX.GetPlayerFromId(source)
  
    -- Check if the player has an allowed job
    for k,v in pairs(Config.Jobs) do 
      if xPlayer.job.name == v then
        -- Trigger an event to remove the zone on the client
        TriggerClientEvent("bsc_conclusionzone:clearZone", -1, source)
  
        -- Show a notification to the player
        TriggerClientEvent('esx:showAdvancedNotification', source, Config.NotifyTitle,  '~r~',  Config.NotifyMessageRemoved, Config.NotifyPicture, 3)
      end   
    end
  end)
   
