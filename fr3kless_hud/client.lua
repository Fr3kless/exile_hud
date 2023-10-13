-- hud by fr3kless
-- github.com/fr3kless

local isHudVisible = true

local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N' } 

Zones = {
    ['AIRP'] = 'Los Santos Airport',
    ['ALAMO'] = 'Alamo Sea',
    ['ALTA'] = 'Alta',
    ['ARMYB'] = 'Fort Zancudo',
    ['BANHAMC'] = 'Banham Canyon Dr',
    ['BANNING'] = 'Banning',
    ['BEACH'] = 'Vespucci Beach',
    ['BHAMCA'] = 'Banham Canyon',
    ['BRADP'] = 'Braddock Pass',
    ['BRADT'] = 'Braddock Tunnel',
    ['BURTON'] = 'Burton',
    ['CALAFB'] = 'Calafia Bridge',
    ['CANNY'] = 'Raton Canyon',
    ['CCREAK'] = 'Cassidy Creek',
    ['CHAMH'] = 'Chamberlain Hills',
    ['CHIL'] = 'Vinewood Hills',
    ['CHU'] = 'Chumash',
    ['CMSW'] = 'Chiliad Mountain',
    ['CYPRE'] = 'Cypress Flats',
    ['DAVIS'] = 'Davis',
    ['DELBE'] = 'Del Perro Beach',
    ['DELPE'] = 'Del Perro',
    ['DELSOL'] = 'La Puerta',
    ['DESRT'] = 'Grand Senora Desert',
    ['DOWNT'] = 'Downtown',
    ['DTVINE'] = 'Downtown Vinewood',
    ['EAST_V'] = 'East Vinewood',
    ['EBURO'] = 'El Burro Heights',
    ['ELGORL'] = 'El Gordo Lighthouse',
    ['ELYSIAN'] = 'Elysian Island',
    ['GALFISH'] = 'Galilee',
    ['GOLF'] = 'GWC and Golfing Society',
    ['GRAPES'] = 'Grapeseed',
    ['GREATC'] = 'Great Chaparral',
    ['HARMO'] = 'Harmony',
    ['HAWICK'] = 'Hawick',
    ['HORS'] = 'Vinewood Racetrack',
    ['HUMLAB'] = 'Humane Labs and Research',
    ['JAIL'] = 'Bolingbroke Penitentiary',
    ['KOREAT'] = 'Little Seoul',
    ['LACT'] = 'Land Act Reservoir',
    ['LAGO'] = 'Lago Zancudo',
    ['LDAM'] = 'Land Act Dam',
    ['LEGSQU'] = 'Legion Square',
    ['LMESA'] = 'La Mesa',
    ['LOSPUER'] = 'La Puerta',
    ['MIRR'] = 'Mirror Park',
    ['MORN'] = 'Morningwood',
    ['MOVIE'] = 'Richards Majestic',
    ['MTCHIL'] = 'Mount Chiliad',
    ['MTGORDO'] = 'Mount Gordo',
    ['MTJOSE'] = 'Mount Josiah',
    ['MURRI'] = 'Murrieta Heights',
    ['NCHU'] = 'North Chumash',
    ['NOOSE'] = 'N.O.O.S.E',
    ['OCEANA'] = 'Pacific Ocean',
    ['PALCOV'] = 'Paleto Cove',
    ['PALETO'] = 'Paleto Bay',
    ['PALFOR'] = 'Paleto Forest',
    ['PALHIGH'] = 'Palomino Highlands',
    ['PALMPOW'] = 'Palmer-Taylor Power Station',
    ['PBLUFF'] = 'Pacific Bluffs',
    ['PBOX'] = 'Pillbox Hill',
    ['PROCOB'] = 'Procopio Beach',
    ['RANCHO'] = 'Rancho',
    ['RGLEN'] = 'Richman Glen',
    ['RICHM'] = 'Richman',
    ['ROCKF'] = 'Rockford Hills',
    ['RTRAK'] = 'Redwood Lights Track',
    ['SANAND'] = 'San Andreas',
    ['SANCHIA'] = 'San Chianski Mountain Range',
    ['SANDY'] = 'Sandy Shores',
    ['SKID'] = 'Mission Row',
    ['SLAB'] = 'Stab City',
    ['STAD'] = 'Maze Bank Arena',
    ['STRAW'] = 'Strawberry',
    ['TATAMO'] = 'Tataviam Mountains',
    ['TERMINA'] = 'Terminal',
    ['TEXTI'] = 'Textile City',
    ['TONGVAH'] = 'Tongva Hills',
    ['TONGVAV'] = 'Tongva Valley',
    ['VCANA'] = 'Vespucci Canals',
    ['VESP'] = 'Vespucci',
    ['VINE'] = 'Vinewood',
    ['WINDF'] = 'Ron Alternates Wind Farm',
    ['WVINE'] = 'West Vinewood',
    ['ZANCUDO'] = 'Zancudo River',
    ['ZP_ORT'] = 'Port of South Los Santos',
    ['ZQ_UAR'] = 'Davis Quartz'
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(100)
    PlayerData = ESX.GetPlayerData()
    SendNUIMessage({
        type = 'TOGGLE_CARHUD',
        invehicle =  false,
    })
end)

Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
    SetRadarZoom(1100)
end)
local talkingstate = false
changeproximity = function()

    SendNUIMessage({
        type = 'talking',
        talking = MumbleIsPlayerTalking(PlayerId()),
        proximity = LocalPlayer.state.proximity.index,
    })

end

function toggleHud()
    local playerPed = PlayerPedId()

    if isHudVisible == true then
        SendNUIMessage({
            type = 'TOGGLE_HUD',
            value = true,
            veh =  LocalPlayer.state.invehicleacc,
        })
        
        isHudVisible = false
        -- print(isHudVisible)
    else
        SendNUIMessage({
            type = 'TOGGLE_HUD',
            value = false,
            veh =  LocalPlayer.state.invehicleacc,
        })
       
        isHudVisible = true
        -- print(isHudVisible)
    end
end

  
local GetArmour = function()
    if GetPedArmour(PlayerId()) == 0 then
        return false
    else 
        return GetPedArmour(PlayerId())
    end
end
LocalPlayer.state.invehicleacc = false
lib.onCache('vehicle', function(value)
    if value then
        SendNUIMessage({
            type = 'TOGGLE_CARHUD',
            invehicle =  true,
          })
          DisplayRadar(true)
        LocalPlayer.state.invehicleacc = true
    else
        DisplayRadar(false)
        SendNUIMessage({
            type = 'TOGGLE_CARHUD',
            invehicle =  false,
          })
        LocalPlayer.state.invehicleacc = false
    end
end)

RegisterCommand('fixcarhud', function()
    DisplayRadar(false)
    SendNUIMessage({
        type = 'TOGGLE_CARHUD',
        invehicle =  false,
      })
    LocalPlayer.state.invehicleacc = false
end)

local carwait = 800
Citizen.CreateThread(function()
    while true do
        SendNUIMessage({
            type = 'talking',
            talking = MumbleIsPlayerTalking(PlayerId()),
            proximity = LocalPlayer.state.proximity.index,
        })
    if isHudVisible == true then
        local playerPed = PlayerPedId()

        if LocalPlayer.state.invehicleacc  then
            carwait = 250
            speed = GetEntitySpeed(playerPed)
            local var2 
            local street2
            local coordsa = GetEntityCoords(PlayerPedId())
			local var = GetStreetNameAtCoord(coordsa.x, coordsa.y, coordsa.y)
            local Street = GetStreetNameAtCoord(coordsa.x, coordsa.y, coordsa.z)
            local direction = nil
            for k, v in pairs(directions) do
                direction = GetEntityHeading(PlayerPedId())
                if math.abs(direction - k) < 22.5 then
                    direction = v
                    break
                end
            end         

            if speed ~= lastSpeed then
                local fura = GetVehiclePedIsIn(playerPed, false)
              SendNUIMessage({
                type = 'UPDATE_CARHUD',
                invehicle =  true,
                direction = (direction or 'N'),
                speed = math.floor(GetEntitySpeed(fura) * 3.6 + 0.5),
                street = GetStreetNameFromHashKey(Street),
            }) 
      
              lastSpeed = speed
            end
            
        else
            carwait = 800
            SendNUIMessage({
                type = 'UPDATE_CARHUD',
                invehicle =  false,
            }) 
        end

    end
        Wait(carwait)
    end
end)

--[[
Citizen.CreateThread(function()
    while true do
        Wait(20)
        local playerPed = PlayerPedId()

        isPedInVehicle = IsPedInAnyVehicle(playerPed, false)
    if isHudVisible == true then
        if isPedInVehicle then
              SendNUIMessage({
                type = 'TOGGLE_CARHUD',
                invehicle =  isPedInVehicle,
              })
        else
            SendNUIMessage({
                type = 'TOGGLE_CARHUD',
                invehicle =  isPedInVehicle,
            }) 
        end
    end
    end
end)

]]

CreateThread(function()
    while true do
        if IsPauseMenuActive() then

        else
  
            local ped = PlayerPedId()
  
        SendNUIMessage({
			action = "updatePlayerId";
			id = GetPlayerServerId(PlayerId());
		})

        end
  
        Citizen.Wait(500)
    end
end)



Citizen.CreateThread(function()
    SendNUIMessage({
        type = 'UPDATE_HUD',
        proximity = mode,
    })
    while true do
        Wait(1500)
        local piciu, jedzenie = nil
        TriggerEvent('esx_status:getStatus', 'thirst', function(status) 
            piciu = status.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'hunger', function(status) 
            jedzenie = status.getPercent()
        end)
        SendNUIMessage({
            type = 'UPDATE_HUD',
            hp = (GetEntityHealth(PlayerPedId()) - 100) or 0,
            armour = GetPedArmour(PlayerPedId()),
            hunger = jedzenie,
            thirst = piciu,
            oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
            talking = MumbleIsPlayerTalking(PlayerId()),
            proximity = LocalPlayer.state.proximity.index,
            hour = string.format("%02d", GetClockHours()),
            minute = string.format("%02d", GetClockMinutes())
        })
       
    end
end)


            -- TriggerEvent('esx_status:getStatus', 'hunger', function(hstatus)
            -- hunger = hstatus.getPercent()
            --     --print(hunger)
            -- TriggerEvent('esx_status:getStatus', 'thirst', function(tstatus)
            -- thirst = tstatus.getPercent()
            --     --print(thirst)
            -- end)
            -- end)

-- AddEventHandler('pma-voice:setTalkingMode', function(mode)
--     SendNUIMessage({
--         action = 'UPDATE_HUD',
--         proximity = mode,
--     })
-- end)

CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        Citizen.Wait(255)    
    end
end)

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

RegisterCommand("minimapfix", function(src, args, raw) 
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
end)

RegisterCommand('+=toggleHud', function()
    toggleHud()
end)

RegisterKeyMapping('+=toggleHud', 'Przełącz hud', 'keyboard', 'MOUSE_MIDDLE')

-- hud by fr3kless
-- github.com/fr3kless

Citizen.CreateThread(function()
    ExecuteCommand('radiolistnui')
    Wait(3)
    ExecuteCommand('fixcarhud')
    Wait(3)
    ExecuteCommand('radiolistnui')
    print('[FR3KLESS] Załadowano UI')
end)