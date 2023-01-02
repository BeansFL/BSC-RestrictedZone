-- Configuration table for a police exclusion zone
Config = {}

-- Name of the blip that appears on the map to mark the zone
Config.Blipname = "~r~EXCLUSION ZONE~s~"

-- Color of the blip that appears on the map to mark the zone
Config.Color = 3
Config.Radius = 150 
blipRadius = 150.0 
  
-- Jobs that are allowed to enter the exclusion zone
Config.Jobs = {
  "police",
  "doa",
  "sheriff",
  "doj", 
  "ambulance"
}

-- Command that players with allowed jobs can use to create an exclusion zone
Config.CreateCommand = "zoneAdd"

-- Command that players with allowed jobs can use to remove an exclusion zone
Config.RemoveCommand = "zoneRemove"

-- Title of the notification that appears when an exclusion zone is created
Config.NotifyTitle = "~r~EXCLUSION ZONE~s~"

-- Icon of the notification that appears when an exclusion zone is created
Config.NotifyPicture = "CHAR_CALL911"

-- Message of the notification that appears when an exclusion zone is created
Config.NotifyMessage = "An exclusion zone was declared. Unallowed approaches must expect to be ~r~arrested" 

-- Message of the notification that appears when an exclusion zone is removed
Config.NotifyMessageRemoved = "The current exclusion zone has been lifted!"

-- Play Sounds?
Config.Sounds = true 