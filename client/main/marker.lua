--_Markers = Config.Markers
_Points = {}
_Blips = {}

_Markers = Config.Markers

local sleep = 500
Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local dist = 0
        for k,v in pairs(_Markers) do
            for i,p in pairs(v.markers) do
                dist = #(vec3(p.pos.x, p.pos.y, p.pos.z) - pos)
                if dist < 10 then
                    if dist < 3 and v.job == _playerData.job.name then
                        sleep = 0
                        DrawMarker(p.style.type, p.pos.x, p.pos.y, p.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, p.style.size.x, p.style.size.y, p.style.size.z, p.style.color.r, p.style.color.g, p.style.color.b, p.style.color.a, p.style.bob, p.style.face, 2, nil, nil, false)
                        DrawText3D(vec3(p.pos.x, p.pos.y, p.pos.z + 0.7), p.label, 0.7)
                    else
                        sleep = 500
                    end 
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

initBlips = function()
    
end

RegisterCommand('interactMarker', function()
    markerInteraction()
end)

RegisterKeyMapping('interactMarker', 'Marker Interaction', 'keyboard', 'E')

markerInteraction = function()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = 0
    local point = getClosestMarker()
    if point ~= nil and point.job == _playerData.job.name then
        local func = point.marker.interaction
        _G[func]()
    end
end

checkJobMarker = function(job)
    for k,v in pairs(_Markers) do
        if k == job then
            return true
        end
    end
end