-- server.lua (e.g. coal_traps/server.lua)

local VORPInv = exports.vorp_inventory:vorp_inventoryApi()

CreateThread(function()
    -- Register "beartrap" as a usable item
    VORPInv.RegisterUsableItem("beartrap", function(data)
        local src = data.source

        -- Optional: consume 1 trap when used
        VORPInv.subItem(src, "beartrap", 1)   -- requires vorp_inventory API 

        -- Tell the client to place the trap
        TriggerClientEvent("coal_traps:placeBearTrap", src)
    end)
end)
