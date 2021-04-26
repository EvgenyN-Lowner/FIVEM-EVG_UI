--Locals
local locationOnscreen = 'radar'
local legalSpeed = 120
local smallSpeed = 60
local mph = false
local type = 'KPH'
local typeFont = 'default'

--Possition on screen
if(locationOnscreen == 'radar') then
  x1 = 0.015
  y1 = 0.77
  x2 = 0.038
  y2 = 0.77
elseif(locationOnscreen == 'top-right') then
  x1 = 0.915
  y1 = 0.104
  x2 = 0.915
  y2 = 0.065
end

if(typeFont == 'fancy') then
  font = 1
elseif(typeFont == 'default') then
  font = 2
elseif(typeFont == 'normal') then
  font = 0
end
function onScreen(content) -- The speed integer itself
      SetTextFont(font)
      SetTextScale(0.6, 0.6)
      SetTextEntry("STRING")
      AddTextComponentString(content)
      DrawText(x1, y1)
end

function unScreen(content) -- the MPH or KPH string (above the int)
  SetTextFont(font)
  SetTextScale(0.6, 0.6)
  SetTextEntry("STRING")
  AddTextComponentString(content)
      DrawText(x2, y2)
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local spd = 0
        if(mph == true)then
            spd = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*2.2369
        else
            spd = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6
        end
            if(IsPedInAnyVehicle(GetPlayerPed(-1), false))
            then
                if(spd < legalSpeed and spd < smallSpeed)then
                    onScreen("~w~" .. math.ceil(spd))
                end
                if(spd > legalSpeed and spd > smallSpeed)then
                    onScreen("~r~" .. math.ceil(spd))
                end
                if(spd < legalSpeed and spd > smallSpeed)then
                    onScreen("~g~" .. math.ceil(spd))
                 end
                 unScreen( type )
        end
    end
end)