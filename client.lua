Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()

        if IsPedShooting(ped) then
            local weapon = GetSelectedPedWeapon(ped)
            if weapon == GetHashKey("WEAPON_SMOKEGRENADE") then
                local coords = GetEntityCoords(PlayerPedId())
                local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 50.0, 1591549914, false, false, false)
                if obj and obj ~= 0 then
                    Citizen.CreateThread(function()
                        while true do
                            Citizen.Wait(100)
                            local vel = GetEntityVelocity(obj)
                            local speed = math.sqrt(vel.x * vel.x + vel.y * vel.y + vel.z * vel.z)
                            if speed < 0.05 then 
                                local objCoords = GetEntityCoords(obj)
                                evento(objCoords.x, objCoords.y, objCoords.z, obj)
                                break
                            end
                        end
                    end)
                end
            end
        end
    end
end)


function evento(coordx, coordy, coordz, obj)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        SetEntityProofs(ped, true, true, true, true, true, true, true, true)
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do
            Citizen.Wait(10)
        end
        UseParticleFxAssetNextCall("core")
        local fxHandle = StartParticleFxLoopedAtCoord("exp_grd_grenade_smoke", coordx, coordy, coordz + 0.3, 0.0, 0.0, 0.0, 6.0, false, false, false, false)
        Citizen.Wait(47000)
        StopParticleFxLooped(fxHandle, false)
        SetEntityProofs(ped, false, false, false, false, false, false, false, false)
    end)
end