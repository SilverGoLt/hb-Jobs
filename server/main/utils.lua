ESX = exports['rc-core']:getSharedObject()

RegisterCommand('getPos', function(source)
    local ped = GetPlayerPed(source)
    local heading = GetEntityHeading(ped)
    local pos = GetEntityCoords(ped)
    print(string.format('x = %s, y = %s, z = %s, heading = %s,', pos.x, pos.y, pos.z, heading))
end)

---Returns the players current job
---@param src number
---@return table
getJob = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer.job
end

---Checks if the player has the job
---@param src number
---@param pJob string
---@return boolean
isJob = function(src, pJob)
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job
    return job.name == pJob
end

---Checks if the player is in the table
---@param table string
---@param identifier string
---@return boolean
checkTable = function(table, identifier)
    for k, v in pairs(table) do
        if v == identifier then
            return true
        end
    end
end

---Sends the event to the client
---@param eventName string
---@param src number
---@param data table
sendClient = function(eventName, src, data)
    TriggerClientEvent(eventName, src, data)
end

---Addes the player to the table
---@param table string
---@param identifier string
addPlayerToTable = function(table, identifier)
    table[#table + 1] = identifier
end

---Removes the player from the table
---@param table string
---@param identifier string
removePlayerFromTable = function(table, identifier)
    for i=1, #table, 1 do
        if table[i] == identifier then
            table[i] = nil
            break
        end
    end
end

---Send message to discord webhook
---@param channel string
---@param msg string
sendToDiscord = function(channel, msg)
    --Discord Function
end

---Looks for vehicle in the config
---@param model string
lookForVeh = function(model)
    for k, v in pairs(Config.Vehicles) do
        for i, p in pairs(v) do
            if p.model == model then
                return {job = k, car = p}
            end
        end
    end
end

--- Returns item info
---@param item string Item Name
getItemInfo = function(item)
    for k,v in pairs(Config.Items) do
        for i, p in pairs(v) do
            if p.item == item then
                return p
            end
        end
    end
end

---Plays sound on vector3
---@param source number
---@param maxDistance number Distance
---@param soundFile string File path
---@param soundVolume number Sound Volume
playSound = function(source, maxDistance, soundFile, soundVolume)
  local ped = GetPlayerPed(source)
  local pos = GetEntityCoords(ped)
  local players = ESX.Players
  local dist = 0

  if maxDistance <= 10 then
    for k,v in pairs(players) do
      local tPed = GetPlayerPed(k)
      local tPos = GetEntityCoords(tPed)
      dist = #(tPos - pos)
      if dist < maxDistance then
        local volume = (1 - (dist / maxDistance)) * soundVolume
        print(string.format('Volume: %s, Player ID: %s', volume, k))
        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', k, dist, maxDistance, soundFile, volume)
      end
    end
  end
end


local whitelisted = {
    'police',
    'ambulance',
    'mechanic'
}
--- Returns if player is in a whitelisted job
checkWhitelist = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob()
    for k,v in pairs(whitelisted) do
        if job.name == v then
            return true
        end
    end
end
