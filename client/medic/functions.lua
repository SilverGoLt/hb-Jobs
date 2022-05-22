local animation = {dict = "dead", name = "dead_a"}
 _cfgVehicles = Config.Vehicles

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	FreezeEntityPosition(ped, false)
	ClearPedTasksImmediately(ped)
	ClearPedBloodDamage(ped)
	_isDead = false
	DecorSetBool(cache.ped, 'isDead', false)
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end

setDead = function()
	local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed)
	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}

	RespawnPed(plyPed, formattedCoords, 0.0)
	ClearPedTasksImmediately(plyPed)
	_isDead = true
	DecorSetBool(plyPed, 'isDead', true)
	lib.requestAnimDict(animation.dict, 100)
	SetEntityHealth(plyPed, GetPedMaxHealth(plyPed))
	SetEntityInvincible(plyPed, true)

	TaskPlayAnim(plyPed, animation.dict, animation.name, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
	while _isDead do
		local check = IsEntityPlayingAnim(plyPed, animation.dict, animation.name, 3)
		if check == false then
			TaskPlayAnim(plyPed, animation.dict, animation.name, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
		end
		Wait(1)
	end
end

--- Uses defib to revive player
useDefib = function(entity)
	local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local target, distance = ESX.Game.GetClosestPlayer(pos)

	--Anim
	local dict, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
	if target ~= -1 and distance < 3 then
		if lib.progressCircle({
			duration = 2000,
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
			},
			anim = {
				dict = dict,
				clip = anim
			},
		}) then
			local targetID = GetPlayerServerId(target)
			lib.callback('medic:useDefib', false, function(state) end, targetID)
		else

		end
    end
end

startHealing = function(item)
	local dict, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)
  local target, distance = ESX.Game.GetClosestPlayer(pos)
	local Item = exports.ox_inventory:Search('count', item)
	if Item > 0 then

		if target ~= -1 and distance < 3 then
			if lib.progressCircle({
				duration = 2000,
				position = 'bottom',
				useWhileDead = false,
				canCancel = true,
				disable = {
					car = true,
				},
				anim = {
					dict = dict,
					clip = anim
				},
			}) then
				local targetID = GetPlayerServerId(target)
				lib.callback('medic:useHeal', false, function(state) end, item, targetID)
			else

			end
		end
		ESX.ShowNotification('Medic Kit used!')
	else
		ESX.ShowNotification('Uh oh no medic kits available!')
	end
end
