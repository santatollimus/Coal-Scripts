-- custom_crosshair.lua
-- Compact 3-row orange crosshair shown while aiming

local r, g, b = 255, 102, 0   -- orange

-- tweak these to taste
local armLength = 0.0022      -- bar length
local thickness = 0.0006      -- bar height
local offsetX   = 0.0020      -- left/right distance from center
local rowGap    = 0.0020      -- vertical distance between rows

local INPUT_AIM = 0xF84FA74F  -- right mouse / LT

CreateThread(function()
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
