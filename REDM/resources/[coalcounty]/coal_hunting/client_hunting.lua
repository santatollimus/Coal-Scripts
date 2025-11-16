-- client_hunting.lua
local Core = exports.vorp_core:GetCore()

local lastCarriedEntity = 0

local function isPedCarryingSomething(ped)
    -- IS_PED_CARRYING_SOMETHING
    return Citizen.InvokeNative(0xA911EE21EDF69DAF, ped)
end

local function getCarriedEntity(ped)
    -- GET_CARRIED_ATTACHED_ENTITY
    return Citizen.InvokeNative(0xD806CD2A4F2C2996, ped, 0)
end

CreateThread(function()
    while true do
        Wait(250)

        local ped = PlayerPedId()

        if isPedCarryingSomething(ped) then
            local ent = getCarriedEntity(ped)

 if ent ~= 0 and DoesEntityExist(ent) then
    if ent ~= lastCarriedEntity then
        lastCarriedEntity = ent

        -- Only try to get a net ID if the entity is actually networked
        local isNetworked = Citizen.InvokeNative(0xC7827959479DCC78, ent) -- NETWORK_GET_ENTITY_IS_NETWORKED
        local netId = nil
        if isNetworked then
            netId = NetworkGetNetworkIdFromEntity(ent)
        else
            netId = 0 -- we'll use the fallback delete path for non-networked entities
        end

        local model = GetEntityModel(ent)

        TriggerEvent("coal_debugger:log",
            ("[coal_hunting] Now carrying entity: netId=%s, model=%s")
            :format(tostring(netId), tostring(model))
        )

        TriggerServerEvent("coal_hunting:PickedUpCarcass", netId, model)
    end
end

        else
            -- Not carrying anything
            lastCarriedEntity = 0
        end
    end
end)

RegisterNetEvent("coal_hunting:ClientDeleteCarcass")
AddEventHandler("coal_hunting:ClientDeleteCarcass", function(netId)
    local ent = nil

    -- Try via network ID first (works for networked props/peds)
    if netId and netId ~= 0 then
        ent = NetworkGetEntityFromNetworkId(netId)
        if ent ~= 0 and DoesEntityExist(ent) then
            -- Debug
            TriggerEvent("coal_debugger:log",
                ("[coal_hunting] Deleting carcass by netId=%s (entity=%s)")
                :format(tostring(netId), tostring(ent))
            )
            DeleteEntity(ent)
            return
        end
    end

    -- Fallback: use the last carried entity (covers local-only entities like some animals)
    if lastCarriedEntity ~= 0 and DoesEntityExist(lastCarriedEntity) then
        TriggerEvent("coal_debugger:log",
            ("[coal_hunting] Deleting carcass using fallback lastCarriedEntity=%s")
            :format(tostring(lastCarriedEntity))
        )
        DeleteEntity(lastCarriedEntity)
        lastCarriedEntity = 0
    else
        TriggerEvent("coal_debugger:log",
            ("[coal_hunting] Failed to delete carcass (netId=%s) – no valid entity found")
            :format(tostring(netId))
        )
    end
end)

