-- coal_aim.lua
-- Make right-click immediately draw + aim your weapon instead of "focus then LMB"

local INPUT_AIM    = 0xF84FA74F -- Right mouse / LT
local INPUT_ATTACK = 0x07CE1E61 -- Left mouse / RT

local function hasFirearmDrawn(ped)
    if not IsPedArmed then return false end
    -- 4 = firearms only
    local armed = IsPedArmed(ped, 4)
    return armed == 1 or armed == true
end

local function drawBestWeapon(ped)
    if not GetBestPedWeapon or not SetCurrentPedWeapon then return end

    -- If current weapon is already a firearm, leave it alone
    if GetCurrentPedWeapon then
        local hasWep, curWep = GetCurrentPedWeapon(ped, true)
        if hasWep and curWep ~= `WEAPON_UNARMED` and curWep ~= 0 then
            return
        end
    end

    local best = GetBestPedWeapon(ped, false, false)
    if best ~= 0 and best ~= `WEAPON_UNARMED` then
        SetCurrentPedWeapon(ped, best, true, 0, false, false)
    end
end

-- how many frames we still want to "fake" LMB for
local fakeAttackFrames = 0

CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()
        if ped == 0 or IsEntityDead(ped) then
            fakeAttackFrames = 0
            goto continue
        end

        -- When you first press aim (right-click / LT)
        if IsControlJustPressed(0, INPUT_AIM) then
            -- Make sure we have a firearm in hand
            if not hasFirearmDrawn(ped) then
                drawBestWeapon(ped)
            end

            -- For the next few frames, we'll:
            --  - disable firing
            --  - "hold" attack input
            -- This tricks the game into thinking you tapped LMB once,
            -- so it goes straight into full aiming with no hint.
            fakeAttackFrames = 3
        end

        -- If you let go of aim, stop faking attack
        if IsControlJustReleased(0, INPUT_AIM) then
            fakeAttackFrames = 0
        end

        if fakeAttackFrames > 0 then
            -- Don’t actually fire
            DisablePlayerFiring(PlayerId(), true)
            -- Simulate LMB/RT being held for this frame
            SetControlNormal(0, INPUT_ATTACK, 1.0)
            fakeAttackFrames = fakeAttackFrames - 1
        end

        ::continue::
    end
end)
