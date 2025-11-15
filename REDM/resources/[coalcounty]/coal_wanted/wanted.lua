local Core = exports.vorp_core:GetCore()
local DBG = {
    Info    = function(...) print('[HEAT][INFO]', ...) end,
    Warning = function(...) print('[HEAT][WARN]', ...) end,
    Error   = function(...) print('[HEAT][ERROR]', ...) end,
}
local PlayerHeat = {}    -- [src] = { heat = number, tier = number }
----------------------------------------------------------------
-- UTIL
----------------------------------------------------------------
local function clamp(v, min, max)
    if v < min then return min end
    if v > max then return max end
    return v
end
local function getTierForHeat(heat)
    local tier = 0
    for _, t in ipairs(CoalWantedConfig.tiers) do
        if heat >= t.min and t.level >= tier then
            tier = t.level
        end
    end
    return tier
end
local function initPlayer(source)
    if not PlayerHeat[source] then
        PlayerHeat[source] = {
            heat = 0,
            tier = 0,
        }
    end
end
local function setHeat(source, newHeat, reason)
    initPlayer(source)
    local data = PlayerHeat[source]
    local oldHeat = data.heat
    local oldTier = data.tier
    local clamped = clamp(newHeat, 0, CoalWantedConfig.maxHeat)
    local newTier = getTierForHeat(clamped)
    data.heat = clamped
    data.tier = newTier
    DBG.Info(('[Heat] src=%s heat=%d tier=%d reason=%s'):format(
        tostring(source), clamped, newTier, tostring(reason or 'n/a')
    ))
    -- Notify this player’s client
    TriggerClientEvent('coal_wanted:ClientHeatUpdate', source, clamped, newTier, reason or '')
    -- If tier changed, fire a separate event (for law AI, jobs, etc)
    if newTier ~= oldTier then
        DBG.Info(('[Heat] src=%s tier changed %d -> %d'):format(
            tostring(source), oldTier, newTier
        ))
        TriggerClientEvent('coal_wanted:ClientTierChanged', source, newTier, oldTier)
        -- Server-side hook for law systems
        TriggerEvent('coal_wanted:ServerTierChanged', source, newTier, oldTier)
    end
end
local function addHeat(source, amount, reason)
    initPlayer(source)
    setHeat(source, (PlayerHeat[source].heat or 0) + amount, reason)
end
local function removeHeat(source, amount, reason)
    initPlayer(source)
    setHeat(source, (PlayerHeat[source].heat or 0) - amount, reason)
end
----------------------------------------------------------------
-- PUBLIC EVENTS / API
----------------------------------------------------------------
-- Generic “crime happened” event
RegisterNetEvent('coal_wanted:AddHeat', function(amount, reason)
    local src = source
    amount = tonumber(amount) or 0
    if amount <= 0 then return end
    addHeat(src, amount, reason or 'generic')
end)
-- More semantic event for other scripts: coal_wanted:Crime
-- Example usage from other resources:
-- TriggerServerEvent('coal_wanted:Crime', 'robbery')
RegisterNetEvent('coal_wanted:Crime', function(crimeType)
    local src = source
    local cfgAmount = CoalWantedConfig.offenseHeat[crimeType] or CoalWantedConfig.offenseHeat.generic or 10
    addHeat(src, cfgAmount, crimeType)
end)
-- Allow other scripts to explicitly clear or set heat
RegisterNetEvent('coal_wanted:SetHeat', function(value, reason)
    local src = source
    setHeat(src, tonumber(value) or 0, reason or 'set')
end)
RegisterNetEvent('coal_wanted:ClearHeat', function()
    local src = source
    setHeat(src, 0, 'clear')
end)
-- Callback-style API (if you want to query from other scripts)
-- Example: Core.Callback.Trigger('coal_wanted:GetHeat', src, function(heat, tier) ... end)
Core.Callback.Register('coal_wanted:GetHeat', function(source, cb)
    initPlayer(source)
    cb(PlayerHeat[source].heat, PlayerHeat[source].tier)
end)
----------------------------------------------------------------
-- DECAY THREAD
----------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(CoalWantedConfig.baseDecay.interval or 60000)
        for src, data in pairs(PlayerHeat) do
            if data.heat and data.heat > 0 then
                -- Basic decay; you could add positional modifiers here later
                local newHeat = data.heat - (CoalWantedConfig.baseDecay.amount or 1)
                setHeat(src, newHeat, 'decay')
            end
        end
    end
end)
----------------------------------------------------------------
-- PLAYER JOIN / DROP
----------------------------------------------------------------
AddEventHandler('playerDropped', function()
    local src = source
    PlayerHeat[src] = nil
end)
-- Optional: initialize on connect (if you want to load from DB later)
AddEventHandler('playerConnecting', function()
    local src = source
    initPlayer(src)
    -- Here is where you’d load heat from DB if you decide to persist it
end)
