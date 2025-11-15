local Core = exports.vorp_core:GetCore()
local vorpInventory = exports.vorp_inventory:vorp_inventoryApi()

-- Look up reward table for a model hash
local function getRewardsForModel(model)
    if not HuntingConfig or not HuntingConfig.rewards then
        return nil
    end
    return HuntingConfig.rewards[model]
end

-- "raw_venison" -> "Raw venison"
local function prettifyItemName(item)
    item = tostring(item or "")
    item = item:gsub("_", " ")
    return item:gsub("^%l", string.upper)
end

-- Give items and build a nice summary string
local function giveMeatToPlayer(source, rewards)
    local parts = {}

    for _, r in ipairs(rewards) do
        if r.item and r.count and r.count > 0 then
            vorpInventory.addItem(source, r.item, r.count)

            local label = string.format("%dx %s", r.count, prettifyItemName(r.item))
            table.insert(parts, label)
        end
    end

    if #parts == 0 then
        return nil
    end

    return table.concat(parts, ", ")
end

RegisterNetEvent("coal_hunting:PickedUpCarcass")
AddEventHandler("coal_hunting:PickedUpCarcass", function(netId, model)
    local src = source
    if not netId or not model then
        return
    end

    -- If the network ID no longer exists, bail out cleanly
    if not NetworkDoesNetworkIdExist(netId) then
        TriggerClientEvent("vorp:TipRight", src, "The carcass is no longer here.", 4000)
        return
    end

    -- Now it's safe to resolve the entity
    local entity = NetworkGetEntityFromNetworkId(netId)
    if entity == 0 or not DoesEntityExist(entity) then
        TriggerClientEvent("vorp:TipRight", src, "The carcass is no longer here.", 4000)
        return
    end

    -- Always trust the actual entity model
    local actualModel = GetEntityModel(entity)
    if actualModel ~= 0 and actualModel ~= -1 then
        model = actualModel
    end

    -- Look up rewards for this model
    local rewards = getRewardsForModel(model)
    if not rewards then
        print(("[coal_hunting] No rewards configured for model hash: %s"):format(tostring(model)))
        TriggerClientEvent("vorp:TipRight", src,
            "No hunting rewards configured for this carcass (model " .. tostring(model) .. ")", 4000)
        return
    end

    -- DEBUG: see exactly what we’re handling
    print(("[coal_hunting] Player %s picked up carcass: netId=%s, model=%s"):format(
        tostring(src), tostring(netId), tostring(model)
    ))

    -- Delete the carcass / prop for everyone
    DeleteEntity(entity)
    TriggerClientEvent("coal_hunting:ClientDeleteCarcass", -1, netId)

    -- Give meat & build summary
local summary = giveMeatToPlayer(src, rewards)

-- NEW: send summary to coal_debugger on that client
TriggerClientEvent("coal_debugger:RewardSummary", src, model, summary)

local msg = summary and ("You collected: " .. summary)
                   or  "You collected nothing from the carcass."

TriggerClientEvent("vorp:TipRight", src, msg, 4000)

end)
