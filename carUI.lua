--Locals
local legalSpeed = 120
local smallSpeed = 60
local fullFuel = 80
local lowFuel = 15
local highRPM = 0.95
local typeSPD = 'KM/H'
local typeFUEL = 'FUEL'
local typeGEAR = 'GEAR'
local typeRPM = 'RPM'
local typeFont = 'fancy'
local ENG = "ENG"
local CHECK = "CHECK ENG"
local SEATBELT = "SEAT BELT"
local OIL = "OIL"
local beltOn = false
local seatbeltkey = 311
local engOn = false
local engkey = 303

--Possitions on screen
  x11 = 0.115
  y11 = 0.83
  x12 = 0.136
  y12 = 0.8385

  x21 = 0.017
  y21 = 0.775
  x22 = 0.041
  y22 = 0.78

  x31 = 0.138
  y31 = 0.884
  x32 = 0.145
  y32 = 0.8885

  x41 = 0.122
  y41 = 0.86
  x42 = 0.145
  y42 = 0.8685

  x51 = 0.115
  y51 = 0.884
  x52 = 0.118
  y52 = 0.78
  x53 = 0.062
  y53 = 0.78
  x54 = 0.1
  y54 = 0.78

--Fonts
if(typeFont == 'fancy') then
  font = 4
elseif(typeFont == 'default') then
  font = 2
elseif(typeFont == 'normal') then
  font = 0
end

AddEventHandler('evg_ui:sounds', function(soundFile, soundVolume)
  SendNUIMessage({
    transactionType = 'playSound',
    transactionFile = soundFile,
    transactionVolume = soundVolume
  })
end)

function onScreenSPD(content)
      SetTextFont(font)
      SetTextScale(0.6, 0.6)
      SetTextEntry("STRING")
      AddTextComponentString(content)
      DrawText(x11, y11)
end

function onScreenSPDT(content)
  SetTextFont(font)
  SetTextScale(0.4, 0.4)
  SetTextEntry("STRING")
  AddTextComponentString(content)
      DrawText(x12, y12)
end

function onScreenFUEL(content)
  SetTextFont(font)
  SetTextScale(0.5, 0.5)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x21, y21)
end

function onScreenFUELT(content)
SetTextFont(font)
SetTextScale(0.4, 0.4)
SetTextEntry("STRING")
AddTextComponentString(content)
  DrawText(x22, y22)
end

function onScreenGEAR(content)
  SetTextFont(font)
  SetTextScale(0.35, 0.35)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x31, y31)
end

function onScreenGEART(content)
SetTextFont(font)
SetTextScale(0.25, 0.25)
SetTextEntry("STRING")
AddTextComponentString(content)
  DrawText(x32, y32)
end

function onScreenRPM(content)
  SetTextFont(font)
  SetTextScale(0.45, 0.45)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x41, y41)
end

function onScreenRPMT(content)
  SetTextFont(font)
  SetTextScale(0.25, 0.25)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x42, y42)
end

function onScreenENG(content)
  SetTextFont(font)
  SetTextScale(0.35, 0.35)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x51, y51)
end

function onScreenCHECK(content)
  SetTextFont(font)
  SetTextScale(0.4, 0.4)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x52, y52)
end

function onScreenBELT(content)
  SetTextFont(font)
  SetTextScale(0.4, 0.4)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x53, y53)
end

function onScreenOIL(content)
  SetTextFont(font)
  SetTextScale(0.4, 0.4)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x54, y54)
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local spd = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6
        local fuel = exports.fuelLevel:getCurrentFuelLevel()
        local fuelP = fuel / 65 * 100
        local gear = GetVehicleCurrentGear(GetVehiclePedIsIn(GetPlayerPed(-1), false))
        local rpm = GetVehicleCurrentRpm(GetVehiclePedIsIn(GetPlayerPed(-1), false))
        local ENGisOn = GetIsVehicleEngineRunning(GetVehiclePedIsIn(GetPlayerPed(-1), false))
        local CHECKisOn = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false))

            if(IsPedInAnyVehicle(GetPlayerPed(-1), false))
            then
                if(spd < legalSpeed and spd < smallSpeed)then
                    onScreenSPD("~w~" .. math.ceil(spd))
                end
                if(spd > legalSpeed and spd > smallSpeed)then
                    onScreenSPD("~r~" .. math.ceil(spd))
                end
                if(spd < legalSpeed and spd > smallSpeed)then
                    onScreenSPD("~g~" .. math.ceil(spd))
                end

                if(fuelP < fullFuel and fuelP < lowFuel)then
                    onScreenFUEL("~o~" .. math.ceil(fuelP) .. "%")
                end
                if(fuelP > fullFuel and fuelP > lowFuel)then
                    onScreenFUEL("~g~" .. math.ceil(fuelP) .. "%")
                end
                if(fuelP < fullFuel and fuelP > lowFuel)then
                    onScreenFUEL("~c~" .. math.ceil(fuelP) .. "%")
                end

                if(fuelP < fullFuel and fuelP < lowFuel)then
                  onScreenFUELT("~o~" .. typeFUEL)
                end
                if(fuelP > fullFuel and fuelP > lowFuel)then
                  onScreenFUELT("~w~" .. typeFUEL)
                end
                if(fuelP < fullFuel and fuelP > lowFuel)then
                  onScreenFUELT("~w~" .. typeFUEL)
                end

                if (spd == 0 and gear == 0) or (spd == 0 and gear == 1) then
                  gear = 'N'
                elseif spd > 0 and gear == 0 then
                  gear = 'R'
                end

                if rpm > 0.99 then
                  rpm = rpm*100
                  rpm = rpm+math.random(-2,2)
                  rpm = rpm/100
                end

                DrawRect(0.135, 0.87, 0.0415, 0.071, 1, 1, 1, 180)
                DrawRect(0.085555, 0.7915, 0.14023, 0.028, 1, 1, 1, 120)
                
                onScreenSPDT( typeSPD )
                onScreenGEART ( typeGEAR )

                if beltOn then 
                  DisableControlAction(0, 75)
                  DisableControlAction(27, 75)
                end
                if IsControlJustPressed(0, seatbeltkey) then 
                  beltOn = not beltOn		  

                  if beltOn then
                    TriggerEvent("evg_ui:sounds", "html_sounds_buckle", 0.5)
                  else
                    TriggerEvent("evg_ui:sounds", "html_sounds_unbuckle", 0.5)
                  end
                end

                if IsControlJustPressed(0, engkey) then 
                  engOn = not engOn	  
                end

                SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), engOn, false, true)

                onScreenRPMT ( typeRPM )

                if ENGisOn == 1 then
                  onScreenENG ("~g~" .. ENG)
                  if CHECKisOn < 800 then
                    onScreenCHECK ("~y~" .. CHECK)
                  else
                    onScreenCHECK ("~c~" .. CHECK)
                  end
                  if CHECKisOn < 400 then
                    onScreenOIL ("~y~" .. OIL)
                  else
                    onScreenOIL ("~c~" .. OIL)
                  end
                  if rpm > highRPM then
                    onScreenRPM ("~r~" .. math.ceil(round(rpm, 2)*10000))
                  end
                  if rpm < highRPM then
                    onScreenRPM ("~c~" .. math.ceil(round(rpm, 2)*10000))
                  end
                  if (spd == 0 and gear == 0) or (spd == 0 and gear == 1) then
                    gear = 'N'
                  elseif spd > 0 and gear == 0 then
                    gear = 'R'
                  end
                  if beltOn == false then
                    onScreenBELT("~r~" .. SEATBELT)
                  end
                  if beltOn == true then
                    onScreenBELT("~g~" .. SEATBELT)
                  end
                else
                  onScreenENG ("~c~" .. ENG)
                  onScreenCHECK ("~c~" .. CHECK)
                  onScreenRPM ("~c~" .. 0)
                  gear = 'N'
                  onScreenBELT("~c~" .. SEATBELT)
                  onScreenOIL("~c~" .. OIL)
                end
                onScreenGEAR ( "~c~" .. gear )
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3500)
    if engOn == true and beltOn == false and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
      TriggerEvent("evg_ui:sounds", "html_sounds_seatbelt", 0.2)
		end    
	end
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end