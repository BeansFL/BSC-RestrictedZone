local stoppedVehicles = {} -- Table to store stopped vehicles

-- Add blips when "bsc_conclusionzone:addZone" event is triggered
RegisterNetEvent("bsc_conclusionzone:addZone")
AddEventHandler("bsc_conclusionzone:addZone", function(blipcoords, radius)
  -- Remove existing blips
  RemoveBlip(locationBlip)
  RemoveBlip(radiusBlip)

  -- Set default radius if none provided
  radius =  blipRadius
  
  -- Create location blip 
  locationBlip = AddBlipForCoord(blipcoords.x, blipcoords.y, blipcoords.z)
  SetBlipSprite(locationBlip, 161)
  SetBlipAsShortRange(locationBlip, true) 
  SetBlipColour(locationBlip, Config.Color)
  SetBlipScale(locationBlip, 1.0)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString(Config.Blipname)
  EndTextCommandSetBlipName(locationBlip)

  -- Create radius blip
  radiusBlip = AddBlipForRadius(blipcoords.x, blipcoords.y, blipcoords.z, radius)
  SetBlipAlpha(radiusBlip, 150)
  SetBlipColour(radiusBlip, Config.Color)

  -- Play sound
  if Config.Sounds then
    PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 0, 1)
  end

  -- Reset stopped vehicles
  stoppedVehicles = {}

  CreateThread(function()
    while true do 
      local vehicle = GetRandomVehicleInSphere(blipcoords.x, blipcoords.y, blipcoords.z, radius, 0, 70)
      if DoesEntityExist(vehicle) then 
        local driver = GetPedInVehicleSeat(vehicle, -1)
        if DoesEntityExist(driver) and not IsPedAPlayer(driver) then 
          TaskVehicleTempAction(driver, vehicle, 6, 1000)
          table.insert(stoppedVehicles, { driver = driver, vehicle = vehicle }) -- Store stopped vehicle
        end
      end
      Wait(0)
    end
  end)
end)

-- Clear blips when "bsc_conclusionzone:clearZone" event is triggered
RegisterNetEvent('bsc_conclusionzone:clearZone')
AddEventHandler("bsc_conclusionzone:clearZone", function() 
  RemoveBlip(locationBlip)
  RemoveBlip(radiusBlip)
  
  for i, data in ipairs(stoppedVehicles) do
    if DoesEntityExist(data.vehicle) then 
      if DoesEntityExist(data.driver) and not IsPedAPlayer(data.driver) then 
        TaskVehicleDriveWander(data.driver, data.vehicle, 20.0, 786603) -- Make NPC drive again
      end
    end
  end

  -- Play sound
  if Config.Sounds then
    PlaySoundFrontend(-1, "PEYOTE_COMPLETED", "HUD_AWARDS", 0, 1)
  end
end)
