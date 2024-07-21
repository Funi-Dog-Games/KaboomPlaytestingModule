--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> timelb
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Playtesting = require(game.ReplicatedStorage.Modules.Playtesting)
return {
	Keyword = "timelb",
	Category = "BasicCommands",
	Description = "Get the leaderboard for time",
	ServerLoad = function(Api)
		local GetFlagsRemoteFunction = Instance.new("RemoteFunction")
		GetFlagsRemoteFunction.Name = "GetTimeLB"
		GetFlagsRemoteFunction.Parent = Api.EventContainer

		GetFlagsRemoteFunction.OnServerInvoke = function()
			local success, data = Playtesting:GetLB()
			if not success then return {} end
			return data
		end
	end,
	ClientRun = function(CommandContext)
		local Util = IncludedCommandUtil.ForContext(CommandContext)
		local ScrollingTextWindow = require(Util.ClientResources:WaitForChild("ScrollingTextWindow")) :: any
		local Api = Util:GetApi()

		local Window = ScrollingTextWindow.new()
		Window.Title = "Leaderboard"
		Window.GetTextLines = function()
			local lbStandings = Api.EventContainer:WaitForChild("GetTimeLB"):InvokeServer()
			local lb = {}
			table.sort(lbStandings, function(a,b) return a.placement < b.placement end)
			local medals = {
				"🏅",
				"🥈",
				"🥉"
			}
			for _,ld in pairs(lbStandings) do
				table.insert(lb, { Text = (if medals[ld.placement] then medals[ld.placement] .. " | " else "#" .. ld.placement .. " | ") .. math.floor(ld.time / (60 * 60)) .. ":" .. (if math.floor(ld.time / 60) % 60 < 10 then "0" .. math.floor((ld.time/60) % 60) else math.floor((ld.time/60) % 60)) .. ":" .. (if math.floor(ld.time % 60) < 10 then "0" .. math.floor(ld.time % 60) else math.floor(ld.time % 60))})
			end

			return lb
		end
		Window:Show()
	end,
}