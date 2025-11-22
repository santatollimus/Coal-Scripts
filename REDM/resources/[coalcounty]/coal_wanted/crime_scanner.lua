-- crime_scanner.lua
-- Simple crime scanner for Coal Wanted:
--   - watches for peds you kill
--   - when you kill an innocent civilian (Stranger NPC), adds murder heat

print("[crime_scanner] Loaded successfully")

local DEBUG_KILLS  = true   -- show what we detect in F8
local DEBUG_FILTER = false  -- show skipped peds / groups

-- Relationship groups for civilians (Strangers)
local CIV_GROUPS = {
    [`REL_CIVMALE`]   = true,
    [`REL_CIVFEMALE`] = true,
    [`REL_CIVNATIVE`] = true,
}

-- (Optional) relationship groups for law, if you later want special law heat
local LAW_GROUPS = {
    [`REL_LAW`]                = true,
    [`REL_LAW_BOUNTY_HUNTER`]  = true,
    [`REL_LAW_DISPATCH`]       = true,
    [`REL_LAW_BRTOWN`]         = true,
    [`REL_LAW_RHODES`]         = true,
    [`REL_LAW_VALENTINE`]      = true,
    [`REL_LAW_SAINT_DENIS`]    = true,
}

-- track peds we've already processed so we don't double-count
local seenDeadPeds = {}

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if playerPed ~= 0 then
            local peds = GetGamePool("CPed")

            for _, ped in ipairs(peds) do
                if ped ~= playerPed
                    and DoesEntityExist(ped)
                    and not IsPedAPlayer(ped)
                then
                    if IsEntityDead(ped) and not seenDeadPeds[ped] then
                        seenDeadPeds[ped] = true

                        local killer = GetPedSourceOfDeath(ped)
                        if killer == playerPed then
                            local model = GetEntityModel(ped)
                            local rel   = GetPedRelationshipGroupHash(ped)

                            if DEBUG_KILLS then
                                print(string.format("[crime_scanner] You killed ped model=%s rel=%s",
                                    tostring(model), tostring(rel)))
                            end

                            -- Is this an innocent Stranger NPC?
                            if IsPedHuman(ped) and CIV_GROUPS[rel] then
                                -- This is your "killed innocent Stranger" case
                                TriggerServerEvent("coal_wanted:Crime", "murder")

                                if DEBUG_KILLS then
                                    print("[crime_scanner] -> Added heat for murder (innocent Stranger)")
                                end

                            -- (optional) lawmen – you can treat these differently later
                            elseif IsPedHuman(ped) and LAW_GROUPS[rel] then
                                -- For now, also treat as murder
                                TriggerServerEvent("coal_wanted:Crime", "murder")

                                if DEBUG_KILLS then
                                    print("[crime_scanner] -> Added heat for murder (lawman)")
                                end

                            elseif DEBUG_FILTER then
                                print("[crime_scanner] Skipped kill (not civilian Stranger)", model, rel)
                            end
                        end
                    end
                end
            end
        end

        Wait(500) -- twice per second is plenty
    end
end)
