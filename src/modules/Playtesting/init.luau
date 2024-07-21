local playtesting = {}
local api = require(script.api)

function playtesting:RequestUserToBeginSession(RUID: number | string)
	if typeof(RUID) ~= "number" or typeof(RUID) ~= "string" then return "Invalid parsing of RUID" end
    local success, data = api:PostAPIRoute("/start", { ruid = RUID })
    if not success then warn("There was an error trying to send `/start`: " .. data) return "Error" end
    return "Success"
end

return playtesting