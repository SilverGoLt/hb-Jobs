_isDragging = false
_draggingID = 0

cuffPlayer = function(entity)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local target, distance = ESX.Game.GetClosestPlayer(pos)

    if target ~= -1 and distance < 3 then
        local targetID = GetPlayerServerId(target)
        lib.callback('police-sv:CuffPlayer', false, function(state)
            if state then
                startCuffAnim(true)
            end
        end, targetID)
    end
    
end

startCuffAnim = function(state)
    if state then
        local cuffdict = 'mp_arrest_paired'
        local cuffanim = 'cop_p2_back_right'
    
        ClearPedTasksImmediately(GetPlayerPed(-1))
        RequestAnimDict(cuffdict)
        while not HasAnimDictLoaded(cuffdict) do
            Citizen.Wait(100)
        end
        TaskPlayAnim(GetPlayerPed(-1), cuffdict, cuffanim, 8.0, -8, 3500, 16, 0, 0, 0, 0)
        Citizen.Wait(3500)
        ClearPedTasks(GetPlayerPed(-1))
    end
end

dragPlayer = function (entity)
    local target, distance = ESX.Game.GetClosestPlayer()
    if target ~= -1 and distance < 2 then
       local targetID = GetPlayerServerId(target)
        lib.callback('police:dragPlayer', false, function(state)
            if state then 
                _draggingID = targetID
                _isDragging = true
                lib.showTextUI('[X] - Nustot vest zaideja', {
                    position = "right-center",
                    icon = "people-pulling",
                })
            end
        end, targetID)
    end
end

stopDrag = function ()
    if _isDragging then
        print('Stopping Drag: '.._draggingID)
        lib.callback('police:unDrag', false, function(state)
            if state then
                _isDragging = false
                _draggingID = 0
                lib.hideTextUI()
            end
        end, _draggingID)
    end
end

RegisterCommand('stopPoliceDrag', function(source, args, raw)
    stopDrag()
end, false)

RegisterKeyMapping('stopPoliceDrag', 'Stop dragging player', 'keyboard', 'X')
