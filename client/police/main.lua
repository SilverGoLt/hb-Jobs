_cuffed = false
_gettingDragged = false
local animation = {dict = "mp_arresting", name = "idle"}
-- Cuff and Uncuff system
RegisterNetEvent('player-cl:syncCuff', function()
    lib.callback('police:checkHandcuff', false, function(state)
        if state then
			local plyPed = PlayerPedId()
			DecorSetBool(cache.ped, 'isCuffed', true)
			ClearPedTasksImmediately(plyPed)
			RequestAnimDict(animation.dict)
			while not HasAnimDictLoaded(animation.dict) do
				Citizen.Wait(100)
			end
			TaskPlayAnim(plyPed, animation.dict, animation.name, 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetEnableHandcuffs(plyPed, true)
			SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
			_cuffed = true
			startCuffThread()
        end
    end)
end)

RegisterNetEvent('player-cl:syncUnCuff', function()
    lib.callback('police:checkHandcuff', false, function(state)
        if state then
			local plyPed = PlayerPedId()
			DecorSetBool(cache.ped, 'isCuffed', false)
			SetEnableHandcuffs(plyPed, false)
			ClearPedTasksImmediately(plyPed)
			_cuffed = false
        end
    end)
end)

startCuffThread = function()
    Citizen.CreateThread(function()
        while _cuffed do
            Wait(0)
            DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			--DisableControlAction(0, 32, true) -- W
			--DisableControlAction(0, 34, true) -- A
			--DisableControlAction(0, 31, true) -- S
			--DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

RegisterNetEvent('police-cl:syncDrag', function(target)
	local targetID = target
	print(targetID)
	lib.callback('police:checkDrag', false, function(state)
		if state then
			_gettingDragged = true
			startDragThread(targetID)
		end
	end)
end)

RegisterNetEvent('police-cl:syncUnDrag', function()
	lib.callback('police:checkDrag', false, function(state)
		print(state)
		if state then
			_gettingDragged = false
			DecorSetBool(cache.ped, 'isDragged', false)
		end
	end)
end)

startDragThread = function (target)
	local playerPed = cache.ped
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	Citizen.CreateThread(function()
		while _gettingDragged do
			Citizen.Wait(1)
			print(_cuffed, _gettingDragged)
			if _cuffed and _gettingDragged then
				if _gettingDragged then
	
					-- undrag if target is in an vehicle
					if not IsPedSittingInAnyVehicle(targetPed) then
						AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					else
						_gettingDragged = false
						DecorSetBool(playerPed, 'isDragged', false)
						DetachEntity(playerPed, true, false)
					end
	
					if DecorGetBool(playerPed, 'isDead') then
						DecorSetBool(playerPed, 'isDragged', false)
						_gettingDragged = false
						DetachEntity(playerPed, true, false)
					end
	
				else
					DetachEntity(playerPed, true, false)
				end
			else
				DetachEntity(playerPed, true, false)
			end
		end
	end)
end