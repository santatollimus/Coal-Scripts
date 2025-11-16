-- custom_crosshair.lua (aim-only, big 3-row debug)

local r, g, b = 255, 102, 0   -- orange

local armLength = 0.0018      -- bar length (nice and modest)
local thickness = 0.0009      -- bar height (thinner)
local offsetX   = 0.0025      -- left/right distance from center
local rowGap    = 0.0030      -- MUCH closer rows (was 0.0060)


local INPUT_AIM = 0xF84FA74F  -- right mouse / LT

CreateThread(function()
    print("[coal_aim] compact 3-row crosshair loaded")

    while true do
        Wait(0)

        -- Only draw when aiming
        if IsAimCamActive() or IsControlPressed(0, INPUT_AIM) then
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
