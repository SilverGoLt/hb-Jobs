ESX = exports['rc-core']:getSharedObject()

_playerData = {
    job = {},
    currentInteraction = '',
    currentUniform = {},
    loaded = false
}


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        local data = ESX.GetPlayerData()
        _playerData.job = data.job
        _playerData.loaded = true
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    _playerData.job = playerData.job
    _playerData.loaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    _playerData.job = job
end)