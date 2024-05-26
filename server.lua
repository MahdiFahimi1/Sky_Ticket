RegisterServerEvent('sendHelpToDiscord')
AddEventHandler('sendHelpToDiscord', function(args, coordsJson)
    local playerId = source
    local playerName = GetPlayerName(playerId)

    if playerName then
        local embedFields = {
            {['name'] = '**Player Name**', ['value'] = playerName},
            {['name'] = '**Reason**', ['value'] = table.concat(args, ' ')}
        }

        local coordsTable = json.decode(coordsJson)
        local coordsDecimal = tonumber(coordsDecimal) or 2

        if showCoords and coordsTable then
            local x = string.format("%." .. coordsDecimal .. "f", coordsTable.x)
            local y = string.format("%." .. coordsDecimal .. "f", coordsTable.y)
            local z = string.format("%." .. coordsDecimal .. "f", coordsTable.z)
            local coordinates = "🆇: " .. x .. "\n 🆈: " .. y .. "\n 🆉: " .. z
            table.insert(embedFields, {['name'] = '🌐 Location 🌐 | 🌐 /tp location 🌐', ['value'] = coordinates})
        end

        local mention = mentionRole and ("<@&".. roleId .. ">") or ""

        local embedMessage = {
            {
                ["color"] = embedColor,
                ["type"] = "rich",
                ["title"] = embedTitle,
                ["fields"] = embedFields,
                ["footer"] = {
                    ["text"] = 'Create By mahdifahimi - Sky Team',
                    ["icon_url"] = embedUrl
                },
            }
        }

        webhookUsername = webhookUsername ~= "" and webhookUsername or "Sky Ticket"
        webhookAvatar = webhookAvatar ~= "" and webhookAvatar or "https://cdn.discordapp.com/attachments/844917200443932682/1098646314792783893/skycheat.png?ex=6543ce1d&is=6531591d&hm=9388a284f84f5c1f7d428833a2eaa681746864b972ef13606418b7646fc090d9&"
        
        local request = {
            ['url'] = webhookURL,
            ['method'] = 'POST',
            ['headers'] = {
                ['Content-Type'] = 'application/json'
            },
            ['data'] = json.encode({
                ['content'] = mention,
                ['embeds'] = embedMessage,
                ['username'] = webhookUsername,
                ['avatar_url'] = webhookAvatar,
            })
        }

        PerformHttpRequest(request.url, function(error, text, headers)
            if error == "" then
                TriggerClientEvent('displayMessage', playerId, displayText1)
            else
                TriggerClientEvent('displayMessage', playerId, displayText2)
            end
        end, request.method, request.data, request.headers)
    else
        TriggerClientEvent('displayMessage', playerId, displayText3)
    end
end)