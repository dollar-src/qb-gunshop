local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('gunshop:serverbuyitem', function(data)
    local a = source
    local b = QBCore.Functions.GetPlayer(a)
    local c = b.PlayerData.money["bank"]
    if c >= data.price  then
        TriggerClientEvent('inventory:client:ItemBox', a, QBCore.Shared.Items[data.item], "add", data.count)
        b.Functions.RemoveMoney("bank", data.price, "Gunshop")
        b.Functions.AddItem(data.item, data.count)
        discordLog(b.PlayerData.charinfo.firstname .." ".. b.PlayerData.charinfo.lastname ..", Bought".." ".. "Price: " ..  " ".."$"..data.price..', ' .. "Amount:  ".. " "..data.count..", ".. "İtemName: " .. " "..data.label)
        
    else
        TriggerClientEvent('QBCore:Notify', a, "Not enough money(Bank)", "error")
    end

end)




function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(Config.discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = Config.discord['name'], embeds = data, avatar_url = Config.discord['image']}), { ['Content-Type'] = 'application/json' })
end

