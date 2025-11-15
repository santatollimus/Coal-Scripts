-- mic_client.lua
local Core = exports.vorp_core:GetCore()
local micMuted = false

local function updateMicState(state)
    micMuted = state
    TriggerServerEvent('coal_voice:SetMuted', micMuted)

    local msg = micMuted and 'Microphone: ~o~OFF~q~' or 'Microphone: ~t~ON~q~'
    Core.NotifyRightTip(msg, 2500)
end

RegisterCommand('mic', function()
    updateMicState(not micMuted)
end, false)

-- Optional: keybind (players can change it in Keybinds -> FiveM/RedM)
RegisterKeyMapping('mic', 'Toggle Microphone', 'keyboard', 'F10')
