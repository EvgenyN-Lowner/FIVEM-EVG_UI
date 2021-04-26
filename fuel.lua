--Locals
local locationOnscreen = 'radar'
local legalSpeed = 45
local smallSpeed = 10
local type = 'FUEL'
local typeFont = 'default'

--Possition on screen
if(locationOnscreen == 'radar') then
  x1 = 0.065
  y1 = 0.77
  x2 = 0.082
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
function onScreen(content)
      SetTextFont(font)
      SetTextScale(0.6, 0.6)
      SetTextEntry("STRING")
      AddTextComponentString(content)
      DrawText(x1, y1)
end

function unScreen(content)
  SetTextFont(font)
  SetTextScale(0.6, 0.6)
  SetTextEntry("STRING")
  AddTextComponentString(content)
      DrawText(x2, y2)
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local spd = exports.fuelLevel:getCurrentFuelLevel()
            if(IsPedInAnyVehicle(GetPlayerPed(-1), false))
            then
                if(spd < legalSpeed and spd < smallSpeed)then
                    onScreen("~o~" .. math.ceil(spd))
                end
                if(spd > legalSpeed and spd > smallSpeed)then
                    onScreen("~g~" .. math.ceil(spd))
                end
                if(spd < legalSpeed and spd > smallSpeed)then
                    onScreen("~w~" .. math.ceil(spd))
                 end
                 unScreen( type )
        end
    end
end)