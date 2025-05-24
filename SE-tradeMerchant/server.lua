local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-trademerchant:server:TradeItem', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Config.TradeItems[itemName] then return end

    local item = Player.Functions.GetItemByName(itemName)
    if not item or item.amount < 1 then
        TriggerClientEvent('QBCore:Notify', src, "You don't have the required item", "error")
        return
    end

    Player.Functions.RemoveItem(itemName, 1)

    for _, reward in pairs(Config.TradeItems[itemName].rewards) do
        Player.Functions.AddItem(reward.material, reward.amount)
    end

    TriggerClientEvent('QBCore:Notify', src, "Item exchanged successfully!", "success")
end)
