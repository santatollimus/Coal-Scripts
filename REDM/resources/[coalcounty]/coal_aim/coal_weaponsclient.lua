CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()

        -- Only when holding a firearm
        if IsPedArmed(ped, 4) then -- 4 = any firearm
            -- 25 = INPUT_AIM (right mouse by default)
            if IsControlPressed(0, 25) then
                -- Make sure we’re actually aiming
                -- (normally the game already does this)
                SetPlayerLockon(PlayerId(), true)
            end
        end
    end
end)
