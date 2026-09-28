--========================================================
-- MAIN.LUA
-- Roblox Studio project
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--========================================================
-- FLUENT
--========================================================

local Fluent = loadstring(game:HttpGet(
	"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
))()

--========================================================
-- MODULES
--========================================================

local Speed = require(script:WaitForChild("Speed"))
local InfiniteJump = require(script:WaitForChild("InfiniteJump"))
local ESP = require(script:WaitForChild("ESP"))
local Menu = require(script:WaitForChild("Menu"))

--========================================================
-- START MODULES
--========================================================

Speed.Start(Player)

InfiniteJump.Start(
	Player,
	UserInputService
)

ESP.Start(
	Players,
	Player,
	RunService
)

--========================================================
-- CREATE MENU
--========================================================

local Window, Tabs =
	Menu.Create(
		Fluent,
		Player
	)

local Options = Fluent.Options

--========================================================
-- MAIN TAB
--========================================================

Tabs.Main:AddParagraph({
	Title = "Game Utility",
	Content = "Movement and utility controls."
})

--========================================================
-- SPEED
--========================================================

Tabs.Main:AddToggle("Speed", {
	Title = "Speed",
	Description = "Enable custom speed",
	Default = false
}):OnChanged(function()
	Speed.SetEnabled(
		Options.Speed.Value,
		Player
	)
end)

Tabs.Main:AddSlider("SpeedValue", {
	Title = "Speed Amount",
	Description = "Choose 16–120",
	Default = 16,
	Min = 16,
	Max = 120,
	Rounding = 0
}):OnChanged(function(value)
	Speed.SetValue(
		value,
		Player
	)
end)

--========================================================
-- INFINITE JUMP
--========================================================

Tabs.Main:AddToggle("InfiniteJump", {
	Title = "Infinite Jump",
	Description = "Jump while airborne",
	Default = false
}):OnChanged(function()
	InfiniteJump.SetEnabled(
		Options.InfiniteJump.Value
	)
end)

--========================================================
-- ESP TAB
--========================================================

Tabs.ESP:AddParagraph({
	Title = "Team ESP",
	Content = "Green = your team | Red = other team"
})

Tabs.ESP:AddToggle("TeamESP", {
	Title = "Team ESP",
	Description = "Automatically scan players",
	Default = false
}):OnChanged(function()

	ESP.SetEnabled(
		Options.TeamESP.Value
	)

end)

--========================================================
-- LOAD
--========================================================

Window:SelectTab(1)

Fluent:Notify({
	Title = "Game Utility",
	Content = "Loaded successfully!",
	Duration = 5
})