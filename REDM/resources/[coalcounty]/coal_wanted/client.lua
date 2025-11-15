local Core = exports.vorp_core:GetCore()
local currentHeat = 0
local currentTier = 0
local lastReason = ''
local SHOW_HEAT_HUD = true
----------------------------------------------------------------
-- EVENT HANDLERS
----------------------------------------------------------------
RegisterNetEvent('coal_wanted:ClientHeatUpdate', function(heat, tier, reason)
    currentHeat = heat or 0
    currentTier = tier or 0
    lastReason = reason or ''
    local msg = ('Heat: %d | Tier: %d'):format(currentHeat, currentTier)
    if reason and reason ~= '' then
        msg = msg .. (' (%s)'):format(reason)
    end
    Core.NotifyRightTip(msg, 4000)
end)
RegisterNetEvent('coal_wanted:ClientTierChanged', function(newTier, oldTier)
    currentTier = newTier or 0
    local msg = ('Wanted tier changed: %d → %d'):format(oldTier or 0, newTier or 0)
    Core.NotifyRightTip(msg, 4000)
end)
----------------------------------------------------------------
-- OPTIONAL HEAT HUD + DEBUG COMMANDS
----------------------------------------------------------------
RegisterCommand('heatadd', function(source, args, raw)
    local amount = tonumber(args[1]) or 25
    TriggerServerEvent('coal_wanted:AddHeat', amount, 'cmd_heatadd')
end, false)
RegisterCommand('heatcrime', function(source, args, raw)
    local crime = args[1] or 'robbery'
    TriggerServerEvent('coal_wanted:Crime', crime)
end, false)
CreateThread(function()
    while true do
        if SHOW_HEAT_HUD then
            local heatText = ('HEAT: %d | TIER: %d'):format(currentHeat, currentTier)
            SetTextScale(0.3, 0.3)
            SetTextColor(255, 255, 255, 180)
            SetTextCentre(false)
            SetTextFontForCurrentCommand(1)
            local x = 0.98
            local y = 0.90
            Citizen.InvokeNative(0x4B18E1144DE175FA, 2)
            Citizen.InvokeNative(0x238FFE5C7B0498A6, 0.0, x)
            DisplayText(CreateVarString(10, 'LITERAL_STRING', heatText), x, y)
        end
        Wait(0)
    end
end)
