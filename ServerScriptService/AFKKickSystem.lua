-- Script Name: AFK Kick System
-- Author: Striatp
-- License: https://github.com/striatp/RobloxAssets/blob/main/LICENSE.md

-- AFK Kick System for Roblox made by Striatp
-- This script kicks players who remain AFK for a specified amount of time (in seconds).
-- It detects player inactivity based on movement and kicks them after the configured AFK time.

-- Instructions for users:
-- 1. Place this script in "ServerScriptService".
-- 2. Adjust the settings in the "config" table below to customize the AFK detection system.

-- Configuration (Customize these values in the config table)
local config = {
	-- AFK Time Settings
	AFKTimeLimit = 300, -- Time in seconds before a player is kicked for being AFK (default: 300 seconds = 5 minutes)
	AFKMessage = "You have been kicked for being AFK.", -- Message shown when the player is kicked
	CheckInterval = 1, -- Interval (in seconds) to check if the player has moved (default: 1 second)
}

-- Services
local Players = game:GetService("Players") -- Access players in the game

-- Helper function to detect player movement
local function isPlayerActive(player)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		local previousPosition = character.PrimaryPart.Position
		wait(config.CheckInterval) -- Wait for the configured interval before checking again
		return previousPosition ~= character.PrimaryPart.Position
	end
	return false
end

-- Function to handle AFK detection and kicking
local function detectAFK(player)
	local lastActivityTime = tick() -- Track the last time the player was active

	while player and player.Parent do
		if isPlayerActive(player) then
			lastActivityTime = tick() -- Reset the timer if the player is active
		end

		-- If the player has been AFK for the full duration, kick them
		if tick() - lastActivityTime >= config.AFKTimeLimit then
			-- Kick the player after being AFK for too long
			player:Kick(config.AFKMessage)
			return
		end

		wait(config.CheckInterval) -- Check every configured interval
	end
end

-- Initialize AFK detection for all players
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		-- Start AFK detection for the player
		detectAFK(player)
	end)
end)

-- Notes:
-- Customize the config table to change the AFKTimeLimit and messages.
-- AFKTimeLimit is the time in seconds after which the player will be kicked for inactivity.
-- AFKMessage can be customized to suit your needs.
-- CheckInterval determines how often the script checks if the player has moved (in seconds).
