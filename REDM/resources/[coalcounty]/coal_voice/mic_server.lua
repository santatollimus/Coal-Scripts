-- mic_server.lua

RegisterNetEvent('coal_voice:SetMuted', function(state)
    local src = source
    -- Mute/unmute this player in Mumble voice
    MumbleSetPlayerMuted(src, state)
end)
