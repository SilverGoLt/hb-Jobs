--- Sends a bill to the target
function sendBilling(source, target, description, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local isWhitelisted = checkWhitelist(source)
    
    if isWhitelisted and xTarget ~= -1 and xTarget ~= nil then
        -- Add bill to the player (Maybe a new billing system?)
        print('[RCJOB] Sending bill to '..xTarget.name)
        return true
    end
end