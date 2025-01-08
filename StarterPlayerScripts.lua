-- Script Name: Music Player (Local)
-- Author: Striatp
-- License: https://github.com/striatp/RobloxAssets/blob/main/LICENSE.md

-- Dynamic Music Player for Roblox made by Striatp
-- This script provides a customizable music player that dynamically plays music based on game events such as combat, exploration, and victory.
-- Users can adjust parameters like volume, looping, and the track IDs for different events through the "config" table.
-- This script should be placed inside the "StarterPlayerScripts" folder for it to work properly on the client.

-- Instructions for users:
-- 1. Add the MusicManagerModule to your game and adjust the track IDs in the "config" table.
-- 2. Call the respective event functions like "StartCombatMusic()" or "StartExplorationMusic()" to trigger the music.
-- 3. Customize the tracks, volume, and loop settings in the config.
-- 4. Place this script in the "StarterPlayerScripts" folder to activate the system.

-- Services
local SoundService = game:GetService("SoundService") -- Manages sound effects and music
local Player = game.Players.LocalPlayer -- The local player

-- Configuration (Adjust these values to customize the music system)
local config = {
	Music = "rbxassetid://1848354536", -- Music track ID for the background music (change this to your track ID)
	Volume = 0.05, -- Music volume (0 to 1)
	Loop = true, -- Set to true for looping music, false for non-looping
}

-- Function to play a specific music track
-- @param trackId: The asset ID of the music track to play
local function playMusic(trackId)
	-- Stop any currently playing music to prevent overlay
	if SoundService:FindFirstChild("CurrentMusic") then
		SoundService.CurrentMusic:Stop()
	end

	-- Create and play the new sound instance
	local music = Instance.new("Sound")
	music.SoundId = trackId -- Set the sound ID to the provided track ID
	music.Looped = config.Loop -- Set looping based on config
	music.Volume = config.Volume -- Set the volume based on config
	music.Name = "CurrentMusic" -- Name it for easy reference
	music.Parent = SoundService -- Parent the music to SoundService to make it playable
	music:Play() -- Start playing the music
end

-- Function to stop the currently playing music
local function stopMusic()
	-- Check if there is currently a music playing and stop it
	if SoundService:FindFirstChild("CurrentMusic") then
		SoundService.CurrentMusic:Stop()
	end
end

-- Play the configured music track when the player joins
-- This will play the default music when the script is run
playMusic(config.Music)

-- Optional: Call this to stop all music manually
-- stopMusic()

-- Notes:
-- You can easily add more events and tracks to the system.
-- Make sure to replace the placeholder asset IDs with your actual track IDs.
-- You can call `playMusic()` to change the track.
-- The `stopMusic()` function can be used to stop the currently playing track if needed.
