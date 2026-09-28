local ESP = {}

ESP.Enabled = false
ESP.Objects = {}

local function Remove(player)
	local highlight = ESP.Objects[player]

	if highlight then
		highlight:Destroy()
		ESP.Objects[player] = nil
	end
end

function ESP.UpdatePlayer(player, localPlayer)

	if player == localPlayer then
		return
	end

	if not ESP.Enabled then
		Remove(player)
		return
	end

	local character = player.Character

	if not character then
		Remove(player)
		return
	end

	local highlight = ESP.Objects[player]

	if not highlight then
		highlight = Instance.new("Highlight")
		highlight.Name = "TeamESP"
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.Parent = character

		ESP.Objects[player] = highlight
	end

	highlight.Adornee = character

	if localPlayer.Team ~= nil
		and player.Team == localPlayer.Team then

		-- YOUR TEAM
		highlight.FillColor = Color3.fromRGB(0, 255, 0)
		highlight.OutlineColor = Color3.fromRGB(0, 180, 0)

	else

		-- OTHER TEAM
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
		highlight.OutlineColor = Color3.fromRGB(180, 0, 0)

	end
end

function ESP.UpdateAll(players, localPlayer)

	for _, player in ipairs(players:GetPlayers()) do
		ESP.UpdatePlayer(player, localPlayer)
	end

	for player, highlight in pairs(ESP.Objects) do
		if not player.Parent then
			highlight:Destroy()
			ESP.Objects[player] = nil
		end
	end
end

function ESP.Clear()
	for player, highlight in pairs(ESP.Objects) do
		highlight:Destroy()
		ESP.Objects[player] = nil
	end
end

function ESP.Start(players, localPlayer, runService)

	players.PlayerAdded:Connect(function(player)

		player.CharacterAdded:Connect(function()
			task.wait(0.5)

			if ESP.Enabled then
				ESP.UpdatePlayer(player, localPlayer)
			end
		end)

		player:GetPropertyChangedSignal("Team"):Connect(function()
			if ESP.Enabled then
				ESP.UpdatePlayer(player, localPlayer)
			end
		end)
	end)

	players.PlayerRemoving:Connect(function(player)
		Remove(player)
	end)

	runService.Heartbeat:Connect(function()
		if ESP.Enabled then
			ESP.UpdateAll(players, localPlayer)
		end
	end)
end

function ESP.SetEnabled(enabled)
	ESP.Enabled = enabled

	if not enabled then
		ESP.Clear()
	end
end

return ESP