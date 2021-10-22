-- Variables
QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
onDuty = false
-- Eventos core


AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    onDuty = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo

    if JobInfo.name == "starbucks" then
        if PlayerJob.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
            onDuty = false
        end
    end

end)

-- Thread

Citizen.CreateThread(function()
    for k, station in pairs(Config.Ubicaciones["blips"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 354)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 27)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)
