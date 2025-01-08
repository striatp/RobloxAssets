-- Script Name: Daylight Cycle
-- Author: Striatp
-- License: https://github.com/striatp/RobloxAssets/blob/main/LICENSE.md

-- Daylight System for Roblox made by Striatp
-- This script provides a customizable day-night cycle system using Roblox's Lighting service and TweenService.
-- Users can adjust parameters like starting time, cycle duration, and loop behavior through the "config" table.
-- This script is recomended to be placed inside of your game's "ServerScriptService" folder.

-- Instructions for users:
-- 1. Set "StartTime" to the desired initial time (e.g., 6 for 6 AM, 18 for 6 PM).
-- 2. Adjust "DayDuration" and "NightDuration" to control how long each phase lasts.
-- 3. Set "Loop" to true for continuous cycling or false for a single day-night transition.
-- 4. Place this script in the ScriptScriptStorage folder to activate the system.

-- Services
local TweenService = game:GetService("TweenService") -- Handles animations and transitions
local Lighting = game:GetService("Lighting") -- Controls in-game lighting

-- Configuration (Adjust these values to customize the system)
local config = {
	StartTime = 6, -- Starting time in hours (6 = 6 AM, 18 = 6 PM, etc.)
	DayDuration = 60, -- Duration of the daytime cycle in seconds
	NightDuration = 60, -- Duration of the nighttime cycle in seconds
	Loop = true -- Set to true for continuous day-night cycling, false for a single cycle
}

-- Apply the starting time to the Lighting service
Lighting.ClockTime = config.StartTime

-- Function to create and play a tween for the Lighting.ClockTime
-- @param targetProperty: The target property for the tween (e.g., {ClockTime = 24})
-- @param duration: Duration of the tween in seconds
local function createTween(targetProperty, duration)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear) -- Tween configuration
	local tween = TweenService:Create(Lighting, tweenInfo, targetProperty) -- Create the tween
	tween:Play() -- Start the tween
	tween.Completed:Wait() -- Wait for the tween to complete before proceeding
end

-- Function to handle the full day-night cycle
local function cycle()
	-- Transition from morning to evening (e.g., 6 AM to 6 PM)
	createTween({ClockTime = 24}, config.DayDuration)

	-- Transition from evening back to morning (e.g., 6 PM to 6 AM)
	createTween({ClockTime = 12}, config.NightDuration)
end

-- Main loop to run the cycle based on the "Loop" configuration
if config.Loop then
	while true do
		cycle() -- Continuously run the day-night cycle
	end
else
	cycle() -- Run the cycle only once
end
