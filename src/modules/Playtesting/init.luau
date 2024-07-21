local HttpService = game:GetService("HttpService")
local playtesting = {}
local api = require(script.api)

function playtesting:RequestUserToBeginSession(RUID: number | string)
	if typeof(RUID) ~= "number" and typeof(RUID) ~= "string" then return false, "Invalid parsing of RUID" end
    local success, data = api:PostAPIRoute("/start", { ruid = RUID })
    if not success then return false, "There was an error trying to send `/start`: " .. data end
    return true, "Success"
end

function playtesting:EndUserSession(RUID: number | string)
    if typeof(RUID) ~= "number" and typeof(RUID) ~= "string" then return false, "Invalid parsing of RUID" end
    local success, data = api:PostAPIRoute("/end", { ruid = RUID })
    if not success then return false, "There was an error trying to send `/end`: " .. data end
    return true, "Success"
end

function playtesting:GetTime(RUID: number | string)
    if typeof(RUID) ~= "number" and typeof(RUID) ~= "string" then return false, "Invalid parsing of RUID" end
    local success, data = api:PostAPIRoute("/getUIDFromRUID", { ruid = RUID })
    if not success then return false, "There was an error trying to send getUIDFromRUID: " .. data end
    local success2, data2 = api:PostAPIRoute("/time", { uid = HttpService:JSONDecode(data).uid })
    if not success2 then return false, "There was an error trying to send /time: " .. data end

    return HttpService:JSONDecode(data2).data -- { hours, minutes, seconds }
end

function playtesting:GetLB()
    local success, data = api:GetAPIRoute("/lb")
    if not success then return false, "There was an error trying to get /lb: " .. data end

    return HttpService:JSONDecode(data).data -- { { uid, time, placement } }
end

function playtesting:Ping()
    local success, _ = api:GetAPIRoute("/")
    return success
end

return playtesting