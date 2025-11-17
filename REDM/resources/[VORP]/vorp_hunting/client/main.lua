-- Mercy + Skin
-- Make sure this is only defined once in the file.
local INTERACTION_ANIMAL_SKIN = joaat("INTERACTION_ANIMAL_SKIN")

-- Find the closest injured animal near the player within a radius (in meters)
local function GetClosestInjuredAnimal(ped, radius)
    local px, py, pz = table.unpack(GetEntityCoords(ped))
    local bestPed = 0
    local bestDistSq = radius * radius

    for _, candidate in ipairs(GetGamePool("CPed")) do
        if candidate ~= ped and DoesEntityExist(candidate) then
            -- Only animals
            if not IsPedHuman(candidate) then
                -- "Downed" but not fully dead (so mercy makes sense)
                local dead = IsEntityDead(candidate)
                local injured = IsPedInjured(candidate) or IsPedRagdoll(candidate)

                if not dead and injured then
                    local cx, cy, cz = table.unpack(GetEntityCoords(candidate))
                    local dx, dy, dz = cx - px, cy - py, cz - pz
                    local distSq = dx * dx + dy * dy + dz * dz

                    if distSq <= bestDistSq then
                        bestDistSq = distSq
                        bestPed = candidate
                    end
                end
            end
        end
    end

    return bestPed
end

-- Mercy + Skin prompt
CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession

    -- Register a new prompt that uses your existing prompts group
    local mercyPrompt = PromptRegisterBegin()
    -- use your configured key or fall back to a default
    local control = Config.keys and Config.keys["G"] or `INPUT_INTERACT_LOCKON`
    PromptSetControlAction(mercyPrompt, control)

    local str = CreateVarString(10, "LITERAL_STRING", "Mercy + Skin")
    PromptSetText(mercyPrompt, str)
    PromptSetEnabled(mercyPrompt, true)
    PromptSetVisible(mercyPrompt, true)
    PromptSetStandardMode(mercyPrompt, true)
    PromptSetHoldMode(mercyPrompt, true)
    PromptSetGroup(mercyPrompt, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, mercyPrompt, true) -- enable prompt
    PromptRegisterEnd(mercyPrompt)

    while true do
        Wait(0)

        local ped = PlayerPedId()
        if not DoesEntityExist(ped) or IsEntityDead(ped) then
            goto continue_loop
        end

        -- Look for a wounded animal close to the player
        local target = GetClosestInjuredAnimal(ped, 2.0)

        if target ~= 0 then
            -- Show the prompt group text
            local label = CreateVarString(10, "LITERAL_STRING", "Mercy + Skin")
            PromptSetActiveGroupThisFrame(prompts, label)

            -- If the player completes the hold on the prompt
            if Citizen.InvokeNative(0xC92AC953F0A982AE, mercyPrompt) then
                -- 1) Kill the animal (instant mercy)
                ApplyDamageToPed(target, 1000.0, true, 0, false, true, false, false)

                -- 2) After a short delay, start skinning the same animal
                CreateThread(function()
                    Wait(1500)
                    if DoesEntityExist(target) then
                        Citizen.InvokeNative(
                            0xCD181A959CFDD7F4,   -- TASK_ANIMAL_INTERACTION
                            ped,
                            target,
                            INTERACTION_ANIMAL_SKIN,
                            0,
                            0
                        )
                    end
                end)
            end
        end

        ::continue_loop::
    end
end)
