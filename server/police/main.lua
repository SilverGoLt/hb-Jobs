--[[
    RC Police System
    Created by: Boost and Haroki
    Used for: Main file used for threads syncing and all the functionality for the job
]]

_handCuffed = {}
_unCuffing = {}
_drag = {}
_unDrag = {}

lib.callback.register('police-sv:CuffPlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    
    if isJob(source, 'police') then
        local check = checkTable(_handCuffed, xTarget.identifier)
        if not check then
            _handCuffed[#_handCuffed+1] = xTarget.identifier
            TriggerClientEvent('player-cl:syncCuff', target)
            return true
        elseif check then
            _unCuffing[#_unCuffing+1] = xTarget.identifier
            TriggerClientEvent('player-cl:syncUnCuff', target)
            return true
        end
    else
        xPlayer.kick('Bye bye!')
    end
end)

lib.callback.register('police:checkHandcuff', function(source, table)
    local xPlayer = ESX.GetPlayerFromId(source)
    local check = checkTable(_handCuffed, xPlayer.identifier)
    local uncuffCheck = checkTable(_unCuffing, xPlayer.identifier)

    if check and not uncuffCheck then
        return true
    elseif check and uncuffCheck then
        removePlayerFromTable(_unCuffing, xPlayer.identifier)
        removePlayerFromTable(_handCuffed, xPlayer.identifier)
        return true
    else
        return false
    end
end)

lib.callback.register('police:dragPlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    
    if isJob(source, 'police') then
        local check = checkTable(_drag, xTarget.identifier)
        if not check then
            _drag[#_drag+1] = xTarget.identifier
            print('Dragging Player: '.. xTarget.source)
            TriggerClientEvent('police-cl:syncDrag', target, source)
            return true
        elseif check then
            removePlayerFromTable(_drag, xTarget.identifier)
            TriggerClientEvent('police-cl:syncUnDrag', target, source)
            return true
        end
    else
        xPlayer.kick('Bye bye!')
    end
end)

lib.callback.register('police:unDrag', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local check = checkTable(_drag, xTarget.identifier)
    print(target)
    print('[RCJOB] Undragging check: '.. tostring(check))
    if check and isJob(source, 'police') then
        _unDrag[#_unDrag+1] = xTarget.identifier
        TriggerClientEvent('police-cl:syncUnDrag', target)
        return true
    end
end)

lib.callback.register('police:checkDrag', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local check = checkTable(_drag, xPlayer.identifier)
    local dragCheck = checkTable(_unDrag, xPlayer.identifier)
    if check and not dragCheck then
        return true
    elseif check and dragCheck then
        removePlayerFromTable(_drag, xPlayer.identifier)
        removePlayerFromTable(_unDrag, xPlayer.identifier)
        return true
    else
        return false
    end
end)

-- Animation events
RegisterNetEvent('police-sv:cuffAnim', function(target)
    local xPlayer = ESX.GetPlayerFromId(target)
    if xPlayer.job.name == 'police' then
        TriggerClientEvent('police-cl:cuffAnim', xPlayer.source, true)
    end
end)