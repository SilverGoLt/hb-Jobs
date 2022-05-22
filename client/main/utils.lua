
--- Prints table out normally
printJson = function(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        printJson(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
end

--- Returns closest marker details
function getClosestMarker()
  local pos = GetEntityCoords(PlayerPedId())
  for k,v in pairs(_Markers) do
    for i,p in pairs(v.markers) do
        dist = #(vec3(p.pos.x, p.pos.y, p.pos.z) - pos)
        if dist < 3 then
          return {marker = p, job = k}
        end
      end
    end
end

function DrawText3D(coords, text, size)
  local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
  if onScreen then
      local camCoords = GetGameplayCamCoord()
      local distance = #(coords - camCoords)
      local fov = (1 / GetGameplayCamFov()) * 100
      local scale = ((size / distance) * fov) * 4

      SetTextScale(0.0, 0.25 * scale)
      SetTextFont(4)
      SetTextDropShadow()
      SetTextCentre(true)

      BeginTextCommandDisplayText('STRING')
      AddTextComponentSubstringPlayerName(text)
      EndTextCommandDisplayText(x, y)
      
      local factor = string.len(text) / 500
      DrawRect(x, y + (0.008 + distance / (5000 * size)) * scale, (0.015 + factor) * scale, 0.02 * scale, 0, 0, 0, 100)
  end
end

spawnVehicle = function(spawn, model)
  ESX.Game.SpawnVehicle(GetHashKey(model), vec3(spawn.x,spawn.y,spawn.z), spawn.heading, function(vehicle)end)
end

--- Sets player skin
setPlayerSkin = function (list, uniform, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)
    if list ~= nil then
      for k,v in pairs(list) do
          if k == uniform then
              if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, v.data.male)
              else
                TriggerEvent('skinchanger:loadClothes', skin, v.data.female)
              end
          end
      end
  end
	end)
end
