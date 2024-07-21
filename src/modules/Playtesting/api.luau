local api = {}
local config = require(script.Parent.config)
local HttpService = game:GetService("HttpService")

function api:GetAPIRoute(route)
    if typeof(route) ~= "string" then return false, "Invalid parsing of route" end
    if string.sub(route, 1, 1) ~= "/" then return false, "Route must start with a slash" end

    local success, data = pcall(function()
        return HttpService:GetAsync(config.BASE_API_URL .. route)
    end)

    if not success then return false, data end

    return true, data
end

function api:PostAPIRoute(route, data)
    if typeof(route) ~= "string" or typeof(data) ~= "table" then return false, "Invalid parsing of route" end
    if string.sub(route, 1, 1) ~= "/" then return false, "Route must start with a slash" end

    local success, data = pcall(function()
        return HttpService:PostAsync(config.BASE_API_URL .. route, HttpService:JSONEncode(data))
    end)

    if not success then return false, data end

    return true, data
end

return api