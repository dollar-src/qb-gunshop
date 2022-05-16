local QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}


RegisterNetEvent('gunshop:client:menu', function()
    local Menu = {
        {
            header = "Gun Shop",
            txt = "Items",
            params = {
                event = "gunshop:client:itemmenu",
            }
        }
    }
    Menu[#Menu+1] = {
        header = "⬅ Close Menu",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent("gunshop:client:itemmenu", function()
    local g = {
        {
            header = "Gun Shop",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Itemlist) do
        g[#g+1] = {
            header = v.label,
            txt = "Item: " .. v.label .. " Price: " .. v.price .. "$".. " ".." " .." Amount:" .." " ..v.count,
            params = {
                isServer = true,
                event = "gunshop:serverbuyitem",
                args = {
                    price = v.price,
                    item = v.item,
                    count = v.count,
                    label = v.label
                }
            }
        }
    end
    g[#g+1] = {
        header = "⬅ Go Back",
    }
    exports['qb-menu']:openMenu(g)
end)


Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("gunshop",vector3(Config.Coords.x,Config.Coords.y,Config.Coords.z), 3, 3, {
        name = "gunshop",
        heading = Config.Coords.w,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "gunshop:client:menu",
                icon = "fas fa-gun",
                label = 'Gun Shop',
                job = Config.AuthJob

            },
        },
        distance = 10
    })
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


AddEventHandler("onResourceStart", function(JobInfo)
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

