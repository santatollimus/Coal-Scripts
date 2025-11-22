-- law_server.lua
local Core = exports.vorp_core:GetCore()

-- who is currently “law on duty”
local OnDutyLawmen = {}   -- [src] = { job = 'sheriff' }

-- CONFIG: when should law care?
local MIN_TIER_TO_NOTIFY = 2
local MIN_TIER_TO_HARD_AGGRO = 3

----------------------------------------------------------------
-- LAW DUTY TOGGLE
----------------------------------------------------------------
RegisterNetEvent('coal_law:GoOnDuty', function(jobName)
    local src = source
    OnDutyLawmen[src] = { job = jobName or 'law' }
    print(('[LAW] %s is now on duty as %s'):format(src, jobName or 'law'))
end)

RegisterNetEvent('coal_law:GoOffDuty', function()
    local src = source
    OnDutyLawmen[src] = nil
    print(('[LAW] %s went off duty'):format(src))
end)

AddEventHandler('playerDropped', function()
    OnDutyLawmen[source] = nil
end)

----------------------------------------------------------------
-- HOOK INTO WANTED TIER CHANGES
----------------------------------------------------------------
AddEventHandler('coal_wanted:ServerTierChanged', function(suspectSrc, newTier, oldTier)
    if newTier < MIN_TIER_TO_NOTIFY then return end
    if newTier <= oldTier then return end

    -- Notify all on-duty player-lawmen
    for lawSrc, _ in pairs(OnDutyLawmen) do
        TriggerClientEvent('coal_law:SuspectTierUpdate', lawSrc, suspectSrc, newTier, MIN_TIER_TO_HARD_AGGRO)
    end

    -- Notification to suspect: spawn posse if threshold crossed
  --  if LawPosseConfig and newTier >= (LawPosseConfig.posseTier or MIN_TIER_TO_HARD_AGGRO) then
    --    TriggerClientEvent('coal_law:SpawnPosseForSuspect', suspectSrc, suspectSrc, newTier)
   -- end
end)

----------------------------------------------------------------
-- CALLBACK API FOR OTHER SCRIPTS / NPC AI
----------------------------------------------------------------
Core.Callback.Register('coal_law:ShouldAggro', function(source, cb, suspectSrc)
    Core.Callback.Trigger('coal_wanted:GetHeat', suspectSrc, function(heat, tier)
        if tier >= MIN_TIER_TO_HARD_AGGRO then
            cb(true, 'hard_aggro')
        elseif tier >= MIN_TIER_TO_NOTIFY then
            cb(true, 'soft_aggro')
        else
            cb(false, 'ignore')
        end
    end)
end)

----------------------------------------------------------------
-- /lawlist (REQUEST LAW LIST)
----------------------------------------------------------------
RegisterNetEvent('coal_law:RequestLawList', function()
    local src = source
    local list = {}

    for lawSrc, data in pairs(OnDutyLawmen) do
        list[#list+1] = {
            id = lawSrc,
            name = GetPlayerName(lawSrc) or ('ID ' .. tostring(lawSrc)),
            job = data.job or 'law'
        }
    end

    TriggerClientEvent('coal_law:ReceiveLawList', src, list)
end)
-- Track who already had a posse spawned at their current heat streak
local PosseSpawnedFor = {}   -- [src] = true/false

CreateThread(function()
    while true do
        Wait(10000) -- check every 10 seconds; tweak if you want faster

        if not LawPosseConfig then
            goto continue
        end

        local posseTier = LawPosseConfig.posseTier or MIN_TIER_TO_HARD_AGGRO

        -- Loop all players on the server
        for _, src in ipairs(GetPlayers()) do
            local intSrc = tonumber(src)

            Core.Callback.Trigger('coal_wanted:GetHeat', intSrc, function(heat, tier)
                local hasPosse = PosseSpawnedFor[intSrc] or false

                -- If player is hot enough and no posse yet for this heat streak → spawn
                if tier >= posseTier and not hasPosse then
                    PosseSpawnedFor[intSrc] = true
                    print(('[LAW] Spawning posse for %s (tier=%d heat=%d)'):format(intSrc, tier, heat))
                    TriggerClientEvent('coal_law:SpawnPosseForSuspect', intSrc, intSrc, tier)

                -- If player cooled down below posseTier → allow future posse again
                elseif tier < posseTier and hasPosse then
                    PosseSpawnedFor[intSrc] = false
                    print(('[LAW] Reset posse flag for %s (tier=%d heat=%d)'):format(intSrc, tier, heat))
                end
            end)
        end

        ::continue::
    end
end)
