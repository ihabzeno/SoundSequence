--// Credits \\--

-- Script Creator	Ihab.exe	https://www.youtube.com/channel/UCAwG53xUwNmnxVZGhaki8Lg
-- Script Create Date	March 9, 2021 10:09 AM EST

--// Script Usage \\-- 

--[[
This is a module script that can be used to make custom sequences of sounds.

This can be useful if you want to create in-depth and special reload sounds only specific to your game.
]]--

--// Script Instructions | Quick Setup Guide \\--

--[[
* This is a starter player script.

local camera = game.Workspace.CurrentCamera -- Set up the parent of which the sound should be in.  Camera is preferable.

local SoundSequence = require(game.ReplicatedStorage.SoundSequence) -- Load in the library module

local sound_seq_1 = SoundSequence.new({}) -- We can put sound data directly in the initilizer to make it compact, but if you dont want to do that then put an {} in there.

sound_seq_1:Add(6232931161, 1, 0, 0, nil) -- Add A Sound

sound_seq_1:Play(camera)

--// Adding Sounds \\--

6232931161	This is the sound id.
1 - This is the volume.
0 - this is the audio start time.
0 - This is the start time.
nil - This is the value (in seconds) of the duration the audio should last.

NOTE: THE AUDIO START TIME IS DIFFERENT FROM THE START TIME.  THE AUDIO START TIME IS THE SECTION IN TIME THE AUDIO WILL START FROM.  THE START TIME IS HOW MUCH YOU WILL HAVE TO WAIT TO HEAR THE SOUND.

]]--

--// Required Libraries \\--

local DebrisService = game:GetService("Debris")


SoundSequence = {}
SoundSequence.__index = SoundSequence


function SoundSequence.new(SoundSequenceInfo)
	local newSoundSequence = {}
	newSoundSequence.SoundSequenceInfo = SoundSequenceInfo
	setmetatable(newSoundSequence, SoundSequence)
	return newSoundSequence
end

function SoundSequence:Add(soundID, volume, audioStartTime, startTime, endTime)
	--[[
	This method adds a sound object into the sequence.
	
	Quick Setup Sounds

	BOLD DRAW BACK	6111895428
	MAG IN	6232931161
	SLAP 	5213679380	o((⊙﹏⊙))o.
	
	]]--
	local SoundObject = {}
	SoundObject.soundID = soundID
	SoundObject.volume = volume
	SoundObject.audioStartTime = audioStartTime
	SoundObject.startTime = startTime
	SoundObject.endTime = endTime
	self.SoundSequenceInfo[#self.SoundSequenceInfo+1] = SoundObject
end

function SoundSequence:Play(parent)
	--[[
	This method plays the SoundSequence, storing the audio objects in the given parent.
	]]--
	
	for _, SoundInfo in pairs(self.SoundSequenceInfo) do
		delay(SoundInfo.startTime, function()
			local PlayingSound = Instance.new("Sound", parent)
			PlayingSound.SoundId = "rbxassetid://"..SoundInfo.soundID
			
			PlayingSound.Playing = true
			PlayingSound.Volume = SoundInfo.volume
			PlayingSound.TimePosition = SoundInfo.audioStartTime
			
			repeat wait() until PlayingSound.isLoaded
			
			if SoundInfo.endTime ~= nil then
				DebrisService:AddItem(PlayingSound, SoundInfo.endTime - SoundInfo.startTime)
			else
				DebrisService:AddItem(PlayingSound, PlayingSound.TimeLength)
			end
		end)
	end
end


return SoundSequence

