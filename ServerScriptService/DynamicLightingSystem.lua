-- Script Name: Dynamic Lighting System with TweenService
-- Author: Striatp
-- License: https://github.com/striatp/RobloxAssets/blob/main/LICENSE.md

-- Dynamic Lighting System for Roblox made by Striatp
-- This script dynamically changes the lighting settings based on the time of day or game events.
-- It uses TweenService to smoothly transition between day and night lighting.

-- Instructions for users:
-- 1. Place this script in "ServerScriptService".
-- 2. Adjust the settings in the "config" table below to customize the lighting effects.

-- Configuration (Customize these values in the config table)
local config = {
	-- Day-Night Cycle Settings
	DayTime = 6, -- Time of day for the "day" period (in hours, 0-24, default: 6 = 6 AM)
	NightTime = 18, -- Time of day for the "night" period (in hours, 0-24, default: 18 = 6 PM)

	-- Lighting Colors (RGB)
	DayColor = Color3.fromRGB(255, 255, 255), -- Daylight color (bright white)
	NightColor = Color3.fromRGB(0, 0, 50), -- Nighttime color (dark blue)

	-- Lighting Effects
	DayAmbient = Color3.fromRGB(255, 255, 255), -- Ambient light during the day
	NightAmbient = Color3.fromRGB(20, 20, 40), -- Ambient light during the night
	DayBrightness = 2, -- Brightness of the day (higher for brighter)
	NightBrightness = 0.5, -- Brightness of the night (lower for darker)

	-- Transition Speed (time in seconds to transition between day and night)
	TransitionSpeed = 5, -- How quickly the lighting changes between day and night
}

-- Services
local Lighting = game:GetService("Lighting") -- Access the lighting service
local TweenService = game:GetService("TweenService") -- TweenService for smooth transitions
local RunService = game:GetService("RunService")  -- Used for continuous updates

-- Function to update lighting based on time
local function updateLighting()
	local currentTime = game.Lighting.ClockTime -- Get the current time of day (0 to 24)

	-- Determine if it's day or night based on the configured times
	if currentTime >= config.DayTime and currentTime < config.NightTime then
		-- Daytime settings
		Lighting.Ambient = config.DayAmbient
		Lighting.OutdoorAmbient = config.DayAmbient
		Lighting.ColorShift_Top = config.DayColor
		Lighting.ColorShift_Bottom = config.DayColor
		Lighting.Brightness = config.DayBrightness
	else
		-- Nighttime settings
		Lighting.Ambient = config.NightAmbient
		Lighting.OutdoorAmbient = config.NightAmbient
		Lighting.ColorShift_Top = config.NightColor
		Lighting.ColorShift_Bottom = config.NightColor
		Lighting.Brightness = config.NightBrightness
	end
end

-- Function to create and play a tween to transition lighting
local function tweenLighting(targetAmbient, targetBrightness, targetColor)
	-- Create tween info for smooth transitions
	local tweenInfo = TweenInfo.new(config.TransitionSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false)

	-- Create the tween for ambient light
	local tweenAmbient = TweenService:Create(Lighting, tweenInfo, {Ambient = targetAmbient, OutdoorAmbient = targetAmbient})

	-- Create the tween for brightness
	local tweenBrightness = TweenService:Create(Lighting, tweenInfo, {Brightness = targetBrightness})

	-- Create the tween for color shift
	local tweenColor = TweenService:Create(Lighting, tweenInfo, {ColorShift_Top = targetColor, ColorShift_Bottom = targetColor})

	-- Play all tweens to transition lighting
	tweenAmbient:Play()
	tweenBrightness:Play()
	tweenColor:Play()
end

-- Function to handle transitions between day and night
local function transitionLighting()
	local currentTime = game.Lighting.ClockTime

	-- Check if it's day or night and set the target values accordingly
	if currentTime >= config.DayTime and currentTime < config.NightTime then
		-- Transition to day
		tweenLighting(config.DayAmbient, config.DayBrightness, config.DayColor)
	else
		-- Transition to night
		tweenLighting(config.NightAmbient, config.NightBrightness, config.NightColor)
	end
end

-- Function to update lighting periodically (to handle dynamic changes)
RunService.Heartbeat:Connect(function()
	updateLighting() -- Update lighting settings based on time
	transitionLighting() -- Smoothly transition the lighting between day and night
end)
