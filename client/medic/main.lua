_isDead = false

RegisterNetEvent('medic:revivePlayer', function()
	print('Reviving Player')
	lib.callback('medic:checkDowned', false, function(state)
		if state then
			local plyPed = PlayerPedId()
			local coords = GetEntityCoords(plyPed)
			LocalPlayer.state:set('invBusy', false, true)
			local formattedCoords = {
				x = ESX.Math.Round(coords.x, 1),
				y = ESX.Math.Round(coords.y, 1),
				z = ESX.Math.Round(coords.z, 1)
			}
			RespawnPed(plyPed, formattedCoords, 0.0)
		end
	end)
end)

RegisterNetEvent('esx_ambulancejob:revive', function()
	local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed)
	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}
	_isDead = false
	LocalPlayer.state:set('invBusy', false, true)
	DecorSetBool(plyPed, 'isDead', false)
	RespawnPed(plyPed, formattedCoords, 0.0)
end)

RegisterNetEvent('medic:setDead', function()
	local ped = PlayerPedId()
	_isDead = true
	-- Disable Inventory Access when dead
	LocalPlayer.state:set('invBusy', true, true)
	DecorSetBool(ped, 'isDead', true)
	setDead()
end)

RegisterNetEvent('medic:healPlayer', function(amount)
	local ped = PlayerPedId()
	lib.callback('medic:checkHealing', false, function(state)
		if state then
			local health = GetEntityHealth(ped)
			local newHealth = health + amount
			SetEntityHealth(ped, newHealth)
			ESX.ShowNotification('Buvote Pagydytas!')
		end
	end)
end)