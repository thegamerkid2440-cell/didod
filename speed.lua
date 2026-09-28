local Speed = {}

Speed.Enabled = false
Speed.Value = 16

function Speed.SetEnabled(enabled, player)
	Speed.Enabled = enabled

	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.WalkSpeed = enabled and Speed.Value or 16
	end
end

function Speed.SetValue(value, player)
	Speed.Value = math.clamp(value, 16, 120)

	if Speed.Enabled then
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.WalkSpeed = Speed.Value
		end
	end
end

function Speed.Start(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")

		if Speed.Enabled then
			humanoid.WalkSpeed = Speed.Value
		else
			humanoid.WalkSpeed = 16
		end
	end)
end

return Speed