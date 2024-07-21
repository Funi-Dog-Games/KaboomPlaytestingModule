--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> testingtime
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Playtesting = require(game.ReplicatedStorage.Modules.Playtesting)

return {
	Keyword = "testingtime",
	Category = "BasicCommands",
	Description = "Checks how much time you have on the current session",
	ServerRun = function(CommandContext)
		local Util = IncludedCommandUtil.ForContext(CommandContext)
		local success, data = Playtesting:GetTime(CommandContext.Executor.UserId)
		if not success then Util:SendMessage("An error occured when trying to send your session: " .. data) return end
        Util:SendMessage("You have " .. data.hours .. " hours, " .. data.minutes .. " minutes, and " .. data.seconds .. " seconds. (If you do not have a session active, this is the time of your last session)")
	end
}