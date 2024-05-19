local MetaPlayer = FindMetaTable("Player")

function MetaPlayer:CycleSpectator(a)
	if self:Alive() then Error("Can't spectate while alive!") return false end
	if !self.SpecIDX then self.SpecIDX = 0 end 
	
	self.SpecIDX = self.SpecIDX + a

	local Players = {}
	for _, v in pairs(GAMEMODE:GetActivePlayers()) do
		Players[#Players + 1] = v
	end
	
	if self.SpecIDX < 1 then 
		self.SpecIDX = #Players
	end
	
	if self.SpecIDX > #Players then 
		self.SpecIDX = 0
	end
	
	local ply 
	ply = Players[self.SpecIDX]
	local OBS=OBS_MODE_CHASE
	if(self.OBSMODE)then
		OBS=self.OBSMODE
	end
	self:Spectate(OBS)
	self:SpectateEntity(ply)
end
local OBS={
	OBS_MODE_CHASE,
	OBS_MODE_IN_EYE,
	OBS_MODE_ROAMING
}
local OBS_KEY=table.GetKeys(OBS)
local MA=#OBS
function MetaPlayer:CycleOBSMode()
	local OBSMODE=self.OBSMODE
	if(not OBSMODE)then OBSMODE=1 end
	local i=OBS_KEY[OBSMODE]
	if(i+1>MA)then
		i=1
	else
		i=i+1
	end
	self.OBSMODE=OBS[i]
	self:SetObserverMode(OBS[i])
end
