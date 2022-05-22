
_playerDamage = {}
setPlayerDowned = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        addPlayerToTable('_downed', xPlayer.identifier)
    end
end

setPlayerDamage = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local damage = {
      identifier = xPlayer.identifier,
      state = downed,
      status = {
        --[[
          {name = "head", bleeding = 'normal'}
        ]]
      }
    }
end
