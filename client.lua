TriggerEvent('chat:addSuggestion', '/'..commandc, 'Send On Discord', {
    { name='Reason', help='Reason' }
})

RegisterNetEvent('displayMessage')
AddEventHandler('displayMessage', function(message)

    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"SYSTEM", message}
    })

end)

RegisterCommand(commandc, function(source, args)

    if #args == 0 then
        TriggerEvent('displayMessage', 'Reason is required')
    else
        local coords = GetEntityCoords(PlayerPedId())
        if coords then
            local coordsTable = {x = coords.x, y = coords.y, z = coords.z}
            local coordsJson = json.encode(coordsTable)
            TriggerServerEvent('sendHelpToDiscord', args, coordsJson)
        else
            TriggerServerEvent('sendHelpToDiscord', args, {})
        end
    end

end)