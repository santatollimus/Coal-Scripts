-- client.lua (same resource: coal_traps/client.lua)

RegisterNetEvent("coal_traps:placeBearTrap")
AddEventHandler("coal_traps:placeBearTrap", function()
    local ped    = PlayerPedId()
    local coords = GetEntityCoords(ped)

    -- TODO: replace this with your real trap prop hash
    local trapModel = GetHashKey("p_beartrap01x")   -- example model name

    if not IsModelValid(trapModel) then
        print("[coal_traps] Invalid bear trap model")
        return
    end

    RequestModel(trapModel)
    while not HasModelLoaded(trapModel) do
        Wait(0)
    end

    local trap = CreateObject(trapModel, coords.x, coords.y, coords.z - 1.0, true, true, true)
    SetEntityHeading(trap, GetEntityHeading(ped))
    SetEntityAsMissionEntity(trap, true, false)

    -- You can add more logic here: snapping to ground, triggering damage,
    -- storing trap in a table for later cleanup, etc.
end)
