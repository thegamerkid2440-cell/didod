local InfiniteJump = {}

InfiniteJump.Enabled = false

function InfiniteJump.Start(player, UserInputService)
	UserInputService.JumpRequest:Connect(function()
		if not InfiniteJump.Enabled then
			return
		end

		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

function InfiniteJump.SetEnabled(enabled)
	InfiniteJump.Enabled = enabled
end

return InfiniteJump