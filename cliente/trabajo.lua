-- Funciones
local currentGarage = 1

QBCore = exports['qb-core']:GetCoreObject()
local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function Autorizado() 
    local retval = false

    if QBCore.Functions.GetPlayerData().job.name == 'starbucks' then
        retval = true
    end
    return retval
end



-- Corazon
CreateThread(function()
    while true do
        sleep = 2000
        if LocalPlayer.state['isLoggedIn'] and PlayerJob.name == "starbucks" then
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Ubicaciones["servicio"]) do
                if #(pos - v) < 5 then
                    sleep = 5
                    if #(pos - v) < 1.5 then
                        if not onDuty then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Entrar")
                        else
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ - Salir")
                        end
                        if IsControlJustReleased(0, 38) then
                            onDuty = not onDuty

                            TriggerServerEvent("QBCore:ToggleDuty")
     
                        end
                    elseif #(pos - v) < 2.5 then
                        DrawText3D(v.x, v.y, v.z, "Entrar/Salir Servicio")
                    end
                end
            end

            for k, v in pairs(Config.Ubicaciones["vehiculos"]) do
                if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
                    if onDuty then
                        sleep = 5
                        DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Guardar")
                            else
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Sacar")
                            end
                            if IsControlJustReleased(0, 38) then
                                if IsPedInAnyVehicle(PlayerPedId(), false) then
                                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                else
                                    MenuGarage()
                                    currentGarage = k
                                    Menu.hidden = not Menu.hidden
                                end
                            end
                            Menu.renderGUI()
                        end
                    end
                end
            end

            for k, v in pairs(Config.Ubicaciones["tienda"]) do
                if #(pos - v) < 4.5 then
                    if onDuty then
                        sleep = 5
                        if #(pos - v) < 1.5 then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Tienda")
                            if IsControlJustReleased(0, 38) then
                                local authorizedItems = {
                                    label = "Tienda",
                                    slots = Config.Slots,
                                    items = {}
                                }
                                local index = 1
                                for _, armoryItem in pairs(Config.Items.items) do
                                    for i=1, #armoryItem.authorizedJobGrades do
                                        if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
                                            authorizedItems.items[index] = armoryItem
                                            authorizedItems.items[index].slot = index
                                            index = index + 1
                                        end
                                    end
                                end
                                TriggerServerEvent("inventory:server:OpenInventory", "shop", "tienda", authorizedItems)
                            end
                        elseif #(pos - v) < 2.5 then
                            DrawText3D(v.x, v.y, v.z, "Tienda")
                        end
                    end
                end
            end

            for k, v in pairs(Config.Ubicaciones["stash"]) do
                if #(pos - v) < 4.5 then
                    if onDuty then
                        sleep = 5
                        if #(pos - v) < 1.5 then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Almacen")
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "almacenstarbucksa", {
                                    maxweight = 40000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "almacenstarbucksa")
                            end
                        elseif #(pos - v) < 2.5 then
                            DrawText3D(v.x, v.y, v.z, "Almacen")
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)


-- Menu vehiculos


function MenuGarage()
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehiculos", "VehicleList", nil)
    Menu.addButton("Cerrar", "closeMenuFull", nil)
end

function VehicleList()
    MenuTitle = "Vehiculos:"
    ClearMenu()
    local authorizedVehicles = Config.Vehiculos[QBCore.Functions.GetPlayerData().job.grade.level]
    for k, v in pairs(authorizedVehicles) do
        Menu.addButton(authorizedVehicles[k], "TakeOutVehicle", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end

    Menu.addButton("Volver", "MenuGarage",nil)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Ubicaciones["vehiculos"][currentGarage]
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "STAR"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end
