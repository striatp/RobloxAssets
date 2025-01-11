-- Script Name: ShiftToSprint
-- Author: Striatp
-- License: https://github.com/striatp/RobloxAssets/blob/main/LICENSE.md

-- ShiftToSprint Script with Customizable Speed and FOV Boost for Roblox
-- This script changes the player's walk speed and FOV when a specified key is pressed, 
-- with a smooth transition for the FOV using TweenService. Users can customize settings through the config table.

-- Services
local Player = game.Players.LocalPlayer -- The local player
local Character = Player.Character or Player.CharacterAdded:Wait() -- The player's character
local Humanoid = Character:WaitForChild("Humanoid") -- The humanoid of the player (controls speed)
local Camera = game.Workspace.CurrentCamera -- The player's camera (controls FOV)
local UserInputService = game:GetService("UserInputService") -- Detects user input
local TweenService = game:GetService("TweenService") -- For smooth transitions

-- Configuration Table
local config = {
	DefaultSpeed = 16, -- The default walking speed
	BoostedSpeed = 20, -- The walking speed when the key is pressed
	DefaultFOV = 70, -- The default Field of View (FOV)
	BoostedFOV = 80, -- The Field of View when the key is pressed
	TransitionDuration = 0.2, -- Duration of the FOV transition in seconds
	TriggerKey = Enum.KeyCode.LeftShift, -- The key to trigger the speed and FOV boost
	EnableSound = false, -- Set to true to play a sound when boosting
	BoostSoundId = "rbxassetid://8208591201", -- Sound ID for the boost sound
	ResetSoundId = "rbxassetid://8208593535" -- Sound ID for the reset sound
}

-- Tween Info for smooth FOV transition
local tweenInfo = TweenInfo.new(
	config.TransitionDuration, -- Time duration for the transition
	Enum.EasingStyle.Linear, -- Easing style for smooth transition
	Enum.EasingDirection.Out -- Direction of the easing
)

-- Function to play a sound effect
local function playSound(soundId)
	if not config.EnableSound then return end
	local sound = Instance.new("Sound")
	sound.SoundId = soundId
	sound.Volume = 1
	sound.Parent = Camera
	sound:Play()
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

-- Function to handle key press for speed and FOV boost
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	-- Check if the input matches the configured key and is not processed by the game (e.g., for GUI or chat)
	if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == config.TriggerKey and not gameProcessedEvent then
		-- Set the player's walk speed to the boosted speed
		Humanoid.WalkSpeed = config.BoostedSpeed

		-- Create a tween to smoothly change the FOV to the boosted value
		local fovTween = TweenService:Create(Camera, tweenInfo, {FieldOfView = config.BoostedFOV})
		fovTween:Play()

		-- Play the boost sound
		playSound(config.BoostSoundId)
	end
end)

-- Function to reset speed and FOV with smooth transition when the key is released
UserInputService.InputEnded:Connect(function(input)
	-- Check if the input matches the configured key
	if input.KeyCode == config.TriggerKey then
		-- Reset the walk speed back to the default
		Humanoid.WalkSpeed = config.DefaultSpeed

		-- Create a tween to smoothly reset the FOV back to the default value
		local fovTween = TweenService:Create(Camera, tweenInfo, {FieldOfView = config.DefaultFOV})
		fovTween:Play()

		-- Play the reset sound
		playSound(config.ResetSoundId)
	end
end)

-- Instructions:
-- 1. Customize the "config" table to set your desired default and boosted speeds, FOV values, trigger key, and sound options.
-- 2. Place this script in "StarterPlayerScripts" to activate the functionality for players.
-- 3. Ensure the specified key in "config.TriggerKey" does not conflict with other game controls.
-- 4. If sounds are enabled, replace the placeholder Sound IDs in "BoostSoundId" and "ResetSoundId" with your own asset IDs.
