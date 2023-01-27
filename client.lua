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
end)

-- Clear blips when "bsc_conclusionzone:clearZone" event is triggered
RegisterNetEvent('bsc_conclusionzone:clearZone')
AddEventHandler("bsc_conclusionzone:clearZone", function() 
  RemoveBlip(locationBlip)
  RemoveBlip(radiusBlip)

  -- Play sound
  if Config.Sounds then
    PlaySoundFrontend(-1, "PEYOTE_COMPLETED", "HUD_AWARDS", 0, 1)
  end
end)