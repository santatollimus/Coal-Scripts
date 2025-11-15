-- law_client.lua
local Core = exports.vorp_core:GetCore()

local IS_ON_DUTY_LAW = false
local TRACKED_SUSPECTS = {} -- [serverId] = { tier = n, blip = blipHandle }

----------------------------------------------------------------
-- SIMPLE DUTY TOGGLE COMMAND (for testing)
----------------------------------------------------------------
RegisterCommand('lawduty', function()
    IS_ON_DUTY_LAW = not IS_ON_DUTY_LAW
    if IS_ON_DUTY_LAW then
        TriggerServerEvent('coal_law:GoOnDuty', 'sheriff')
        Core.NotifyRightTip('You are now ~o~ON DUTY~q~ as lawman', 4000)
    else
        TriggerServerEvent('coal_law:GoOffDuty')
        Core.NotifyRightTip('You are now ~o~OFF DUTY~q~', 4000)
        for _, data in pairs(TRACKED_SUSPECTS) do
            if data.blip then
                RemoveBlip(data.blip)
            end
        end
        TRACKED_SUSPECTS = {}
    end
end, false)

RegisterCommand('lawlist', function()
    TriggerServerEvent('coal_law:RequestLawList')
end, false)
----------------------------------------------------------------
-- RECEIVE SUSPECT UPDATES FROM SERVER
----------------------------------------------------------------
RegisterNetEvent('coal_law:SuspectTierUpdate', function(suspectSrc, newTier, hardAggroTier)
    if not IS_ON_DUTY_LAW then return end

    local suspectClientId = GetPlayerFromServerId(suspectSrc)
    if suspectClientId == -1 then return end -- not streamed in

    local ped = GetPlayerPed(suspectClientId)
    if not DoesEntityExist(ped) then return end

    local isHardAggro = (newTier >= hardAggroTier)
    local msg
    if isHardAggro then
        msg = ("[LAW] HARD target (Tier %d) – CHASE!"):format(newTier)
    else
        msg = ("[LAW] Suspect Tier %d – investigate / question."):format(newTier)
    end
    Core.NotifyRightTip(msg, 5000)

    -- Create or update a blip for this suspect
    local existing = TRACKED_SUSPECTS[suspectSrc]
    if existing and existing.blip then
        RemoveBlip(existing.blip)
    end

    local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, ped) -- RedM: MAP BLIP on entity
    -- Some natives for blip style; tweak as needed:
    -- Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Suspect")

    TRACKED_SUSPECTS[suspectSrc] = {
        tier = newTier,
        blip = blip,
        hard = isHardAggro,
    }
end)
----------------------------------------------------------------
--LAWLIST
----------------------------------------------------------------
RegisterNetEvent('coal_law:ReceiveLawList', function(list)
    if not list or #list == 0 then
        TriggerEvent('chat:addMessage', {
            args = { 'LAW', 'No lawmen are currently on duty.' }
        })
        return
    end

    TriggerEvent('chat:addMessage', {
        args = { 'LAW', 'On-duty lawmen:' }
    })

    for _, entry in ipairs(list) do
        local line = ('[%d] %s (%s)'):format(entry.id, entry.name, entry.job or 'law')
        TriggerEvent('chat:addMessage', {
            args = { 'LAW', line }
        })
    end
end)
----------------------------------------------------------------
-- OPTIONAL: CLEAN UP STALE BLIPS (player far away / dropped)
----------------------------------------------------------------
CreateThread(function()
    while true do
        if IS_ON_DUTY_LAW then
            for suspectSrc, data in pairs(TRACKED_SUSPECTS) do
                local suspectClientId = GetPlayerFromServerId(suspectSrc)
                if suspectClientId == -1 then
                    -- suspect not in range / left – remove blip
                    if data.blip then
                        RemoveBlip(data.blip)
                    end
                    TRACKED_SUSPECTS[suspectSrc] = nil
                end
            end
        end
        Wait(5000)
    end
end)
