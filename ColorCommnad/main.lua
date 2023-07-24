local QBCore = exports['qb-core']:GetCoreObject()

local colors = {
    red = {255, 0, 0},
    blue = {0, 0, 255},
    green = {0, 255, 0},
    orange = {255, 165, 0},
    purple = {128, 0, 128},
    yellow = {255, 255, 0},
    pink = {255, 192, 203},
    cyan = {0, 255, 255},
    white = {255, 255, 255},
    black = {0, 0, 0},
    silver = {192, 192, 192},
    gold = {255, 215, 0},
    brown = {139, 69, 19},
    -- Add more colors here as needed
}
-- Custom function to get table keys
function getTableKeys(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

RegisterCommand("changeColor", function(source, args)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local color = args[1] and args[1]:lower()
        if color and colors[color] then
            local r, g, b = table.unpack(colors[color])
            if r and g and b then
                SetVehicleCustomPrimaryColour(veh, r, g, b)
                QBCore.Functions.Notify("Changing car color to " .. color .. "...", "success", 3000)
            else
                QBCore.Functions.Notify("Error: Unable to change car color.", "error", 3000)
            end
        else
            local colorNames = table.concat(getTableKeys(colors), ", ")
            if color then
                QBCore.Functions.Notify("Error: Unsupported color! Available colors: " .. colorNames, "error", 3000)
            else
                QBCore.Functions.Notify("Error: Please specify a color! Available colors: " .. colorNames, "error", 3000)
            end
        end
    else
        QBCore.Functions.Notify("Error: You must be inside a vehicle to change its color!", "error", 3000)
    end
end, false)
