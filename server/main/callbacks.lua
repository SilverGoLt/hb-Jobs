lib.callback.register('job-sv:takeOut', function(source, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job
    local info = lookForVeh(model)

    if info ~= nil then
        return info.job == job.name
    else
        return false
    end
end)

lib.callback.register('job-sv:checkWhitelist', function(source)
    local whitelist = checkWhitelist(source)
    if whitelist ~= nil and whitelist then return true else return false end
end)

lib.callback.register('job-sv:sendBill', function(source, data)
    print(json.encode())
    local bill = sendBilling(source, data.target, data.description, data.amount)
    if bill then
        return true
    else
        return false
    end
end)

