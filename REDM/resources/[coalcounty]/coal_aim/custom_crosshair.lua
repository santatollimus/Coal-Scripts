-- custom_crosshair.lua
-- style orange (#FF6600)
-- custom_crosshair.lua – slightly larger crosshair
local r, g, b = 255, 102, 0   -- orange

local armSize   = 0.0022      -- bar length
local thickness = 0.0006      -- bar height
local offsetX   = 0.0019      -- how far left/right from center
local rowGap    = 0.0020      -- vertical distance between rows



local function isAiming()
    return IsAimCamActive() or IsControlPressed(0, 0xF84FA74F)
end

-- Only treat it as "drawn" if the ped actually has a firearm out
local function hasWeaponDrawn()
    if not PlayerPedId then return false end

    local ped = PlayerPedId()
    if ped == 0 then return false end

    -- Preferred: use IsPedArmed (works on RedM)
    if IsPedArmed then
        -- 4 = firearms only (no fists/animals etc.)
        local armed = IsPedArmed(ped, 4)
        if armed == 1 or armed == true then
            return true
        else
            return false
        end
    end

    -- Fallback: current weapon check if available
    if GetCurrentPedWeapon then
        local gotWeapon, weaponHash = GetCurrentPedWeapon(ped, true)
        if not gotWeapon then return false end

        -- treat UNARMED / 0 as "no weapon"
        if weaponHash == `WEAPON_UNARMED` or weaponHash == 0 then
            return false
        end

        return true
    end

    -- If we really can't tell, err on the side of NO crosshair
    return false
end

local function shouldShowCrosshair()
    return isAiming() and hasWeaponDrawn()
end

CreateThread(function()
    while true do
        if shouldShowCrosshair() then
            -- Hide Rockstar's default reticle if this native exists
            if HideHudComponentThisFrame then
                HideHudComponentThisFrame(14)
            end

-- center of screen
local cx, cy = 0.5, 0.5

-- pre-calc x and y positions
local leftX  = cx - offsetX
local rightX = cx + offsetX

local midY   = cy
local topY   = cy - rowGap
local botY   = cy + rowGap

-- MIDDLE row
DrawRect(leftX,  midY, armSize, thickness, r, g, b, 255)
DrawRect(rightX, midY, armSize, thickness, r, g, b, 255)

-- TOP row
DrawRect(leftX,  topY, armSize, thickness, r, g, b, 255)
DrawRect(rightX, topY, armSize, thickness, r, g, b, 255)

-- BOTTOM row
DrawRect(leftX,  botY, armSize, thickness, r, g, b, 255)
DrawRect(rightX, botY, armSize, thickness, r, g, b, 255)


  end

        Wait(0)
    end
end)
