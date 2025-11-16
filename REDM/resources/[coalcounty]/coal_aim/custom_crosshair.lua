-- custom_crosshair.lua
-- Simple orange crosshair shown while aiming

local r, g, b = 255, 102, 0   -- color

-- tweak these to taste
local armSize   = 0.0022      -- bar length
local thickness = 0.0006      -- bar height
local offsetX   = 0.0019      -- left/right distance from center
local rowGap    = 0.0020      -- vertical distance between rows

CreateThread(function()
    while true do
        Wait(0)

        -- Only draw when aiming
        if IsAimCamActive() or IsControlPressed(0, 0xF84FA74F) then
            local cx, cy = 0.5, 0.5

            -- precomputed positions
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
    end
end)
