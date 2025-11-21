local r, g, b = 255, 102, 0   -- orange

local armLength = 0.0018
local thickness = 0.0009
local offsetX   = 0.0025
local rowGap    = 0.0030

local INPUT_AIM = 0xF84FA74F  -- right mouse / LT

local function isFirearm(weapon)
    return weapon ~= `WEAPON_FISHINGROD`
       and weapon ~= `WEAPON_LASSO`
       and weapon ~= `WEAPON_KIT_BINOCULARS`
       and weapon ~= `WEAPON_KIT_CAMERA`
end

CreateThread(function()
    print("[coal_aim] compact 3-row crosshair loaded")

    while true do
        Wait(0)

        local ped = PlayerPedId()
        local hasWeapon, weapon = GetCurrentPedWeapon(ped, true)

        -- Only when actually aiming down sights with a firearm
        if IsAimCamActive()
            and hasWeapon
            and IsPedArmed(ped, 4)
            and isFirearm(weapon)
        then
            local cx, cy = 0.5, 0.5

            local leftX  = cx - offsetX
            local rightX = cx + offsetX

            local midY   = cy
            local topY   = cy - rowGap
            local botY   = cy + rowGap

            -- MIDDLE row
            DrawRect(leftX,  midY, armLength, thickness, r, g, b, 255)
            DrawRect(rightX, midY, armLength, thickness, r, g, b, 255)

            -- TOP row
            DrawRect(leftX,  topY, armLength, thickness, r, g, b, 255)
            DrawRect(rightX, topY, armLength, thickness, r, g, b, 255)

            -- BOTTOM row
            DrawRect(leftX,  botY, armLength, thickness, r, g, b, 255)
            DrawRect(rightX, botY, armLength, thickness, r, g, b, 255)
        end
    end
end)
