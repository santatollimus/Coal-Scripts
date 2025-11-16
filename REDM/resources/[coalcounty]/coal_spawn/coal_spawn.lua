-- coal_spawn.lua
-- Dev helper: /spawn <hashOrName>

-- simple model loader
local function loadModel(model)
    if not IsModelValid(model) then
        print(("[coal_spawn] Invalid model hash: %s"):format(tostring(model)))
        return false
    end

    if not HasModelLoaded(model) then
        RequestModel(model)
        local timeout = GetGameTimer() + 5000

        while not HasModelLoaded(model) do
            Wait(0)
            if GetGameTimer() > timeout then
                print("[coal_spawn] Failed to load model in time")
                return false
            end
        end
    end

    return true
end

-- RedM CreatePed_2 wrapper
local function CreatePed_2(modelHash, x, y, z, heading, isNetwork, thisScriptCheck, p7, p8)
    return Citizen.InvokeNative(
        0xD49F9B0955C367DE, -- CREATE_PED
        modelHash, x, y, z, heading, isNetwork, thisScriptCheck, p7, p8
    )
end

-- give the ped a default/random outfit (fix invisible animal issue)
local function SetPedDefaultOutfit(ped)
    if ped ~= 0 and DoesEntityExist(ped) then
        -- 0x283978A15512B2FE: _SET_RANDOM_OUTFIT_VARIATION / default outfit
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    end
end

RegisterCommand("spawn", function(source, args)
    if #args < 1 then
        print("[coal_spawn] Usage: /spawn <hash or model name>")
        return
    end

    local input = args[1]

    -- allow either numeric hash or model name
    local model = tonumber(input)
    if not model then
        model = GetHashKey(input)
    end

    if not IsModelValid(model) then
        print(("[coal_spawn] Model is not valid: %s"):format(tostring(input)))
        return
    end

    if not loadModel(model) then
        return
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    -- spawn a couple meters in front of the player
    local spawnDist = 3.0
    local rad = math.rad(heading)
    local sx = coords.x + math.cos(rad) * spawnDist
    local sy = coords.y + math.sin(rad) * spawnDist
    local sz = coords.z

    local spawned = CreatePed_2(model, sx, sy, sz, heading, true, true, true, true)

    if spawned == 0 or not DoesEntityExist(spawned) then
        print("[coal_spawn] Failed to create ped")
        return
    end

    SetPedDefaultOutfit(spawned)
    SetEntityAsMissionEntity(spawned, true, false)

    print(("[coal_spawn] Spawned ped %s at %.2f, %.2f, %.2f (model=%s)")
        :format(tostring(spawned), sx, sy, sz, tostring(model)))
end, false)
