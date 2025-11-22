-- crime_scanner.lua
-- Listens for EVENT_CRIME_CONFIRMED and feeds coal_wanted with specific offenses,
-- plus a backup handler for killing innocent civilian "stranger" NPCs.

print("[crime_scanner] Loaded successfully")

local EVENT_CRIME_CONFIRMED = GetHashKey("EVENT_CRIME_CONFIRMED") -- 1924269094
local EVENT_PED_KILLED      = GetHashKey("EVENT_PED_KILLED")

-- Map game crime type hashes -> your CoalWantedConfig.offenseHeat keys
local CrimeHashToOffense = {
    ----------------------------------------------------------------------
    -- MURDER (players + NPCs + law + animals)
    ----------------------------------------------------------------------
    [GetHashKey("CRIME_MURDER")]               = "murder",
    [GetHashKey("CRIME_MURDER_LAW")]           = "murder",
    [GetHashKey("CRIME_MURDER_PLAYER")]        = "murder",
    [GetHashKey("CRIME_MURDER_PLAYER_HORSE")]  = "murder",
    [GetHashKey("CRIME_MURDER_HORSE")]         = "murder",
    [GetHashKey("CRIME_MURDER_LIVESTOCK")]     = "murder",
    [GetHashKey("CRIME_MURDER_ANIMAL")]        = "murder", -- change to "poaching" if you want

    ----------------------------------------------------------------------
    -- ASSAULT / THREAT / RESISTING
    ----------------------------------------------------------------------
    [GetHashKey("CRIME_ASSAULT")]              = "assault",
    [GetHashKey("CRIME_UNARMED_ASSAULT")]      = "assault",
    [GetHashKey("CRIME_ASSAULT_LAW")]          = "assault",
    [GetHashKey("CRIME_ASSAULT_HORSE")]        = "assault",
    [GetHashKey("CRIME_ASSAULT_ANIMAL")]       = "assault",
    [GetHashKey("CRIME_LASSO_ASSAULT")]        = "assault",
    [GetHashKey("CRIME_RESIST_ARREST")]        = "assault",
    [GetHashKey("CRIME_LAW_IS_THREATENED")]    = "assault",
    [GetHashKey("CRIME_THREATEN")]             = "assault",
    [GetHashKey("CRIME_THREATEN_LAW")]         = "assault",
    [GetHashKey("CRIME_HIT_AND_RUN")]          = "assault",
    [GetHashKey("CRIME_HIT_AND_RUN_LAW")]      = "assault",
    [GetHashKey("CRIME_TRAMPLE")]              = "assault",
    [GetHashKey("CRIME_TRAMPLE_LAW")]          = "assault",
    [GetHashKey("CRIME_TRAMPLE_PLAYER")]       = "assault",

    ----------------------------------------------------------------------
    -- ROBBERY / BURGLARY
    ----------------------------------------------------------------------
    [GetHashKey("CRIME_ROBBERY")]              = "robbery",
    [GetHashKey("CRIME_BANK_ROBBERY")]         = "robbery",
    [GetHashKey("CRIME_TRAIN_ROBBERY")]        = "robbery",
    [GetHashKey("CRIME_STAGECOACH_ROBBERY")]   = "robbery",
    [GetHashKey("CRIME_BURGLARY")]             = "robbery",
    [GetHashKey("CRIME_JACK_VEHICLE")]         = "robbery",
    [GetHashKey("CRIME_JACK_HORSE")]           = "robbery",
    [GetHashKey("CRIME_GRAVE_ROBBERY")]        = "robbery",
    [GetHashKey("CRIME_KIDNAPPING")]           = "robbery",
    [GetHashKey("CRIME_KIDNAPPING_LAW")]       = "robbery",

    ----------------------------------------------------------------------
    -- THEFT / STOLEN GOODS
    ----------------------------------------------------------------------
    [GetHashKey("CRIME_THEFT")]                = "theft",
    [GetHashKey("CRIME_THEFT_HORSE")]          = "theft",
    [GetHashKey("CRIME_THEFT_LIVESTOCK")]      = "theft",
    [GetHashKey("CRIME_THEFT_VEHICLE")]        = "theft",
    [GetHashKey("CRIME_STOLEN_GOODS")]         = "theft",
    [GetHashKey("CRIME_LOOTING")]              = "theft",
    [GetHashKey("CRIME_JACK_HORSE")]           = "theft",   -- flip to "robbery" if you prefer
    [GetHashKey("CRIME_JACK_VEHICLE")]         = "theft",
    [GetHashKey("CRIME_CHEATING")]             = "theft",

    ----------------------------------------------------------------------
    -- TRESPASS / MINOR DISORDER
    ----------------------------------------------------------------------
    [GetHashKey("CRIME_TRESPASSING")]          = "trespass",
    [GetHashKey("CRIME_LOITERING")]            = "trespass",
    [GetHashKey("CRIME_DISTURBANCE")]          = "trespass",
    [GetHashKey("CRIME_HASSLE")]               = "trespass",

    ----------------------------------------------------------------------
    -- PROPERTY DAMAGE / EXPLOSIONS (generic heat)
    ----------------------------------------------------------------------
    [GetHashKey("CRIME_PROPERTY_DESTRUCTION")] = "generic",
    [GetHashKey("CRIME_VANDALISM")]            = "generic",
    [GetHashKey("CRIME_VANDALISM_VEHICLE")]    = "generic",
    [GetHashKey("CRIME_VEHICLE_DESTRUCTION")]  = "generic",
    [GetHashKey("CRIME_EXPLOSION")]            = "generic",
    [GetHashKey("CRIME_EXPLOSION_POISON")]     = "generic",

    ----------------------------------------------------------------------
    -- FALLBACK / DEBUG-ONLY TYPES
    ----------------------------------------------------------------------
    [GetHashKey("CRIME_ARSON")]                = "generic",
    [GetHashKey("CRIME_ACCOMPLICE")]           = "generic",
    [GetHashKey("CRIME_SELF_DEFENCE")]         = "generic", -- usually shouldn't give heat
    [GetHashKey("CRIME_WANTED_LEVEL_UP_DEBUG_HIGH")] = "generic",
    [GetHashKey("CRIME_WANTED_LEVEL_UP_DEBUG_LOW")]  = "generic",
}

local DEFAULT_OFFENSE = "generic"
local DEBUG_CRIMES    = true
local DEBUG_KILLS     = true

-- Helper: read 3 int32s from an event using the raw native
local function ReadEventInts(group, index, dataSize)
    local dv = DataView.ArrayBuffer(8 * dataSize)          -- 8 bytes per int slot
    local ok = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA,    -- GET_EVENT_DATA
        group, index, dv:Buffer(), dataSize)
    if not ok then
        return nil
    end
    local values = {}
    for n = 0, dataSize - 1 do
        values[#values+1] = dv:GetInt32(n * 8)
    end
    return table.unpack(values)
end

CreateThread(function()
    while true do
        Wait(0)

        -- crimes are in group 0 according to vorp_utils/events.lua
        local size = GetNumberOfEvents(0)
        if size > 0 then
            for i = 0, size - 1 do
                local eventType = GetEventAtIndex(0, i)

                -- 1) Standard crime system → map by crime hash
                if eventType == EVENT_CRIME_CONFIRMED then
                    -- datasize = 3 (crimeHash, criminalPed, witness) in events.lua
                    local crimeHash, criminalPed, witnessPed = ReadEventInts(0, i, 3)
                    if crimeHash and criminalPed then
                        if criminalPed == PlayerPedId() then
                            local offense = CrimeHashToOffense[crimeHash] or DEFAULT_OFFENSE

                            if DEBUG_CRIMES then
                                print(("[crime] EVENT_CRIME_CONFIRMED hash=%s offense=%s")
                                    :format(tostring(crimeHash), offense))
                            end

                            TriggerServerEvent("coal_wanted:Crime", offense)
                        end
                    end

                -- 2) Backup: killing an innocent civilian stranger NPC
                elseif eventType == EVENT_PED_KILLED then
                    -- datasize is also 3 for PED_KILLED: victim, killer, weapon
                    local victim, killer, weaponHash = ReadEventInts(0, i, 3)
                    if victim and killer then
                        if killer == PlayerPedId()
                            and DoesEntityExist(victim)
                            and IsPedHuman(victim)
                            and not IsPedAPlayer(victim)
                        then
                            local rel = GetPedRelationshipGroupHash(victim)
                            if rel == `REL_CIVMALE` or rel == `REL_CIVFEMALE` or rel == `REL_CIVNATIVE` then
                                if DEBUG_KILLS then
                                    print("[crime] Killed innocent stranger → adding murder heat")
                                end
                                TriggerServerEvent("coal_wanted:Crime", "murder")
                            end
                        end
                    end
                end
            end
        end
    end
end)
