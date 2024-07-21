--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> endsession
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Playtesting = require(game.ReplicatedStorage.Modules.Playtesting)

return {
	Keyword = "endsession",
	Category = "BasicCommands",
	Description = "End the current session",
	ServerRun = function(CommandContext)
		local Util = IncludedCommandUtil.ForContext(CommandContext)
		local success, err = Playtesting:EndUserSession(CommandContext.Executor.UserId)
		if not success then Util:SendMessage("An error occured when trying to send your session: " .. err) return end
	end
}