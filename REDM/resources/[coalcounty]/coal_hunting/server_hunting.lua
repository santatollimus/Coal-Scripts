-- server_hunting.lua - Coal County hunting rewards

local Core          = exports.vorp_core:GetCore()
local vorpInventory = exports.vorp_inventory:vorp_inventoryApi()

-----------------------------------------------------------------------
-- Reward lookup
-----------------------------------------------------------------------
local function getRewardsForModel(model)
    if not HuntingConfig or not HuntingConfig.rewards then
        return nil
    end
    return HuntingConfig.rewards[model]
end

-----------------------------------------------------------------------
-- Helpers for labels & pretty names
-----------------------------------------------------------------------
local function prettifyItemName(item)
    item = tostring(item or "")
    item = item:gsub("_", " ")
    return item:gsub("^%l", string.upper)
end

-- Try to fetch the **label** from vorp_inventory; fall back to prettified name
local function getItemLabel(itemName)
    itemName = tostring(itemName or "")

    -- 1) Newer vorp_inventory export: getServerItem
    local ok, data = pcall(function()
        local inv = exports.vorp_inventory
        if inv and inv.getServerItem then
            return inv:getServerItem(itemName)
        end
    end)

    if ok and data and data.label then
        return data.label
    end

    -- 2) Older vorpInventoryApi export: getDBItem
    if vorpInventory and vorpInventory.getDBItem then
        local ok2, data2 = pcall(function()
            -- source is unused in DB lookup, 0 is fine
            return vorpInventory.getDBItem(0, itemName)
        end)

        if ok2 and data2 and data2.label then
            return data2.label
        end
    end

    -- 3) Fallback: prettified internal name
    return prettifyItemName(itemName)
end

-----------------------------------------------------------------------
-- Give items + build summary string for debugger / tips
-----------------------------------------------------------------------
local function giveMeatToPlayer(source, rewards)
    local parts = {}

    for _, r in ipairs(rewards) do
        if r.item and r.count and r.count > 0 then
            vorpInventory.addItem(source, r.item, r.count)

            local itemName = tostring(r.item)
            -- allow manual override with r.display if you ever want it
            local label = r.display or getItemLabel(itemName)

            table.insert(parts, string.format("%dx %s", r.count, label))
        end
    end

    if #parts == 0 then
        return nil
    end

    return table.concat(parts, ", ")
end

-----------------------------------------------------------------------
-- Main handler: called when client picks up a carcass/pelt
-----------------------------------------------------------------------
RegisterNetEvent("coal_hunting:PickedUpCarcass")
AddEventHandler("coal_hunting:PickedUpCarcass", function(netId, model)
    local src = source

    model = tonumber(model) or model
    if not model then
        print("[coal_hunting] PickedUpCarcass: missing model from client")
        return
    end

    local rewards = getRewardsForModel(model)
    if not rewards then
        local msg = ("[coal_hunting] No rewards configured for model hash: %s")
            :format(tostring(model))
        print(msg)

        TriggerClientEvent("vorp:TipRight", src,
            "No hunting rewards configured for this carcass (model " .. tostring(model) .. ")",
            4000
        )

        -- Let Coal Debugger show this in F8 too
        TriggerClientEvent("coal_debugger:rewardLog", src, msg)
        return
    end

    -- Ask clients to delete the carcass entity.
    -- If netId == 0, your client fallback delete logic will handle it.
    if netId and netId ~= 0 then
        TriggerClientEvent("coal_hunting:ClientDeleteCarcass", -1, netId)
    else
        -- optional: if you have a specific fallback event, fire it here
        TriggerClientEvent("coal_hunting:ClientDeleteCarcassFallback", src)
    end

    -- Give rewards & build summary
    local summary = giveMeatToPlayer(src, rewards)

    local msg
    if summary then
        msg = ("[coal_hunting] Gave to %s from model %s: %s")
            :format(tostring(src), tostring(model), tostring(summary))
        TriggerClientEvent("vorp:TipRight", src, "You collected: " .. summary, 4000)
    else
        msg = ("[coal_hunting] Gave nothing to %s from model %s")
            :format(tostring(src), tostring(model))
        TriggerClientEvent("vorp:TipRight", src,
            "You collected nothing from the carcass.", 4000)
    end

    -- Server console log
    print(msg)

    -- Coal Debugger F8 log
    TriggerClientEvent("coal_debugger:rewardLog", src, msg)
end)
