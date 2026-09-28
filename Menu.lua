local Menu = {}

function Menu.Create(Fluent, Player)

	local Window = Fluent:CreateWindow({
		Title = "Game Utility",
		SubTitle = "thegamerkid24300",
		TabWidth = 150,
		Size = UDim2.fromOffset(560, 430),
		Acrylic = true,
		Theme = "Dark",
		MinimizeKey = Enum.KeyCode.LeftControl
	})

	local Tabs = {
		Main = Window:AddTab({
			Title = "Main",
			Icon = "home"
		}),

		ESP = Window:AddTab({
			Title = "ESP",
			Icon = "eye"
		}),

		Settings = Window:AddTab({
			Title = "Settings",
			Icon = "settings"
		})
	}

	-- Floating restore button
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "UtilityRestore"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = Player:WaitForChild("PlayerGui")

	local RestoreButton = Instance.new("TextButton")

	RestoreButton.Size = UDim2.fromOffset(44, 44)
	RestoreButton.Position = UDim2.new(1, -60, 0, 25)

	RestoreButton.BackgroundColor3 =
		Color3.fromRGB(35, 35, 35)

	RestoreButton.TextColor3 =
		Color3.fromRGB(255, 255, 255)

	RestoreButton.Text = "☰"
	RestoreButton.TextSize = 20
	RestoreButton.Font = Enum.Font.GothamBold

	RestoreButton.Active = true
	RestoreButton.Draggable = true
	RestoreButton.Visible = false
	RestoreButton.Parent = ScreenGui

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 10)
	Corner.Parent = RestoreButton

	local function SetVisible(visible)

		if Window.Root then
			Window.Root.Visible = visible
		end

		RestoreButton.Visible = not visible
	end

	RestoreButton.MouseButton1Click:Connect(function()
		SetVisible(true)
	end)

	-- Top-right minimize button
	local MinimizeButton = Instance.new("TextButton")

	MinimizeButton.Size = UDim2.fromOffset(32, 32)
	MinimizeButton.Position = UDim2.new(1, -42, 0, 8)

	MinimizeButton.BackgroundTransparency = 1
	MinimizeButton.Text = "☰"
	MinimizeButton.TextColor3 =
		Color3.fromRGB(255, 255, 255)

	MinimizeButton.TextSize = 19
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.ZIndex = 100
	MinimizeButton.Parent = ScreenGui

	MinimizeButton.MouseButton1Click:Connect(function()
		SetVisible(false)
	end)

	return Window, Tabs
end

return Menu