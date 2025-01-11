-- Script Name: Anti-Jump (Local)
-- Author: Striatp
-- License: https://github.com/striatp/RobloxAssets/blob/main/LICENSE.md

-- Customizable Anti-Jump Script for Roblox made by Striatp
-- This script disables the player's ability to jump by modifying the Humanoid's JumpHeight and JumpPower properties.
-- The script allows for easy customization to either disable or set specific values for JumpHeight and JumpPower.
-- It also prevents jumping when the Jumping event is triggered, ensuring the player cannot jump.
-- This script should be placed inside the "StarterPlayerScripts" folder for it to work properly on the client.

-- Instructions for users:
-- 1. Place this script inside the "StarterPlayerScripts" folder.
-- 2. Configure the "config" table to set the desired JumpHeight and JumpPower values.
-- 3. The script will automatically disable or modify jumping for the local player.

-- Services
local Player = game.Players.LocalPlayer -- The local player
local Character = Player.Character or Player.CharacterAdded:Wait() -- The player's character
local Humanoid = Character:WaitForChild("Humanoid") -- The player's humanoid

-- Configuration (Adjust these values to customize the anti-jump system)
local config = {
	DisableJump = true, -- Set to true to completely disable jumping, false to allow jumping
	SetJumpHeightTo = 7, -- Set to a specific value to control JumpHeight (set to 0 to disable jump height)
	SetJumpPowerTo = 50, -- Set to a specific value to control JumpPower (set to 0 to disable jump power)
}

-- Function to disable or modify jumping based on the configuration
local function customizeJump()
	-- Disable or modify JumpHeight and JumpPower based on config
	if config.DisableJump then
		Humanoid.JumpHeight = 0 -- Disable jumping by setting JumpHeight to 0
		Humanoid.JumpPower = 0 -- Disable jumping by setting JumpPower to 0
	else
		Humanoid.JumpHeight = config.SetJumpHeightTo -- Set JumpHeight to a specific value if desired
		Humanoid.JumpPower = config.SetJumpPowerTo -- Set JumpPower to a specific value if desired
	end

	-- Optional: Prevent jumping when the player respawns
	Player.CharacterAdded:Connect(function(newCharacter)
		local newHumanoid = newCharacter:WaitForChild("Humanoid")
		if config.DisableJump then
			newHumanoid.JumpHeight = 0
			newHumanoid.JumpPower = 0
		else
			newHumanoid.JumpHeight = config.SetJumpHeightTo
			newHumanoid.JumpPower = config.SetJumpPowerTo
		end
	end)
end

-- Function to prevent jumping using the Jumping event
local function preventJumpWithEvent()
	-- Prevent jumping by canceling the jump when the player tries to jump
	Humanoid.Jumping:Connect(function()
		Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end)

	-- Optional: Prevent jumping when the player respawns
	Player.CharacterAdded:Connect(function(newCharacter)
		local newHumanoid = newCharacter:WaitForChild("Humanoid")
		newHumanoid.Jumping:Connect(function()
			newHumanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end)
	end)
end

-- Customize jumping based on the configuration
customizeJump()

-- Optional: You can use preventJumpWithEvent() if you prefer using the Jumping event
-- preventJumpWithEvent()

-- Notes:
-- The "DisableJump" config option completely disables jumping when set to true.
-- You can customize the JumpHeight and JumpPower values in the config table if you want to set specific jump parameters.
-- The script will automatically apply the settings even if the player respawns.
