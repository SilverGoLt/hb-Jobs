_bleeding = false
_injury = {
    ['head'] = {bleeding = false},
    ['body'] = {bleeding = false},
    ['leg'] = {bleeding = false},
}
AddEventHandler('gameEventTriggered', function (name, args)
    local hit, bone = GetPedLastDamageBone(cache.ped)
    if name == 'CEventNetworkEntityDamage' then
        if args[1] == cache.ped then
            --Head
            if bone == 31086 or bone == 39317 then
                _injury['head'].bleeding = true
                if not _bleeding then
                    _bleeding = true
                    bleedingThread()
                end
            end
            --Body
            if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
                 _injury['body'].bleeding = true
                if not _bleeding then
                    _bleeding = true
                    bleedingThread()
                end
            end
            --Leg
            if bone == 63931 or bone == 36864 or bone == 58271 or bone == 51826 or bone == 14201 or bone == 52301 then
                _injury['leg'].bleeding = true
                if not _bleeding then
                    _bleeding = true
                    bleedingThread()
                end
            end 
        end
    end
end)


shake = false
sprint = false
bleedingThread = function()
    while _bleeding do
        local curHP = GetEntityHealth(cache.ped)
        local maxHp = GetEntityMaxHealth(cache.ped)
        SetEntityHealth(curHP - 5)

        --- Shaking Screen with Red Screen Effect
        if not shake and curHP < maxHp then
            ShakeGameplayCam("DRUNK_SHAKE", 1.5)
            StartScreenEffect('Rampage', 0, true)
            shake = true
        elseif shake and not _bleeding then
            shake = false
            StopScreenEffect('Rampage')
            StopGameplayCamShaking(false)
        end
        ---

        if _injury['head'].bleeding then
        end

        if _injury['body'].bleeding then
            
        end

        if _injury['leg'].bleeding then
            if not sprint then
                disableSprinting()
                spring = true
            elseif sprint and _injury['leg'].bleeding == false then
                sprint = false
            end
        end

        Wait(3000)
    end
end

disableSprinting = function()
    Citizen.CreateThread(function()
        while _injury['leg'].bleeding do
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 22, true)
            Wait(0)
        end
    end)
end