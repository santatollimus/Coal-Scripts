-- coal_aim.lua - simple version
-- If you right-click while unarmed, just draw your best firearm.
-- No fake LMB, no trickery.

local INPUT_AIM = 0xF84FA74F -- Right mouse / LT

local function hasFirearmDrawn(ped)
    return IsPedArmed(ped, 4) == 1 or IsPedArmed(ped, 4) == true
end

local function drawBestWeapon(ped)
    local hasWep, curWep = GetCurrentPedWeapon(ped, true)
    if hasWep and curWep ~= `WEAPON_UNARMED` and curWep ~= 0 then
        return
    end

    local best = GetBestPedWeapon(ped, false, false)
    if best ~= 0 and best ~= `WEAPON_UNARMED` then
        SetCurrentPedWeapon(ped, best, true, 0, false, false)
    end
end

CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()
        if ped == 0 or IsEntityDead(ped) then
            goto continue
        end

        if IsControlJustPressed(0, INPUT_AIM) then
            if not hasFirearmDrawn(ped) then
                drawBestWeapon(ped)
            end
        end

        ::continue::
    end
end)
