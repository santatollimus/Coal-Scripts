-- anti_lockon.lua (aim-safe version)

-- Thread 1: constantly force Free Aim targeting mode (no assisted modes)
CreateThread(function()
    while true do
        if SetPlayerTargetingMode then
            -- 3 = Free Aim (no assisted lock-on)
            SetPlayerTargetingMode(3)
        end

        -- No need to spam every frame
        Wait(2000)
    end
end)

-- Thread 2: disable soft lock-on on the ped (but keep ADS working)
CreateThread(function()
    while true do
        local ped    = PlayerPedId and PlayerPedId() or 0

        if ped ~= 0 and SetPedConfigFlag then
            -- 43 = disable "soft" controller lock-on / aim assist
            -- This keeps you from sticky-locking to targets,
            -- but still lets RMB / LT aim down sights.
            SetPedConfigFlag(ped, 43, true)
        end

        -- IMPORTANT:
        -- We do NOT call SetPlayerLockon(player, false)
        -- or SetPlayerLockonRangeOverride(player, 0.0) here,
        -- because that combination is what was causing
        -- the "RMB only zooms, no proper ADS" bug.
        Wait(500)
    end
end)
