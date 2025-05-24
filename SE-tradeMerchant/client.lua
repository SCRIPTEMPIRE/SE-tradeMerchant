local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    RequestModel(Config.PedModel)
    while not HasModelLoaded(Config.PedModel) do Wait(0) end

    local ped = CreatePed(4, Config.PedModel, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z - 1.0, 90.0, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    RequestAnimDict("amb@world_human_smoking@male@male_a@idle_a")
    while not HasAnimDictLoaded("amb@world_human_smoking@male@male_a@idle_a") do Wait(0) end
    TaskPlayAnim(ped, "amb@world_human_smoking@male@male_a@idle_a", "idle_c", 8.0, -8.0, -1, 1, 0, false, false, false)

    local backOffset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -3.0, 0.0)
    RequestModel(Config.VehicleModel)
    while not HasModelLoaded(Config.VehicleModel) do Wait(0) end

    local vehicle = CreateVehicle(Config.VehicleModel, backOffset.x, backOffset.y, backOffset.z, 90.0, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "TRADE")
    SetVehicleDoorsLocked(vehicle, 2)
end)

RegisterNetEvent('openTrade', function()
    TriggerEvent('qb-menu:client:openMenu', {
        { header = "Trade Machine", isMenuHeader = true },
        { header = "💻 Trade Hacking Device", txt = "Get materials", params = { event = "qb-trademerchant:client:TradeItem", args = { item = "hacking_device" } } },
        { header = "🖼️ Trade Stolen Art", txt = "Get materials", params = { event = "qb-trademerchant:client:TradeItem", args = { item = "stolenart" } } },
        { header = "🔭 Trade Stolen PC", txt = "Get materials", params = { event = "qb-trademerchant:client:TradeItem", args = { item = "stolenpc" } } },
        { header = "📺 Trade Stolen TV", txt = "Get materials", params = { event = "qb-trademerchant:client:TradeItem", args = { item = "stolentv" } } },
        { header = "📡 Trade Stolen Microwave", txt = "Get materials", params = { event = "qb-trademerchant:client:TradeItem", args = { item = "stolenmicro" } } },
        { header = "❌ Close", params = {} }
    })
end)

RegisterNetEvent('qb-trademerchant:client:TradeItem', function(data)
    TriggerServerEvent('qb-trademerchant:server:TradeItem', data.item)
end)

