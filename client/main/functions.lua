--- Opens uniform menu
function openUniforms()
    local point = getClosestMarker()
    local list = Config.Skins[_playerData.job.name]
    if point ~= nil and point.job == _playerData.job.name then
        local menu = {
            {
                id = 0,
                header = "Persirengimo Kambarys",
                txt = 'Uniformos pasirinkimas'
            },
        }
        if list ~= nil then
            for k,v in pairs(list) do
                if v.grade <= _playerData.job.grade then
                    menu[#menu+1] = {
                        id = k,
                        header = v.label,
                        txt = ' ',
                        params = {
                            event = 'job-cl:putUniform',
                            isServer = false,
                            args = {
                                uniform = k
                            }
                        }
                    }
                end
            end
        end
        exports['rc-context']:openMenu(menu)
    end
end

RegisterCommand('testBill', function() sendBillingRequest() end)
--- Opens billing menu
function sendBillingRequest(entity)
    local target, distance = ESX.Game.GetClosestPlayer()
    if target ~= -1 and distance < 2 then
        lib.callback('job-sv:checkWhitelist', false, function(whitelisted)
            if whitelisted then
                local input = lib.inputDialog('Saskaitos Israsymas', {'Aprasymas', 'Suma'})
                if input then
                    local description = input[1]
                    local amount = tonumber(input[2])
                    if amount ~= -1 and amount ~= nil then
                        lib.callback('job-sv:sendBill', false, function(completed)
                            if completed then
                                lib.notify({
                                    title = 'Saskaitos',
                                    description = string.format('Saskaita zaidejui: %s israsyta sekmingai!', GetPlayerServerId(target)),
                                    type = 'success'
                                })
                            end
                        end, {
                            target = GetPlayerServerId(target), 
                            description = description, 
                            amount = amount
                        })
                    end
                end
            end
        end)
    end
end

RegisterNetEvent('job-cl:putUniform', function(args)
    local list = Config.Skins[_playerData.job.name]
    print(json.encode(args))
    if list ~= nil and args.uniform >= 1 then
        for k,v in pairs(list) do
            if k == args.uniform then
                if v.reset ~= nil then
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        local isMale = skin.sex == 0
                        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                TriggerEvent('esx:restoreLoadout')
                            end)
                        end)
            
                    end)
                else
                    setPlayerSkin(list, k, cache.ped)
                end
            end
        end
    end
end)

RegisterNetEvent('job-cl:resetSkin', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0
        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
            end)
        end)

    end)
end)

--- Garage System Section

local currentSpawn = {}
--- Opens the job garage
openGarage = function()
	local list = _cfgVehicles[_playerData.job.name]
	local point = getClosestMarker()
	printJson(point)
	currentSpawn = point.marker.spawn
	if point.marker.spawn == nil then
		ESX.ShowNotification('Uh oh sistemos klaida!')
		return
	end
	
	local jobName = string.upper(point.job)
	local cars = {}
	local menu = {
		{
            id = 0,
            header = string.format('%s GARAZAS', jobName),
            txt = 'Cia galite isitraukti savo lauza'
        },
	}
	if list ~= nil then
		for k,v in pairs(list) do
			if v.grade <= _playerData.job.grade then
				menu[#menu+1] = {
					id = k,
					header = v.name,
					txt = 'Masinos Istraukimas!',
					params = {
						event = 'job-cl:tryTakeout',
						isServer = false,
						args = {
							model = v.model
						}
					}
				}
			end
		end
	end
	exports['rc-context']:openMenu(menu)
end

RegisterNetEvent('job-cl:tryTakeout', function(args)
	local check = ESX.Game.IsSpawnPointClear(currentSpawn, 5)
	if check then
		lib.callback('job-sv:takeOut',false, function(state)
			print(state)
			if state then
				spawnVehicle(currentSpawn, args.model)
			else
				ESX.ShowNotification('Jus negalite istraukti masinos!')
			end
		end, args.model)
	else
		ESX.ShowNotification('Nepavyko isitraukti masinos')
	end
end)