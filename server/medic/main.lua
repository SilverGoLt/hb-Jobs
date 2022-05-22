--[[
    RC Medic System
    Created by: Boost and Haroki
    Used for: Main file used for threads syncing and all the functionality for the job
]]

_downed = {}
_playerStatus = {}
_healing = {}
_colleagues = {}

-- Death handler
RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    addPlayerToTable(_downed, xPlayer.identifier)
    TriggerClientEvent('medic:setDead', source)
end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	 args.playerId.triggerEvent('esx_ambulancejob:revive')
  end, true,
  {help = 'yeet', validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

RegisterCommand('kill', function(source, args)
    TriggerClientEvent('medic:setDead', args[1])
    local xPlayer = ESX.GetPlayerFromId(args[1])
    addPlayerToTable(_downed, xPlayer.identifier)
end, true)

lib.callback.register('medic:useDefib', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local pos = GetEntityCoords(GetPlayerPed(source))
    local job = isJob(source, 'ambulance')
    local isDead = checkTable(_downed, xTarget.identifier)
    playSound(source, 10, 'defib.mp3', 0.8)
    if job and isDead then
        xPlayer.addMoney(500)
        TriggerClientEvent('medic:revivePlayer', target)
        return true
    else
        return false
    end
end)

lib.callback.register('medic:useHeal', function(source, item, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local job = isJob(source, 'ambulance')
    local isHealing = checkTable(_healing, xTarget.identifier)
    local Item = getItemInfo(item)

    if isHealing == nil then
        if job then
            addPlayerToTable(_healing, xTarget.identifier)
            xPlayer.removeInventoryItem(Item.item, 1)
            TriggerClientEvent('medic:healPlayer', target, Item.heal)
        end
    end
end)

lib.callback.register('medic:checkHealing', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isHealing = checkTable(_healing, xPlayer.identifier)

    if isHealing then
        removePlayerFromTable(_healing, xPlayer.identifier)
        return true
    else
        return false
    end
end)

lib.callback.register('medic:checkDowned', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isDead = checkTable(_downed, xPlayer.identifier)

    if isDead then
        removePlayerFromTable(_downed, xPlayer.identifier)
        return true
    else
        return false
    end
end)
