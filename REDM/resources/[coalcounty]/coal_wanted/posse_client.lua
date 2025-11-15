-- posse_client.lua
local spawnedDeputies = {} -- [ped] = true

local function loadModel(hash)
    if not IsModelValid(hash) then return false end
    RequestModel(hash)
    local timeout = GetGameTimer() + 5000
    while not HasModelLoaded(hash) do
        Wait(0)
        if GetGameTimer() > timeout then
            return false
        end
    end
    return true
end

local function createDeputyAt(coords)
    local models = LawPosseConfig and LawPosseConfig.models or {}
    if #models == 0 then return nil end

    local model = models[math.random(1, #models)]
    local modelHash = model

    if not loadModel(modelHash) then
        return nil
    end

    local heading = math.random(0, 360) + 0.0
    local ped = CreatePed(modelHash, coords.x, coords.y, coords.z, heading, true, true, true, true)
    if not DoesEntityExist(ped) then
        SetModelAsNoLongerNeeded(modelHash)
        return nil
    end

    -- arm the deputy
    local weaponHash = (LawPosseConfig and LawPosseConfig.weapon) or `WEAPON_REPEATER_CARBINE`
    Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, 100, true, false, 0, false, 0.5, 1.0, 0.0, true) -- GiveWeaponToPed_2 ish

    SetPedRelationshipGroupHash(ped, `LAW`) -- optional, tweak relationship
    SetPedAccuracy(ped, 40)
    SetPedSeeingRange(ped, 80.0)
    SetPedHearingRange(ped, 80.0)

    SetModelAsNoLongerNeeded(modelHash)
    spawnedDeputies[ped] = true
    return ped
end

local function getRandomOffsetCoordsAround(entity, radius)
    local base = GetEntityCoords(entity)
    local angle = math.random() * 2.0 * math.pi
    local r = (math.random() * 0.5 + 0.5) * radius
    local offset = vector3(
        base.x + math.cos(angle) * r,
        base.y + math.sin(angle) * r,
        base.z
    )
    return offset
end

RegisterNetEvent('coal_law:SpawnPosseForSuspect', function(suspectSrc, tier)
    local myServerId = GetPlayerServerId(PlayerId())
    if suspectSrc ~= myServerId then
        -- not for us
        return
    end

    if not LawPosseConfig then
        return
    end

    local num = LawPosseConfig.numDeputies or 3
    local radius = LawPosseConfig.spawnRadius or 25.0

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- Simple one-time posse spawn
    for i = 1, num do
        local spawnPos = getRandomOffsetCoordsAround(playerPed, radius)
        local deputy = createDeputyAt(spawnPos)
        if deputy and DoesEntityExist(deputy) then
            -- Make them hate the player
            TaskCombatPed(deputy, playerPed, 0, 0)
        end
    end
end)

-- cleanup dead/too-far deputies
CreateThread(function()
    while true do
        if LawPosseConfig then
            local maxDist = LawPosseConfig.maxDistanceFromPlayer or 120.0
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for ped, _ in pairs(spawnedDeputies) do
                if not DoesEntityExist(ped) or IsEntityDead(ped) then
                    spawnedDeputies[ped] = nil
                else
                    local pCoords = GetEntityCoords(ped)
                    local dist = #(pCoords - playerCoords)
                    if dist > maxDist then
                        DeletePed(ped)
                        spawnedDeputies[ped] = nil
                    end
                end
            end
        end
        Wait(5000)
    end
end)
