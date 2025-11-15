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
        local ped = PlayerPedId()

        if ped ~= 0 and isPedCarryingSomething(ped) then
            local carried = getCarriedEntity(ped)

            if carried ~= 0 and DoesEntityExist(carried) and carried ~= lastCarriedEntity then
                lastCarriedEntity = carried

                local model = GetEntityModel(carried)

                -- Only try to get a net ID if the entity is networked,
                -- otherwise RedM will warn: no net object for entity
                local netId = 0
                if NetworkGetEntityIsNetworked(carried) then
                    netId = NetworkGetNetworkIdFromEntity(carried)
                end

                -- If you want it in chat too, uncomment this:
                -- TriggerEvent("chat:addMessage", {
                --     args = { "Hunting", "Model hash: " .. tostring(model) }
                -- })

                if netId ~= 0 then
                    -- Send the carcass model + net ID to the server
                    TriggerServerEvent("coal_hunting:PickedUpCarcass", netId, model)
                else
                    -- Optional: local-only entity; no server sync
                    -- print(("[coal_hunting] Local-only carcass, model=%s"):format(tostring(model)))
                end
            end
        end

        Wait(500)
    end
end)

-- Optional: client-side delete if server asks (safety / desync fix)
RegisterNetEvent("coal_hunting:ClientDeleteCarcass", function(netId)
    local ent = NetworkGetEntityFromNetworkId(netId)
    if ent ~= 0 and DoesEntityExist(ent) then
        DeleteEntity(ent)
    end
end)
